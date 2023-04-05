/* decision variables */
var paliwa_silnikowe       >=0;
var domowe_paliwa_olejowe  >=0;
var ciezkie_paliwa_olejowe >=0;
var B1                     >=0;
var B2                     >=0;
var olej_B1_ciezkie        >=0;
var olej_B1_domowe         >=0;
var destylat_B1_krak       >=0;
var destylat_B1_ciezkie    >=0;
var olej_B2_ciezkie        >=0;
var olej_B2_domowe         >=0;
var destylat_B2_krak       >=0;
var destylat_B2_ciezkie    >=0;

/* objective function represents cost */
minimize cost: 1300*B1 + 1500*B2 + 10*(B1+B2) + 20*(destylat_B1_krak + destylat_B2_krak);

/* constraints */
s.t. ciezkie_skladniki: ciezkie_paliwa_olejowe <= 0.25*B2+0.15*B1+destylat_B2_ciezkie+destylat_B1_ciezkie+olej_B1_ciezkie+olej_B2_ciezkie+0.06*(destylat_B1_krak+destylat_B2_krak);
s.t. domowe_skladniki: olej_B1_domowe+olej_B2_domowe+0.2*(destylat_B1_krak+destylat_B2_krak) >= domowe_paliwa_olejowe;
s.t. silnikowe_skladniki: 0.15*B1+0.1*B2+0.5*(destylat_B1_krak+destylat_B2_krak) >= paliwa_silnikowe;

s.t. rozdz_dest_B2: destylat_B2_krak + destylat_B2_ciezkie = 0.2*B2;
s.t. rozdz_dest_B1: destylat_B1_krak + destylat_B1_ciezkie = 0.15*B1;
s.t. rozdz_olej_B2: olej_B2_ciezkie + olej_B2_domowe = 0.35*B2;
s.t. rozdz_olej_B1: olej_B1_ciezkie + olej_B1_domowe = 0.4*B1;

s.t. requirements_silnikowe:  paliwa_silnikowe				                >= 200000;
s.t. requirements_domowe:             domowe_paliwa_olejowe            		>= 400000;
s.t. requirements_ciezkie:                          ciezkie_paliwa_olejowe  >= 250000;

s.t. siarka: domowe_paliwa_olejowe*0.005 >= 0.002*olej_B1_domowe + 0.012*olej_B2_domowe + destylat_B1_krak*0.2*0.003 + destylat_B2_krak*0.2*0.025;


end;
