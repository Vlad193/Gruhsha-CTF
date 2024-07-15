// language_ru.as
/*
    Русский перевод для Grusha CTF.
    -- -- -- -- -- -- -- -- --
    Авторы перевода:
    TerminalHash
*/
namespace ru
{
	const string

	//////////////////////////////////////////////////////////
	// Descriptions
	//////////////////////////////////////////////////////////

	// Accolades.as
	d_goldgrushatext						= "Контрибьютор Груши - за разработку мода Gruhsha CTF",
	d_bronzetokentext						= "Бронзовая монета - за поддержание игры после запуска во F2P",
	d_kiwitext								= "Контрибьютор KIW1 - за помощь в разработке мода KIW1",
	d_captaintext							= "Лучший капитан - за смелость и умение набирать хорошие команды",

	// ArcherShop.as
	d_woodenarrowdesc						= "Ставит деревянный блок на месте приземления.",

	// BindingsCommon.as
	d_modbindplaceholder					= "пусто",
	d_modbindnull							= "Нет клавиши",

			// Settings
	d_bmoptlag								= "Дружелюбный к лагам",
	d_bmoptvan								= "Ванильное",
	d_universalyes							= "Да",
	d_universalno							= "Нет",
	d_universalon							= "Включено",
	d_universaloff							= "Выключено",

	// PickingCommands.as
	d_bindingscom							= "Открыть меню кастомных биндингов",
	d_togglechcomtext						= "Переключить смену классов в магазинах",
	d_togglechcomchat						= "Смена классов теперь ",
	d_togglechcom2							= "включена",
	d_togglechcom3							= "выключена",
	d_archerlimchat							= "Максимум лучников теперь ",
	d_archerlimtext							= "Устанавливает лимит на лучников в командах",
	d_builderlimchat						= "Максимум строителей теперь ",
	d_builderlimtext						= "Устанавливает лимит на строителей в командах",
	d_lockcomtext							= "Запрещает набирать людей в команды, запоминая состав и останавливая процесс набора игроков",
	d_lockcomchatunl						= "Команды расформированы",
	d_lockcomchatloc						= "Команды сформированы",
	d_pickcomtext							= "Берёт указанного игрока из наблюдателей в твою команду и передаёт право выбора другому Капитану",
	d_demotecomtext							= "Понизить Капитанов до обычных игроков",
	d_appointcomtext						= "Повысить двух игроков до Капитанов (они выбирают остальных игроков к себе в команду)",
	d_specallcomtext						= "Сделать всех игроков наблюдателями",
	d_preventvoicelinespamtext				= "Запретить игроку спамить войслайнами",

	// Satchel.as
	d_satcheldesc							= "Поджигает горючие блоки, активируется при помощи клавиши броска",

	// SoundsCommands.as
	d_togglesoundscomtext					= "Включить или выключить звук вокалайзов для себя",
	d_togglesoundschattexton				= "Надоедливые звуки войслайнов выключены, ",
	d_togglesoundschattextoff				= "Надоедливые звуки войслайнов включены, ",

	// ScoreboardCommon.as
	d_oldstatstooltip						= "Зажми клавишу \"Shift\", чтобы увидеть статистику прошлого матча",

	// ScoreboardRender.as
	d_currentversiontext					= "Текущая версия: ",

	// ClassSelectMenu.as
	d_totaltext								= "Всего ",

	// Quarters.as
	d_beertext								= "Кружка освежающего кваса.",
	d_mealtext								= "Нажористый и вкусный борщ.",
	d_burgertext							= "Пирожок с грушами с собой в дорогу.",
	d_peartext								= "Сочная и сладкая груша.",
	d_sleeptext								= "Прилечь поспать. Бесплатно!",

	// TimeToEnd.as
	d_thirtyminutesleft						= "Осталось 10 минут до конца раунда, поторопитесь!",

	//////////////////////////////////////////////////////////
	// Names
	//////////////////////////////////////////////////////////

	// ArcherShop.as
	n_woodenarrow							= "Стрела-блок",
	n_bombarrow								= "Стрела-бомба",

	//BindingsCommon.as

		// Buttons
	n_modbindemote							= "Эмоция ",
	n_modbindsmenu							= "Метки",
	n_emotemenu								= "Эмоции",
	n_blocksmenu							= "Блоки",
	n_actionsmenu							= "Действия",
	n_archernmb								= "Магазин лучника\n (бинды)",
	n_buildernmb							= "Магазин строителя\n (бинды)",
	n_knightnmb								= "Магазин рыцаря\n (бинды)",
	n_quartersnmb							= "Магазин еды\n (бинды)",
	n_vehiclenmb							= "Магазин машин\n (бинды)",
	n_boatnmb								= "Магазин лодок\n (бинды)",
	n_settingsmenu							= "Настройки",
	n_vsettingsmenu							= "Настройки визуа-\n ла и звуков",
	n_tagwheel								= "Колесо меток",
	n_emotewheelvanilla						= "Ванильное колесо эмоций",
	n_emotewheelsecond						= "Модовое колесо эмоций",

		// Blocks
	n_stonebl								= "Каменный блок",
	n_stoneback								= "Каменная стена",
	n_stonedoor								= "Каменная дверь",
	n_woodbl								= "Деревянный блок",
	n_woodback								= "Деревянная стена",
	n_wooddoor								= "Деревянная дверь",
	n_platformt								= "Командная платформа",
	n_ladder								= "Лестница",
	n_platform								= "Платформа",
	n_shop									= "Магазин",
	n_spikes								= "Шипы",

		// Actions
	n_drillcommand							= "Достать/Убрать дрель",
	n_cancelarrowschargingcommand			= "Перестать заряжать лук",
	n_markbuildercommand					= "Отмечать позицию строителя",
	n_activateorthrowbomb					= "Активация бомбы (Строитель)",

		// NoMenuBuying Binds
			// Knight Shop
	n_bombnmb								= "Бомба",
	n_waterbombnmb							= "Водная бомба",
	n_minenmb								= "Мина",
	n_kegnmb								= "Кега",
	n_drillnmb								= "Бур",
	n_satchelnmb							= "Взрывпакет",

			// Builder Shop
	n_drillbnmb								= "Бур",
	n_spongebnmb							= "Губка",
	n_bucketwnmb							= "Ведро с водой",
	n_bouldernmb							= "Булыжник",
	n_lanternnmb							= "Фонарь",
	n_bucketnnmb							= "Ведро",
	n_trampolinenmb							= "Батут",
	n_sawnmb								= "Пила",
	n_cratewoodnmb							= "Ящик (за дерево)",
	n_cratecoinsnmb							= "Ящик (за монеты)",

			// Archer Shop
	n_arrowsnmb								= "Стрелы",
	n_waterarrowsnmb						= "Водные стрелы",
	n_firearrowsnmb							= "Огненные стрелы",
	n_bombarrowsnmb							= "Стрелы-бомбы",
	n_blockarrowsnmb						= "Стрелы-блоки",

			// Quarters
	n_beernmb								= "Квас",
	n_mealnmb								= "Борщ",
	n_eggnmb								= "Яйцо",
	n_burgernmb								= "Пирожок с грушей",
	n_pearnmb								= "Груша",
	n_sleepnmb								= "Спать",

			// Vehicle Shop
	n_catapultnmb							= "Катапульта",
	n_ballistanmb							= "Баллиста",
	n_outpostnmb							= "Аванпост",
	n_boltsnmb								= "Болты для баллисты",
	n_shellsnmb								= "Взрывные болты для баллисты",

			// Boat Shop
	n_dinghynmb								= "Шлюпка",
	n_longboatnmb							= "Большая лодка",
	n_warboatnmb							= "Военная лодка",

		// Settings
	n_buildmode								= "Режим строительства",
	n_blockbar								= "Включить панель с блоками",
	n_dsewnmb								= "NoMenuBuying-фича без эмоций",
	n_shownomenubuyingpan					= "Включить NoMenuBuying панель",
	n_nomenubuyingset						= "NoMenuBuying-фича",
	n_nomenubuyingboldarset					= "NoMenuBuying-фича (Строитель)",
	n_camerasw								= "Покачивание камеры (По-умол. 5)",
	n_bodytilt								= "Иммерсивное поведение тела",
	n_headrotating							= "Поворот головы в сторону курсора",
	n_clusterfuck							= "Отображение частиц и кусков",
	n_clusterfuck_blood						= "Отображение крови",
	n_clusterfuck_smoke						= "Отображение дыма",
	n_drillzoneborders						= "Границы зоны дриллинга",
	n_grapplewhilecharging					= "Использовать крюк при стрельбе",
	n_annoyingnature						= "Звук от кустов и листьев",
	n_annoyingvoicelines					= "Звуки войслайнов",
	n_annoyingtags							= "Звуки меток",
	n_customdpsounds						= "Кастомные звуки смерти/боли",
	n_switchclasschanginginshop				= "Выкл. смену класса в магазинах",
	n_drillknight							= "Автоподбор дрели (Рыцарь)",
	n_drillbuilder							= "Автоподбор дрели (Строитель)",
	n_drillarcher							= "Автоподбор дрели (Лучник)",
	n_bombbuilder							= "Автоподбор бомб (Строитель)",
	n_bombarcher							= "Автоподбор бомб (Лучник)",

		// Other
	n_pressdelete							= "Выбери клавишу и нажми [DELETE] для очистки хоткея!",

	// Food.as
	n_burgerinv								= "Пирожок с грушами",

	// KIWI_Playercard.as
	n_medalsn								= "Медали",
	n_partipin								= "Участие",
	n_clanbadgetext							= "Этот игрок состоит в гильдии",

	// ScoreboardCommon.as
	n_modsettingsbutton						= "Настройки",

	// ScoreboardRender.as
	n_matssection							= "Материалы",

	// Quarters.as
	n_beeritem								= "Квас - 1 Сердце",
	//n_beeritem								= "Пиво - 1 Сердце",
	n_mealitem								= "Борщ - Полное здоровье",
	//n_mealitem								= "Мясное блюдо - Полное здоровье",
	n_eggitem								= "Яйцо - Полное здоровье",
	n_burgeritem							= "Пирожок с грушами - Полное здоровье",
	//n_burgeritem							= "Бургер - Полное здоровье",
	n_pearitem								= "Груша - 2 Сердца",
	n_sleepaction							= "Лечь спать",

	empty 					= ""; // keep last
}
