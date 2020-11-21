page 50000 "SDH Working Days"
{
    PageType = Card;
    ApplicationArea = All;
    Caption = 'Working Days';
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            group(Input)
            {
                field("Start Date"; StartDate)
                {
                    ApplicationArea = All;
                }
                field("End Date"; EndDate)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        IF EndDate < StartDate THEN
                            Error('End Date Should be Greater Than Start Date!');
                    end;
                }
            }
            group(Results)
            {
                field("Total Days"; TotalDays)
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Working Days"; WorkingDays)
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Non-Working Days"; NonWorkingDays)
                {
                    ApplicationArea = All;
                    Editable = False;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CountWorkingDays)
            {
                ApplicationArea = All;
                Promoted = True;
                Image = Calculate;
                trigger OnAction()
                var
                    WorkingDaysCalc: Codeunit "SDH Calc Working Days";
                begin
                    WorkingDaysCalc.CalculateWorkingDays(StartDate, EndDate, WorkingDays, NonWorkingDays, TotalDays);
                end;
            }
        }
    }

    var
        StartDate: Date;
        EndDate: Date;
        WorkingDays: Integer;
        NonWorkingDays: Integer;
        TotalDays: Integer;
}