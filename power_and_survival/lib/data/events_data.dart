import '../models/event_model.dart';

class EventsData {
  static const List<EventModel> allEvents = [
    // ============================================================
    // ECONOMIC EVENTS (1-8)
    // ============================================================
    EventModel(
      id: 'economic_recession',
      title: 'Economic Recession Looms',
      description: 'GDP growth has turned negative for the second consecutive quarter. Unemployment is rising sharply as factories close and businesses downsize. Your economic advisors are split on whether to pursue austerity or stimulus spending. The central bank is warning of a potential banking crisis if action is not taken immediately.',
      category: 'economic',
      choices: [
        EventChoice(
          id: 'recession_stimulus',
          text: 'Launch a massive stimulus package — inject money into infrastructure projects, subsidize struggling industries, and extend unemployment benefits to keep people spending.',
          statEffects: {'economy': 8, 'happiness': 5, 'stability': 3, 'approvalRating': 5},
          treasuryCost: 150,
          debtIncrease: 80,
        ),
        EventChoice(
          id: 'recession_austerity',
          text: 'Implement austerity measures — cut government spending, freeze public sector wages, and reduce subsidies to balance the budget and restore market confidence.',
          statEffects: {'economy': 3, 'happiness': -10, 'stability': -5, 'approvalRating': -8, 'oppositionPower': 5},
        ),
        EventChoice(
          id: 'recession_tax_cut',
          text: 'Cut taxes for businesses and middle class to stimulate private sector growth, while maintaining essential services.',
          statEffects: {'economy': 5, 'happiness': 3, 'stability': 2, 'approvalRating': 3},
          treasuryCost: 100,
        ),
        EventChoice(
          id: 'recession_blame',
          text: 'Blame the previous administration and foreign markets. Launch a media campaign to deflect responsibility while making minimal changes.',
          statEffects: {'economy': -2, 'mediaTrust': -8, 'stability': -3, 'oppositionPower': 8, 'corruption': 5},
        ),
      ],
    ),
    EventModel(
      id: 'foreign_investment_offer',
      title: 'Foreign Investment Opportunity',
      description: 'A major multinational corporation wants to build a 2 billion dollar manufacturing complex in your country. They promise 50,000 new jobs but demand a 15-year tax holiday, relaxed environmental regulations, and exclusive access to your mineral resources. Your environmental minister is alarmed, but the finance minister sees it as a lifeline.',
      category: 'economic',
      choices: [
        EventChoice(
          id: 'investment_accept_full',
          text: 'Accept all their terms — the jobs and economic boost are worth the environmental and sovereignty concessions. Sign the deal immediately.',
          statEffects: {'economy': 12, 'happiness': 5, 'corruption': 8, 'internationalRelations': 5, 'health': -5},
          treasuryCost: -200,
        ),
        EventChoice(
          id: 'investment_negotiate',
          text: 'Negotiate harder terms — accept the investment but demand environmental standards, local hiring quotas, and a shorter tax holiday of 7 years.',
          statEffects: {'economy': 7, 'happiness': 3, 'internationalRelations': 3, 'approvalRating': 5},
          treasuryCost: -100,
        ),
        EventChoice(
          id: 'investment_reject',
          text: 'Reject the deal — your country\'s sovereignty and environment are not for sale. Announce a program to develop domestic industries instead.',
          statEffects: {'economy': -3, 'happiness': -2, 'internationalRelations': -5, 'mediaTrust': 5, 'stability': 3},
        ),
        EventChoice(
          id: 'investment_secret_deal',
          text: 'Quietly accept the deal with even more favorable terms for the corporation, skimming personal commissions through offshore accounts.',
          statEffects: {'economy': 10, 'corruption': 15, 'mediaTrust': -5, 'approvalRating': -3},
          treasuryCost: -150,
        ),
      ],
    ),
    EventModel(
      id: 'imf_bailout_demand',
      title: 'IMF Demands Austerity Package',
      description: 'Your country\'s debt has spiraled out of control. The International Monetary Fund is offering a bailout package of 5 billion dollars, but their conditions are brutal: slash public wages by 20%, privatize state enterprises, remove food and fuel subsidies, and open markets to foreign competition. Without the bailout, your country faces sovereign default within 3 months.',
      category: 'economic',
      statTriggers: {'debt': 700},
      choices: [
        EventChoice(
          id: 'imf_accept',
          text: 'Accept the IMF terms in full. It will be painful, but sovereign default would be catastrophic. Announce the reforms and brace for public anger.',
          statEffects: {'economy': 5, 'happiness': -15, 'stability': -10, 'oppositionPower': 15, 'approvalRating': -12, 'internationalRelations': 8},
          debtIncrease: -300,
          crisisChainTriggers: ['protest_chain'],
        ),
        EventChoice(
          id: 'imf_partial',
          text: 'Negotiate a partial package — accept some conditions but protect food subsidies and public wages. Take a smaller bailout with slower reform timeline.',
          statEffects: {'economy': 2, 'happiness': -5, 'stability': -3, 'oppositionPower': 5, 'internationalRelations': 3},
          debtIncrease: -150,
        ),
        EventChoice(
          id: 'imf_reject',
          text: 'Reject the IMF entirely. Announce economic sovereignty and seek alternative funding from allied nations. Print money if necessary.',
          statEffects: {'economy': -10, 'happiness': 5, 'stability': -8, 'internationalRelations': -15, 'mediaTrust': 5, 'approvalRating': 8},
          debtIncrease: 100,
        ),
      ],
    ),
    EventModel(
      id: 'stock_market_crash',
      title: 'Stock Market Crash',
      description: 'The national stock exchange has lost 40% of its value in three days. Banks are refusing to lend, businesses are freezing hiring, and middle-class families are watching their savings evaporate. Panicked investors are pulling money out of the country. Your finance minister looks pale as he briefs you on the cascading effects.',
      category: 'economic',
      choices: [
        EventChoice(
          id: 'crash_bank_guarantee',
          text: 'Guarantee all bank deposits and inject emergency liquidity into the banking system. Announce a market stabilization fund to restore confidence.',
          statEffects: {'economy': 5, 'stability': 5, 'happiness': 3, 'approvalRating': 5},
          treasuryCost: 200,
          debtIncrease: 100,
        ),
        EventChoice(
          id: 'crash_let_correct',
          text: 'Let the market correct itself naturally. Issue a calm statement that fundamentals are strong and this is a temporary adjustment.',
          statEffects: {'economy': -8, 'happiness': -8, 'stability': -5, 'mediaTrust': -3, 'approvalRating': -5},
        ),
        EventChoice(
          id: 'crash_capital_controls',
          text: 'Implement emergency capital controls — freeze foreign withdrawals, halt trading for 48 hours, and ban short-selling.',
          statEffects: {'economy': -3, 'stability': 3, 'internationalRelations': -10, 'happiness': -5},
        ),
        EventChoice(
          id: 'crash_blame_speculators',
          text: 'Blame foreign speculators and market manipulation. Launch an investigation and arrest several prominent traders as a show of force.',
          statEffects: {'economy': -5, 'stability': 2, 'internationalRelations': -8, 'mediaTrust': -5, 'approvalRating': 5, 'corruption': 5},
        ),
      ],
    ),
    EventModel(
      id: 'inflation_spike',
      title: 'Inflation Crisis',
      description: 'Inflation has hit 25% annually. The price of bread has doubled in three months. Citizens are struggling to afford basic necessities. Workers\' unions are threatening a general strike unless wages are increased. The central bank governor recommends raising interest rates sharply, but this could trigger a recession.',
      category: 'economic',
      choices: [
        EventChoice(
          id: 'inflation_raise_rates',
          text: 'Raise interest rates aggressively to crush inflation. Accept the short-term economic pain of slower growth and higher unemployment.',
          statEffects: {'economy': -5, 'happiness': -3, 'stability': 3, 'approvalRating': -3},
        ),
        EventChoice(
          id: 'inflation_price_controls',
          text: 'Implement price controls on essential goods — cap bread, fuel, and medicine prices. Subsidize the difference from the treasury.',
          statEffects: {'economy': -3, 'happiness': 8, 'stability': 5, 'approvalRating': 8},
          treasuryCost: 100,
        ),
        EventChoice(
          id: 'inflation_wage_increase',
          text: 'Mandate a 30% minimum wage increase to match inflation. Force businesses to absorb the cost.',
          statEffects: {'economy': -8, 'happiness': 10, 'stability': -3, 'approvalRating': 10, 'corruption': 3},
        ),
      ],
    ),
    EventModel(
      id: 'tax_revenue_collapse',
      title: 'Tax Revenue Collapse',
      description: 'Tax collections have fallen 35% below projections. A massive shadow economy has emerged as businesses avoid paying taxes through creative accounting, bribery, and offshore structures. Your tax authority is overwhelmed and underfunded. Without action, the government will run out of money within 6 months.',
      category: 'economic',
      choices: [
        EventChoice(
          id: 'tax_crackdown',
          text: 'Launch a major tax enforcement crackdown — hire auditors, raid evaders, impose heavy fines, and make examples of high-profile tax cheats.',
          statEffects: {'economy': 3, 'corruption': -8, 'happiness': -3, 'stability': -2, 'approvalRating': 3},
          treasuryCost: -80,
        ),
        EventChoice(
          id: 'tax_simplify',
          text: 'Simplify the tax code — lower rates but broaden the base. Make it easier and cheaper to comply than to cheat.',
          statEffects: {'economy': 5, 'corruption': -5, 'happiness': 5, 'approvalRating': 5},
          treasuryCost: -50,
        ),
        EventChoice(
          id: 'tax_amnesty',
          text: 'Offer a one-time tax amnesty — let evaders pay a reduced penalty with no criminal charges if they come clean and start paying.',
          statEffects: {'economy': 2, 'corruption': 3, 'happiness': 2, 'mediaTrust': -5, 'approvalRating': -3},
          treasuryCost: -60,
        ),
      ],
    ),
    EventModel(
      id: 'trade_agreement_offer',
      title: 'Regional Trade Agreement',
      description: 'Your neighboring country proposes a comprehensive free trade agreement. It would eliminate tariffs on 90% of goods, harmonize regulations, and create a shared economic zone. Local manufacturers fear competition from cheaper imports, but exporters see massive new markets. The agreement requires parliamentary approval.',
      category: 'economic',
      choices: [
        EventChoice(
          id: 'trade_accept',
          text: 'Champion the agreement — push it through parliament, emphasizing the economic growth potential and improved diplomatic relations.',
          statEffects: {'economy': 8, 'internationalRelations': 10, 'happiness': 3, 'approvalRating': 3, 'stability': 2},
        ),
        EventChoice(
          id: 'trade_modify',
          text: 'Accept with modifications — protect sensitive industries with transition periods and safeguard clauses for local businesses.',
          statEffects: {'economy': 5, 'internationalRelations': 5, 'happiness': 5, 'approvalRating': 5},
        ),
        EventChoice(
          id: 'trade_reject',
          text: 'Reject the deal — protect local industries and national economic independence. Announce a "Buy National" campaign instead.',
          statEffects: {'economy': -3, 'internationalRelations': -8, 'happiness': 3, 'stability': 2, 'oppositionPower': 3},
        ),
      ],
    ),
    EventModel(
      id: 'smuggling_network',
      title: 'Smuggling Network Discovered',
      description: 'Customs officials have uncovered a massive smuggling operation worth billions. The network stretches across your borders, involving corrupt officials, organized crime, and possibly members of your own government. The evidence suggests that some of your cabinet members may be connected.',
      category: 'economic',
      choices: [
        EventChoice(
          id: 'smuggling_full_investigation',
          text: 'Order a full, public investigation — no one is above the law. Fire any implicated officials and cooperate with international law enforcement.',
          statEffects: {'corruption': -10, 'stability': -5, 'mediaTrust': 8, 'approvalRating': 8, 'crime': -5},
          characterEffects: {'army_chief': -5, 'intelligence_chief': 5},
        ),
        EventChoice(
          id: 'smuggling_quiet_cleanup',
          text: 'Handle it quietly — remove the compromised officials, dismantle the network through back channels, and avoid a public scandal.',
          statEffects: {'corruption': -3, 'stability': 3, 'mediaTrust': -5, 'crime': -3},
        ),
        EventChoice(
          id: 'smuggling_take_cut',
          text: 'Take control of the network yourself — redirect the profits to fund your political operations while appearing to fight the problem.',
          statEffects: {'corruption': 15, 'crime': 5, 'stability': -3, 'mediaTrust': -3},
          treasuryCost: -200,
        ),
      ],
    ),

    // ============================================================
    // SOCIAL EVENTS (9-16)
    // ============================================================
    EventModel(
      id: 'food_price_crisis',
      title: 'Food Price Crisis',
      description: 'Staple food prices have risen 60% in just two months due to a combination of drought, supply chain disruptions, and speculative hoarding. Citizens in poor neighborhoods are going hungry. Supermarkets report panic buying and empty shelves. Community leaders warn that people are reaching a breaking point.',
      category: 'social',
      choices: [
        EventChoice(
          id: 'food_subsidize',
          text: 'Immediately subsidize basic food prices — cap the cost of bread, rice, and cooking oil. Deploy army trucks to distribute food in affected areas.',
          statEffects: {'happiness': 10, 'stability': 5, 'health': 3, 'approvalRating': 8},
          treasuryCost: 120,
          crisisChainTriggers: [],
        ),
        EventChoice(
          id: 'food_market_forces',
          text: 'Let market forces adjust prices naturally. Issue a statement that the government should not interfere with free markets.',
          statEffects: {'happiness': -12, 'stability': -8, 'health': -5, 'approvalRating': -10},
          followUpEventId: 'protest_stage_1',
        ),
        EventChoice(
          id: 'food_anti_hoarding',
          text: 'Launch anti-hoarding raids — send police to warehouses, arrest speculators, and redistribute stockpiled food at government-set prices.',
          statEffects: {'happiness': 5, 'stability': -3, 'crime': -3, 'mediaTrust': 3, 'approvalRating': 5},
          treasuryCost: 50,
        ),
        EventChoice(
          id: 'food_import_emergency',
          text: 'Declare a food emergency and import emergency food supplies from international partners. Accept foreign aid openly.',
          statEffects: {'happiness': 5, 'health': 5, 'internationalRelations': 5, 'stability': 3, 'approvalRating': 3},
          treasuryCost: 80,
          debtIncrease: 40,
        ),
      ],
    ),
    EventModel(
      id: 'hospital_shortage_emergency',
      title: 'Hospital Emergency Crisis',
      description: 'Hospitals across the country are running out of essential medicines, surgical supplies, and even basic painkillers. Doctors are performing surgeries without adequate anesthesia. Three children died this week because insulin was unavailable. The health minister is pleading for emergency funding.',
      category: 'social',
      choices: [
        EventChoice(
          id: 'hospital_emergency_fund',
          text: 'Declare a health emergency — release emergency funds, import medicines directly, and deploy military medical units to overwhelmed hospitals.',
          statEffects: {'health': 12, 'happiness': 8, 'stability': 5, 'approvalRating': 10},
          treasuryCost: 150,
        ),
        EventChoice(
          id: 'hospital_private_sector',
          text: 'Partner with private pharmaceutical companies — offer them tax breaks and fast-track approvals in exchange for supplying medicines at cost.',
          statEffects: {'health': 7, 'happiness': 3, 'corruption': 5, 'economy': 2, 'approvalRating': 3},
          treasuryCost: 50,
        ),
        EventChoice(
          id: 'hospital_foreign_aid',
          text: 'Request emergency medical aid from international health organizations and foreign governments. Accept whatever help is available.',
          statEffects: {'health': 8, 'happiness': 5, 'internationalRelations': 5, 'approvalRating': 5, 'mediaTrust': 3},
          treasuryCost: 30,
        ),
      ],
    ),
    EventModel(
      id: 'education_budget_protest',
      title: 'Education Funding Crisis',
      description: 'Universities across the country have gone on strike. Professors haven\'t been paid in three months. Students are protesting tuition hikes that have tripled in two years. The education minister has resigned in protest. Opposition leaders are using the crisis to galvanize support among young voters.',
      category: 'social',
      choices: [
        EventChoice(
          id: 'education_fund',
          text: 'Immediately restore education funding — pay back wages, freeze tuition increases, and announce a 5-year education investment plan.',
          statEffects: {'education': 10, 'happiness': 8, 'stability': 5, 'approvalRating': 8, 'oppositionPower': -5},
          treasuryCost: 120,
        ),
        EventChoice(
          id: 'education_reform',
          text: 'Acknowledge the crisis but propose structural reforms — merge inefficient institutions, introduce performance-based funding, and offer student loans.',
          statEffects: {'education': 5, 'happiness': 2, 'stability': -2, 'approvalRating': 2, 'economy': 2},
          treasuryCost: 60,
        ),
        EventChoice(
          id: 'education_suppress',
          text: 'Order police to clear the protests. Declare the strikes illegal and threaten to expel protesting students and fire striking professors.',
          statEffects: {'education': -5, 'happiness': -10, 'stability': -8, 'mediaTrust': -8, 'approvalRating': -10, 'oppositionPower': 10},
          followUpEventId: 'protest_stage_1',
        ),
      ],
    ),
    EventModel(
      id: 'unemployment_surge',
      title: 'Unemployment Surges to 25%',
      description: 'The unemployment rate has hit a record 25%. In some regions, youth unemployment exceeds 50%. Factories are closing, construction has halted, and even the service sector is shedding jobs. Desperate citizens are lining up at government employment offices that have nothing to offer them.',
      category: 'social',
      choices: [
        EventChoice(
          id: 'unemployment_public_works',
          text: 'Launch a massive public works program — build roads, bridges, schools, and hospitals. Create government jobs even if it means running a deficit.',
          statEffects: {'economy': 5, 'happiness': 8, 'stability': 5, 'approvalRating': 8, 'education': 2, 'health': 2},
          treasuryCost: 180,
          debtIncrease: 80,
        ),
        EventChoice(
          id: 'unemployment_business_incentives',
          text: 'Offer tax breaks and subsidies to businesses that hire new workers. Create enterprise zones with reduced regulations.',
          statEffects: {'economy': 8, 'happiness': 3, 'stability': 3, 'approvalRating': 3, 'corruption': 3},
          treasuryCost: 100,
        ),
        EventChoice(
          id: 'unemployment_retraining',
          text: 'Invest in worker retraining programs for emerging industries. Focus on technology, renewable energy, and digital skills.',
          statEffects: {'economy': 3, 'education': 8, 'happiness': 3, 'stability': 2, 'approvalRating': 3},
          treasuryCost: 80,
        ),
      ],
    ),
    EventModel(
      id: 'housing_crisis',
      title: 'Housing Crisis',
      description: 'Housing prices have skyrocketed 300% in five years. Young families cannot afford to buy or rent homes. Homelessness is visible on every major street. Developers are building luxury condos while ordinary citizens live in overcrowded slums. The housing minister admits the system is broken.',
      category: 'social',
      choices: [
        EventChoice(
          id: 'housing_public_program',
          text: 'Launch a public housing construction program — build 100,000 affordable units over 5 years with rent-to-own options for low-income families.',
          statEffects: {'happiness': 10, 'stability': 5, 'economy': 3, 'approvalRating': 8},
          treasuryCost: 200,
          debtIncrease: 100,
          promiseId: 'promise_housing',
        ),
        EventChoice(
          id: 'housing_rent_control',
          text: 'Implement strict rent control — cap rent increases, ban evictions without cause, and tax vacant properties to discourage speculation.',
          statEffects: {'happiness': 8, 'economy': -3, 'stability': 3, 'approvalRating': 8},
        ),
        EventChoice(
          id: 'housing_market_solution',
          text: 'Deregulate zoning and reduce building permits to encourage private construction. The market will solve the problem if we remove barriers.',
          statEffects: {'happiness': -3, 'economy': 5, 'stability': -2, 'approvalRating': -3, 'corruption': 3},
        ),
      ],
    ),
    EventModel(
      id: 'drug_epidemic_discovery',
      title: 'Drug Epidemic Sweeping the Nation',
      description: 'A synthetic drug epidemic is destroying communities across the country. Overdose deaths have tripled in one year. Emergency rooms are overwhelmed. The drug is cheap to produce and nearly impossible to detect at borders. Families are breaking apart, and entire neighborhoods are consumed by addiction.',
      category: 'social',
      choices: [
        EventChoice(
          id: 'drug_war',
          text: 'Declare a war on drugs — increase police funding, impose mandatory minimum sentences, and deploy the military to intercept drug shipments.',
          statEffects: {'crime': -8, 'happiness': -3, 'stability': -3, 'military': 3, 'approvalRating': 5, 'health': -2},
          treasuryCost: 100,
        ),
        EventChoice(
          id: 'drug_treatment',
          text: 'Treat addiction as a health crisis — fund rehabilitation centers, decriminalize personal use, and invest in prevention education.',
          statEffects: {'health': 8, 'happiness': 5, 'crime': -3, 'stability': 3, 'approvalRating': 3, 'education': 3},
          treasuryCost: 120,
        ),
        EventChoice(
          id: 'drug_ignore',
          text: 'Focus on other priorities. The drug problem is a personal choice issue, not a government responsibility.',
          statEffects: {'health': -8, 'happiness': -8, 'crime': 10, 'stability': -5, 'approvalRating': -8},
        ),
      ],
    ),
    EventModel(
      id: 'child_labor_report',
      title: 'International Child Labor Report',
      description: 'An international human rights organization has published a damning report documenting widespread child labor in your country. Children as young as 8 are working in mines, factories, and agricultural fields. The report includes photos and testimonies. International media is picking up the story.',
      category: 'social',
      choices: [
        EventChoice(
          id: 'child_labor_enforce',
          text: 'Acknowledge the problem and launch a comprehensive crackdown — enforce existing child labor laws, fund school enrollment programs, and punish violators harshly.',
          statEffects: {'education': 8, 'happiness': 5, 'internationalRelations': 8, 'mediaTrust': 8, 'approvalRating': 5, 'economy': -3},
          treasuryCost: 80,
        ),
        EventChoice(
          id: 'child_labor_deny',
          text: 'Deny the report\'s findings as exaggerated Western propaganda. Accuse the organization of having a political agenda against your country.',
          statEffects: {'internationalRelations': -10, 'mediaTrust': -8, 'approvalRating': 3, 'stability': -3},
        ),
        EventChoice(
          id: 'child_labor_gradual',
          text: 'Accept the findings but explain the economic reality — promise gradual reforms while providing financial support to families who depend on child income.',
          statEffects: {'education': 3, 'happiness': 3, 'internationalRelations': 3, 'mediaTrust': 3, 'approvalRating': 3},
          treasuryCost: 50,
        ),
      ],
    ),
    EventModel(
      id: 'homeless_camp_crisis',
      title: 'Homeless Camps in Capital',
      description: 'Tent cities have appeared in the capital\'s most prominent parks and public spaces. Thousands of homeless citizens, including families with children, are living in squalid conditions. The situation is a humanitarian crisis and a political embarrassment. Tourism is dropping as images spread internationally.',
      category: 'social',
      choices: [
        EventChoice(
          id: 'homeless_shelters',
          text: 'Open emergency shelters — convert unused government buildings, provide food and medical services, and create a pathway to permanent housing.',
          statEffects: {'happiness': 8, 'health': 5, 'stability': 5, 'approvalRating': 8, 'mediaTrust': 5},
          treasuryCost: 100,
        ),
        EventChoice(
          id: 'homeless_clear',
          text: 'Clear the camps — send police to remove the tents, relocate homeless people to facilities outside the city center, and clean up the parks.',
          statEffects: {'happiness': -8, 'stability': -5, 'mediaTrust': -10, 'approvalRating': -5, 'oppositionPower': 5},
        ),
        EventChoice(
          id: 'homeless_jobs',
          text: 'Create a work-for-shelter program — offer temporary jobs in city maintenance and cleaning in exchange for guaranteed shelter and meals.',
          statEffects: {'happiness': 5, 'economy': 2, 'stability': 3, 'approvalRating': 5},
          treasuryCost: 60,
        ),
      ],
    ),

    // ============================================================
    // POLITICAL EVENTS (17-24)
    // ============================================================
    EventModel(
      id: 'corruption_scandal_breaks',
      title: 'Major Corruption Scandal',
      description: 'Investigative journalists have uncovered evidence that senior members of your government have been embezzling public funds through fake infrastructure contracts. Bank records show millions flowing to offshore accounts. The media is calling it the biggest scandal in the country\'s history.',
      category: 'political',
      chainId: 'scandal_chain',
      chainStage: 1,
      nextChainEventId: 'scandal_chain_2',
      choices: [
        EventChoice(
          id: 'scandal_investigate',
          text: 'Order an independent investigation — fire the implicated officials, freeze their assets, and cooperate fully with the media and judiciary.',
          statEffects: {'corruption': -10, 'mediaTrust': 10, 'stability': -5, 'approvalRating': 8, 'oppositionPower': -3},
          characterEffects: {'finance_minister': -10},
        ),
        EventChoice(
          id: 'scandal_cover_up',
          text: 'Attempt to suppress the story — pressure media owners, threaten journalists, and launch a counter-narrative blaming foreign interference.',
          statEffects: {'corruption': 10, 'mediaTrust': -15, 'stability': -8, 'approvalRating': -10, 'oppositionPower': 10},
        ),
        EventChoice(
          id: 'scandal_sacrifice',
          text: 'Sacrifice the lowest-ranking officials — let them take the fall while protecting the senior members. Announce "swift justice" to satisfy the public.',
          statEffects: {'corruption': 3, 'mediaTrust': -5, 'stability': 2, 'approvalRating': -3},
        ),
        EventChoice(
          id: 'scandal_reform',
          text: 'Use the scandal as a catalyst for anti-corruption reform — propose new transparency laws, asset declaration requirements, and an independent anti-corruption agency.',
          statEffects: {'corruption': -8, 'mediaTrust': 8, 'stability': 3, 'approvalRating': 10, 'economy': 2},
          treasuryCost: 40,
        ),
      ],
    ),
    EventModel(
      id: 'opposition_press_conference',
      title: 'Opposition Press Conference',
      description: 'The opposition leader has called a dramatic press conference accusing your government of incompetence, corruption, and leading the country toward ruin. They presented a detailed "alternative government plan" and called for early elections. The conference was broadcast live and is trending on social media.',
      category: 'political',
      choices: [
        EventChoice(
          id: 'opposition_debate',
          text: 'Accept their challenge — propose a live televised debate between you and the opposition leader. Show the country you have nothing to hide.',
          statEffects: {'mediaTrust': 5, 'stability': 3, 'approvalRating': 5, 'oppositionPower': -5},
        ),
        EventChoice(
          id: 'opposition_counter',
          text: 'Hold your own press conference — present your achievements, counter their claims with data, and question their qualifications.',
          statEffects: {'mediaTrust': 3, 'stability': 2, 'approvalRating': 3, 'oppositionPower': -2},
        ),
        EventChoice(
          id: 'opposition_ignore',
          text: 'Ignore the opposition and focus on governing. Don\'t dignify their attacks with a response. Let your record speak for itself.',
          statEffects: {'stability': -2, 'approvalRating': -3, 'oppositionPower': 5},
        ),
        EventChoice(
          id: 'opposition_investigate',
          text: 'Order an investigation into the opposition leader\'s finances and personal life. Find something to discredit them.',
          statEffects: {'corruption': 8, 'mediaTrust': -8, 'stability': -5, 'oppositionPower': -3, 'approvalRating': -5},
        ),
      ],
    ),
    EventModel(
      id: 'parliament_boycott',
      title: 'Parliament Boycott',
      description: 'Opposition parties have walked out of parliament, refusing to participate until their demands are met. They want the resignation of your interior minister, a new election commission, and an independent investigation into recent policy decisions. Without their presence, parliament lacks quorum for major legislation.',
      category: 'political',
      choices: [
        EventChoice(
          id: 'boycott_negotiate',
          text: 'Open negotiations — invite opposition leaders for private talks, offer concessions on the election commission, and seek a compromise.',
          statEffects: {'stability': 5, 'oppositionPower': -3, 'approvalRating': 5, 'mediaTrust': 5},
        ),
        EventChoice(
          id: 'boycott_proceed',
          text: 'Proceed without them — change parliamentary rules to lower the quorum requirement and pass legislation with your majority alone.',
          statEffects: {'stability': -8, 'oppositionPower': 10, 'approvalRating': -5, 'mediaTrust': -8, 'corruption': 5},
        ),
        EventChoice(
          id: 'boycott_public_pressure',
          text: 'Appeal directly to the public — address the nation on TV, explain your position, and ask citizens to pressure opposition MPs to return.',
          statEffects: {'stability': 2, 'mediaTrust': 3, 'approvalRating': 5, 'oppositionPower': -2},
        ),
      ],
    ),
    EventModel(
      id: 'impeachment_motion_filed',
      title: 'Impeachment Motion Filed',
      description: 'Opposition lawmakers have filed a formal impeachment motion against you, citing abuse of power, economic mismanagement, and violation of constitutional norms. The motion needs a two-thirds majority to proceed. While you currently have enough allies to block it, some within your own party are wavering.',
      category: 'political',
      choices: [
        EventChoice(
          id: 'impeachment_fight',
          text: 'Fight the motion aggressively — rally your party, make deals with wavering MPs, and mount a legal defense. Address the nation to defend your record.',
          statEffects: {'stability': -5, 'oppositionPower': -5, 'approvalRating': 5, 'corruption': 3},
          characterEffects: {'vice_president': 5},
        ),
        EventChoice(
          id: 'impeachment_reform',
          text: 'Acknowledge the concerns and propose reforms — agree to some opposition demands in exchange for withdrawing the motion.',
          statEffects: {'stability': 5, 'oppositionPower': -3, 'approvalRating': 3, 'mediaTrust': 5, 'corruption': -3},
        ),
        EventChoice(
          id: 'impeachment_dissolve',
          text: 'Threaten to dissolve parliament and call snap elections. Make it clear that if they want a fight, you\'ll take it to the people.',
          statEffects: {'stability': -10, 'oppositionPower': -8, 'approvalRating': -5, 'mediaTrust': -3},
        ),
      ],
    ),
    EventModel(
      id: 'vice_president_criticism',
      title: 'Vice President Breaks Ranks',
      description: 'Your Vice President has given an unauthorized interview criticizing your economic policies and suggesting the country needs "new leadership with fresh ideas." The interview is widely interpreted as a direct challenge to your authority and possibly a signal of a planned leadership challenge.',
      category: 'political',
      isCharacterEvent: true,
      characterId: 'vice_president',
      choices: [
        EventChoice(
          id: 'vp_confront',
          text: 'Summon the Vice President for a private meeting. Remind them of their oath of loyalty and demand a public retraction.',
          statEffects: {'stability': -3, 'approvalRating': 2},
          characterEffects: {'vice_president': -10},
        ),
        EventChoice(
          id: 'vp_dismiss',
          text: 'Fire the Vice President immediately. Announce that disloyalty will not be tolerated and appoint a trusted ally as replacement.',
          statEffects: {'stability': -8, 'oppositionPower': 5, 'mediaTrust': -3, 'approvalRating': -3},
          characterEffects: {'vice_president': -30},
        ),
        EventChoice(
          id: 'vp_accommodate',
          text: 'Meet with the VP privately, listen to their concerns, and offer them more influence over economic policy. Keep friends close and rivals closer.',
          statEffects: {'stability': 3, 'approvalRating': 2, 'economy': 2},
          characterEffects: {'vice_president': 10},
        ),
      ],
    ),
    EventModel(
      id: 'senior_party_defection',
      title: 'Senior Party Defection',
      description: 'Three senior members of your party have publicly defected to the opposition, citing "irreconcilable differences" with your leadership. They\'ve taken 15 MPs with them, weakening your parliamentary majority. The defectors are holding a press conference to announce a new political movement.',
      category: 'political',
      choices: [
        EventChoice(
          id: 'defection_reach_out',
          text: 'Try to win back the defectors — offer them better positions, policy concessions, and personal appeals. Every seat matters.',
          statEffects: {'stability': -2, 'corruption': 5, 'oppositionPower': -3, 'approvalRating': -2},
          treasuryCost: 30,
        ),
        EventChoice(
          id: 'defection_replace',
          text: 'Let them go and promote younger, more loyal party members to fill the vacancies. Use the opportunity to refresh your team.',
          statEffects: {'stability': -5, 'oppositionPower': 5, 'approvalRating': 3},
        ),
        EventChoice(
          id: 'defection_expose',
          text: 'Release damaging information about the defectors — their past corruption, personal scandals, and private communications. Destroy their credibility.',
          statEffects: {'corruption': 8, 'mediaTrust': -8, 'oppositionPower': -5, 'stability': -3, 'approvalRating': -5},
        ),
      ],
    ),
    EventModel(
      id: 'election_commission_dispute',
      title: 'Election Commission Controversy',
      description: 'The Election Commission chairman has been caught on tape discussing how to manipulate voter registration in your party\'s favor. The tape has been leaked to the media. Opposition parties are demanding the chairman\'s resignation and new commissioners appointed by consensus.',
      category: 'political',
      choices: [
        EventChoice(
          id: 'commission_resign',
          text: 'Ask the chairman to resign immediately. Propose a bipartisan committee to select new commissioners and restore public trust.',
          statEffects: {'mediaTrust': 8, 'stability': 5, 'approvalRating': 5, 'oppositionPower': -3, 'corruption': -5},
        ),
        EventChoice(
          id: 'commission_defend',
          text: 'Defend the chairman — claim the tape is doctored and part of a conspiracy. Launch an investigation into who leaked it.',
          statEffects: {'mediaTrust': -10, 'stability': -5, 'approvalRating': -8, 'oppositionPower': 10, 'corruption': 5},
        ),
        EventChoice(
          id: 'commission_ignore',
          text: 'Say nothing and let the controversy die down naturally. Political scandals come and go.',
          statEffects: {'mediaTrust': -5, 'stability': -3, 'approvalRating': -5, 'oppositionPower': 5},
        ),
      ],
    ),
    EventModel(
      id: 'foreign_government_criticism',
      title: 'Foreign Government Condemns You',
      description: 'A major world power has publicly condemned your government\'s human rights record, threatened sanctions, and called for democratic reforms. Their ambassador delivered a stern warning during a diplomatic reception. International media is amplifying the criticism.',
      category: 'political',
      choices: [
        EventChoice(
          id: 'foreign_criticism_reform',
          text: 'Acknowledge the concerns and announce concrete reforms — release political prisoners, invite international observers, and promise free press protections.',
          statEffects: {'internationalRelations': 8, 'mediaTrust': 8, 'happiness': 5, 'approvalRating': 5, 'oppositionPower': 3},
        ),
        EventChoice(
          id: 'foreign_criticism_defy',
          text: 'Defy the criticism — expel their ambassador, rally nationalist sentiment, and denounce foreign interference in your sovereignty.',
          statEffects: {'internationalRelations': -15, 'stability': 3, 'approvalRating': 8, 'oppositionPower': -3, 'mediaTrust': -5},
        ),
        EventChoice(
          id: 'foreign_criticism_deflect',
          text: 'Deflect by highlighting the criticizing country\'s own human rights issues. Point out their hypocrisy while quietly making minor reforms.',
          statEffects: {'internationalRelations': -5, 'mediaTrust': 3, 'stability': 2, 'approvalRating': 3},
        ),
      ],
    ),

    // ============================================================
    // SECURITY EVENTS (25-32)
    // ============================================================
    EventModel(
      id: 'coup_warning',
      title: 'Coup Plot Intelligence',
      description: 'Your intelligence chief has presented classified evidence of a military coup plot. Senior army officers have been meeting secretly, stockpiling weapons at a base outside the capital, and making contact with opposition politicians. The coup is planned for next month. You have a narrow window to act.',
      category: 'security',
      chainId: 'coup_chain',
      chainStage: 1,
      nextChainEventId: 'coup_chain_2',
      isCharacterEvent: true,
      characterId: 'army_chief',
      choices: [
        EventChoice(
          id: 'coup_arrest',
          text: 'Order immediate arrests — round up the plotters in a pre-dawn raid, seal the military base, and put the army on lockdown.',
          statEffects: {'stability': 5, 'military': -5, 'mediaTrust': -3, 'approvalRating': 3},
          characterEffects: {'army_chief': -15},
        ),
        EventChoice(
          id: 'coup_negotiate',
          text: 'Negotiate with the plotters through back channels — find out what they want, offer concessions, and try to defuse the situation peacefully.',
          statEffects: {'stability': 2, 'military': 3, 'corruption': 5, 'approvalRating': -3},
          characterEffects: {'army_chief': 5},
        ),
        EventChoice(
          id: 'coup_reshuffle',
          text: 'Quietly reshuffle military leadership — transfer suspected plotters to remote postings, promote loyalists, and increase security without public drama.',
          statEffects: {'stability': 3, 'military': 2, 'approvalRating': 2},
          characterEffects: {'army_chief': -5},
        ),
        EventChoice(
          id: 'coup_public',
          text: 'Go public — address the nation about the coup attempt, name the plotters, and rally public support against military intervention in politics.',
          statEffects: {'stability': -3, 'mediaTrust': 8, 'approvalRating': 10, 'oppositionPower': -5, 'military': -8},
          characterEffects: {'army_chief': -20},
        ),
      ],
    ),
    EventModel(
      id: 'military_emergency_powers_demand',
      title: 'Military Demands Emergency Powers',
      description: 'The Army Chief has formally requested emergency military powers to deal with "internal security threats." He wants authority to arrest civilians, impose curfews, and deploy troops in cities without civilian oversight. He warns that without these powers, he "cannot guarantee the security of the state."',
      category: 'security',
      isCharacterEvent: true,
      characterId: 'army_chief',
      choices: [
        EventChoice(
          id: 'emergency_grant',
          text: 'Grant the emergency powers — the security situation is serious and the military needs flexibility to protect the country.',
          statEffects: {'military': 10, 'stability': 5, 'happiness': -10, 'mediaTrust': -10, 'approvalRating': -8, 'oppositionPower': 8},
          characterEffects: {'army_chief': 15},
        ),
        EventChoice(
          id: 'emergency_refuse',
          text: 'Refuse firmly — civilian authority over the military is non-negotiable. Remind the Army Chief who is Commander-in-Chief.',
          statEffects: {'stability': -5, 'happiness': 5, 'mediaTrust': 5, 'approvalRating': 5},
          characterEffects: {'army_chief': -15},
        ),
        EventChoice(
          id: 'emergency_compromise',
          text: 'Offer a compromise — grant limited powers for 30 days with parliamentary oversight and mandatory reporting. Include a sunset clause.',
          statEffects: {'military': 5, 'stability': 3, 'happiness': -3, 'mediaTrust': 2, 'approvalRating': 2},
          characterEffects: {'army_chief': 5},
        ),
      ],
    ),
    EventModel(
      id: 'police_brutality_scandal',
      title: 'Police Brutality Caught on Camera',
      description: 'A viral video shows police officers beating unarmed protesters, including women and elderly citizens. The footage has sparked outrage domestically and internationally. The police union is defending the officers, claiming they were provoked. The Interior Minister is requesting guidance.',
      category: 'security',
      choices: [
        EventChoice(
          id: 'brutality_investigate',
          text: 'Condemn the violence immediately — suspend the officers, launch an independent investigation, and promise police reform.',
          statEffects: {'happiness': 5, 'stability': 3, 'mediaTrust': 8, 'approvalRating': 8, 'crime': -2},
        ),
        EventChoice(
          id: 'brutality_defend',
          text: 'Defend the police — the protesters were breaking the law and the officers were doing their duty. Law and order must be maintained.',
          statEffects: {'happiness': -10, 'stability': -5, 'mediaTrust': -10, 'approvalRating': -8, 'oppositionPower': 8},
        ),
        EventChoice(
          id: 'brutality_reform',
          text: 'Announce comprehensive police reform — body cameras, independent oversight, community policing, and mandatory de-escalation training.',
          statEffects: {'happiness': 8, 'stability': 5, 'mediaTrust': 10, 'approvalRating': 10, 'crime': -3},
          treasuryCost: 80,
        ),
      ],
    ),
    EventModel(
      id: 'cyber_attack',
      title: 'Major Cyber Attack on Government',
      description: 'A sophisticated cyber attack has crippled government systems. The tax authority, welfare payments, and military communications are all offline. Citizen data including social security numbers and bank details may have been compromised. Intelligence suggests a foreign state actor is responsible.',
      category: 'security',
      choices: [
        EventChoice(
          id: 'cyber_emergency_response',
          text: 'Declare a cyber emergency — activate the national cybersecurity team, bring in international experts, and inform citizens about the data breach.',
          statEffects: {'stability': -3, 'mediaTrust': 5, 'internationalRelations': 3, 'approvalRating': 5, 'economy': -3},
          treasuryCost: 100,
        ),
        EventChoice(
          id: 'cyber_retaliate',
          text: 'Retaliate — order your intelligence services to launch counter-cyber operations against the suspected foreign attacker.',
          statEffects: {'stability': -5, 'internationalRelations': -10, 'military': 3, 'approvalRating': 3},
          treasuryCost: 60,
        ),
        EventChoice(
          id: 'cyber_cover_up',
          text: 'Minimize the breach — tell the public it was a minor technical issue, handle it quietly, and avoid causing panic.',
          statEffects: {'stability': 2, 'mediaTrust': -10, 'approvalRating': -5, 'corruption': 5},
        ),
      ],
    ),
    EventModel(
      id: 'border_skirmish',
      title: 'Border Skirmish with Neighbor',
      description: 'Armed clashes have erupted along your northern border. A neighboring country\'s military has crossed into disputed territory, and your border forces have engaged them. Three of your soldiers are dead and seven wounded. The neighbor claims your forces fired first.',
      category: 'security',
      choices: [
        EventChoice(
          id: 'border_military',
          text: 'Mobilize the military — reinforce the border, deploy additional troops, and prepare for potential escalation. Show strength.',
          statEffects: {'military': 8, 'stability': -5, 'internationalRelations': -10, 'approvalRating': 8, 'happiness': -3},
          treasuryCost: 120,
        ),
        EventChoice(
          id: 'border_diplomacy',
          text: 'Pursue diplomatic resolution — request an emergency UN session, invite mediators, and propose a ceasefire and border demarcation talks.',
          statEffects: {'internationalRelations': 8, 'stability': 5, 'mediaTrust': 5, 'approvalRating': 3},
        ),
        EventChoice(
          id: 'border_withdraw',
          text: 'Pull back forces and de-escalate — avoid a full-scale war at all costs. Propose a buffer zone and international peacekeeping presence.',
          statEffects: {'stability': 3, 'internationalRelations': 5, 'military': -5, 'approvalRating': -8, 'happiness': -5},
        ),
      ],
    ),
    EventModel(
      id: 'terrorist_threat_intelligence',
      title: 'Terrorist Threat Intelligence',
      description: 'Intelligence services have intercepted communications indicating a planned terrorist attack on the capital\'s main transit hub during rush hour. The attack is planned for within 72 hours. The intelligence is credible but not 100% confirmed. Going public could cause mass panic.',
      category: 'security',
      choices: [
        EventChoice(
          id: 'terror_covert',
          text: 'Handle it covertly — deploy plainclothes security, increase surveillance, and attempt to apprehend the suspects before they act.',
          statEffects: {'stability': 3, 'crime': -5, 'approvalRating': 3, 'military': 2},
          treasuryCost: 40,
        ),
        EventChoice(
          id: 'terror_public',
          text: 'Go public — issue a terror alert, increase visible security, evacuate the transit hub, and ask citizens for vigilance.',
          statEffects: {'stability': -5, 'happiness': -5, 'mediaTrust': 5, 'approvalRating': 5, 'crime': -3},
          treasuryCost: 60,
        ),
        EventChoice(
          id: 'terror_ignore',
          text: 'Assess the intelligence as unreliable and maintain normal operations. You can\'t shut down the country every time there\'s a threat.',
          statEffects: {'stability': -2, 'approvalRating': -3},
        ),
      ],
    ),
    EventModel(
      id: 'prison_riot',
      title: 'Major Prison Riot',
      description: 'A massive riot has erupted in the country\'s largest prison. Inmates have taken 30 guards hostage and are demanding better conditions, amnesty for some prisoners, and a meeting with the president. The prison is overcrowded at 300% capacity. TV cameras are broadcasting the standoff live.',
      category: 'security',
      choices: [
        EventChoice(
          id: 'prison_negotiate',
          text: 'Negotiate with the inmates — send in mediators, agree to review prison conditions, and promise reforms in exchange for releasing the hostages.',
          statEffects: {'stability': 3, 'happiness': 3, 'mediaTrust': 5, 'approvalRating': 3, 'crime': 3},
        ),
        EventChoice(
          id: 'prison_force',
          text: 'Send in special forces — storm the prison, rescue the hostages, and restore order by force. Accept potential casualties.',
          statEffects: {'stability': -5, 'happiness': -5, 'mediaTrust': -5, 'approvalRating': 5, 'crime': -5, 'military': 3},
        ),
        EventChoice(
          id: 'prison_reform',
          text: 'Use the crisis to announce prison reform — address overcrowding, improve conditions, and implement rehabilitation programs.',
          statEffects: {'stability': 5, 'happiness': 5, 'mediaTrust': 8, 'approvalRating': 8, 'crime': -5},
          treasuryCost: 80,
        ),
      ],
    ),
    EventModel(
      id: 'assassination_threat_warning',
      title: 'Assassination Plot Uncovered',
      description: 'Your personal security detail has uncovered a plot to assassinate you during your upcoming public speech. The plotters include a disgruntled former military officer, a radicalized civilian, and possibly someone within your own security apparatus. Your chief of security recommends canceling all public appearances.',
      category: 'security',
      choices: [
        EventChoice(
          id: 'assassination_cancel',
          text: 'Cancel all public appearances, increase security to maximum, and order a thorough investigation into the plot and its sponsors.',
          statEffects: {'stability': -5, 'approvalRating': -3, 'crime': -3},
          treasuryCost: 40,
        ),
        EventChoice(
          id: 'assassination_proceed',
          text: 'Proceed with the speech after enhanced security measures. Show the nation that you will not be intimidated by threats.',
          statEffects: {'stability': 3, 'approvalRating': 10, 'mediaTrust': 5, 'happiness': 3},
          treasuryCost: 60,
        ),
        EventChoice(
          id: 'assassination_trap',
          text: 'Use the speech as a trap — proceed with it but have security forces ready to catch the plotters in the act. High risk, high reward.',
          statEffects: {'stability': -3, 'approvalRating': 8, 'crime': -8, 'military': 3},
          treasuryCost: 50,
        ),
      ],
    ),

    // ============================================================
    // PROTEST CHAIN EVENTS (33-38)
    // ============================================================
    EventModel(
      id: 'protest_stage_1',
      title: 'Small Protest Erupts',
      description: 'Around 100 citizens have gathered outside the presidential palace, holding signs demanding change. They are peaceful but vocal, chanting slogans against your economic policies. Local media is covering the event. Your advisors say it will probably blow over by tomorrow.',
      category: 'protest',
      chainId: 'protest_chain',
      chainStage: 1,
      nextChainEventId: 'protest_stage_2',
      choices: [
        EventChoice(
          id: 'protest1_listen',
          text: 'Send a representative to listen to their demands. Show that you care about citizens\' concerns even if you disagree.',
          statEffects: {'happiness': 5, 'stability': 3, 'mediaTrust': 5, 'approvalRating': 5},
        ),
        EventChoice(
          id: 'protest1_ignore',
          text: 'Ignore the protest — it\'s just 100 people. Don\'t give them the attention they crave. Focus on governing.',
          statEffects: {'happiness': -3, 'stability': -2, 'approvalRating': -3},
          followUpEventId: 'protest_stage_2',
        ),
        EventChoice(
          id: 'protest1_disperse',
          text: 'Send police to disperse the crowd. They don\'t have a permit and are blocking traffic.',
          statEffects: {'happiness': -8, 'stability': -5, 'mediaTrust': -8, 'approvalRating': -5, 'oppositionPower': 5},
          followUpEventId: 'protest_stage_2',
        ),
      ],
    ),
    EventModel(
      id: 'protest_stage_2',
      title: 'Protests Growing',
      description: 'The protests have swelled to thousands of people. Multiple cities are now seeing daily demonstrations. Workers\' unions have joined, threatening a general strike. University students are organizing through social media. International media has started covering the unrest.',
      category: 'protest',
      chainId: 'protest_chain',
      chainStage: 2,
      nextChainEventId: 'protest_stage_3',
      choices: [
        EventChoice(
          id: 'protest2_concessions',
          text: 'Make meaningful concessions — announce specific policy changes that address the protesters\' core demands. Show genuine willingness to change.',
          statEffects: {'happiness': 8, 'stability': 5, 'approvalRating': 8, 'oppositionPower': -3, 'mediaTrust': 5},
          treasuryCost: 60,
        ),
        EventChoice(
          id: 'protest2_dialogue',
          text: 'Invite protest leaders for formal dialogue. Establish a citizen committee to review their demands and propose solutions.',
          statEffects: {'happiness': 5, 'stability': 3, 'approvalRating': 5, 'mediaTrust': 3},
        ),
        EventChoice(
          id: 'protest2_crackdown',
          text: 'Order a police crackdown — arrest protest leaders, use tear gas and water cannons, and impose curfews in affected areas.',
          statEffects: {'happiness': -12, 'stability': -8, 'mediaTrust': -10, 'approvalRating': -10, 'oppositionPower': 10},
          followUpEventId: 'protest_stage_3',
        ),
      ],
    ),
    EventModel(
      id: 'protest_stage_3',
      title: 'Nationwide Protests',
      description: 'Every major city in the country is now experiencing massive protests. Hundreds of thousands of people are in the streets. The economy is grinding to a halt as businesses close and transport is disrupted. International governments are calling for restraint. Your cabinet is divided on how to respond.',
      category: 'protest',
      chainId: 'protest_chain',
      chainStage: 3,
      nextChainEventId: 'protest_stage_4',
      choices: [
        EventChoice(
          id: 'protest3_address_nation',
          text: 'Address the nation — acknowledge mistakes, announce a comprehensive reform package, and ask for time to implement changes.',
          statEffects: {'happiness': 8, 'stability': 5, 'approvalRating': 10, 'mediaTrust': 8, 'oppositionPower': -5},
          treasuryCost: 100,
        ),
        EventChoice(
          id: 'protest3_emergency',
          text: 'Declare a state of emergency — impose martial law, ban public gatherings, and deploy the military to restore order.',
          statEffects: {'happiness': -15, 'stability': -10, 'mediaTrust': -15, 'approvalRating': -15, 'oppositionPower': 15, 'military': 5},
          followUpEventId: 'protest_stage_4',
        ),
        EventChoice(
          id: 'protest3_resign_cabinet',
          text: 'Dismiss your entire cabinet and announce early elections. Show the nation you respect their voice and the democratic process.',
          statEffects: {'happiness': 10, 'stability': 3, 'approvalRating': 8, 'mediaTrust': 10, 'oppositionPower': -8},
        ),
      ],
    ),
    EventModel(
      id: 'protest_stage_4',
      title: 'Riots Break Out',
      description: 'The protests have turned violent. Rioters are burning government buildings, looting businesses, and clashing with police. Molotov cocktails and stones are being thrown. Several people have been killed. The situation is spiraling out of control and your authority is being openly challenged.',
      category: 'protest',
      chainId: 'protest_chain',
      chainStage: 4,
      nextChainEventId: 'protest_stage_5',
      choices: [
        EventChoice(
          id: 'protest4_negotiate_urgently',
          text: 'Make an urgent appeal for calm — go on national TV, offer amnesty to peaceful protesters, and announce immediate emergency reforms.',
          statEffects: {'happiness': 5, 'stability': 3, 'approvalRating': 5, 'mediaTrust': 5},
          treasuryCost: 150,
        ),
        EventChoice(
          id: 'protest4_military',
          text: 'Deploy the military with orders to restore order using whatever force is necessary. The survival of the state is at stake.',
          statEffects: {'happiness': -15, 'stability': -5, 'mediaTrust': -15, 'approvalRating': -15, 'military': 5, 'internationalRelations': -10},
          followUpEventId: 'protest_stage_5',
        ),
        EventChoice(
          id: 'protest4_resign',
          text: 'Announce your resignation — step down to prevent further bloodshed and allow a peaceful transition of power.',
          statEffects: {'happiness': 10, 'stability': 5, 'mediaTrust': 10},
        ),
      ],
    ),
    EventModel(
      id: 'protest_stage_5',
      title: 'Armed Confrontation',
      description: 'Armed groups have formed among the protesters. They have seized weapons from police stations and military depots. Parts of the capital are now controlled by armed militants. Some military units are refusing orders or defecting to the protesters. This is no longer a protest — it\'s an insurrection.',
      category: 'protest',
      chainId: 'protest_chain',
      chainStage: 5,
      nextChainEventId: 'protest_stage_6',
      choices: [
        EventChoice(
          id: 'protest5_ceasefire',
          text: 'Call for an immediate ceasefire and unconditional negotiations. Invite international mediators. Offer a national unity government.',
          statEffects: {'stability': 5, 'happiness': 5, 'mediaTrust': 5, 'internationalRelations': 5, 'approvalRating': 5},
        ),
        EventChoice(
          id: 'protest5_crush',
          text: 'Order loyal military units to crush the insurrection. Use all available force. This is civil war and you must win.',
          statEffects: {'stability': -15, 'happiness': -20, 'mediaTrust': -15, 'internationalRelations': -15, 'approvalRating': -20, 'military': 5},
          followUpEventId: 'protest_stage_6',
        ),
        EventChoice(
          id: 'protest5_flee',
          text: 'Evacuate the capital and set up a government-in-exile. Preserve what you can and hope for international support.',
          statEffects: {'stability': -20, 'approvalRating': -25},
        ),
      ],
    ),
    EventModel(
      id: 'protest_stage_6',
      title: 'Revolution at the Gates',
      description: 'The presidential palace is surrounded. Armed revolutionaries control most of the capital. The military has largely fractured, with some units loyal to you and others joining the revolution. International news crews are broadcasting the scene worldwide. This is the end game.',
      category: 'protest',
      chainId: 'protest_chain',
      chainStage: 6,
      choices: [
        EventChoice(
          id: 'protest6_negotiate',
          text: 'Open the palace gates and negotiate a peaceful transition. Offer to resign in exchange for safe passage and no prosecution.',
          statEffects: {'stability': 5, 'happiness': 5},
        ),
        EventChoice(
          id: 'protest6_last_stand',
          text: 'Make a last stand — order your loyal forces to defend the palace. History will judge, but you will not surrender.',
          statEffects: {'stability': -25, 'happiness': -25, 'approvalRating': -30},
        ),
        EventChoice(
          id: 'protest6_broadcast',
          text: 'Go on live TV one last time — address the nation, accept responsibility, announce free elections, and step down with dignity.',
          statEffects: {'stability': 8, 'happiness': 10, 'mediaTrust': 10, 'approvalRating': 5},
        ),
      ],
    ),

    // ============================================================
    // ENVIRONMENTAL EVENTS (39-44)
    // ============================================================
    EventModel(
      id: 'flood_disaster',
      title: 'Catastrophic Flooding',
      description: 'Unprecedented rainfall has caused devastating floods across three provinces. Thousands of homes are underwater, bridges have collapsed, and farmland is destroyed. At least 200 people are confirmed dead with hundreds more missing. Rescue teams are overwhelmed.',
      category: 'environmental',
      choices: [
        EventChoice(
          id: 'flood_full_response',
          text: 'Deploy everything — military rescue helicopters, emergency shelters, food and water supplies, medical teams. Declare a national disaster.',
          statEffects: {'happiness': 8, 'health': 5, 'stability': 3, 'approvalRating': 10, 'mediaTrust': 5},
          treasuryCost: 200,
        ),
        EventChoice(
          id: 'flood_minimal',
          text: 'Respond with available resources — send local emergency services and request international aid. Avoid overspending.',
          statEffects: {'happiness': -5, 'stability': -3, 'approvalRating': -5},
          treasuryCost: 50,
        ),
        EventChoice(
          id: 'flood_international_aid',
          text: 'Accept all international aid offers — let foreign rescue teams in, accept donations, and coordinate with international relief organizations.',
          statEffects: {'happiness': 5, 'health': 3, 'internationalRelations': 8, 'approvalRating': 5},
          treasuryCost: 80,
        ),
      ],
    ),
    EventModel(
      id: 'drought_crop_failure',
      title: 'Severe Drought — Crops Failing',
      description: 'The worst drought in 50 years is destroying agricultural production. Farmers report 70% crop losses. Rural communities face famine. Water rationing has been imposed in several cities. The agricultural sector, which employs 40% of the population, is in crisis.',
      category: 'environmental',
      choices: [
        EventChoice(
          id: 'drought_emergency_irrigation',
          text: 'Launch emergency measures — fund emergency irrigation, distribute seed aid, provide financial relief to farmers, and import food reserves.',
          statEffects: {'happiness': 5, 'health': 3, 'economy': -3, 'stability': 3, 'approvalRating': 8},
          treasuryCost: 150,
        ),
        EventChoice(
          id: 'drought_long_term',
          text: 'Focus on long-term solutions — invest in drought-resistant crops, build reservoirs, and implement water conservation programs.',
          statEffects: {'economy': 3, 'education': 3, 'stability': 2, 'approvalRating': 3},
          treasuryCost: 100,
        ),
        EventChoice(
          id: 'drought_pray',
          text: 'Call for national prayer and patience. The drought will end naturally. Provide minimal government intervention.',
          statEffects: {'happiness': -10, 'health': -8, 'stability': -8, 'approvalRating': -10},
        ),
      ],
    ),
    EventModel(
      id: 'industrial_accident_pollution',
      title: 'Industrial Chemical Spill',
      description: 'A major chemical plant has exploded, releasing toxic gases into the atmosphere. Thousands of residents in nearby areas are experiencing breathing difficulties, skin burns, and eye irritation. The river downstream is contaminated. The company that owns the plant is a major employer and political donor.',
      category: 'environmental',
      choices: [
        EventChoice(
          id: 'pollution_full_response',
          text: 'Evacuate affected areas, shut down the plant permanently, prosecute the company, and fund long-term health monitoring for affected residents.',
          statEffects: {'health': 8, 'happiness': 5, 'economy': -8, 'mediaTrust': 8, 'approvalRating': 8},
          treasuryCost: 150,
        ),
        EventChoice(
          id: 'pollution_moderate',
          text: 'Order the plant to temporarily shut down for safety upgrades while providing medical treatment to affected residents.',
          statEffects: {'health': 5, 'happiness': 3, 'economy': -3, 'approvalRating': 3},
          treasuryCost: 80,
        ),
        EventChoice(
          id: 'pollution_protect_company',
          text: 'Minimize the incident — blame the accident on worker error, protect the company from prosecution, and quietly settle with affected families.',
          statEffects: {'health': -5, 'corruption': 10, 'mediaTrust': -8, 'economy': 3, 'approvalRating': -8},
          treasuryCost: 40,
        ),
      ],
    ),
    EventModel(
      id: 'earthquake',
      title: 'Devastating Earthquake',
      description: 'A 7.2 magnitude earthquake has struck your country\'s second-largest city. Buildings have collapsed, infrastructure is destroyed, and thousands are trapped under rubble. The death toll is rising rapidly. Emergency services are overwhelmed and the city has no power or water.',
      category: 'environmental',
      choices: [
        EventChoice(
          id: 'quake_all_resources',
          text: 'Mobilize every available resource — military, police, firefighters, volunteers. Fly in international rescue teams. Set up field hospitals and tent cities.',
          statEffects: {'happiness': 8, 'health': 5, 'stability': 3, 'approvalRating': 10, 'internationalRelations': 5},
          treasuryCost: 250,
          debtIncrease: 100,
        ),
        EventChoice(
          id: 'quake_targeted',
          text: 'Focus resources on the most affected areas — deploy rescue teams strategically, prioritize hospitals and schools, and set up emergency shelters.',
          statEffects: {'happiness': 3, 'health': 3, 'stability': 2, 'approvalRating': 5},
          treasuryCost: 150,
        ),
        EventChoice(
          id: 'quake_international',
          text: 'Appeal for massive international assistance — accept all help from any country, open borders to rescue teams, and let the international community lead the response.',
          statEffects: {'happiness': 3, 'health': 5, 'internationalRelations': 10, 'approvalRating': 3, 'stability': 2},
          treasuryCost: 80,
        ),
      ],
    ),
    EventModel(
      id: 'pandemic_outbreak',
      title: 'Pandemic Outbreak',
      description: 'A highly contagious virus is spreading rapidly through your population. Hospitals are reaching capacity, and the death toll is climbing. International health organizations are warning of a potential catastrophe. Your health minister says you have two weeks before the healthcare system collapses.',
      category: 'environmental',
      choices: [
        EventChoice(
          id: 'pandemic_lockdown',
          text: 'Implement a strict national lockdown — close borders, shut businesses, mandate masks, and fund an emergency healthcare expansion.',
          statEffects: {'health': 10, 'economy': -12, 'happiness': -8, 'stability': -5, 'approvalRating': 3},
          treasuryCost: 200,
        ),
        EventChoice(
          id: 'pandemic_targeted',
          text: 'Implement targeted measures — isolate hotspots, expand testing, protect vulnerable populations, but keep the economy partially open.',
          statEffects: {'health': 5, 'economy': -5, 'happiness': -3, 'stability': 2, 'approvalRating': 5},
          treasuryCost: 120,
        ),
        EventChoice(
          id: 'pandemic_herd_immunity',
          text: 'Pursue a natural immunity strategy — keep the country open, protect the elderly, and let the virus run its course.',
          statEffects: {'health': -15, 'economy': 3, 'happiness': -10, 'stability': -8, 'approvalRating': -10, 'mediaTrust': -5},
        ),
      ],
    ),
    EventModel(
      id: 'energy_crisis_fuel_shortage',
      title: 'Energy Crisis — Fuel Shortage',
      description: 'Fuel supplies have dropped to critical levels. Gas stations have run dry, power plants are rationing electricity, and industries are shutting down. The cause is a combination of international price spikes, poor energy planning, and pipeline disruptions. Citizens are queuing for hours to get petrol.',
      category: 'environmental',
      choices: [
        EventChoice(
          id: 'energy_emergency_import',
          text: 'Negotiate emergency fuel imports — pay premium prices, tap strategic reserves, and ration fuel to essential services first.',
          statEffects: {'economy': -5, 'stability': 3, 'happiness': 3, 'approvalRating': 3},
          treasuryCost: 150,
        ),
        EventChoice(
          id: 'energy_renewable',
          text: 'Announce an emergency pivot to renewable energy — fast-track solar and wind projects, and incentivize electric vehicles.',
          statEffects: {'economy': -3, 'stability': 2, 'education': 3, 'happiness': 2, 'approvalRating': 5},
          treasuryCost: 120,
        ),
        EventChoice(
          id: 'energy_rationing',
          text: 'Implement strict energy rationing — rolling blackouts, fuel quotas, and mandatory conservation measures. Share the pain equally.',
          statEffects: {'happiness': -8, 'economy': -5, 'stability': -3, 'approvalRating': -5},
        ),
      ],
    ),

    // ============================================================
    // INTERNATIONAL EVENTS (45-50)
    // ============================================================
    EventModel(
      id: 'foreign_aid_with_conditions',
      title: 'Foreign Aid with Strings Attached',
      description: 'A wealthy nation offers 3 billion dollars in development aid, but with conditions: open your markets to their companies, allow them to build a military base on your soil, and vote with them in the UN on key issues. The aid could transform your infrastructure, but the conditions feel like neocolonialism.',
      category: 'international',
      choices: [
        EventChoice(
          id: 'aid_accept',
          text: 'Accept the full package — your people need the money and the infrastructure investment will pay off for generations.',
          statEffects: {'economy': 10, 'internationalRelations': 8, 'stability': 3, 'happiness': 5, 'military': -3},
          treasuryCost: -300,
        ),
        EventChoice(
          id: 'aid_negotiate',
          text: 'Negotiate — accept the development aid but reject the military base. Agree to trade openings with protections for local businesses.',
          statEffects: {'economy': 5, 'internationalRelations': 5, 'stability': 2, 'happiness': 3},
          treasuryCost: -150,
        ),
        EventChoice(
          id: 'aid_reject',
          text: 'Reject the offer proudly — your sovereignty is not for sale. Announce a self-reliance economic program.',
          statEffects: {'economy': -3, 'internationalRelations': -8, 'approvalRating': 8, 'stability': 2, 'happiness': 3},
        ),
      ],
    ),
    EventModel(
      id: 'neighboring_border_dispute',
      title: 'Border Dispute Escalates',
      description: 'A long-simmering territorial dispute with your western neighbor has escalated. They\'ve built permanent military installations on contested land and are demanding you recognize their claim. Your own citizens in the disputed region are protesting and demanding your protection.',
      category: 'international',
      choices: [
        EventChoice(
          id: 'border_dispute_military',
          text: 'Match their military buildup — deploy forces to the border, build your own installations, and make it clear you won\'t back down.',
          statEffects: {'military': 5, 'internationalRelations': -10, 'stability': -5, 'approvalRating': 8, 'happiness': -3},
          treasuryCost: 100,
        ),
        EventChoice(
          id: 'border_dispute_court',
          text: 'Take the dispute to the International Court of Justice. Present your legal case and abide by the ruling.',
          statEffects: {'internationalRelations': 8, 'stability': 3, 'mediaTrust': 5, 'approvalRating': 3},
        ),
        EventChoice(
          id: 'border_dispute_concede',
          text: 'Offer to share the territory — propose joint administration and shared resource access. Avoid conflict at all costs.',
          statEffects: {'internationalRelations': 5, 'stability': 3, 'approvalRating': -8, 'happiness': -5, 'oppositionPower': 8},
        ),
      ],
    ),
    EventModel(
      id: 'international_sanctions_warning',
      title: 'International Sanctions Warning',
      description: 'A coalition of powerful nations has warned that they will impose economic sanctions on your country unless you reverse recent authoritarian actions — press censorship, political arrests, and curtailed judicial independence. The sanctions could devastate your economy.',
      category: 'international',
      choices: [
        EventChoice(
          id: 'sanctions_comply',
          text: 'Comply with international demands — release prisoners, restore press freedom, and reinstate judicial independence. Avoid the economic damage.',
          statEffects: {'internationalRelations': 10, 'mediaTrust': 10, 'happiness': 5, 'stability': 3, 'approvalRating': -3, 'oppositionPower': 5},
        ),
        EventChoice(
          id: 'sanctions_defy',
          text: 'Defy the threats — sanctions are an act of economic warfare. Rally your people around national pride and seek alternative trading partners.',
          statEffects: {'internationalRelations': -15, 'economy': -10, 'happiness': -5, 'approvalRating': 8, 'stability': -5},
        ),
        EventChoice(
          id: 'sanctions_partial',
          text: 'Make cosmetic concessions — release a few prisoners and lift some press restrictions while maintaining your core policies.',
          statEffects: {'internationalRelations': 3, 'mediaTrust': 3, 'stability': 2, 'corruption': 3},
        ),
      ],
    ),
    EventModel(
      id: 'foreign_spy_ring',
      title: 'Foreign Spy Ring Exposed',
      description: 'Your intelligence services have uncovered a foreign spy ring operating within your government. Several mid-level officials have been passing classified information to a foreign intelligence agency. The discovery shakes your entire security apparatus.',
      category: 'international',
      choices: [
        EventChoice(
          id: 'spy_public_trial',
          text: 'Arrest and publicly try the spies — send a message that espionage will not be tolerated. Expel the foreign diplomats involved.',
          statEffects: {'stability': 3, 'internationalRelations': -8, 'mediaTrust': 5, 'approvalRating': 8, 'crime': -3},
        ),
        EventChoice(
          id: 'spy_quiet',
          text: 'Handle it quietly — use the spies as double agents to feed false information to the foreign power. Play the long game.',
          statEffects: {'stability': 2, 'military': 5, 'corruption': 3},
          characterEffects: {'intelligence_chief': 5},
        ),
        EventChoice(
          id: 'spy_diplomatic',
          text: 'Use it diplomatically — confront the foreign government privately and demand concessions in exchange for not going public.',
          statEffects: {'internationalRelations': 3, 'stability': 2, 'corruption': 5},
          treasuryCost: -50,
        ),
      ],
    ),
    EventModel(
      id: 'refugee_crisis',
      title: 'Refugee Crisis at the Border',
      description: 'A civil war in a neighboring country has sent 500,000 refugees streaming toward your border. Refugee camps are overflowing, and citizens in border regions are becoming hostile toward the newcomers. International organizations are pressuring you to accept more, while your opposition demands you close the border.',
      category: 'international',
      choices: [
        EventChoice(
          id: 'refugee_welcome',
          text: 'Open your borders — accept the refugees, set up proper camps, and integrate them into the economy. It\'s the humanitarian thing to do.',
          statEffects: {'happiness': -5, 'internationalRelations': 10, 'stability': -5, 'approvalRating': -3, 'mediaTrust': 5, 'health': -3},
          treasuryCost: 120,
        ),
        EventChoice(
          id: 'refugee_limited',
          text: 'Accept a limited number — screen refugees for security, set up temporary camps, and seek international burden-sharing.',
          statEffects: {'happiness': -2, 'internationalRelations': 5, 'stability': 2, 'approvalRating': 3},
          treasuryCost: 60,
        ),
        EventChoice(
          id: 'refugee_close',
          text: 'Close the border — deploy the military to prevent crossings. Your country can\'t afford to take in half a million people.',
          statEffects: {'happiness': 3, 'internationalRelations': -10, 'stability': 3, 'approvalRating': 5, 'mediaTrust': -8},
        ),
      ],
    ),
    EventModel(
      id: 'international_summit_invitation',
      title: 'International Summit Invitation',
      description: 'You\'ve been invited to a prestigious international summit of world leaders. The summit will discuss climate change, trade, and security. Your attendance would boost your country\'s international standing, but opponents at home will criticize you for "traveling while the country burns."',
      category: 'international',
      choices: [
        EventChoice(
          id: 'summit_attend',
          text: 'Attend the summit — this is a rare opportunity to put your country on the world stage, attract investment, and build alliances.',
          statEffects: {'internationalRelations': 10, 'mediaTrust': 3, 'economy': 3, 'approvalRating': 3},
          treasuryCost: 30,
        ),
        EventChoice(
          id: 'summit_send_delegate',
          text: 'Send your vice president instead — show you\'re focused on domestic issues while still maintaining international engagement.',
          statEffects: {'internationalRelations': 3, 'approvalRating': 3, 'stability': 2},
          characterEffects: {'vice_president': 5},
        ),
        EventChoice(
          id: 'summit_decline',
          text: 'Decline the invitation — you have more important things to do at home. The people elected you to serve them, not to attend fancy parties.',
          statEffects: {'internationalRelations': -5, 'approvalRating': 5, 'stability': 2},
        ),
      ],
    ),

    // ============================================================
    // CHARACTER-DRIVEN EVENTS (51-56)
    // ============================================================
    EventModel(
      id: 'army_chief_demands_power',
      title: 'Army Chief\'s Ultimatum',
      description: 'The Army Chief has requested a private meeting. Behind closed doors, he demands a 50% increase in the military budget, the appointment of military officers to key civilian posts, and immunity from prosecution for military personnel. He implies that "the army\'s patience has limits."',
      category: 'character',
      isCharacterEvent: true,
      characterId: 'army_chief',
      choices: [
        EventChoice(
          id: 'army_comply',
          text: 'Accept his demands — you need the military\'s support and can\'t afford a confrontation right now.',
          statEffects: {'military': 10, 'stability': 5, 'happiness': -5, 'corruption': 8, 'approvalRating': -5},
          characterEffects: {'army_chief': 15},
          treasuryCost: 100,
        ),
        EventChoice(
          id: 'army_refuse',
          text: 'Firmly refuse — you are the commander-in-chief and the military answers to civilian authority. Period.',
          statEffects: {'stability': -5, 'happiness': 3, 'mediaTrust': 5, 'approvalRating': 5},
          characterEffects: {'army_chief': -15},
        ),
        EventChoice(
          id: 'army_partial',
          text: 'Offer a compromise — increase the budget by 20%, appoint one military advisor to your cabinet, but refuse immunity.',
          statEffects: {'military': 5, 'stability': 2, 'corruption': 3, 'approvalRating': 2},
          characterEffects: {'army_chief': 5},
          treasuryCost: 50,
        ),
        EventChoice(
          id: 'army_replace',
          text: 'Thank him for his service and immediately replace him with a more loyal general. Send a clear message about chain of command.',
          statEffects: {'military': -5, 'stability': -3, 'approvalRating': 5},
          characterEffects: {'army_chief': -30},
        ),
      ],
    ),
    EventModel(
      id: 'finance_minister_bankruptcy_warning',
      title: 'Finance Minister\'s Dire Warning',
      description: 'Your Finance Minister has requested an emergency meeting. She presents data showing the country is on track for sovereign default within 4 months unless drastic action is taken. She recommends massive spending cuts, tax increases, and an emergency bond issuance.',
      category: 'character',
      isCharacterEvent: true,
      characterId: 'finance_minister',
      choices: [
        EventChoice(
          id: 'finance_follow',
          text: 'Follow her recommendations fully — implement austerity, raise taxes, and issue emergency bonds. Trust the expert.',
          statEffects: {'economy': 5, 'happiness': -10, 'stability': -5, 'approvalRating': -8},
          characterEffects: {'finance_minister': 10},
          treasuryCost: -100,
          debtIncrease: -50,
        ),
        EventChoice(
          id: 'finance_partial',
          text: 'Accept some recommendations but protect social spending. Find a balance between fiscal discipline and social welfare.',
          statEffects: {'economy': 3, 'happiness': -3, 'stability': 2, 'approvalRating': 2},
          characterEffects: {'finance_minister': 5},
          treasuryCost: -50,
        ),
        EventChoice(
          id: 'finance_ignore',
          text: 'Dismiss her warnings as overly pessimistic. The economy will recover on its own. Continue current spending levels.',
          statEffects: {'economy': -5, 'stability': -3, 'approvalRating': 2},
          characterEffects: {'finance_minister': -15},
          debtIncrease: 50,
        ),
        EventChoice(
          id: 'finance_replace',
          text: 'Fire the Finance Minister for causing panic and replace her with someone who shares your optimistic vision.',
          statEffects: {'economy': -8, 'mediaTrust': -5, 'stability': -5, 'corruption': 5},
          characterEffects: {'finance_minister': -25},
        ),
      ],
    ),
    EventModel(
      id: 'intelligence_coup_warning',
      title: 'Intelligence Chief\'s Secret Report',
      description: 'Your Intelligence Chief has handed you a top-secret report detailing internal threats to your presidency. The report names several high-ranking officials, business leaders, and military officers who are conspiring to remove you from power. He recommends preemptive action.',
      category: 'character',
      isCharacterEvent: true,
      characterId: 'intelligence_chief',
      choices: [
        EventChoice(
          id: 'intel_act',
          text: 'Act on the intelligence — quietly remove the named conspirators from their positions, increase surveillance, and strengthen your personal security.',
          statEffects: {'stability': 5, 'corruption': 5, 'approvalRating': 2},
          characterEffects: {'intelligence_chief': 10},
          treasuryCost: 40,
        ),
        EventChoice(
          id: 'intel_verify',
          text: 'Demand independent verification — the intelligence chief might be using this to eliminate his own rivals. Trust but verify.',
          statEffects: {'stability': 2, 'mediaTrust': 3, 'approvalRating': 3},
          characterEffects: {'intelligence_chief': -5},
        ),
        EventChoice(
          id: 'intel_ignore',
          text: 'Ignore the report — you won\'t govern through paranoia and purges. If people have grievances, address them through policy.',
          statEffects: {'stability': -3, 'happiness': 3, 'mediaTrust': 5},
          characterEffects: {'intelligence_chief': -10},
        ),
      ],
    ),
    EventModel(
      id: 'business_tycoon_secret_deal',
      title: 'Business Tycoon Proposes Secret Deal',
      description: 'The country\'s wealthiest business tycoon requests a secret meeting. He offers to invest 500 million dollars in your country\'s economy and fund your reelection campaign. In return, he wants exclusive mining rights, tax exemptions, and a seat on the economic advisory council.',
      category: 'character',
      isCharacterEvent: true,
      characterId: 'business_tycoon',
      choices: [
        EventChoice(
          id: 'tycoon_accept',
          text: 'Accept the deal — the investment and campaign funding will strengthen your position and the economy.',
          statEffects: {'economy': 10, 'corruption': 15, 'approvalRating': 3, 'stability': 2},
          treasuryCost: -100,
        ),
        EventChoice(
          id: 'tycoon_negotiate',
          text: 'Negotiate — accept the investment but with transparency. No secret deals, no exclusive rights, and the campaign funding goes through legal channels.',
          statEffects: {'economy': 5, 'corruption': 3, 'mediaTrust': 3, 'approvalRating': 3},
          treasuryCost: -50,
        ),
        EventChoice(
          id: 'tycoon_reject',
          text: 'Reject the deal entirely — you won\'t be bought. Announce an anti-corruption initiative targeting oligarchic influence in politics.',
          statEffects: {'corruption': -8, 'mediaTrust': 8, 'approvalRating': 8, 'economy': -3},
        ),
        EventChoice(
          id: 'tycoon_expose',
          text: 'Record the conversation and leak it to the media — expose the culture of corruption and position yourself as a reformer.',
          statEffects: {'corruption': -10, 'mediaTrust': 10, 'approvalRating': 10, 'economy': -5, 'stability': -3},
        ),
      ],
    ),
    EventModel(
      id: 'student_leader_strike_call',
      title: 'Student Leader Calls for Strike',
      description: 'A charismatic student leader has gone viral on social media, calling for a national student strike to demand free education, job creation programs, and democratic reforms. Her movement is growing rapidly and threatening to paralyze universities and spill into the streets.',
      category: 'character',
      isCharacterEvent: true,
      characterId: 'student_leader',
      choices: [
        EventChoice(
          id: 'student_meet',
          text: 'Invite the student leader to the presidential palace — meet her personally, listen to her demands, and show respect for youth activism.',
          statEffects: {'happiness': 8, 'stability': 5, 'approvalRating': 8, 'mediaTrust': 5, 'education': 3},
        ),
        EventChoice(
          id: 'student_concessions',
          text: 'Address their demands directly — announce scholarships, job training programs, and a youth advisory council. Take the wind out of the movement.',
          statEffects: {'happiness': 10, 'education': 8, 'stability': 5, 'approvalRating': 10, 'oppositionPower': -5},
          treasuryCost: 100,
        ),
        EventChoice(
          id: 'student_suppress',
          text: 'Suppress the movement — ban the student organization, arrest the leader for inciting unrest, and shut down student social media channels.',
          statEffects: {'happiness': -12, 'stability': -8, 'mediaTrust': -10, 'approvalRating': -10, 'oppositionPower': 10, 'education': -5},
        ),
      ],
    ),
    EventModel(
      id: 'opposition_demands_early_election',
      title: 'Opposition Demands Early Elections',
      description: 'The opposition leader has launched a formal campaign demanding early elections, claiming your government has lost its mandate. They\'ve gathered 2 million signatures on a petition and are threatening indefinite protests until you agree. Some within your own party are quietly supporting the idea.',
      category: 'character',
      choices: [
        EventChoice(
          id: 'early_election_accept',
          text: 'Accept the challenge — call early elections. If you\'re a true democrat, you should welcome the chance to renew your mandate.',
          statEffects: {'stability': 5, 'mediaTrust': 10, 'approvalRating': 8, 'oppositionPower': -5},
        ),
        EventChoice(
          id: 'early_election_refuse',
          text: 'Refuse firmly — elections have a schedule and you won\'t be bullied by street pressure. Govern until your term ends.',
          statEffects: {'stability': -5, 'oppositionPower': 10, 'approvalRating': -5, 'mediaTrust': -3},
        ),
        EventChoice(
          id: 'early_election_referendum',
          text: 'Propose a referendum instead — let the people vote on whether they want early elections. Respect the outcome either way.',
          statEffects: {'stability': 3, 'mediaTrust': 8, 'approvalRating': 5, 'oppositionPower': -3},
          treasuryCost: 40,
        ),
      ],
    ),
  ];

  static EventModel? getEventById(String id) {
    try {
      return allEvents.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  static List<EventModel> getEventsByCategory(String category) {
    return allEvents.where((e) => e.category == category).toList();
  }

  static List<EventModel> getChainEvents(String chainId) {
    return allEvents.where((e) => e.chainId == chainId).toList()
      ..sort((a, b) => (a.chainStage ?? 0).compareTo(b.chainStage ?? 0));
  }
}
