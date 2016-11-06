namespace Hospital.Models
{
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

    [Table(name: "Diagnoses")]
    public class Diagnosis
    {
        public int Id { get; set; }

        [MaxLength(200)]
        [Required]
        public string Name { get; set; }

        [MaxLength(500)]
        public string Comments { get; set; }

        public int PatientId { get; set; }

        public virtual Patient patient { get; set; }
    }
}