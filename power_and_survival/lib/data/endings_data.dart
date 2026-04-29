class EndingsData {
  static const Map<String, Map<String, String>> allEndings = {
    'beloved_leader': {
      'title': 'The Beloved Leader',
      'condition': 'approvalRating >= 80 && happiness >= 75 && economy >= 60',
      'text': '''You step down from office to thunderous applause. Crowds line the streets as your motorcade passes through the capital one final time. Children wave flags, veterans salute, and even your political opponents acknowledge your contribution to the nation.

Your presidency will be remembered as a golden age. The economy flourished under your stewardship, citizens prospered, and the nation\'s standing in the world reached new heights. Schools bear your name, and the presidential library you leave behind becomes a monument to democratic governance.

History will record you as one of the greatest leaders this nation has ever known. Your successor inherits a stable, prosperous country — and the enormous challenge of living up to your legacy. You retire to a quiet life, knowing you made a difference when it mattered most.''',
    },
    'iron_ruler': {
      'title': 'The Iron Ruler',
      'condition': 'military >= 75 && stability >= 70 && happiness < 40',
      'text': '''Your presidency ends with the nation intact but its spirit broken. You maintained order through strength, crushed dissent with an iron fist, and kept the machinery of state running through sheer force of will. The military respects you. The people fear you.

No one dares challenge your authority as you complete your term, but the streets are quiet not from contentment but from resignation. Artists have fled, journalists write only what is approved, and the young dream of emigration rather than building their homeland.

Your legacy is one of stability without freedom, order without joy. Future historians will debate whether your iron hand saved the nation from chaos or merely delayed an inevitable reckoning. The country you leave behind is functional but fragile — a pressure cooker with the lid screwed tight.''',
    },
    'economic_architect': {
      'title': 'The Economic Architect',
      'condition': 'economy >= 80 && treasury >= 500 && debt <= 100',
      'text': '''You leave office as the architect of an economic miracle. When you took power, the treasury was empty and businesses were fleeing. Through shrewd policy, disciplined spending, and bold reforms, you transformed the nation into a regional economic powerhouse.

Foreign investment pours in, unemployment is at historic lows, and the national currency is strong. Markets around the world watch your country\'s stock exchange as a barometer of regional health. Your economic reforms have been studied and replicated by developing nations across the globe.

Your critics say you prioritized profits over people, that inequality grew while the GDP soared. Perhaps there is truth in that. But as you hand over the keys to a prosperous nation, you know that without a strong economy, none of the social programs your successors dream of would be possible.''',
    },
    'fallen_dictator': {
      'title': 'The Fallen Dictator',
      'condition': 'isGameOver && (gameOverReason == "revolution" || gameOverReason == "coup")',
      'text': '''It ended as it always does for those who grip power too tightly — with the sound of boots in the hallway and the roar of crowds outside the gates. Your presidency, which began with such promise, devolved into authoritarianism, corruption, and finally, collapse.

The images broadcast around the world tell the story: your empty office, ransacked by revolutionaries; your portraits torn from walls; your loyalists fleeing in the night. The people you claimed to serve dancing in the streets as your regime crumbles.

You escape into exile — or perhaps you don\'t. History will remember you as a cautionary tale, a leader who had every opportunity to serve their people but chose instead to serve themselves. Your name becomes a synonym for corruption and betrayal of public trust.''',
    },
    'bankrupt_nation': {
      'title': 'The Bankrupt President',
      'condition': 'isGameOver && gameOverReason == "bankruptcy"',
      'text': '''The numbers finally caught up with you. Despite endless promises and creative accounting, the national treasury hit zero — and then went deep into the red. International creditors came calling, and when you couldn\'t pay, they stopped lending. The economic collapse was swift and merciless.

Banks closed their doors. Currency became worthless. Citizens watched their life savings evaporate overnight. The IMF sent its team, but their conditions were so harsh that implementing them sparked the very unrest they were meant to prevent.

Your presidency ends not with a bang but with a balance sheet written in red ink. The nation will spend a generation recovering from the debt you accumulated. Economic textbooks will use your administration as a case study in fiscal irresponsibility.''',
    },
    'peaceful_transition': {
      'title': 'The Peaceful Transition',
      'condition': 'stability >= 50 && !isGameOver',
      'text': '''Your presidency ends as democracy intended — with a peaceful transfer of power. You may not have been perfect, you may not have achieved everything you promised, but you honored the most sacred duty of any democratic leader: you stepped aside when your time was up.

The transition ceremony is dignified. Your successor takes the oath as you watch, remembering the day you stood in that same spot, full of hope and ambition. The challenges you faced — economic crises, security threats, political storms — tested you in ways you never imagined.

You leave office with your head held high, knowing that the most important thing you did was preserve the democratic institutions that will outlast any single presidency. The nation endures, its democracy intact, its future uncertain but full of possibility.''',
    },
    'scandal_exit': {
      'title': 'The Scandalous Exit',
      'condition': 'isGameOver && gameOverReason == "impeachment"',
      'text': '''The cameras flash as you walk down the steps of the presidential palace for the last time, not in triumph but in disgrace. The impeachment proceedings were brutal — weeks of testimony, leaked documents, and damning evidence paraded before the nation and the world.

Your allies abandoned you one by one. The party you built turned its back. Even your closest advisors testified against you in exchange for immunity. The final vote was overwhelming — the parliament spoke with one voice, and that voice said you had to go.

Your legacy is a cautionary tale about the corrupting influence of power. The reforms you championed, the policies you enacted, the genuine good you may have done — all of it overshadowed by the scandal that brought you down. History is unforgiving to those who abuse the public trust.''',
    },
  };

  static Map<String, String>? getEndingById(String id) => allEndings[id];

  static List<String> get endingIds => allEndings.keys.toList();
}
