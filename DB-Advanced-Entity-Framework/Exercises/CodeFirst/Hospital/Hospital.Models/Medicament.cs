namespace Hospital.Models
{
    using System.ComponentModel.DataAnnotations;

    public class Medicament
    {
        public int Id { get; set; }

        [Required]
        public string Name { get; set; }

        public int PatientId { get; set; }

        public virtual Patient Patient { get; set; }
    }
}