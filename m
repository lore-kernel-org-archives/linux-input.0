Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793367485;
	b=ywKQlY9dGFnQOSN6y6uGvWUh1MFtMaOETcCEv447Hrc72L+nZ3CFuv3M1t9iPgPmD0+F
	 GTuQ1EFFwfdgdTeqJ43vM6bnKPNuUEX2y2kHoCCeB1TbAMgyFfpQ0Gkzh5fbWWH5a43DK
	 PP9FgiiwGv6/aNQfp2IH3Ttf/rQLtjo8zLQm+w6v7tE5z1h66/yHji6LMSCBKEkRmLvX2
	 enuuDWwKsqTIP5PSUEWogLBMqvXU7YJq5aVSARcJortTZrAL0qc0bog8ctUn5skrXFu9d
	 bzg+hR5369C/8BkGNEMARu/3nLYMIx4yRJQcyRa1VQIrV6g5hUBqt1J7zR5fzlghKtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793367485;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=iPdG+cT0BL38NwEwOoKvNVgVRPztRGl2TCqDKgrPcRE=;
	b=YqiRoXj/3Ts8aOzIfEEXVbn2ahztPB7lvZrziRnVub8RMvySY2nj3MjW8tnAzT4uMpNS
	 YzGNrZfi2wW2nsYLel/2iV+KnQUYFsELCiR5BcT/nIm7c848tz1CX8eREGuIZs8DmGu5V
	 zm3kKSUwbugpjCbecvqCMzSeo31zoJx0+sHZJtfayRaD5WZL8ZglwLdzuzUmmWgZD1K7o
	 BnaNUKDPRTwxwdWmtXQhrNnS9hwCa93B9rRkTzU97G1hTgSQDsaP1tDIOrV7UAA/14qb4
	 M/uruLbIVKOKmnKWOvqs1gFRnTAtoxii9Ym+c9yYpYraiIiDLTPILHfbJlz+jVS0d7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DXOYJ36+;
	arc=none smtp.remote-ip=91.218.175.62
Received: from mta0.migadu.com (out-62.mta0.migadu.com [91.218.175.62])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691B7606A31C
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 13:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 691B7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DXOYJ36+
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KQkCKReoMEvNXYUJqNKgJpZ8XeejZRmx6DCKCG7tiuU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793367481; v=1; x=1793972281;
 b=DXOYJ36+Zo7EtHcnbxeT41hnbtGaomCUA1paMNFrpYA4eGJ2FntKGMrIjrgvq9VZP2/3LW8t
 CAfKCB87kAYmDjDDx5WtvnCzdGSpbqucBEwO4ZnonvtN7cpPWldq9maN3RI+kvvJo9MyA/cSPo4
 M8s8AKnGp38iPHxbHRDZGERA=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8bd6876d816b4420;
	Fri, 30 Oct 2026 13:38:01 +0000
X-Mizu-Trace-ID: 8bd6876d816b4420
X-Migadu-Flow: FLOW_OUT
Message-ID: <3791151b-8530-4c38-a9a5-77f415625116@linux.dev>
Date: Fri, 30 Oct 2026 14:38:00 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 01/18] HID: asus: add support for ROG Ally handhelds
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 linux-input@vger.kernel.org, kernel@lists.opengamingcollective.org,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 "Luke D . Jones" <luke@ljones.dev>,
 Mateusz Schwartz <matthew.schwartz@linux.dev>,
 Denis Benato <benato.denis96@gmail.com>, Jonathan LoBue
 <jlobue10@gmail.com>, Khamunetri Clark <khamunetriclark@gmail.com>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Joshua Leivenzon <hacker1024@users.sourceforge.net>,
 Nathan Chancellor <nathan@kernel.org>,
 =?UTF-8?Q?Rebecca_Mara_M=C3=BCller?= <rebecca.mara@posteo.de>,
 Ivan Levchenko <me@livan.pro>, Corentin Chary <corentin.chary@gmail.com>,
 Hans de Goede <hansg@kernel.org>
References: <20261025235232.129945-1-denis.benato@linux.dev>
 <20261025235232.129945-2-denis.benato@linux.dev>
 <088f5d2a-c5e1-5805-1872-27aa70b556dd@linux.intel.com>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <088f5d2a-c5e1-5805-1872-27aa70b556dd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/26/26 13:38, Ilpo Järvinen wrote:
> On Sun, 25 Oct 2026, Denis Benato wrote:
>
>> Implement the core functionality for ASUS handhelds:
>> - extend functionality of hid-asus if driver is enabled
>> - initialise the device to a "ready" state
>> - implement Ally X input mapping
>> - emit a single proper event for AC button long press
>> - reject probes from a different controller and from duplicated
>>   interfaces of the same one, which could evict the shared state
>>
>> Signed-off-by: Khamunetri Clark <khamunetriclark@gmail.com>
>> Signed-off-by: Denis Benato <denis.benato@linux.dev>
>> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> Signed-off-by: Luke Jones <luke@ljones.dev>
>> Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
> Shouldn't you be using some Co-developed-by tags too?
>
>> ---
>>  drivers/hid/hid-asus.c | 996 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 996 insertions(+)
>>
>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
>> index f6aa1be09ad5..9e6796bbbdcb 100644
>> --- a/drivers/hid/hid-asus.c
>> +++ b/drivers/hid/hid-asus.c
>> @@ -24,12 +24,18 @@
>>  #include <linux/cleanup.h>
>>  #include <linux/dmi.h>
>>  #include <linux/hid.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/list.h>
>>  #include <linux/module.h>
>> +#include <linux/mutex.h>
>>  #include <linux/platform_data/x86/asus-wmi.h>
>> +#include <linux/types.h>
>>  #include <linux/input/mt.h>
>>  #include <linux/usb.h> /* For to_usb_interface for T100 touchpad intf check */
>>  #include <linux/power_supply.h>
>> +#include <linux/stddef.h>
>>  #include <linux/leds.h>
>> +#include <linux/unaligned.h>
>>  
>>  #include "hid-ids.h"
>>  
>> @@ -37,6 +43,9 @@ MODULE_AUTHOR("Yusuke Fujimaki <usk.fujimaki@gmail.com>");
>>  MODULE_AUTHOR("Brendan McGrath <redmcg@redmandi.dyndns.org>");
>>  MODULE_AUTHOR("Victor Vlasenko <victor.vlasenko@sysgears.com>");
>>  MODULE_AUTHOR("Frederik Wenigwieser <frederik.wenigwieser@gmail.com>");
>> +MODULE_AUTHOR("Denis Benato <denis.benato@linux.dev>");
>> +MODULE_AUTHOR("Luke Jones <luke@ljones.dev>");
>> +MODULE_AUTHOR("Khamunetri Clark <khamunetriclark@gmail.com>");
>>  MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>>  
>>  #define T100_TPAD_INTF 2
>> @@ -57,6 +66,19 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>>  #define ROG_ALLY_X_MIN_MCU 313
>>  #define ROG_ALLY_MIN_MCU 319
>>  
>> +#define HID_ALLY_INTF_KEYBOARD_IN 0x81
>> +#define HID_ALLY_INTF_CFG_IN 0x83
>> +#define HID_ALLY_X_INTF_IN 0x87
>> +
>> +#define HID_ALLY_GET_REPORT_ID 0x0D
>> +#define HID_ALLY_SET_REPORT_ID 0x5A
>> +#define HID_ALLY_FEATURE_CODE_PAGE 0xD1
>> +
>> +#define HID_ALLY_X_INPUT_REPORT_SIZE 16
>> +#define HID_ALLY_X_INPUT_REPORT 0x0B
>> +
>> +#define HID_ALLY_READY_MAX_TRIES 6
>> +
>>  /* Spurious HID codes sent by QUIRK_ROG_NKEY_KEYBOARD devices */
>>  #define ASUS_SPURIOUS_CODE_0XEA 0xea
>>  #define ASUS_SPURIOUS_CODE_0XEC 0xec
>> @@ -161,6 +183,40 @@ struct asus_touchpad_info {
>>  	int report_size;
>>  };
>>  
>> +struct ally_handheld {
>> +	/* All read/write to IN interfaces must lock */
>> +	struct mutex intf_mutex;
>> +	/*
>> +	 * USB device of the connected controller, held with a reference:
>> +	 * at most one ROG Ally can exist, so probes from any other USB
>> +	 * device are rejected to protect the shared state.
>> +	 */
>> +	struct usb_device *udev;
>> +	struct hid_device *cfg_hdev;
>> +
>> +	struct input_dev *ally_x_input;
>> +	struct hid_device *ally_x_hdev;
>> +	/*
>> +	 * Probe reservations: set under ally_data_lock when a probe takes
>> +	 * a role on, cleared when that probe publishes its pointer or
>> +	 * fails, so a concurrent second probe of the same role is rejected
>> +	 * instead of racing the first one through its sleeping
>> +	 * initialization (or its check-to-publication window, for the
>> +	 * keyboard role).
>> +	 */
>> +	bool cfg_probe_in_progress;
>> +	bool ally_x_probe_in_progress;
>> +	bool keyboard_probe_in_progress;
>> +
>> +	struct hid_device *keyboard_hdev;
>> +	struct input_dev *keyboard_input;
>> +
>> +	u8 cad_sequence_state;
>> +	unsigned long cad_last_event_time;
>> +
>> +	struct delayed_work resume_work;
>> +};
>> +
>>  struct asus_drvdata {
>>  	unsigned long quirks;
>>  	struct hid_device *hdev;
>> @@ -168,6 +224,7 @@ struct asus_drvdata {
>>  	struct input_dev *tp_kbd_input;
>>  	struct asus_worker *worker;
>>  	unsigned int kbd_backlight_brightness;
>> +	struct ally_handheld *rog_ally;
>>  	const struct asus_touchpad_info *tp;
>>  	struct power_supply *battery;
>>  	struct power_supply_desc battery_desc;
>> @@ -240,12 +297,906 @@ static const struct asus_touchpad_info medion_e1239t_tp = {
>>  	.report_size = 32 /* 2 byte header + 5 * 5 + 5 byte footer */,
>>  };
>>  
>> +enum ally_command_codes {
>> +	CMD_SET_GAMEPAD_MODE            = 0x01,
>> +	CMD_SET_MAPPING                 = 0x02,
>> +	CMD_SET_JOYSTICK_MAPPING        = 0x03,
>> +	CMD_SET_JOYSTICK_DEADZONE       = 0x04,
>> +	CMD_SET_TRIGGER_RANGE           = 0x05,
>> +	CMD_SET_VIBRATION_INTENSITY     = 0x06,
>> +	CMD_LED_CONTROL                 = 0x08,
>> +	CMD_CHECK_READY                 = 0x0A,
>> +	CMD_SET_XBOX_CONTROLLER         = 0x0B,
>> +	CMD_CHECK_XBOX_SUPPORT          = 0x0C,
>> +	CMD_USER_CAL_DATA               = 0x0D,
>> +	CMD_CHECK_USER_CAL_SUPPORT      = 0x0E,
>> +	CMD_SET_TURBO_PARAMS            = 0x0F,
>> +	CMD_CHECK_TURBO_SUPPORT         = 0x10,
>> +	CMD_CHECK_RESP_CURVE_SUPPORT    = 0x12,
>> +	CMD_SET_RESP_CURVE              = 0x13,
>> +	CMD_CHECK_DIR_TO_BTN_SUPPORT    = 0x14,
>> +	CMD_SET_GYRO_PARAMS             = 0x15,
>> +	CMD_CHECK_GYRO_TO_JOYSTICK      = 0x16,
>> +	CMD_CHECK_ANTI_DEADZONE         = 0x17,
>> +	CMD_SET_ANTI_DEADZONE           = 0x18,
>> +};
>> +
>> +static const u8 ALLY_FORCE_FEEDBACK_OFF[] = {
>> +	0x0D, 0x0F, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0xEB
>> +};
>> +
>> +/*
>> + * The ROG Ally device presents multiple USB interfaces (keyboard, mouse, gamepad,
>> + * and custom configuration interface) that bind to the same module. Since only
>> + * one ROG Ally device can be connected at a time, we use a single global static
>> + * ally_handheld structure to share state across these separate HID interfaces.
>> + */
>> +static void ally_resume_work_fn(struct work_struct *work);
>> +
>> +/*
>> + * Changes to ally_drvdata must lock: the raw_event callbacks, which may
>> + * run in atomic (URB completion) context, also take this lock, so it must
>> + * be a spinlock.
>> + */
>> +static DEFINE_SPINLOCK(ally_data_lock);
>> +static struct ally_handheld ally_drvdata = {
>> +	.intf_mutex = __MUTEX_INITIALIZER(ally_drvdata.intf_mutex),
>> +	/*
>> +	 * Initialised statically so it is always safe to cancel, whichever
>> +	 * of the interfaces probed or failed to probe.
>> +	 */
>> +	.resume_work = __DELAYED_WORK_INITIALIZER(ally_drvdata.resume_work,
>> +						  ally_resume_work_fn, 0),
>> +};
>> +
>> +/*
>> + * Drop the recorded USB device if no Ally interface is bound anymore and
>> + * none is initializing either: probe failures never run remove(), so
>> + * without this cleanup a failed probe would leave a stale record behind
>> + * and the driver would then reject the real controller when it
>> + * reconnects. A probe whose role is reserved still needs the record.
>> + */
>> +static void ally_put_udev_if_orphaned(void)
>> +{
>> +	struct usb_device *udev;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&ally_data_lock, flags);
>> +	if (!ally_drvdata.udev || ally_drvdata.keyboard_hdev ||
>> +	    ally_drvdata.cfg_hdev || ally_drvdata.ally_x_hdev ||
>> +	    ally_drvdata.cfg_probe_in_progress ||
>> +	    ally_drvdata.ally_x_probe_in_progress ||
>> +	    ally_drvdata.keyboard_probe_in_progress) {
>> +		spin_unlock_irqrestore(&ally_data_lock, flags);
>> +		return;
>> +	}
>> +
>> +	udev = ally_drvdata.udev;
>> +	ally_drvdata.udev = NULL;
>> +	spin_unlock_irqrestore(&ally_data_lock, flags);
> Please use scoped guard() so duplicating unlock is avoided.
>
>> +
>> +	usb_put_dev(udev);
>> +}
>> +
>> +/*
>> + * Release the role reservation taken by hid_asus_ally_probe(): a failed
>> + * probe must free the role again, or every later probe of that role
>> + * would be rejected. A successful probe releases it when it publishes
>> + * its pointer.
>> + */
>> +static void ally_probe_release_role(int ep)
>> +{
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&ally_data_lock, flags);
>> +	if (ep == HID_ALLY_INTF_CFG_IN)
>> +		ally_drvdata.cfg_probe_in_progress = false;
>> +	else if (ep == HID_ALLY_X_INTF_IN)
>> +		ally_drvdata.ally_x_probe_in_progress = false;
>> +	else if (ep == HID_ALLY_INTF_KEYBOARD_IN)
>> +		ally_drvdata.keyboard_probe_in_progress = false;
>> +	spin_unlock_irqrestore(&ally_data_lock, flags);
>> +}
>> +
>>  static const u8 asus_report_id_init[] = {
>>  	FEATURE_KBD_REPORT_ID,
>>  	FEATURE_KBD_LED_REPORT_ID1,
>>  	FEATURE_KBD_LED_REPORT_ID2
>>  };
>>  
>> +static inline int ally_dev_set_report(struct hid_device *hdev, const u8 *buf, size_t len)
>> +{
>> +	u8 *dmabuf __free(kfree) = kmemdup(buf, len, GFP_KERNEL);
>> +	if (!dmabuf)
>> +		return -ENOMEM;
>> +
>> +	return hid_hw_raw_request(hdev, buf[0], dmabuf, len,
>> +					HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
>> +}
>> +
>> +static inline int ally_dev_get_report(struct hid_device *hdev, u8 *out, size_t len)
>> +{
>> +	return hid_hw_raw_request(hdev, HID_ALLY_GET_REPORT_ID, out, len,
>> +		HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
>> +}
>> +
>> +static void ally_resume_work_fn(struct work_struct *work)
>> +{
>> +	struct ally_handheld *ally = container_of(work, struct ally_handheld,
> Include for container_of().
>
>> +						  resume_work.work);
>> +	struct input_dev *keyboard_input, *x_input;
>> +	unsigned long flags;
>> +
>> +	/*
>> +	 * Snapshot the very pointers that get dereferenced under the lock
>> +	 * protecting them, and take a reference on each input_dev: probe
>> +	 * sets keyboard_hdev even when the interface exposes no input_dev,
>> +	 * removal clears the two fields one after the other, and the input
>> +	 * devices are freed with their own interface.
>> +	 */
>> +	spin_lock_irqsave(&ally_data_lock, flags);
>> +	keyboard_input = input_get_device(ally->keyboard_input);
>> +	x_input = input_get_device(ally->ally_x_input);
>> +	spin_unlock_irqrestore(&ally_data_lock, flags);
>> +
>> +	/*
>> +	 * Force release all vendor buttons to prevent "stuck" ghosting on
>> +	 * resume (workaround for Ally X USB re-probing during suspend/resume).
>> +	 */
>> +	if (keyboard_input) {
>> +		input_report_key(keyboard_input, KEY_F16, 0);
>> +		input_report_key(keyboard_input, KEY_F17, 0);
>> +		input_report_key(keyboard_input, KEY_F18, 0);
>> +		input_report_key(keyboard_input, KEY_F19, 0);
>> +		input_report_key(keyboard_input, KEY_F20, 0);
>> +		input_report_key(keyboard_input, KEY_PROG1, 0);
>> +		input_sync(keyboard_input);
>> +		input_put_device(keyboard_input);
>> +	}
>> +
>> +	if (x_input) {
>> +		input_report_key(x_input, KEY_F16, 0);
>> +		input_report_key(x_input, KEY_F17, 0);
>> +		input_report_key(x_input, KEY_F18, 0);
>> +		input_report_key(x_input, KEY_PROG1, 0);
>> +		input_sync(x_input);
>> +		input_put_device(x_input);
>> +	}
>> +}
>> +
>> +/**
>> + * handle_ctrl_alt_del() - detect a left button long press
>> + * @ally: ally handheld structure holding the sequence state
>> + * @data: raw report buffer, rewritten in place when the sequence matches
>> + * @size: length of @data in bytes
>> + *
>> + * The Ally left button emits a sequence of ctrl+alt+del events. Capture that
>> + * and emit only a single code for that single event.
>> + *
>> + * Return: true iff the event has been managed
> Add .
>
>> + */
>> +static bool handle_ctrl_alt_del(struct ally_handheld *ally, u8 *data, int size)
>> +{
>> +	bool time_is_past = time_after(jiffies, ally->cad_last_event_time + msecs_to_jiffies(100));
>> +
>> +	if (size < 16 || data[0] != 0x01)
> You're conjuring...
>
>> +		return false;
>> +
>> +	if (ally->cad_sequence_state > 0 && time_is_past)
>> +		ally->cad_sequence_state = 0;
>> +
>> +	ally->cad_last_event_time = jiffies;
>> +
>> +	switch (ally->cad_sequence_state) {
>> +	case 0:
>> +		if (data[1] == 0x01 && data[2] == 0x00 && data[3] == 0x00) {
>> +			ally->cad_sequence_state = 1;
>> +			data[1] = 0x00;
>> +			return true;
>> +		}
>> +		break;
>> +	case 1:
>> +		if (data[1] == 0x05 && data[2] == 0x00 && data[3] == 0x00) {
>> +			ally->cad_sequence_state = 2;
>> +			data[1] = 0x00;
>> +			return true;
>> +		}
>> +		break;
>> +	case 2:
>> +		if (data[1] == 0x05 && data[2] == 0x00 && data[3] == 0x4c) {
>> +			ally->cad_sequence_state = 3;
>> +			data[1] = 0x00;
>> +			data[3] = 0x6F; /* F20 */
>> +			return true;
>> +		}
>> +		break;
>> +	case 3:
>> +		if (data[1] == 0x04 && data[2] == 0x00 && data[3] == 0x4c) {
>> +			ally->cad_sequence_state = 4;
>> +			data[1] = 0x00;
>> +			data[3] = 0x00;
>> +			return true;
>> +		}
>> +		break;
>> +	case 4:
>> +		if (data[1] == 0x00 && data[2] == 0x00 && data[3] == 0x4c) {
>> +			ally->cad_sequence_state = 5;
>> +			data[3] = 0x00;
>> +			return true;
>> +		}
>> +		break;
>> +	}
> ...There were lots of literals in this function. I suggest naming most of 
> them with defines for better readability.
>
>> +	ally->cad_sequence_state = 0;
>> +	return false;
>> +}
>> +
>> +static bool handle_ally_event(struct hid_device *hdev, struct ally_handheld *ally,
>> +			      u8 *data, int size)
>> +{
>> +	struct input_dev *keyboard_input;
>> +	unsigned long flags;
>> +	int keycode = 0;
>> +
>> +	if (size < 2)
>> +		return false;
>> +
>> +	if (data[0] == 0x5A) {
>> +		switch (data[1]) {
>> +		case 0x38:
>> +			keycode = KEY_F19;
> Here's a good example for what I'm after:
>
> That data[0] == 0x5A line tells me nothing what the check is for (I 
> guess the same goes for most readers of this code!). If you'd name 0x5A 
> with a define, the problem would likely vanish, I'm not sure if [0] needs 
> name too or not.
>
> In contrast, the case + keycode combination might not necessarily need 
> naming 0x38 because the meaning can be inherited (I don't mind if you name 
> 0x38 as well but it doesn't seem as big problem as 0x5A).
>
>> +			break;
>> +		case 0xA6:
>> +			keycode = KEY_F16;
>> +			break;
>> +		case 0xA7:
>> +			keycode = KEY_F17;
>> +			break;
>> +		case 0xA8:
>> +			keycode = KEY_F18;
>> +			break;
>> +		default:
>> +			return false;
>> +		}
>> +
>> +		/*
>> +		 * Take a reference on the input_dev before dropping the lock:
>> +		 * the keyboard interface can be unbound concurrently, and its
>> +		 * input_dev is freed with it.
>> +		 */
>> +		spin_lock_irqsave(&ally_data_lock, flags);
>> +		keyboard_input = input_get_device(ally->keyboard_input);
>> +		spin_unlock_irqrestore(&ally_data_lock, flags);
>> +
>> +		if (!keyboard_input)
>> +			return false;
>> +
>> +		input_report_key(keyboard_input, keycode, 1);
>> +		input_sync(keyboard_input);
>> +		input_report_key(keyboard_input, keycode, 0);
>> +		input_sync(keyboard_input);
>> +		input_put_device(keyboard_input);
>> +		return true;
>> +	}
>> +	return false;
>> +}
>> +
>> +/**
>> + * ally_gamepad_send_packet() - Send a raw packet to the gamepad device
>> + * @ally: ally handheld structure
>> + * @hdev: HID device
>> + * @buf: buffer containing the packet data
>> + * @len: length of data to send
>> + *
>> + * Return: count of data transferred, negative if error
>> + */
>> +static int ally_gamepad_send_packet(struct ally_handheld *ally,
>> +				    struct hid_device *hdev, const u8 *buf, size_t len)
>> +{
>> +	guard(mutex)(&ally->intf_mutex);
>> +	return ally_dev_set_report(hdev, buf, len);
>> +}
>> +
>> +/**
>> + * ally_gamepad_send_receive_packet() - Send a packet and receive the response
>> + * @ally: ally handheld structure
>> + * @hdev: HID device
>> + * @buf: buffer containing the packet data to send and receive response in
>> + * @len: length of buffer
>> + *
>> + * Return: count of data transferred, negative if error
>> + */
>> +static int ally_gamepad_send_receive_packet(struct ally_handheld *ally,
>> +					    struct hid_device *hdev,
>> +					    u8 *buf, size_t len)
>> +{
>> +	int ret;
>> +
>> +	scoped_guard(mutex, &ally->intf_mutex) {
>> +		ret = ally_dev_set_report(hdev, buf, len);
>> +		if (ret >= 0) {
>> +			memset(buf, 0, len);
>> +			ret = ally_dev_get_report(hdev, buf, len);
> Thanks to using guard, you can revese the logic, handle errors first and 
> return immediately, in both cases.
>
> Also, this function doesn't need scoped_guard() but could use plain 
> guard()
>
>> +		}
>> +	}
>> +
>> +	return ret;
> This becomes plain return 0; when you return errors right away
>
> => simpler code flow.
>
>> +}
>> +
>> +/**
>> + * ally_alloc_cmd() - Construct a command buffer for the gamepad
>> + * @cmd: Command code to send
>> + * @payload: Optional payload data to include in the command
>> + * @payload_size: Size of the payload data
>> + *
>> + * The constructed buffer is 64 bytes long, and it is the caller
>> + * responsibility to free the buffer using kfree().
>> + *
>> + * Return: the newly allocated buffer containing the command, or NULL on
>> + * allocation failure or if the payload would not fit in the report
> Add .
>
>> + */
>> +static u8 *ally_alloc_cmd(u8 cmd, const u8 *payload, u8 payload_size)
>> +{
>> +	u8 *hidbuf;
>> +
>> +	/*
>> +	 * The payload is written after the 4-byte command header:
>> +	 * reject one that would spill past the end of the report.
>> +	 */
>> +	if (payload_size > ROG_ALLY_REPORT_SIZE - 4)
> Name 4 with define or make a struct so you can use sizeof().
>
>> +		return NULL;
>> +
>> +	hidbuf = kzalloc(ROG_ALLY_REPORT_SIZE, GFP_KERNEL);
>> +
>> +	if (!hidbuf)
>> +		return NULL;
>> +
>> +	hidbuf[0] = HID_ALLY_SET_REPORT_ID;
>> +	hidbuf[1] = HID_ALLY_FEATURE_CODE_PAGE;
>> +	hidbuf[2] = cmd;
>> +	hidbuf[3] = payload_size;
>> +
>> +	if (payload_size > 0 && payload)
>> +		memcpy(&hidbuf[4], payload, payload_size);
>> +
>> +	return hidbuf;
>> +}
>> +
>> +/**
>> + * ally_gamepad_check_ready() - Wait for the gamepad MCU to report ready
>> + * @ally: ally handheld structure
>> + * @hdev: HID device
>> + *
>> + * This should be called before any remapping attempts, and on driver
>> + * init/resume, after the asus handshake has been performed on the
>> + * configuration endpoint.
>> + *
>> + * Return: 0 on success, negative errno on failure
>> + */
>> +static int ally_gamepad_check_ready(struct ally_handheld *ally, struct hid_device *hdev)
>> +{
>> +	u8 payload[] = { 0x00 };
> = {} is enough to initialize.
>
>> +	int ret;
>> +
>> +	for (int i = 0; i < HID_ALLY_READY_MAX_TRIES; i++) {
>> +		u8 *buf __free(kfree) = ally_alloc_cmd(CMD_CHECK_READY, payload, sizeof(payload));
>> +		if (!buf)
>> +			return -ENOMEM;
>> +
>> +		ret = ally_gamepad_send_receive_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);
> ally_gamepad_send_packet()'s buf is const so why you need to alloc it over 
> and over again?
>
> Arguably, I'm not sure if this retry loop is expected to execute many 
> times.

no the used buffer is u8 *buf (non const) and it gets overwritten by the method
with the MCU response.

Since I am not sure if while not ready it can write other bytes I have opted to
free it and reallocate it with correct data sice it is what gets sent and also
what is returned.

Also yes, that cycle has to run many times to await for the MCU to come back:
it has caused quite a few troubles in the past.

>> +		if (ret < 0) {
>> +			hid_dbg(hdev, "ROG Ally check %d/%d failed: %d\n", i,
>> +				HID_ALLY_READY_MAX_TRIES, ret);
>> +			continue;
>> +		}
>> +
>> +		if (buf[2] == CMD_CHECK_READY)
>> +			return 0;
>> +
>> +		usleep_range(1000, 2000);
>> +	}
>> +
>> +	hid_err(hdev, "ROG Ally never responded with a ready\n");
>> +	return -ENODEV;
>> +}
>> +
>> +static int ally_get_endpoint_address(struct hid_device *hdev)
>> +{
>> +	struct usb_host_endpoint *ep;
>> +	struct usb_interface *intf;
>> +
>> +	if (!hid_is_usb(hdev))
>> +		return -ENODEV;
>> +
>> +	intf = to_usb_interface(hdev->dev.parent);
>> +	if (!intf || !intf->cur_altsetting)
>> +		return -ENODEV;
>> +
>> +	if (intf->cur_altsetting->desc.bNumEndpoints == 0)
>> +		return -ENODEV;
>> +
>> +	ep = intf->cur_altsetting->endpoint;
>> +	if (!ep)
>> +		return -ENODEV;
>> +
>> +	return ep->desc.bEndpointAddress;
>> +}
>> +
>> +struct ally_x_input_report {
>> +	__le16 x, y;
>> +	__le16 rx, ry;
>> +	__le16 z, rz;
>> +	u8 buttons[3];
>> +} __packed;
>> +
>> +/* The hatswitch outputs integers, we use them to index this X|Y pair */
>> +static const int hat_values[][2] = {
>> +	{ 0, 0 }, { 0, -1 }, { 1, -1 }, { 1, 0 },   { 1, 1 },
>> +	{ 0, 1 }, { -1, 1 }, { -1, 0 }, { -1, -1 },
>> +};
>> +
>> +/**
>> + * ally_x_raw_event() - Parse and report an Ally X gamepad input report
>> + * @input: input device to report the events on
>> + * @data: raw report buffer
>> + * @size: length of @data in bytes
>> + *
>> + * Return: true if the event was handled, otherwise false
>> + */
>> +static bool ally_x_raw_event(struct input_dev *input, u8 *data, int size)
>> +{
>> +	struct ally_x_input_report *in_report;
>> +	u16 x, y, rx, ry, z, rz;
>> +	u8 byte;
>> +
>> +	if (!input)
>> +		return false;
>> +
>> +	if (size < 1)
>> +		return false;
>> +
>> +	/*
>> +	 * The size check above only guarantees one valid byte: do not
>> +	 * read the code of a truncated report.
>> +	 */
>> +	if (data[0] == 0x5A) {
>> +		if (size < 2)
>> +			return false;
>> +
>> +		input_report_key(input, KEY_PROG1, data[1] == 0x38);
>> +		input_report_key(input, KEY_F16, data[1] == 0xA6);
>> +		input_report_key(input, KEY_F17, data[1] == 0xA7);
>> +		input_report_key(input, KEY_F18, data[1] == 0xA8);
>> +		input_sync(input);
>> +
>> +		return data[1] == 0xA6 || data[1] == 0xA7 || data[1] == 0xA8 || data[1] == 0x38;
>> +	}
>> +
>> +	if (data[0] != HID_ALLY_X_INPUT_REPORT)
>> +		return false;
>> +
>> +	/*
>> +	 * hid-core only guarantees size >= 1 and does not zero-pad short
>> +	 * reports before ->raw_event, so a truncated transfer would leave the
>> +	 * payload below pointing at stale DMA buffer contents.
>> +	 */
>> +	if (size < 1 + sizeof(*in_report))
>> +		return false;
>> +
>> +	in_report = (struct ally_x_input_report *)&data[1];
>> +
>> +	/* USB HID payloads are little-endian: convert them explicitly. */
>> +	x = get_unaligned_le16(&in_report->x);
>> +	y = get_unaligned_le16(&in_report->y);
>> +	rx = get_unaligned_le16(&in_report->rx);
>> +	ry = get_unaligned_le16(&in_report->ry);
>> +	z = get_unaligned_le16(&in_report->z);
>> +	rz = get_unaligned_le16(&in_report->rz);
>> +
>> +	input_report_abs(input, ABS_X, x - 32768);
>> +	input_report_abs(input, ABS_Y, y - 32768);
>> +	input_report_abs(input, ABS_RX, rx - 32768);
>> +	input_report_abs(input, ABS_RY, ry - 32768);
>> +	input_report_abs(input, ABS_Z, z);
>> +	input_report_abs(input, ABS_RZ, rz);
>> +
>> +	byte = in_report->buttons[0];
>> +	input_report_key(input, BTN_A, byte & BIT(0));
>> +	input_report_key(input, BTN_B, byte & BIT(1));
>> +	input_report_key(input, BTN_X, byte & BIT(2));
>> +	input_report_key(input, BTN_Y, byte & BIT(3));
>> +	input_report_key(input, BTN_TL, byte & BIT(4));
>> +	input_report_key(input, BTN_TR, byte & BIT(5));
>> +	input_report_key(input, BTN_SELECT, byte & BIT(6));
>> +	input_report_key(input, BTN_START, byte & BIT(7));
>> +
>> +	byte = in_report->buttons[1];
>> +	input_report_key(input, BTN_THUMBL, byte & BIT(0));
>> +	input_report_key(input, BTN_THUMBR, byte & BIT(1));
>> +	input_report_key(input, BTN_MODE, byte & BIT(2));
>> +
>> +	/* The hatswitch byte is device-controlled; treat anything the table
>> +	 * does not cover as centred rather than indexing out of bounds.
>> +	 */
>> +	byte = in_report->buttons[2];
>> +	if (byte >= ARRAY_SIZE(hat_values))
> Add include.
>
>> +		byte = 0;
>> +	input_report_abs(input, ABS_HAT0X, hat_values[byte][0]);
>> +	input_report_abs(input, ABS_HAT0Y, hat_values[byte][1]);
>> +
>> +	input_sync(input);
>> +
>> +	return true;
>> +}
>> +
>> +static int ally_x_input_open(struct input_dev *dev)
>> +{
>> +	struct hid_device *hdev = input_get_drvdata(dev);
>> +
>> +	return hid_hw_open(hdev);
>> +}
>> +
>> +static void ally_x_input_close(struct input_dev *dev)
>> +{
>> +	hid_hw_close(input_get_drvdata(dev));
>> +}
>> +
>> +static struct input_dev *ally_x_alloc_input_dev(struct hid_device *hdev)
>> +{
>> +	struct input_dev *input_dev = input_allocate_device();
>> +
>> +	if (!input_dev)
>> +		return ERR_PTR(-ENOMEM);
> Add include.
>
>> +
>> +	input_dev->dev.parent = &hdev->dev;
>> +	input_dev->id.bustype = hdev->bus;
>> +	input_dev->id.vendor = hdev->vendor;
>> +	input_dev->id.product = hdev->product;
>> +	input_dev->id.version = hdev->version;
>> +	input_dev->uniq = hdev->uniq;
>> +	input_dev->name = "ASUS ROG Ally X Gamepad";
>> +
>> +	input_set_drvdata(input_dev, hdev);
>> +	/*
>> +	 * Let the input core hold the hardware open while the device node
>> +	 * is in use: without these the interface could be runtime-suspended
>> +	 * and drop events.
>> +	 */
>> +	input_dev->open = ally_x_input_open;
>> +	input_dev->close = ally_x_input_close;
>> +
>> +	return input_dev;
>> +}
>> +
>> +static int ally_x_setup_input(struct hid_device *hdev, struct ally_handheld *ally)
>> +{
>> +	struct input_dev *input = ally_x_alloc_input_dev(hdev);
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	if (IS_ERR(input))
>> +		return PTR_ERR(input);
>> +
>> +	input_set_abs_params(input, ABS_X, -32768, 32767, 0, 0);
>> +	input_set_abs_params(input, ABS_Y, -32768, 32767, 0, 0);
>> +	input_set_abs_params(input, ABS_RX, -32768, 32767, 0, 0);
>> +	input_set_abs_params(input, ABS_RY, -32768, 32767, 0, 0);
>> +	input_set_abs_params(input, ABS_Z, 0, 1023, 0, 0);
>> +	input_set_abs_params(input, ABS_RZ, 0, 1023, 0, 0);
>> +	input_set_abs_params(input, ABS_HAT0X, -1, 1, 0, 0);
>> +	input_set_abs_params(input, ABS_HAT0Y, -1, 1, 0, 0);
>> +	input_set_capability(input, EV_KEY, BTN_A);
>> +	input_set_capability(input, EV_KEY, BTN_B);
>> +	input_set_capability(input, EV_KEY, BTN_X);
>> +	input_set_capability(input, EV_KEY, BTN_Y);
>> +	input_set_capability(input, EV_KEY, BTN_TL);
>> +	input_set_capability(input, EV_KEY, BTN_TR);
>> +	input_set_capability(input, EV_KEY, BTN_SELECT);
>> +	input_set_capability(input, EV_KEY, BTN_START);
>> +	input_set_capability(input, EV_KEY, BTN_MODE);
>> +	input_set_capability(input, EV_KEY, BTN_THUMBL);
>> +	input_set_capability(input, EV_KEY, BTN_THUMBR);
>> +
>> +	input_set_capability(input, EV_KEY, KEY_PROG1);
>> +	input_set_capability(input, EV_KEY, KEY_F16);
>> +	input_set_capability(input, EV_KEY, KEY_F17);
>> +	input_set_capability(input, EV_KEY, KEY_F18);
>> +	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY);
>> +	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY1);
>> +
>> +	ret = input_register_device(input);
>> +	if (ret) {
>> +		hid_err(hdev, "Failed to register Ally X gamepad device: %d\n", ret);
>> +		goto ally_x_setup_input_err;
>> +	}
>> +
>> +	/* Publish the input_dev only when it is fully set up. */
>> +	spin_lock_irqsave(&ally_data_lock, flags);
>> +	ally->ally_x_input = input;
>> +	spin_unlock_irqrestore(&ally_data_lock, flags);
>> +
>> +	return 0;
>> +ally_x_setup_input_err:
>> +	input_free_device(input);
>> +	return ret;
>> +}
>> +
>> +static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handheld *ally)
>> +{
>> +	int ret;
>> +
>> +	/* Failure at this point is non-critical */
>> +	ret = ally_gamepad_send_packet(ally, hdev, ALLY_FORCE_FEEDBACK_OFF,
>> +				       sizeof(ALLY_FORCE_FEEDBACK_OFF));
> Don't name a real array with caps.
>
>> +	if (ret < 0)
>> +		hid_err(hdev, "Ally failed to init force-feedback off: %d\n", ret);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * hid_asus_ally_raw_event() - Route raw reports from the Ally interfaces
>> + * @hdev: HID device
>> + * @ally: ally handheld structure
>> + * @report: HID report the raw data arrived in
>> + * @data: raw report buffer
>> + * @size: length of @data in bytes
>> + *
>> + * Called from the raw_event callback, which may run in atomic (URB
>> + * completion) context: only spinlock-protected accesses to the shared
>> + * state are allowed here.
>> + *
>> + * Return: true if the event was handled, otherwise false
> .
>
>> + */
>> +static bool hid_asus_ally_raw_event(struct hid_device *hdev, struct ally_handheld *ally,
>> +				    struct hid_report *report, u8 *data, int size)
>> +{
>> +	struct input_dev *x_input;
>> +	unsigned long flags;
>> +	bool handled;
>> +
>> +	if (!ally)
>> +		return false;
>> +
>> +	switch (ally_get_endpoint_address(hdev)) {
>> +	case HID_ALLY_X_INTF_IN:
>> +		/*
>> +		 * Take a reference on the input_dev while using it: the
>> +		 * gamepad interface can be unbound concurrently, and its
>> +		 * input_dev is freed with it.
>> +		 */
>> +		spin_lock_irqsave(&ally_data_lock, flags);
>> +		x_input = input_get_device(ally->ally_x_input);
>> +		spin_unlock_irqrestore(&ally_data_lock, flags);
>> +
>> +		handled = ally_x_raw_event(x_input, data, size);
> Since ypu've dropped the lock, couldn't things change right away after the 
> unlock?
>
> Perhaps there's something else that prevents problems but I generally feel 
> unconvinced by how ally_data_lock is used. Given what I see, 
> ally_data_lock feels either unnecessarily (or is an overkill for where a 
> barrier would be enough to synchronize with the init) or doesn't protect 
> everything properly (if uninit can race with this code).
>
>> +		input_put_device(x_input);
>> +		if (handled)
>> +			return true;
>> +		break;
>> +	case HID_ALLY_INTF_CFG_IN:
>> +		if (handle_ally_event(hdev, ally, data, size))
>> +			return true;
>> +		break;
>> +	case HID_ALLY_INTF_KEYBOARD_IN:
>> +		if (handle_ctrl_alt_del(ally, data, size))
>> +			return false;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +/**
>> + * hid_asus_ally_probe() - Initialize the ROG Ally HID extension
>> + * @hdev: HID device
>> + *
>> + * This module works alongside the main Asus HID driver to handle
>> + * Ally-specific features and quirks.
>> + *
>> + * Return: an ally_handheld struct pointer on success, an ERR_PTR on
>> + * failure. The caller is not expected to use the returned pointer, but it
>> + * should check for errors by using IS_ERR and PTR_ERR and pass NULL to
>> + * other functions if there was an error.
>> + */
>> +static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
>> +{
>> +	unsigned long flags;
>> +	int ret, ep = ally_get_endpoint_address(hdev);
>> +	struct usb_device *udev;
>> +	struct hid_input *hidinput;
>> +
>> +	if (ep < 0)
>> +		return ERR_PTR(ep);
>> +
>> +	/*
>> +	 * The ROG Ally controller is integrated into a handheld PC, so at
>> +	 * most one device can exist and the shared global state relies on
>> +	 * that: reject a probe from a different USB device, or a spoofed
>> +	 * peripheral could overwrite the state of the real controller. The
>> +	 * recorded device is dropped when the last interface of the
>> +	 * controller is unbound, so the re-enumeration the embedded
>> +	 * controller performs after a suspend cycle (it cuts the controller
>> +	 * power when powersave is enabled) is still accepted.
>> +	 */
>> +	udev = interface_to_usbdev(to_usb_interface(hdev->dev.parent));
>> +
>> +	spin_lock_irqsave(&ally_data_lock, flags);
>> +	if (ally_drvdata.udev && ally_drvdata.udev != udev) {
>> +		spin_unlock_irqrestore(&ally_data_lock, flags);
> scoped_guard() would avoid having to duplicate unlock but I'm not sure if 
> hid_err() is happy being called with a spinlock held...
>
>> +		hid_err(hdev, "A ROG Ally controller is already connected\n");
>> +		return ERR_PTR(-ENODEV);
> Shouldn't this be -EBUSY instead (the error message hints to that)?
>
>> +	}
>> +
>> +	/*
>> +	 * Interfaces of an already connected controller are equally
>> +	 * untrusted: a crafted descriptor could present the same
>> +	 * endpoint twice, and a second probe of one role would evict
>> +	 * the state recorded by the first one, whose input_dev would
>> +	 * then never be unregistered. The probe reservations make the
>> +	 * check hold across the sleeping initialization below, which
>> +	 * runs before the role pointer is published.
>> +	 */
>> +	if ((ep == HID_ALLY_INTF_CFG_IN &&
>> +	     (ally_drvdata.cfg_hdev || ally_drvdata.cfg_probe_in_progress)) ||
>> +	    (ep == HID_ALLY_X_INTF_IN &&
>> +	     (ally_drvdata.ally_x_hdev || ally_drvdata.ally_x_probe_in_progress)) ||
>> +	    (ep == HID_ALLY_INTF_KEYBOARD_IN &&
>> +	     (ally_drvdata.keyboard_hdev || ally_drvdata.keyboard_probe_in_progress))) {
>> +		spin_unlock_irqrestore(&ally_data_lock, flags);
>> +		hid_err(hdev,
>> +			"An interface of a ROG Ally controller is already connected\n");
>> +		return ERR_PTR(-ENODEV);
> Same here?
>
>> +	}
>> +
>> +	/* Reserve the role for as long as the initialization below runs. */
>> +	if (ep == HID_ALLY_INTF_CFG_IN)
>> +		ally_drvdata.cfg_probe_in_progress = true;
>> +	else if (ep == HID_ALLY_X_INTF_IN)
>> +		ally_drvdata.ally_x_probe_in_progress = true;
>> +	else if (ep == HID_ALLY_INTF_KEYBOARD_IN)
>> +		ally_drvdata.keyboard_probe_in_progress = true;
>> +
>> +	if (!ally_drvdata.udev) {
>> +		usb_get_dev(udev);
>> +		ally_drvdata.udev = udev;
>> +	}
>> +	spin_unlock_irqrestore(&ally_data_lock, flags);
>> +
>> +	/*
>> +	 * The interface initialization sleeps (it performs USB transfers),
>> +	 * so it must not run under ally_data_lock: the role stays reserved
>> +	 * while it runs, and the pointers are published only once it
>> +	 * succeeded.
>> +	 */
>> +	switch (ep) {
>> +	case HID_ALLY_INTF_CFG_IN:
>> +		/*
>> +		 * This function assumes the asus-specific initialization
>> +		 * to have been performed already at this point.
>> +		 */
>> +		ret = ally_gamepad_check_ready(&ally_drvdata, hdev);
>> +		if (ret < 0) {
>> +			hid_err(hdev, "ROG Ally device is not ready: %d\n", ret);
>> +			ally_probe_release_role(ep);
>> +			ally_put_udev_if_orphaned();
> How about sharing the rollback path, there seems to be multiple of 
> these.
>
>> +			return ERR_PTR(ret);
>> +		}
>> +
>> +		ret = hid_asus_ally_init(hdev, &ally_drvdata);
>> +		if (ret < 0) {
>> +			ally_probe_release_role(ep);
>> +			ally_put_udev_if_orphaned();
>> +			return ERR_PTR(ret);
>> +		}
>> +
>> +		spin_lock_irqsave(&ally_data_lock, flags);
>> +		ally_drvdata.cfg_hdev = hdev;
>> +		ally_drvdata.cfg_probe_in_progress = false;
>> +		spin_unlock_irqrestore(&ally_data_lock, flags);
>> +		break;
>> +	case HID_ALLY_X_INTF_IN:
>> +		/* This will create and populate ally_x_input */
>> +		ret = ally_x_setup_input(hdev, &ally_drvdata);
>> +		if (ret) {
>> +			hid_err(hdev, "Failed to create Ally X gamepad device.\n");
>> +			ally_probe_release_role(ep);
>> +			ally_put_udev_if_orphaned();
>> +			return ERR_PTR(ret);
>> +		}
>> +
>> +		spin_lock_irqsave(&ally_data_lock, flags);
>> +		ally_drvdata.ally_x_hdev = hdev;
>> +		ally_drvdata.ally_x_probe_in_progress = false;
>> +		spin_unlock_irqrestore(&ally_data_lock, flags);
>> +		break;
>> +	case HID_ALLY_INTF_KEYBOARD_IN:
>> +		spin_lock_irqsave(&ally_data_lock, flags);
>> +		ally_drvdata.keyboard_hdev = hdev;
>> +		ally_drvdata.keyboard_probe_in_progress = false;
>> +		if (!list_empty(&hdev->inputs)) {
>> +			hidinput = list_first_entry(&hdev->inputs, struct hid_input, list);
>> +			ally_drvdata.keyboard_input = hidinput->input;
>> +		}
>> +		spin_unlock_irqrestore(&ally_data_lock, flags);
>> +		break;
>> +	default:
>> +		/* This is normally supposed to happen */
>> +		break;
>> +	}
>> +
>> +	return &ally_drvdata;
>> +}
>> +
>> +static void hid_asus_ally_remove(struct hid_device *hdev, struct ally_handheld *ally)
>> +{
>> +	struct input_dev *x_input = NULL;
>> +	unsigned long flags;
>> +
>> +	if (!ally)
>> +		return;
>> +
>> +	/*
>> +	 * Any of the three interfaces can own an input_dev the resume work
>> +	 * reports through, and they are torn down in an arbitrary order, so
>> +	 * drain it before clearing anything. Cancel outside ally_data_lock so
>> +	 * a handler that wants the lock cannot deadlock against us.
>> +	 */
>> +	cancel_delayed_work_sync(&ally->resume_work);
>> +
>> +	spin_lock_irqsave(&ally_data_lock, flags);
>> +	if (ally->ally_x_hdev == hdev) {
>> +		x_input = ally->ally_x_input;
>> +		ally->ally_x_input = NULL;
>> +		ally->ally_x_hdev = NULL;
>> +	}
>> +
>> +	/*
>> +	 * The keyboard interface is torn down before the config one, and
>> +	 * its input_dev is freed with it. handle_ally_event() and
>> +	 * ally_resume_work_fn() both report keys through it from the
>> +	 * config endpoint, so drop the references here or they dangle.
>> +	 */
>> +	if (ally->keyboard_hdev == hdev) {
>> +		ally->keyboard_input = NULL;
>> +		ally->keyboard_hdev = NULL;
>> +	}
>> +	spin_unlock_irqrestore(&ally_data_lock, flags);
>> +
>> +	if (x_input)
>> +		input_unregister_device(x_input);
>> +
>> +	/*
>> +	 * Drop the recorded USB device when the last interface of the
>> +	 * controller has been unbound: the driver is then ready to accept
>> +	 * the controller again when it reconnects.
>> +	 */
>> +	ally_put_udev_if_orphaned();
>> +}
>> +
>> +static int hid_asus_ally_reset_resume(struct hid_device *hdev, struct ally_handheld *ally)
>> +{
>> +	int ep, ret;
>> +
>> +	/*
>> +	 * The extensions failed to probe and the device is operating as a
>> +	 * generic HID device: do not fail the resume because of that.
>> +	 */
>> +	if (!ally)
>> +		return 0;
>> +
>> +	ep = ally_get_endpoint_address(hdev);
>> +	if (ep != HID_ALLY_INTF_CFG_IN)
>> +		return 0;
>> +
>> +	ret = hid_asus_ally_init(hdev, ally);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return 0;
> Why can't you just return directly what hid_asus_ally_init() returned?
>
>> +}
>> +
>>  /*
>>   * Send events to asus-wmi driver for handling special keys
>>   */
>> @@ -513,6 +1464,17 @@ static int asus_raw_event(struct hid_device *hdev,
>>  	if (drvdata->quirks & QUIRK_MEDION_E1239T)
>>  		return asus_e1239t_event(drvdata, data, size);
>>  
>> +	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
>> +		/*
>> +		 * Return -1 to suppress further processing by the generic HID
>> +		 * input parser for reports we fully handle for the Gamepad (0x0B):
>> +		 * letting 0x0B reach the default parser creates a generic gamepad
>> +		 * causing Steam Input overlaps (i.e. L1 stuck on screenshot).
>> +		 */
>> +		if (hid_asus_ally_raw_event(hdev, drvdata->rog_ally, report, data, size))
>> +			return -1;
>> +	}
>> +
>>  	/*
>>  	 * Skip these report ID, the device emits a continuous stream associated
>>  	 * with the AURA mode it is in which looks like an 'echo'.
>> @@ -1306,6 +2268,7 @@ static int asus_input_mapping(struct hid_device *hdev,
>>  		case 0x5f: asus_map_key_clear(KEY_PROG2);	break; /* S-shaped programmable key */
>>  		case 0x6b: asus_map_key_clear(KEY_F21);		break; /* ASUS touchpad toggle */
>>  		case 0x38: asus_map_key_clear(KEY_PROG1);	break; /* ROG key */
>> +		case 0x93: asus_map_key_clear(KEY_PROG1);	break; /* ROG Ally X AC button */
>>  		case 0xba: asus_map_key_clear(KEY_PROG2);	break; /* Fn+C ASUS Splendid */
>>  		case 0x5c: asus_map_key_clear(KEY_PROG3);	break; /* Fn+Space Power4Gear */
>>  		case 0x99: asus_map_key_clear(KEY_PROG4);	break; /* Fn+F5 "fan" symbol */
>> @@ -1480,6 +2443,8 @@ static int asus_xgm_init(struct hid_device *hdev, struct asus_drvdata *drvdata)
>>  static int __maybe_unused asus_resume(struct hid_device *hdev)
>>  {
>>  	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
>> +	struct ally_handheld *ally = drvdata->rog_ally;
>> +	int ep;
>>  
>>  	/*
>>  	 * If we have a backlight listener registered, restore the previous state,
>> @@ -1489,12 +2454,19 @@ static int __maybe_unused asus_resume(struct hid_device *hdev)
>>  	if (drvdata->listener.brightness_set)
>>  		asus_kbd_backlight_set(&drvdata->listener, drvdata->kbd_backlight_brightness);
>>  
>> +	if (ally && (drvdata->quirks & QUIRK_ROG_ALLY_XPAD)) {
>> +		ep = ally_get_endpoint_address(hdev);
>> +		if (ep == HID_ALLY_INTF_CFG_IN)
>> +			schedule_delayed_work(&ally->resume_work, msecs_to_jiffies(500));
>> +	}
>> +
>>  	return 0;
>>  }
>>  
>>  static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
>>  {
>>  	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
>> +	int ret;
>>  
>>  	if (!drvdata->tp)
>>  		asus_initialize_reports(hdev);
>> @@ -1502,6 +2474,14 @@ static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
>>  	if (drvdata->tp)
>>  		return asus_start_multitouch(hdev);
>>  
>> +	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
>> +		ret = hid_asus_ally_reset_resume(hdev, drvdata->rog_ally);
>> +		if (ret) {
>> +			hid_err(hdev, "Failed to resume ROG Ally HID extensions: %d\n", ret);
>> +			return ret;
>> +		}
>> +	}
>> +
>>  	return 0;
>>  }
>>  
>> @@ -1509,6 +2489,7 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>  {
>>  	struct hid_report_enum *rep_enum;
>>  	struct asus_drvdata *drvdata;
>> +	struct ally_handheld *ally;
>>  	struct hid_report *rep;
>>  	bool is_vendor = false;
>>  	int ret;
>> @@ -1632,6 +2613,15 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>  		(asus_kbd_register_leds(hdev)))
>>  		hid_warn(hdev, "Failed to initialize backlight.\n");
>>  
>> +	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
>> +		ally = hid_asus_ally_probe(hdev);
>> +		if (IS_ERR(ally))
>> +			hid_err(hdev, "Failed to initialize ROG Ally HID extensions: %ld\n",
>> +				PTR_ERR(ally));
>> +		else
>> +			drvdata->rog_ally = ally;
>> +	}
>> +
>>  	/*
>>  	 * For ROG keyboards, skip rename for consistency and ->input check as
>>  	 * some devices do not have inputs.
>> @@ -1666,6 +2656,9 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>  	if (drvdata->xgm_led)
>>  		devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
>>  
>> +	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD)
>> +		hid_asus_ally_remove(hdev, drvdata->rog_ally);
>> +
>>  	asus_worker_stop(drvdata->worker);
>>  	hid_hw_stop(hdev);
>>  	return ret;
>> @@ -1681,6 +2674,9 @@ static void asus_remove(struct hid_device *hdev)
>>  	if (drvdata->xgm_led)
>>  		devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
>>  
>> +	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD)
>> +		hid_asus_ally_remove(hdev, drvdata->rog_ally);
>> +
>>  	asus_worker_stop(drvdata->worker);
>>  	hid_hw_stop(hdev);
>>  }
>>
