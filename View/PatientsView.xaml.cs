using Application.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Application.View
{
    /// <summary>
    /// Логика взаимодействия для PatientsView.xaml
    /// </summary>
    public partial class PatientsView : Page
    {

        public static PatientsView MainFormInstance;
        public PatientsView()
        {
            InitializeComponent();

            var Patients = HealthCenterEntities.GetContext().Patients.ToList();
            PatientsListView.ItemsSource = Patients;

            MainFormInstance = this;
        }

        public static void Update(string Search, string filterName = null, int filterValue = -1)
        {
            var Patients = HealthCenterEntities.GetContext().Patients.ToList();
            if (Search == "" && filterName == null && filterValue == -1)
            {
                Patients = HealthCenterEntities.GetContext().Patients.ToList();
            }
            else
            {
                Patients = Patients.Where(
                p => (
                    (p.Surname + " " + p.Name + " " + p.Patronymic).ToLower().Contains(Search.ToLower()) ||
                    p.City.ToLower().Contains(Search.ToLower()) ||
                    p.Age.ToString().Contains(Search.ToLower()) ||
                    p.Adress.ToLower().Contains(Search.ToLower())
                )).ToList();

                if (filterName != null && filterValue != -1)
                {
                    if (filterName == "Пол")
                    {
                        Patients = Patients.Where(p => p.IDGender == filterValue).ToList();
                    }
                }
            }
            MainFormInstance.PatientsListView.ItemsSource = Patients;
        }
    }
}
