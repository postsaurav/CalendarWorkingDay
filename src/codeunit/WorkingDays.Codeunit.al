codeunit 50000 "SDH Calc Working Days"
{
    procedure CalculateWorkingDays(StartDate: Date; EndDate: Date; Var WorkingDays: Integer; Var NonWorkingDays: Integer; Var TotalDays: Integer)
    begin
        ClearValues(WorkingDays, NonWorkingDays, TotalDays);
        CheckMinimumRequired(StartDate, EndDate);
        CountDays(StartDate, EndDate, WorkingDays, NonWorkingDays, TotalDays);
    end;

    local procedure CheckMinimumRequired(StartDate: Date; EndDate: Date)
    var
        CompanyInfo: Record "Company Information";
    begin
        IF (StartDate = 0D) or (EndDate = 0D) then
            Error('Start Date and End Date is Mandatory.');

        CompanyInfo.Get;
        CompanyInfo.TESTFIELD("Base Calendar Code");
    end;

    local procedure CountDays(StartDate: Date; EndDate: Date; Var WorkingDays: Integer; Var NonWorkingDays: Integer; Var TotalDays: Integer)
    var
        CalenderMgmt: Codeunit "Calendar Management";
        CustomCalenderChange: Record "Customized Calendar Change";
        CompanyInformation: Record "Company Information";
        CheckDate: Date;
    begin
        CompanyInformation.Get();
        CalenderMgmt.SetSource(CompanyInformation, CustomCalenderChange);
        TotalDays := (EndDate - StartDate) + 1;
        CheckDate := StartDate;
        repeat
            IF CalenderMgmt.IsNonworkingDay(CheckDate, CustomCalenderChange) THEN
                NonWorkingDays += 1;
            CheckDate := CalcDate('<1D>', CheckDate);
        until (CheckDate > EndDate);
        WorkingDays := TotalDays - NonWorkingDays;
    end;

    local procedure ClearValues(var WorkingDays: Integer; var NonWorkingDays: Integer; var TotalDays: Integer)
    begin
        Clear(WorkingDays);
        Clear(TotalDays);
        Clear(NonWorkingDays);
    end;
}