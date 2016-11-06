namespace Hospital.ConsoleClient
{
    using System;
    using System.Linq;
    using Data;
    using Models;

    public class Startup
    {
        public static void Main()
        {
            var db = new HospitalContext();
            using (db)
            {
                if (!db.Patients.Any())
                {
                    InsertInitialData(db);
                }
            }
        }

        #region DataInsertion
        private static void InsertInitialData(HospitalContext context)
        {
            var firstPatient = new Patient
            {
                Id = 1,
                FirstName = "Ivan",
                LastName = "Ivanov",
                Address = "Sofia",
                HasInsurance = true,
                Email = "ivo@ivanov.bg",
                GeneralPhysicianID = 1
            };

            var secondPatient = new Patient
            {
                Id = 2,
                FirstName = "Maria",
                LastName = "Ivanova",
                Address = "Sofia",
                HasInsurance = false,
                Email = "mimi@provider.bg",
                GeneralPhysicianID = 1
            };

            context.Patients.Add(firstPatient);
            context.Patients.Add(secondPatient);

            var otitis = new Diagnosis
            {
                Name = "Otitis",
                Comments = "Type - Acute, Symptoms - Severe",
                PatientId = 1
            };

            var migrane = new Diagnosis
            {
                Name = "Migrane",
                Comments = "Type - Chronic, Symptoms - on and off, non-severe",
                PatientId = 2
            };

            context.Diagnoses.Add(otitis);
            context.Diagnoses.Add(migrane);

            var morningVisit = new Visitation
            {
                Date = new DateTime(2016, 12, 10),
                Comments = "Patient has sever pain",
                PatientId = 1
            };

            var eveningVisit = new Visitation
            {
                Date = new DateTime(2016, 12, 11),
                Comments = "Full MRI scan show no signs of malignant formations.",
                PatientId = 2
            };

            context.Visitations.Add(morningVisit);
            context.Visitations.Add(eveningVisit);

            var aspirin = new Medicament
            {
                Name = "Aspirin",
                PatientId = 1
            };

            var vicodin = new Medicament
            {
                Name = "Vicodin",
                PatientId = 2
            };

            context.Medicaments.Add(aspirin);
            context.Medicaments.Add(vicodin);

            var gp = new GeneralPhysician
            {
                Id = 1,
                FirstName = "Rada",
                LastName = "Radeva",
                Email = "dr.radeva@rakia.bg",
                Password = "vodataevredna"
            };

            context.GeneralPhysicians.Add(gp);
        }
        #endregion
    }
}
