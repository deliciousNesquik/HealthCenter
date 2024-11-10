using Application.Database;
using System;
using System.Data.Entity.Migrations.Model;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media.Animation;

namespace Application.View
{
    public partial class MedicalHistoryView : Page
    {
        public static MedicalHistoryView MainFormInstance;
        public MedicalHistoryView()
        {
            InitializeComponent();
            MainFormInstance = this;

            DateTime today = DateTime.Now;
            CultureInfo russianCulture = new CultureInfo("ru-RU");
            string formattedDate = today.ToString("d MMMM yyyy", russianCulture);
            TodayTextBlock.Text = formattedDate;

            var CountRecords = HealthCenterEntities.GetContext().MedicalHistory.Count();
            CountRecordsTextBlock.Text = "Количество записей в таблице: " + CountRecords;

            var MedicalHistory = HealthCenterEntities.GetContext().MedicalHistory.ToList();
            MedicalHistoryListView.ItemsSource = MedicalHistory;
        }

        public static void Filtered(string filterName, string filterValue)
        {
            if(filterName == "TypeTreatment")
            {

            }
        }

        public static void Update(string Search, string filterName = null, int filterValue = -1)
        {
            var MedicalHistory = HealthCenterEntities.GetContext().MedicalHistory.ToList();
            if (Search == "" && filterName == null && filterValue == -1)
            {
                MedicalHistory = HealthCenterEntities.GetContext().MedicalHistory.ToList();
            }
            else
            {
                var DiagnoseID = HealthCenterEntities.GetContext().Diagnoses.Where(p => p.NameDiagnose.ToLower().Contains(Search)).Select(p => p.ID).FirstOrDefault();
                var PatientID = HealthCenterEntities.GetContext().Patients.Where(p => (p.Surname + " " + p.Name + " " + p.Patronymic).ToLower().Contains(Search.ToLower())).Select(p => p.ID).FirstOrDefault();
                var EmployeeID = HealthCenterEntities.GetContext().Employee.Where(p => (p.Surname + " " + p.Name + " " + p.Patronymic).ToLower().Contains(Search.ToLower())).Select(p => p.ID).FirstOrDefault();
                var ThreatmentID = HealthCenterEntities.GetContext().TypeOfTreatments.Where(p => p.TypeOfTreatment.ToLower().Contains(Search.ToLower())).Select(p => p.ID).FirstOrDefault();

                MedicalHistory = MedicalHistory.Where(
                p => (
                    p.ID.ToString().ToLower().Contains(Search.ToLower()) ||
                    p.IDDiagnose.ToString().ToLower().Contains(DiagnoseID.ToString()) ||
                    p.IDPatient.ToString().ToLower().Contains(PatientID.ToString()) ||
                    p.IDEmployee.ToString().ToLower().Contains(EmployeeID.ToString()) ||
                    p.IDTypeOfTreatment.ToString().ToLower().Contains(ThreatmentID.ToString())
                )).ToList();

                if (filterName != null && filterValue != -1)
                {
                    if(filterName == "Тип лечения")
                    {
                        MedicalHistory = MedicalHistory.Where(p => p.IDTypeOfTreatment == filterValue).ToList();
                    }
                }
            }
            MainFormInstance.MedicalHistoryListView.ItemsSource = MedicalHistory;
        }

        private void UpdateButton_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            var CountRecords = HealthCenterEntities.GetContext().MedicalHistory.Count();
            CountRecordsTextBlock.Text = "Количество записей в таблице: " + CountRecords;

            var MedicalHistory = HealthCenterEntities.GetContext().MedicalHistory.ToList();
            MedicalHistoryListView.ItemsSource = MedicalHistory;
        }

        private void AddButton_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            Modules.Manager.NavigationFrame.Navigate(new MedicalHistoryAddView(null));
        }

        private void UpdateButton_MouseEnter(object sender, System.Windows.Input.MouseEventArgs e)
        {
            double beginState = 25;
            double endState = 100;
            double animationDuration = 0.2;

            DoubleAnimation buttonScaleAnim = new DoubleAnimation();
            buttonScaleAnim.From = beginState;
            buttonScaleAnim.To = endState;
            buttonScaleAnim.Duration = TimeSpan.FromSeconds(animationDuration);

            UpdateButton.BeginAnimation(Button.WidthProperty, buttonScaleAnim);
        }

        private void UpdateButton_MouseLeave(object sender, System.Windows.Input.MouseEventArgs e)
        {
            double beginState = 100;
            double endState = 25;
            double animationDuration = 0.2;

            DoubleAnimation buttonScaleAnim = new DoubleAnimation();
            buttonScaleAnim.From = beginState;
            buttonScaleAnim.To = endState;
            buttonScaleAnim.Duration = TimeSpan.FromSeconds(animationDuration);

            UpdateButton.BeginAnimation(Button.WidthProperty, buttonScaleAnim);
        }

        private void AddButton_MouseEnter(object sender, System.Windows.Input.MouseEventArgs e)
        {
            double beginState = 25;
            double endState = 100;
            double animationDuration = 0.2;

            DoubleAnimation buttonScaleAnim = new DoubleAnimation();
            buttonScaleAnim.From = beginState;
            buttonScaleAnim.To = endState;
            buttonScaleAnim.Duration = TimeSpan.FromSeconds(animationDuration);

            AddButton.BeginAnimation(Button.WidthProperty, buttonScaleAnim);
        }

        private void AddButton_MouseLeave(object sender, System.Windows.Input.MouseEventArgs e)
        {
            double beginState = 100;
            double endState = 25;
            double animationDuration = 0.2;

            DoubleAnimation buttonScaleAnim = new DoubleAnimation();
            buttonScaleAnim.From = beginState;
            buttonScaleAnim.To = endState;
            buttonScaleAnim.Duration = TimeSpan.FromSeconds(animationDuration);

            AddButton.BeginAnimation(Button.WidthProperty, buttonScaleAnim);
        }

        private void Page_IsVisibleChanged(object sender, System.Windows.DependencyPropertyChangedEventArgs e)
        {
            var CountRecords = HealthCenterEntities.GetContext().MedicalHistory.Count();
            CountRecordsTextBlock.Text = "Количество записей в таблице: " + CountRecords;

            var MedicalHistory = HealthCenterEntities.GetContext().MedicalHistory.ToList();
            MedicalHistoryListView.ItemsSource = MedicalHistory;
        }

        private void Border_MouseEnter(object sender, System.Windows.Input.MouseEventArgs e)
        {
            Border MedicalHistoryCard = (Border)sender;
            StackPanel ControlBorderStackPanel = (StackPanel)MedicalHistoryCard.FindName("ControlBorderStackPanel");

            ControlBorderStackPanel.Visibility = (System.Windows.Visibility)0;
        }

        private void Border_MouseLeave(object sender, System.Windows.Input.MouseEventArgs e)
        {
            Border MedicalHistoryCard = (Border)sender;
            StackPanel ControlBorderStackPanel = (StackPanel)MedicalHistoryCard.FindName("ControlBorderStackPanel");

            ControlBorderStackPanel.Visibility = (System.Windows.Visibility)2;
        }

        private void DeleteButton_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            if(MessageBox.Show("Подтверждение удаления записи", "Удаление", MessageBoxButton.YesNo) == MessageBoxResult.Yes)
            {
                HealthCenterEntities.GetContext().MedicalHistory.Remove((sender as Button).DataContext as MedicalHistory);
                HealthCenterEntities.GetContext().SaveChanges();
            }
            var MedicalHistory = HealthCenterEntities.GetContext().MedicalHistory.ToList();
            MedicalHistoryListView.ItemsSource = MedicalHistory;

            var CountRecords = HealthCenterEntities.GetContext().MedicalHistory.Count();
            CountRecordsTextBlock.Text = "Количество записей в таблице: " + CountRecords;
        }

        private void EditButton_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            Modules.Manager.NavigationFrame.Navigate(new MedicalHistoryAddView((sender as Button).DataContext as MedicalHistory));
        }
    }
}
