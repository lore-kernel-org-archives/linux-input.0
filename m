From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 26/27] HID: wacom: leds: handle the switch of the LEDs
 directly in the kernel
Date: Tue, 5 Jul 2016 23:32:12 +0200
Message-ID: <20160705213212.GB20992@mail.corp.redhat.com>
References: <1467729563-23318-27-git-send-email-benjamin.tissoires@redhat.com>
 <201607052301.nUC43Iyl%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44847 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755425AbcGEVcU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Jul 2016 17:32:20 -0400
Content-Disposition: inline
In-Reply-To: <201607052301.nUC43Iyl%fengguang.wu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi,

On Jul 05 2016 or thereabouts, kbuild test robot wrote:
> Hi,
> 
> [auto build test ERROR on hid/for-next]
> [also build test ERROR on v4.7-rc6 next-20160705]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Benjamin-Tissoires/HID-wacom-cleanup-EKR-LED/20160705-225431
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-next
> config: i386-randconfig-a0-201627 (attached as .config)
> compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/hid/wacom_sys.c: In function 'wacom_led_register_one':
> >> drivers/hid/wacom_sys.c:1061:15: error: 'struct led_trigger' has no member named 'name'
>       led->trigger.name = name;

Thanks, looks like I forgot to add the Kconfig bits CONFIG_LEDS_TRIGGERS
here (and CONFIG_LEDS_CLASS in 23/27).

Cheers,
Benjamin

>                   ^
> >> drivers/hid/wacom_sys.c:1062:11: error: implicit declaration of function 'devm_led_trigger_register' [-Werror=implicit-function-declaration]
>       error = devm_led_trigger_register(dev, &led->trigger);
>               ^~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/hid/wacom_sys.c: In function 'wacom_led_next':
> >> drivers/hid/wacom_sys.c:1200:25: error: 'struct led_classdev' has no member named 'trigger'
>      } while (next_led->cdev.trigger != &next_led->trigger);
>                             ^
>    cc1: some warnings being treated as errors
> 
> vim +1061 drivers/hid/wacom_sys.c
> 
>   1055				      group,
>   1056				      id);
>   1057		if (!name)
>   1058			return -ENOMEM;
>   1059	
>   1060		if (!read_only) {
> > 1061			led->trigger.name = name;
> > 1062			error = devm_led_trigger_register(dev, &led->trigger);
>   1063			if (error) {
>   1064				hid_err(wacom->hdev,
>   1065					"failed to register LED trigger %s: %d\n",
>   1066					led->cdev.name, error);
>   1067				return error;
>   1068			}
>   1069		}
>   1070	
>   1071		led->group = group;
>   1072		led->id = id;
>   1073		led->wacom = wacom;
>   1074		led->llv = wacom->led.llv;
>   1075		led->hlv = wacom->led.hlv;
>   1076		led->cdev.name = name;
>   1077		led->cdev.max_brightness = LED_FULL;
>   1078		led->cdev.brightness_get = __wacom_led_brightness_get;
>   1079		if (!read_only) {
>   1080			led->cdev.brightness_set_blocking = wacom_led_brightness_set;
>   1081			led->cdev.default_trigger = led->cdev.name;
>   1082		} else {
>   1083			led->cdev.brightness_set = wacom_led_readonly_brightness_set;
>   1084		}
>   1085	
>   1086		error = devm_led_classdev_register(dev, &led->cdev);
>   1087		if (error) {
>   1088			hid_err(wacom->hdev,
>   1089				"failed to register LED %s: %d\n",
>   1090				led->cdev.name, error);
>   1091			led->cdev.name = NULL;
>   1092			return error;
>   1093		}
>   1094	
>   1095		return 0;
>   1096	}
>   1097	
>   1098	static void wacom_led_groups_release_one(void *data)
>   1099	{
>   1100		struct wacom_group_leds *group = data;
>   1101	
>   1102		devres_release_group(group->dev, group);
>   1103	}
>   1104	
>   1105	static int wacom_led_groups_alloc_and_register_one(struct device *dev,
>   1106							   struct wacom *wacom,
>   1107							   int group_id, int count,
>   1108							   bool read_only)
>   1109	{
>   1110		struct wacom_led *leds;
>   1111		int i, error;
>   1112	
>   1113		if (group_id >= wacom->led.count || count <= 0)
>   1114			return -EINVAL;
>   1115	
>   1116		if (!devres_open_group(dev, &wacom->led.groups[group_id], GFP_KERNEL))
>   1117			return -ENOMEM;
>   1118	
>   1119		leds = devm_kzalloc(dev, sizeof(struct wacom_led) * count, GFP_KERNEL);
>   1120		if (!leds) {
>   1121			error = -ENOMEM;
>   1122			goto err;
>   1123		}
>   1124	
>   1125		wacom->led.groups[group_id].leds = leds;
>   1126		wacom->led.groups[group_id].count = count;
>   1127	
>   1128		for (i = 0; i < count; i++) {
>   1129			error = wacom_led_register_one(dev, wacom, &leds[i],
>   1130						       group_id, i, read_only);
>   1131			if (error)
>   1132				goto err;
>   1133		}
>   1134	
>   1135		wacom->led.groups[group_id].dev = dev;
>   1136	
>   1137		devres_close_group(dev, &wacom->led.groups[group_id]);
>   1138	
>   1139		/*
>   1140		 * There is a bug (?) in devm_led_classdev_register() in which its
>   1141		 * increments the refcount of the parent. If the parent is an input
>   1142		 * device, that means the ref count never reaches 0 when
>   1143		 * devm_input_device_release() gets called.
>   1144		 * This means that the LEDs are still there after disconnect.
>   1145		 * Manually force the release of the group so that the leds are released
>   1146		 * once we are done using them.
>   1147		 */
>   1148		error = devm_add_action_or_reset(&wacom->hdev->dev,
>   1149						 wacom_led_groups_release_one,
>   1150						 &wacom->led.groups[group_id]);
>   1151		if (error)
>   1152			return error;
>   1153	
>   1154		return 0;
>   1155	
>   1156	err:
>   1157		devres_release_group(dev, &wacom->led.groups[group_id]);
>   1158		return error;
>   1159	}
>   1160	
>   1161	struct wacom_led *wacom_led_find(struct wacom *wacom, unsigned int group_id,
>   1162					 unsigned int id)
>   1163	{
>   1164		struct wacom_group_leds *group;
>   1165	
>   1166		if (group_id >= wacom->led.count)
>   1167			return NULL;
>   1168	
>   1169		group = &wacom->led.groups[group_id];
>   1170	
>   1171		if (!group->leds)
>   1172			return NULL;
>   1173	
>   1174		id %= group->count;
>   1175	
>   1176		return &group->leds[id];
>   1177	}
>   1178	
>   1179	/**
>   1180	 * wacom_led_next: gives the next available led with a wacom trigger.
>   1181	 *
>   1182	 * returns the next available struct wacom_led which has its default trigger
>   1183	 * or the current one if none is available.
>   1184	 */
>   1185	struct wacom_led *wacom_led_next(struct wacom *wacom, struct wacom_led *cur)
>   1186	{
>   1187		struct wacom_led *next_led;
>   1188		int group, next;
>   1189	
>   1190		if (!wacom || !cur)
>   1191			return NULL;
>   1192	
>   1193		group = cur->group;
>   1194		next = cur->id;
>   1195	
>   1196		do {
>   1197			next_led = wacom_led_find(wacom, group, ++next);
>   1198			if (!next_led || next_led == cur)
>   1199				return next_led;
> > 1200		} while (next_led->cdev.trigger != &next_led->trigger);
>   1201	
>   1202		return next_led;
>   1203	}
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


