using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace RecipeApp
{
    public partial class MainFrm : Form
    {
        Int32 rowselect;
        public MainFrm()
        {
            InitializeComponent();
           
        }

        private void MainFrm_Load(object sender, EventArgs e)
        {
            
            try
            {
                // TODO: This line of code loads data into the 'ra_dataset.RecipeIngredient' table. You can move, or remove it, as needed.
            this.recipeIngredientTableAdapter.Fill_RecipeIngredientData(this.ra_dataset.RecipeIngredient);
            // TODO: This line of code loads data into the 'ra_dataset.Measure' table. You can move, or remove it, as needed.
            this.measureTableAdapter.Fill_MeasureData(this.ra_dataset.Measure);
            // TODO: This line of code loads data into the 'ra_dataset.Ingredient' table. You can move, or remove it, as needed.
            this.ingredientTableAdapter.Fill_IngredientData(this.ra_dataset.Ingredient);
            // TODO: This line of code loads data into the 'ra_dataset.Recipe' table. You can move, or remove it, as needed.
            this.recipeTableAdapter.Fill_RecipeData(this.ra_dataset.Recipe);
            // TODO: This line of code loads data into the 'ra_dataset.RecipeImage' table. You can move, or remove it, as needed.
            this.recipeImageTableAdapter.Fill_RecimeImageData(this.ra_dataset.RecipeImage);
            // TODO: This line of code loads data into the 'ra_dataset.Review' table. You can move, or remove it, as needed.
            this.reviewTableAdapter.Fill_ReviewData(this.ra_dataset.Review);
            // TODO: This line of code loads data into the 'ra_dataset.ReviewImage' table. You can move, or remove it, as needed.
            this.reviewImageTableAdapter.Fill_ReviewImageData(this.ra_dataset.ReviewImage);
            // TODO: This line of code loads data into the 'ra_dataset.Users' table. You can move, or remove it, as needed.
            this.usersTableAdapter.Fill_UserData(this.ra_dataset.Users);
            // TODO: This line of code loads data into the 'ra_dataset.AllTables' table. You can move, or remove it, as needed.
            this.allTablesTableAdapter.Fill_all_data(this.ra_dataset.AllTables);

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            //INITIAL STATE 
            //---disable save and cancel btns
            this.savebtn.Enabled = false;
            this.cancelbtn.Enabled = false;
            //disable groupbox1 and enable datagridview
            this.groupBox1.Enabled = false;
            //disable auto select on tables
            clearSelect();
            //enable all tables grid view
            tablegridview_true();

        }
        void clearSelect()
        {

            this.usersDataGridView.ClearSelection();
            this.recipeImageDataGridView.ClearSelection();
            this.reviewImageDataGridView.ClearSelection();
            this.recipeDataGridView.ClearSelection();
            this.reviewDataGridView.ClearSelection();
            this.ingredientDataGridView.ClearSelection();
            this.measureDataGridView.ClearSelection();
            this.recipeIngredientDataGridView.ClearSelection();
        }
        void tablegridview_true()
        {
            this.usersDataGridView.Enabled = true;
            this.recipeImageDataGridView.Enabled = true;
            this.reviewImageDataGridView.Enabled = true;
            this.recipeDataGridView.Enabled = true;
            this.reviewDataGridView.Enabled = true;
            this.ingredientDataGridView.Enabled = true;
            this.measureDataGridView.Enabled = true;
            this.recipeIngredientDataGridView.Enabled = true;
        }
        void tablegridview_false()
        {
            this.usersDataGridView.Enabled = false;
            this.recipeImageDataGridView.Enabled = false;
            this.reviewImageDataGridView.Enabled = false;
            this.recipeDataGridView.Enabled = false;
            this.reviewDataGridView.Enabled = false;
            this.ingredientDataGridView.Enabled = false;
            this.measureDataGridView.Enabled = false;
            this.recipeIngredientDataGridView.Enabled = false;
        }

        private void deletebtn_Click(object sender, EventArgs e)
        {
            //delete button will show an error message for attemps on deleting from tables with no records: on the table event methods down below
            //------------------------
            //call up a method to disable the add new record, edit record, and delete record buttons
            new_edit_delete_btn_enable();
            this.groupBox1.Enabled = false;
            //delete record
            remove_data();
        }
        private void newbtn_Click(object sender, EventArgs e)
        {
            //call up a method to disable the add new record, edit record, and delete record buttons
            new_edit_delete_btn_enable();
            //add new record, call the add_data() method
            add_data();
        }

        private void editbtn_Click(object sender, EventArgs e)
        {
            //delete button will show an error message for attemps on deleting from tables with no records: on the table event methods down below
            //------------------------
            //call up a method to disable the add new record, edit record, and delete record buttons
            new_edit_delete_btn_enable();

        }

        private void savebtn_Click(object sender, EventArgs e)
        {
            // call up a method to disable the save and cancel buttons
            save_cancel_btn_enable();
            //update record, endedit is telling the controls to finishing the editing, we want to update the controls
            //(may need to if statements)
            //then call update_data to update the records in the database 
            update_dataendedit();

            //if r is 0 then nothing is saved, if r is greater than 0 then the record(s) were updated successfully
            update_data();
        }
        private void cancelbtn_Click(object sender, EventArgs e)
        {
            // call up a method to disable the save and cancel buttons
            save_cancel_btn_enable();
            //--------- cancel changes--------------
            //reject_data will rollback the changes (may need to change the outside if statement checks)
            reject_data();
            //cancels the edit operation on the table(s)
            canceledit_data();
            //disable auto select on tables to reset to original state
            clearSelect();
            //--------------------------------------
        }

        void new_edit_delete_btn_enable()
        {
            //disable add new, edit, and delete btns when one of the three are selected. 
            this.newbtn.Enabled = false;
            this.editbtn.Enabled = false;
            this.deletebtn.Enabled = false;
            //--enable save and canel btns
            this.savebtn.Enabled = true;
            this.cancelbtn.Enabled = true;
            //enable groupbox1 and disable datagridview 
            this.groupBox1.Enabled = true;
            tablegridview_false();


        }

        void save_cancel_btn_enable()
        {
            //---disable save and cancel btns when one of the two are selected. 
            this.savebtn.Enabled = false;
            this.cancelbtn.Enabled = false;
            //--enable  add new, edit, and delete btns to reset back to original state
            this.editbtn.Enabled = true;
            this.newbtn.Enabled = true;
            this.deletebtn.Enabled = true;
            //disable groupbox1 and enable datagridview
            this.groupBox1.Enabled = false;
            tablegridview_true();
        }
        
        void add_data()
        {
            //----------- add new record in tables(s)-------------
            if (usersBindingSource != null)
            {
                rowselect = this.usersDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.usersBindingSource.AddNew();
                }
            }
            if (recipeImageBindingSource != null)
            {
                rowselect = this.recipeImageDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.recipeImageBindingSource.AddNew();
                }
            }
            if (reviewImageBindingSource != null)
            {
                rowselect = this.reviewImageDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.reviewImageBindingSource.AddNew();
                }
            }
            if (recipeBindingSource != null)
            {
                rowselect = this.recipeDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.recipeBindingSource.AddNew();
                }
            }
            if (reviewBindingSource != null)
            {
                rowselect = this.reviewDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.reviewBindingSource.AddNew();
                }
            }
            if (ingredientBindingSource != null)
            {
                rowselect = this.ingredientDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.ingredientBindingSource.AddNew();
                }
            }
            if (measureBindingSource != null)
            {
                rowselect = this.measureDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.measureBindingSource.AddNew();
                }
            }
            if (recipeIngredientBindingSource != null)
            {
                rowselect = this.recipeIngredientDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.recipeIngredientBindingSource.AddNew();
                }
            }
        }

        void remove_data()
        {
            //----------- delete record in table(s)-------------
            //create a global variable for all the tables, 
            //on each table click event, if the table is clicked, then set global variable to that table and delete
            if (usersBindingSource!=null) {
                rowselect = this.usersDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.usersBindingSource.RemoveCurrent();
                }
            }
            if (recipeImageBindingSource != null)
            {
                rowselect = this.recipeImageDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.recipeImageBindingSource.RemoveCurrent();
                }
            }
            if (reviewImageBindingSource != null)
            {
                rowselect = this.reviewImageDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.reviewImageBindingSource.RemoveCurrent();
                }
            }
            if (recipeBindingSource != null)
            {
                rowselect = this.recipeDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.recipeBindingSource.RemoveCurrent();
                }
            }
            if (reviewBindingSource != null)
            {
                rowselect = this.reviewDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.reviewBindingSource.RemoveCurrent();
                }
            }
            if (ingredientBindingSource != null)
            {
                rowselect = this.ingredientDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.ingredientBindingSource.RemoveCurrent();
                }
            }
            if (measureBindingSource != null)
            {
                rowselect = this.measureDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.measureBindingSource.RemoveCurrent();
                }
            }
            if (recipeIngredientBindingSource != null)
            {
                rowselect = this.recipeIngredientDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.recipeIngredientBindingSource.RemoveCurrent();
                }
            }  
        }
        void reject_data()
        {
            //rollback the changes for the table(s)
            if (usersBindingSource != null)
            {
                rowselect = this.usersDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.ra_dataset.Users.RejectChanges();
                }
            }
            if (recipeImageBindingSource != null)
            {
                rowselect = this.recipeImageDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.ra_dataset.RecipeImage.RejectChanges();
                }
            }
            if (reviewImageBindingSource != null)
            {
                rowselect = this.reviewImageDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.ra_dataset.ReviewImage.RejectChanges();
                }
            }
            if (recipeBindingSource != null)
            {
                rowselect = this.recipeDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.ra_dataset.Recipe.RejectChanges();
                }
            }
            if (reviewBindingSource != null)
            {
                rowselect = this.reviewDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.ra_dataset.Review.RejectChanges();
                }
            }
            if (ingredientBindingSource != null)
            {
                rowselect = this.ingredientDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.ra_dataset.Ingredient.RejectChanges();
                }
            }
            if (measureBindingSource != null)
            {
                rowselect = this.measureDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.ra_dataset.Measure.RejectChanges();
                }
            }
            if (recipeIngredientBindingSource != null)
            {
                rowselect = this.recipeIngredientDataGridView.SelectedCells.Count;
                if (rowselect > 0)
                {
                    this.ra_dataset.RecipeIngredient.RejectChanges();
                }
            }
        }
        void canceledit_data()
        {
            //cancels edit operation for all tables
            this.usersBindingSource.CancelEdit();
            this.recipeImageBindingSource.CancelEdit();
            this.reviewImageBindingSource.CancelEdit();
            this.recipeBindingSource.CancelEdit();
            this.reviewBindingSource.CancelEdit();
            this.ingredientBindingSource.CancelEdit();
            this.measureBindingSource.CancelEdit();
            this.recipeIngredientBindingSource.CancelEdit();
        }


        void update_dataendedit()
        {
            //finish editing in table(s)
            this.usersBindingSource.EndEdit();
            this.recipeImageBindingSource.EndEdit();
            this.reviewImageBindingSource.EndEdit();
            this.recipeBindingSource.EndEdit();
            this.reviewBindingSource.EndEdit();
            this.ingredientBindingSource.EndEdit();
            this.measureBindingSource.EndEdit();
            this.recipeIngredientBindingSource.EndEdit();

        }
        void update_data()
        {
            //update record in table(s)
            if (usersDataGridView.CellClick) { 
            try
            {
                rowselect = this.usersTableAdapter.Update(this.ra_dataset.Users);
                if (rowselect > 0)
                {
                    MessageBox.Show("User Saved!");
                }
                else
                {
                    MessageBox.Show("User Not Saved!");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);

            }
        }

            /*
            try
            {
                r = this.recipeImageTableAdapter.Update(this.ra_dataset.RecipeImage);
                if (r > 0)
                {
                    MessageBox.Show("Saved!");
                }
                else
                {
                    MessageBox.Show("Not Saved!");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);

            }
            try
            {
                r = this.reviewImageTableAdapter.Update(this.ra_dataset.ReviewImage);
                if (r > 0)
                {
                    MessageBox.Show("Saved!");
                }
                else
                {
                    MessageBox.Show("Not Saved!");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);

            }
            try
            {
                r = this.recipeTableAdapter.Update(this.ra_dataset.Recipe);
                if (r > 0)
                {
                    MessageBox.Show("Saved!");
                }
                else
                {
                    MessageBox.Show("Not Saved!");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);

            }
            try
            {
                r = this.reviewTableAdapter.Update(this.ra_dataset.Review);
                if (r > 0)
                {
                    MessageBox.Show("Saved!");
                }
                else
                {
                    MessageBox.Show("Not Saved!");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);

            }
            try
            {
                r = this.ingredientTableAdapter.Update(this.ra_dataset.Ingredient);
                if (r > 0)
                {
                    MessageBox.Show("Saved!");
                }
                else
                {
                    MessageBox.Show("Not Saved!");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);

            }
            try
            {
                r = this.measureTableAdapter.Update(this.ra_dataset.Measure);
                if (r > 0)
                {
                    MessageBox.Show("Saved!");
                }
                else
                {
                    MessageBox.Show("Not Saved!");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);

            }
            try
            {
                r = this.recipeIngredientTableAdapter.Update(this.ra_dataset.RecipeIngredient);
                if (r > 0)
                {
                    MessageBox.Show("Saved!");
                }
                else
                {
                    MessageBox.Show("Not Saved!");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);

            }
            */

        }

        private void UsersDataGridView_Click(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }

        //If a table is clicked on for editing or deleting a record and there is no data in the table, then show an error message for that table
        private void usersDataGridView_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            //call rowselect function: if the row count is 0 then return an error
            rowselect = this.ra_dataset.Users.Rows.Count;
            if (rowselect == 0)
            {
                if (deletebtn.Checked)
                {
                    MessageBox.Show("Please select your record to delete!");
                    return;
                }
                else if (editbtn.Checked)
                {
                    {
                        MessageBox.Show("Please select your record to edit!");
                        return;
                    }

                }
            }
        }

        private void recipeImageDataGridView_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            //call rowselect function: if the row count is 0 then return an error
            rowselect = this.ra_dataset.RecipeImage.Rows.Count;
            if (rowselect == 0)
            {
                if (deletebtn.Checked)
                {
                    MessageBox.Show("Please select your record to delete!");
                    return;
                }
                else if (editbtn.Checked)
                {
                    {
                        MessageBox.Show("Please select your record to edit!");
                        return;
                    }

                }
            }
        }

        private void reviewImageDataGridView_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            //call rowselect function: if the row count is 0 then return an error
            rowselect = this.ra_dataset.ReviewImage.Rows.Count;
            if (rowselect == 0)
            {
                if (deletebtn.Checked)
                {
                    MessageBox.Show("Please select your record to delete!");
                    return;
                }
                else if (editbtn.Checked)
                {
                    {
                        MessageBox.Show("Please select your record to edit!");
                        return;
                    }

                }
            }
        }

        private void recipeDataGridView_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            //call rowselect function: if the row count is 0 then return an error
            rowselect = this.ra_dataset.Recipe.Rows.Count;
            if (rowselect == 0)
            {
                if (deletebtn.Checked)
                {
                    MessageBox.Show("Please select your record to delete!");
                    return;
                }
                else if (editbtn.Checked)
                {
                    {
                        MessageBox.Show("Please select your record to edit!");
                        return;
                    }

                }
            }
        }

        private void reviewDataGridView_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            //call rowselect function: if the row count is 0 then return an error
            rowselect = this.ra_dataset.Review.Rows.Count;
            if (rowselect == 0)
            {
                if (deletebtn.Checked)
                {
                    MessageBox.Show("Please select your record to delete!");
                    return;
                }
                else if (editbtn.Checked)
                {
                    {
                        MessageBox.Show("Please select your record to edit!");
                        return;
                    }

                }
            }
        }

        private void ingredientDataGridView_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            //call rowselect function: if the row count is 0 then return an error
            rowselect = this.ra_dataset.Ingredient.Rows.Count;
            if (rowselect == 0)
            {
                if (deletebtn.Checked)
                {
                    MessageBox.Show("Please select your record to delete!");
                    return;
                }
                else if (editbtn.Checked)
                {
                    {
                        MessageBox.Show("Please select your record to edit!");
                        return;
                    }

                }
            }
        }

        private void measureDataGridView_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            //call rowselect function: if the row count is 0 then return an error
            rowselect = this.ra_dataset.Measure.Rows.Count;
            if (rowselect == 0)
            {
                if (deletebtn.Checked)
                {
                    MessageBox.Show("Please select your record to delete!");
                    return;
                }
                else if (editbtn.Checked)
                {
                    {
                        MessageBox.Show("Please select your record to edit!");
                        return;
                    }

                }
            }
        }

        private void recipeIngredientDataGridView_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            //call rowselect function: if the row count is 0 then return an error
            rowselect = this.ra_dataset.RecipeIngredient.Rows.Count;
            if (rowselect == 0)
            {
                if (deletebtn.Checked)
                {
                    MessageBox.Show("Please select your record to delete!");
                    return;
                }
                else if (editbtn.Checked)
                {
                    {
                        MessageBox.Show("Please select your record to edit!");
                        return;
                    }

                }
            }
        }
    }
}
