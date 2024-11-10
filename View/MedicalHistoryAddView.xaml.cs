using Application.Modules;
using System;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;

namespace Application.Database
{
    public partial class MedicalHistoryAddView : Page
    {
        private MedicalHistory medicalHistory = new MedicalHistory();
        private bool IsEdit = false;
        public MedicalHistoryAddView(MedicalHistory medicalHistorySelected)
        {
            InitializeComponent();
            

            var Patients = HealthCenterEntities.GetContext().Patients.Select(p => p.Surname + " " + p.Name + " " + p.Patronymic).ToList();
            var Employees = HealthCenterEntities.GetContext().Employee.Select(p => p.Surname + " " + p.Name + " " + p.Patronymic).ToList();
            var Diagnoses = HealthCenterEntities.GetContext().Diagnoses.Select(p => p.NameDiagnose).ToList();

            foreach(var Patient in Patients)
            {
                PatientComboBox.Items.Add(Patient);
            }
            foreach (var Employee in Employees)
            {
                DoctorComboBox.Items.Add(Employee);
            }
            foreach (var Diagnose in Diagnoses)
            {
                DiagnosisComboBox.Items.Add(Diagnose);
            }
            TreatmentTypeComboBox.Items.Add("Амбулаторное");
            TreatmentTypeComboBox.Items.Add("Стационарное");

            IsEdit = false;
            if (medicalHistorySelected != null)
            {
                IsEdit = true;
                medicalHistory = medicalHistorySelected;
                PatientComboBox.SelectedIndex = medicalHistory.IDPatient - 1;
                DoctorComboBox.SelectedIndex = medicalHistory.IDEmployee - 1;
                DiagnosisComboBox.SelectedIndex = medicalHistory.IDDiagnose - 1;
                TreatmentTypeComboBox.SelectedIndex = medicalHistory.IDTypeOfTreatment - 1;

                TreatmentTextBox.Text = medicalHistory.Treatment;
                DiseaseDatePicker.SelectedDate = medicalHistory.DateOfTheDisease;
                RecoveryDatePicker.SelectedDate = medicalHistory.DateOfCure;
            }
        }

        private void SaveMedicalHistoryButton_Click(object sender, RoutedEventArgs e)
        {
            StringBuilder errors = new StringBuilder();
            bool dateCheck = true;

            if(PatientComboBox.SelectedIndex == -1)
            {
                errors.AppendLine("Выберите пациента!");
            }
            if(DoctorComboBox.SelectedIndex == -1)
            {
                errors.AppendLine("Выберите врача!");
            }
            if(DiagnosisComboBox.SelectedIndex == -1)
            {
                errors.AppendLine("Выберите диагноз!");
            }
            if(TreatmentTypeComboBox.SelectedIndex == -1)
            {
                errors.AppendLine("Выберите вид лечения!");
            }

            if (string.IsNullOrEmpty(TreatmentTextBox.Text) && string.IsNullOrWhiteSpace(TreatmentTextBox.Text))
            {
                errors.AppendLine("Введите назначения лечения!");
            }

            if (DiseaseDatePicker.SelectedDate == null)
            {
                errors.AppendLine("Выберите дату заболевания!");
                dateCheck = false;
            }
            if (RecoveryDatePicker.SelectedDate == null)
            {
                errors.AppendLine("Выберите дату вылечивания!");
                dateCheck = false;
            }
            if (dateCheck == true && DiseaseDatePicker.SelectedDate > RecoveryDatePicker.SelectedDate)
            {
                errors.AppendLine("Дата заболевания не может быть больше даты вылечивания!");
            }
            

            if(errors.Length > 0)
            {
                MessageBox.Show(errors.ToString(), "Ошибка сохранения");
                return;
            }

            medicalHistory.IDPatient = PatientComboBox.SelectedIndex + 1;
            medicalHistory.IDEmployee = DoctorComboBox.SelectedIndex + 1;
            medicalHistory.IDDiagnose = DiagnosisComboBox.SelectedIndex + 1;
            medicalHistory.Treatment = TreatmentTextBox.Text;
            medicalHistory.DateOfTheDisease = (DateTime)DiseaseDatePicker.SelectedDate;
            medicalHistory.DateOfCure = (DateTime)RecoveryDatePicker.SelectedDate;
            medicalHistory.IDTypeOfTreatment = TreatmentTypeComboBox.SelectedIndex + 1;

            if (IsEdit)
            {
                //MessageBox.Show("Происходит редактирование записи!", "Редактирование записи");

                try
                {
                    if (HealthCenterEntities.GetContext().SaveChanges() == 1)
                    {
                        MessageBox.Show("Запись посещения успешно редактирована!", "Успешное сохранение");
                        Manager.NavigationFrame.GoBack();
                    }
                    else
                    {
                        MessageBox.Show("Изменение записи не произошло!", "Ошибка сохранения");
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Изменение записи не произошло!" + ex.Message.ToString(), "Ошибка сохранения");
                }
            }
            else
            {
                //MessageBox.Show("Происходит добавление записи!", "Добавление записи");

                HealthCenterEntities.GetContext().MedicalHistory.Add(medicalHistory);
                try
                {
                    if (HealthCenterEntities.GetContext().SaveChanges() == 1)
                    {
                        MessageBox.Show("Запись посещения успешно добавлена!", "Успешное сохранение");
                        Manager.NavigationFrame.GoBack();
                    }
                    else
                    {
                        MessageBox.Show("Добавление записи не произошло!", "Ошибка сохранения");
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Добавление записи не произошло!" + ex.Message.ToString(), "Ошибка сохранения");
                }
            }
        }
    }
}
