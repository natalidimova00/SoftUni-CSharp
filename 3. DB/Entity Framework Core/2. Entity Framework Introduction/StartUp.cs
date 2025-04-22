using SoftUni.Data;
using System.Text;

namespace SoftUni
{
    public class StartUp
    {
        public static void Main()
        {
            var context = new SoftUniContext();
            Console.WriteLine(GetEmployeesWithSalaryOver50000(context));

        }

        // 03
        public static string GetEmployeesFullInformation(SoftUniContext context)
        {
            // option 1

            /*
            return string.Join(Environment.NewLine, context.Employees
                .Select(e => $"{e.FirstName} {e.LastName} {e.MiddleName} {e.JobTitle} {e.Salary:f2}")
                .ToList());
            */

            // option 2

            var employees = context.Employees
                .Select(e => new
                {
                    e.FirstName,
                    e.LastName,
                    e.MiddleName,
                    e.JobTitle,
                    e.Salary
                })
                .ToList();

            var sb = new StringBuilder();
            foreach (var e in employees)
            {
                sb.AppendLine($"{e.FirstName} {e.LastName} {e.MiddleName} {e.JobTitle} {e.Salary:f2}");
            }
            return sb.ToString().TrimEnd();
        }

        // 04
        public static string GetEmployeesWithSalaryOver50000(SoftUniContext context)
        {
            var richEmployees = context.Employees
                .Where(e => e.Salary > 50000)
                .Select(e => new 
                {
                    e.FirstName,
                    e.Salary
                })
                .OrderBy(e => e.FirstName)
                .ToList();

            var sb = new StringBuilder();

            foreach (var e in richEmployees)
            {
                sb.AppendLine($"{e.FirstName} - {e.Salary:f2}");
            }

            return sb.ToString().TrimEnd();
        }
    }
}