using Application.Database;
using Application.Modules;
using Application.View;
using System;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;

namespace Application
{
    public partial class MainWindow : Window
    {
        private static string currentOpenedTable = null;
        public MainWindow()
        {
            InitializeComponent();

            ActionListView.PreviewMouseWheel += HorizontalListView_MouseWheel;
        }

        private void HorizontalListView_MouseWheel(object sender, MouseWheelEventArgs e)
        {
            // Получаем ScrollViewer внутри ListView
            var scrollViewer = GetScrollViewer(ActionListView);
            if (scrollViewer != null)
            {
                // Прокручиваем горизонтально, изменяя горизонтальное смещение
                scrollViewer.ScrollToHorizontalOffset(scrollViewer.HorizontalOffset - e.Delta);
                e.Handled = true; // Останавливаем вертикальную прокрутку
            }
        }

        private ScrollViewer GetScrollViewer(DependencyObject obj)
        {
            if (obj is ScrollViewer) return (ScrollViewer)obj;

            for (int i = 0; i < VisualTreeHelper.GetChildrenCount(obj); i++)
            {
                var child = VisualTreeHelper.GetChild(obj, i);
                var result = GetScrollViewer(child);
                if (result != null) return result;
            }
            return null;
        }

        private void NavigationFrame_ContentRendered(object sender, System.EventArgs e)
        {

        }

        private void MedicalHistoryDisplay_Click(object sender, RoutedEventArgs e)
        {
            FilterMedicalHistory.Visibility = Visibility.Visible;
            FilterPatients.Visibility = Visibility.Collapsed;
            FilterDoctor.Visibility = Visibility.Collapsed;

            var TypeTreatments = HealthCenterEntities.GetContext().TypeOfTreatments.Select(p => p.TypeOfTreatment);
            FilterTypeTreatment.Items.Clear();
            foreach (var TypeTreatment in TypeTreatments)
            {
                FilterTypeTreatment.Items.Add(TypeTreatment);
            }


            currentOpenedTable = "MedicalHistory";

            InfoMessageStackPanel.Visibility = Visibility.Hidden;
            
            NavigationFrame.Navigate(
                new MedicalHistoryView()
            );

            Modules.Manager.NavigationFrame = NavigationFrame;
        }

        private void Search_TextChanged(object sender, System.Windows.Controls.TextChangedEventArgs e)
        {
            if(Search.Text == "")
            {
                SearchTextBlock.Visibility = Visibility.Visible;
            }
            else
            {
                SearchTextBlock.Visibility = Visibility.Hidden;
            }

            if (currentOpenedTable != null)
            {
                if (currentOpenedTable == "MedicalHistory")
                {
                    View.MedicalHistoryView.Update(Search.Text);
                }
                if (currentOpenedTable == "Patients")
                {
                    View.PatientsView.Update(Search.Text);
                }
                if (currentOpenedTable == "Employee")
                {
                    View.EmployeeView.Update(Search.Text);
                }
            }
            else
            {
                Thickness beginState = new Thickness(0, 0, 0, 0);
                Thickness endState = new Thickness(0, 0, 0, 20);
                double animationDuration = 0.2;

                ThicknessAnimation ImageAnim = new ThicknessAnimation();
                ImageAnim.From = beginState;
                ImageAnim.To = endState;
                ImageAnim.Duration = TimeSpan.FromSeconds(animationDuration);

                InfoImage.BeginAnimation(Image.MarginProperty, ImageAnim);

                Task.Delay(300);

                ImageAnim.From = endState;
                ImageAnim.To = beginState;
                animationDuration = 0.5;
                ImageAnim.Duration = TimeSpan.FromSeconds(animationDuration);

                InfoImage.BeginAnimation(Image.MarginProperty, ImageAnim);
            }
        }

        private void PatientsDisplay_Click(object sender, RoutedEventArgs e)
        {
            FilterMedicalHistory.Visibility = Visibility.Collapsed;
            FilterPatients.Visibility = Visibility.Visible;
            FilterDoctor.Visibility = Visibility.Collapsed;

            var Genders = HealthCenterEntities.GetContext().Genders.Select(p => p.Gender);
            FilterGender.Items.Clear();
            foreach (var Gender in Genders)
            {
                FilterGender.Items.Add(Gender);
            }


            currentOpenedTable = "Patients";

            InfoMessageStackPanel.Visibility = Visibility.Hidden;

            NavigationFrame.Navigate(
                new PatientsView()
            );

            Modules.Manager.NavigationFrame = NavigationFrame;
        }

        private void EmployeeDisplpay_Click(object sender, RoutedEventArgs e)
        {
            FilterMedicalHistory.Visibility = Visibility.Collapsed;
            FilterPatients.Visibility = Visibility.Collapsed;
            FilterDoctor.Visibility = Visibility.Visible;

            var Positions = HealthCenterEntities.GetContext().Employee.Select(p => p.Post).Distinct();
            FilterPosition.Items.Clear();
            foreach (var Position in Positions)
            {
                FilterPosition.Items.Add(Position);
            }

            currentOpenedTable = "Employee";

            InfoMessageStackPanel.Visibility = Visibility.Hidden;

            NavigationFrame.Navigate(
                new EmployeeView()
            );

            Modules.Manager.NavigationFrame = NavigationFrame;
        }

        private void Border_MouseDown(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            if (e.ChangedButton == System.Windows.Input.MouseButton.Left)
            {
                this.DragMove();
            }
        }

        private bool IsMaximized = false;
        private void Border_MouseLeftButtonDown(object sender, System.Windows.Input.MouseButtonEventArgs e)
        {
            if (e.ClickCount == 2)
            {
                if (IsMaximized)
                {
                    this.WindowState = WindowState.Normal;
                    this.Width = 800;
                    this.Height = 540;

                    IsMaximized = false;
                }
                else
                {
                    this.WindowState = WindowState.Maximized;

                    IsMaximized = true;
                }
            }
        }

        private void CloseAppButton_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void FilterTypeTreatment_Selected(object sender, RoutedEventArgs e)
        {
            View.MedicalHistoryView.Update("", "Тип лечения", FilterTypeTreatment.SelectedIndex + 1);
        }

        private void FilterGender_Selected(object sender, RoutedEventArgs e)
        {
            View.PatientsView.Update("", "Пол", FilterGender.SelectedIndex + 1);
        }

        private void FilterPosition_Selected(object sender, RoutedEventArgs e)
        {
            View.EmployeeView.Update("", "Должность", FilterPosition.SelectedItem.ToString());
        }
    }
}
