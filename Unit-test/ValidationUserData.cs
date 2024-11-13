using System;
using System.Text;

namespace Application.Unit_test
{
    public class ValidationUserDataClass
    {
        public static string ValidationUserData(int patient, int doctor, int diagnoses, int typeTreatment, string treatment, DateTime diseaseDate, DateTime recoveryDate)
        {
            StringBuilder errors = new StringBuilder();
            bool dateCheck = true;

            if (patient == -1)
            {
                return "patient not select";
            }
            if (doctor == -1)
            {
                return "doctor not select";
            }
            if (diagnoses == -1)
            {
                return "diagnoses not select";
            }
            if (typeTreatment == -1)
            {
                return "type treatment not select";
            }

            if (string.IsNullOrEmpty(treatment) || string.IsNullOrWhiteSpace(treatment))
            {
                return "treatment is empty";
            }

            if (diseaseDate == new DateTime())
            {
                dateCheck = false;
                return "disease date not select";
            }
            if (recoveryDate == new DateTime())
            {
                dateCheck = false;
                return "recovery date not select";
            }
            if (dateCheck == true && diseaseDate > recoveryDate)
            {
                return "disease date is longer recovery date";
            }

            return "succsess";
        }
    }
}
