--魔救の分析者

--Scripted by mallu11
function c100414003.initial_effect(c)
	--spsummon1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100414003,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,100414003)
	e1:SetCondition(c100414003.spcon1)
	e1:SetTarget(c100414003.sptg1)
	e1:SetOperation(c100414003.spop1)
	c:RegisterEffect(e1)
	--spsummon2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100414003,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,100414103)
	e2:SetTarget(c100414003.sptg2)
	e2:SetOperation(c100414003.spop2)
	c:RegisterEffect(e2)
end
function c100414003.spcon1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0 and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
end
function c100414003.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c100414003.spop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c100414003.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>4 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,0,tp,LOCATION_DECK)
end
function c100414003.spfilter(c,e,tp)
	return not c:IsType(TYPE_TUNER) and c:IsLevelBelow(4) and c:IsRace(RACE_ROCK) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100414003.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=4 then return end
	Duel.ConfirmDecktop(tp,5)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local g=Duel.GetDecktopGroup(tp,5)
	if g:GetCount()>0 and g:FilterCount(c100414003.spfilter,nil,e,tp)>0 and Duel.SelectYesNo(tp,aux.Stringid(100414003,2)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		Duel.DisableShuffleCheck()
		local sg=g:FilterSelect(tp,c100414003.spfilter,1,1,nil,e,tp)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		local ct=g:GetCount()-sg:GetCount()
		if ct>0 then
			Duel.SortDecktop(tp,tp,ct)
			for i=1,ct do
				local mg=Duel.GetDecktopGroup(tp,1)
				Duel.MoveSequence(mg:GetFirst(),1)
			end
		end
	end
end
