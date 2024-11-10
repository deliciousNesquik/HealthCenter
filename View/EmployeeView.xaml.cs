using Application.Database;
using System.Linq;
using System.Windows.Controls;

namespace Application.View
{
    public partial class EmployeeView : Page
    {
        public static EmployeeView MainFormInstance;
        public EmployeeView()
        {
            InitializeComponent();

            var Employee = HealthCenterEntities.GetContext().Employee.ToList();
            EmployeeListView.ItemsSource = Employee;

            MainFormInstance = this;
        }

        public static void Update(string Search, string filterName = null, string filterValue = null)
        {
            var Employee = HealthCenterEntities.GetContext().Employee.ToList();
            if (Search == "" && filterName == null && filterValue == null)
            {
                Employee = HealthCenterEntities.GetContext().Employee.ToList();
            }
            else
            {
                Employee = Employee.Where(
                p => (
                    (p.Surname + " " + p.Name + " " + p.Patronymic).ToLower().Contains(Search.ToLower()) ||
                    p.Post.ToLower().Contains(Search.ToLower()) ||
                    p.WorkExperience.ToString().Contains(Search.ToLower()) ||
                    p.Adress.ToLower().Contains(Search.ToLower())
                )).ToList();

                if (filterName != null && filterValue != null)
                {
                    if (filterName == "Должность")
                    {
                        Employee = Employee.Where(p => p.Post == filterValue).ToList();
                    }
                }

            }
            MainFormInstance.EmployeeListView.ItemsSource = Employee;
        }
    }
}
