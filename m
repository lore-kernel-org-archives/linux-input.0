From: "Junge, Terry" <Terry.Junge@plantronics.com>
Subject: RE: [PATCH] HID: Support telephony devices
Date: Thu, 15 Sep 2016 00:01:04 +0000
Message-ID: <51856e008f3345f285f948767e7ee3db@usscmb04.plt.plantronics.com>
References: <1470214307-29441-1-git-send-email-nolsen@jabra.com>
 <04496bf1ddd749d780ad24bb8d85f40d@usscmb04.plt.plantronics.com>
 <VI1PR0701MB2990B9157845AE6C5BDB7440DA150@VI1PR0701MB2990.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail4.plantronics.com ([198.231.10.50]:53283 "EHLO
        mail4.plantronics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757554AbcIOABT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2016 20:01:19 -0400
In-Reply-To: <VI1PR0701MB2990B9157845AE6C5BDB7440DA150@VI1PR0701MB2990.eurprd07.prod.outlook.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Niels Skou Olsen <nolsen@jabra.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: "jikos@kernel.org" <jikos@kernel.org>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>

Niels,

Sorry, just got back from holiday and am working my way through email.

Is there a V2 for this? Maybe I missed it?

If the maintainers have no issue with the duplicate functionalities then I have no further issues and am anxious to see V2 get applied.

Regards,
Terry

>-----Original Message-----
>From: Niels Skou Olsen [mailto:nolsen@jabra.com]
>Sent: Thursday, August 18, 2016 2:00 AM
>To: Junge, Terry; linux-input@vger.kernel.org
>Cc: jikos@kernel.org; benjamin.tissoires@redhat.com; dmitry.torokhov@gmail.com
>Subject: RE: [PATCH] HID: Support telephony devices
>
>First of all thank you for review and good feedback!
>
>>Good to get telephony support into the kernel.
>>
>>My only concerns are the duplicate functionalities of LED_RING::LED_RINGER and LED_MUTE::LED_MICROPHONE.
>
>By adding RINGER and MICROPHONE we are trying to achieve finer grained
>telephony control from user space. We understand your concern about the
>user having to handle additional values that may be hard to distinguish.
>
>RINGER is a functionality that has a different meaning than RING in the HUT
>spec. So, if a user space application really wants RINGER (or needs both)
>then it should have the option. It is more flexible to make the choice
>available in user space, than it is to require vendor specific drivers. Also,
>having only RING would preclude applications from using both RING and
>RINGER against devices that support both.
>
>As you point out, RINGER is not an LED usage, so changing the name will
>help decrease confusion. But the telephony related usages do not fit well
>with the current event types EV_KEY, EV_LED etc. The problem is that we are
>trying to extend the existing event types. Maybe we need a new EV_TEL event
>type, and a new TEL_ prefix for telephony related values: TEL_RINGER,
>TEL_REDIAL etc.?
>
>>
>>Please see below.
>>
>
>Further comments interleaved below.
>
>>>-----Original Message-----
>>>From: linux-input-owner@vger.kernel.org
>>>[mailto:linux-input-owner@vger.kernel.org] On Behalf Of
>>>nolsen@jabra.com
>>>Sent: Wednesday, August 03, 2016 1:52 AM
>>>To: linux-input@vger.kernel.org
>>>Cc: jikos@kernel.org; benjamin.tissoires@redhat.com;
>>>dmitry.torokhov@gmail.com; Niels Skou Olsen
>>>Subject: [PATCH] HID: Support telephony devices
>>>
>>>From: Niels Skou Olsen <nolsen@jabra.com>
>>>
>>>Add support for telephony device buttons and LEDs as described in the
>>>USB HID Usage Tables specification.
>>>
>>>This allows user mode applications convenient access to telephony
>>>devices such as headsets, speaker phones and desk phones.
>>>
>>>Signed-off-by: Niels Skou Olsen <nolsen@jabra.com>
>>>---
>>> drivers/hid/hid-debug.c                | 39 ++++++++++++++++++++-
>>> drivers/hid/hid-input.c                | 63 +++++++++++++++++++++++++++++++---
>>> drivers/input/input-leds.c             |  5 +++
>>> include/linux/hid.h                    |  8 ++++-
>>> include/linux/mod_devicetable.h        |  2 +-
>>> include/uapi/linux/input-event-codes.h | 18 +++++++++-
>>> 6 files changed, 126 insertions(+), 9 deletions(-)
>>>
>>>diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c index
>>>acfb522..9f109c3 100644
>>>--- a/drivers/hid/hid-debug.c
>>>+++ b/drivers/hid/hid-debug.c
>>>@@ -129,9 +129,42 @@ static const struct hid_usage_entry hid_usage_table[] = {
>>>       {0, 0x03, "ScrollLock"},
>>>       {0, 0x04, "Compose"},
>>>       {0, 0x05, "Kana"},
>>>+{0, 0x09, "Mute"},
>>>+{0, 0x17, "OffHook"},
>>>+{0, 0x18, "Ring"},
>>>+{0, 0x19, "MessageWaiting"},
>>>+{0, 0x20, "Hold"},
>>>+{0, 0x21, "Microphone"},
>>>+{0, 0x27, "Standby"},
> >>+{0, 0x2a, "Online"},
>>>+{0, 0x4c, "SystemSuspend"},
>>>+{0, 0x4d, "ExtPowerConnected"},
>>>       {0, 0x4b, "GenericIndicator"},
>>>   {  9, 0, "Button" },
>>>   { 10, 0, "Ordinal" },
>>>+{ 11, 0, "Telephony" },
>>>+{0, 0x20, "KeyHookSwitch"},
>>>+{0, 0x21, "KeyFlash"},
>>>+{0, 0x23, "KeyHold"},
>>>+{0, 0x24, "KeyRedial"},
>>>+{0, 0x2f, "KeyMicMute"},
>>>+{0, 0x9e, "LedRinger"},
>>
>>This is not an LED usage, it's a Locally Generated Tone usage, maybe "RingerTone"?
>
>Yes, you are right. A V2 patch is forthcoming, once we agree how to proceed.
>
>>>+{0, 0xb0, "KeyNumeric0"},
>>>+{0, 0xb1, "KeyNumeric1"},
>>>+{0, 0xb2, "KeyNumeric2"},
>>>+{0, 0xb3, "KeyNumeric3"},
>>>+{0, 0xb4, "KeyNumeric4"},
>>>+{0, 0xb5, "KeyNumeric5"},
>>>+{0, 0xb6, "KeyNumeric6"},
>>>+{0, 0xb7, "KeyNumeric7"},
>>>+{0, 0xb8, "KeyNumeric8"},
>>>+{0, 0xb9, "KeyNumeric9"},
>>>+{0, 0xba, "KeyNumericStar"},
>>>+{0, 0xbb, "KeyNumericPound"},
>>>+{0, 0xbc, "KeyNumericA"},
>>>+{0, 0xbd, "KeyNumericB"},
>>>+{0, 0xbe, "KeyNumericC"},
>>>+{0, 0xbf, "KeyNumericD"},
>>>   { 12, 0, "Consumer" },
>>>       {0, 0x238, "HorizontalWheel"},
>>>   { 13, 0, "Digitizers" },
>>>@@ -998,7 +1031,11 @@ static const char *leds[LED_MAX + 1] = {
>>> [LED_SCROLLL] = "ScrollLock",[LED_COMPOSE] = "Compose",
>>> [LED_KANA] = "Kana",[LED_SLEEP] = "Sleep",
>>> [LED_SUSPEND] = "Suspend",[LED_MUTE] = "Mute",
>>>-[LED_MISC] = "Misc",
>>>+[LED_MISC] = "Misc",[LED_MAIL] = "Mail",
>>>+[LED_CHARGING] = "Charging",[LED_OFF_HOOK] = "Off-hook",
>>>+[LED_RING] = "Ring",[LED_RINGER] = "Ringer",
>>
>>LED_RINGER duplicates the functionality of LED_RING to the user.
>>Multiple vendor products in the field already respond to the proposed mapping of LED_RING by indicating inbound ring to the user.
>>Adding LED_RINGER to the core and mapping it to 0x000b009e will require the user to decide which one to use, LED_RING or
>LED_RINGER.
>>If needed, the 0x000b009e usage should be mapped by a vendor driver to LED_RING so the user will only have to deal with
>LED_RING.
>>
>
>See reply at the top.
>
>>>+[LED_HOLD] = "Hold",[LED_MICROPHONE] = "Microphone",
>>
>>LED_MICROPHONE duplicates the functionality of LED_MUTE to the user.
>>Multiple vendor products in the field already respond to the core mapping of LED_MUTE by muting the microphone.
>>Adding LED_MICROPHONE to the core and mapping it to 0x00080021 will require the user to decide which one to use, LED_MUTE
>or LED_MICROPHONE.
>>If needed, the 0x00080021 usage should be mapped by a vendor driver to LED_MUTE so the user will only have to deal with
>LED_MUTE.
>>
>
>See reply at the top.
>
>>>+[LED_ONLINE] = "Online"
>>> };
>>>
>>> static const char *repeats[REP_MAX + 1] = { diff --git
>>>a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c index
>>>bcfaf32..b2a4136 100644
>>>--- a/drivers/hid/hid-input.c
>>>+++ b/drivers/hid/hid-input.c
>>>@@ -509,9 +509,11 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>>> if (field->report_count < 1)
>>> goto ignore;
>>>
>>>-/* only LED usages are supported in output fields */
>>>+/* only LED and TELEPHONY usages are supported in output fields */
>>> if (field->report_type == HID_OUTPUT_REPORT &&
>>>-(usage->hid & HID_USAGE_PAGE) != HID_UP_LED) {
>>>+(usage->hid & HID_USAGE_PAGE) != HID_UP_LED &&
>>>+(usage->hid & HID_USAGE_PAGE) != HID_UP_TELEPHONY) {
>>>+
>>> goto ignore;
>>> }
>>
>>This allowance for telephony page output mapping in order to map LED_RINGER would not be needed if the 0x000b009e mapping
>were done by a vendor driver and the vendor driver was allowed access before the currently preemptive LED page test, like this:
>>
>>if (device->driver->input_mapping) {
>>int ret = device->driver->input_mapping(device, hidinput, field,
>>usage, &bit, &max);
>>if (ret > 0)
>>goto mapped;
>>if (ret < 0)
>>goto ignore;
>>}
>>
>>/* only LED usages are supported in output fields */
>>if (field->report_type == HID_OUTPUT_REPORT &&
>>(usage->hid & HID_USAGE_PAGE) != HID_UP_LED) {
>>goto ignore;
>>}
>>
>
>See reply at the top.
>
>>>
>>>@@ -658,11 +660,32 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>>> case 0x03:  map_led (LED_SCROLLL);  break;    /*   "Scroll Lock"              */
>>> case 0x04:  map_led (LED_COMPOSE);  break;    /*   "Compose"                  */
>>> case 0x05:  map_led (LED_KANA);     break;    /*   "Kana"                     */
>>>-case 0x27:  map_led (LED_SLEEP);    break;    /*   "Stand-By"                 */
>>>-case 0x4c:  map_led (LED_SUSPEND);  break;    /*   "System Suspend"           */
>>> case 0x09:  map_led (LED_MUTE);     break;    /*   "Mute"                     */
>>>-case 0x4b:  map_led (LED_MISC);     break;    /*   "Generic Indicator"        */
>>>+case 0x17: /* "Off hook" */
>>>+map_led(LED_OFF_HOOK);
>>>+break;
>>>+case 0x18: /* "Ring" */
>>>+map_led(LED_RING);
>>>+break;
>>> case 0x19:  map_led (LED_MAIL);     break;    /*   "Message Waiting"          */
>>>+case 0x20: /* "Hold" */
>>>+map_led(LED_HOLD);
>>>+break;
>>>+case 0x21: /* "Microphone" */
>>>+map_led(LED_MICROPHONE);
>>>+break;
>>
>>As previous comment on duplicate functionality of LED_MICROPHONE and LED_MUTE.
>>Usage 0x00080021 could be mapped to LED_MUTE in a vendor driver.
>
>See reply at the top.
>
>>
>>>+case 0x27: /* "Stand-By" */
>>>+map_led(LED_SLEEP);
>>>+break;
>>>+case 0x2a: /* "Online" */
>>>+map_led(LED_ONLINE);
>>>+break;
>>>+case 0x4b: /* "Generic Indicator" */
>>>+map_led(LED_MISC);
>>>+break;
>>>+case 0x4c: /* "System Suspend" */
>>>+map_led(LED_SUSPEND);
>>>+break;
>>> case 0x4d:  map_led (LED_CHARGING); break;    /*   "External Power Connected" */
>>>
>>> default: goto ignore;
>>>@@ -732,7 +755,37 @@ static void hidinput_configure_usage(struct
>>>hid_input *hidinput, struct hid_fiel
>>>
>>> case HID_UP_TELEPHONY:
>>> switch (usage->hid & HID_USAGE) {
>>>+case 0x07:
>>>+map_key_clear(KEY_PROGRAMMABLE);
>>>+break;
>>
>>----
>>>+case 0x1e:
>>>+map_led(LED_SPEAKER);
>>>+break;
>>----
>>
>>This is in the wrong place, it should be in the HID_UP_LED case switch statement block.
>>Speaker usage 0x1e is in the LED page not the telephony page.
>>
>
>Yes, you are right. A V2 patch is forthcoming, once we agree how to proceed.
>
>>>+case 0x20:
>>>+map_key_clear(KEY_HOOK_SWITCH);
>>>+break;
>>>+case 0x21:
>>>+map_key_clear(KEY_FLASH);
>>>+break;
>>>+case 0x23:
>>>+map_key_clear(KEY_HOLD);
>>>+break;
>>>+case 0x24:
>>>+map_key_clear(KEY_REDIAL);
>>>+break;
>>>+case 0x2a:
>>>+map_key_clear(KEY_LINE);
>>>+break;
>>>+case 0x2b:
>>>+map_key_clear(KEY_SPEAKER_PHONE);
>>>+break;
>>> case 0x2f: map_key_clear(KEY_MICMUTE);break;
>>>+case 0x50:
>>>+map_key_clear(KEY_SPEED_DIAL);
>>>+break;
>>>+case 0x9e:
>>>+map_led(LED_RINGER);
>>>+break;
>>
>>As previous comment on duplicate functionality of LED_RINGER and LED_RING.
>>Usage 0x000b009e could be mapped to LED_RING in a vendor driver.
>
>See reply at the top.
>
>>
>>> case 0xb0: map_key_clear(KEY_NUMERIC_0);break;
>>> case 0xb1: map_key_clear(KEY_NUMERIC_1);break;
>>> case 0xb2: map_key_clear(KEY_NUMERIC_2);break;
>>>diff --git a/drivers/input/input-leds.c b/drivers/input/input-leds.c
>>>index 766bf26..cf692df 100644
>>>--- a/drivers/input/input-leds.c
>>>+++ b/drivers/input/input-leds.c
>>>@@ -36,6 +36,11 @@ static const struct {
>>> [LED_MISC]= { "misc" },
>>> [LED_MAIL]= { "mail" },
>>> [LED_CHARGING]= { "charging" },
>>>+[LED_OFF_HOOK]= { "off-hook" },
>>>+[LED_RING]= { "ring" },
>>>+[LED_HOLD]= { "hold" },
>>>+[LED_MICROPHONE] = { "microphone" },
>>
>>As previous comments on duplicate functionality of LED_MICROPHONE and LED_MUTE.
>>Is LED_RINGER missing here?
>
>If we change LED_RINGER to something else (maybe TEL_RINGER), then it doesn't belong here.
>
>>
>>>+[LED_ONLINE]= { "online" },
>>> };
>>>
>>> struct input_led {
>>>diff --git a/include/linux/hid.h b/include/linux/hid.h index
>>>75b66ec..0c91c89 100644
>>>--- a/include/linux/hid.h
>>>+++ b/include/linux/hid.h
>>>@@ -764,7 +764,13 @@ struct hid_ll_driver {
>>>
>>> /* Applications from HID Usage Tables 4/8/99 Version 1.1 */
>>> /* We ignore a few input applications that are not widely used */
>>>-#define IS_INPUT_APPLICATION(a) (((a >= 0x00010000) && (a <=
>>>0x00010008)) || (a == 0x00010080) || (a == 0x000c0001) || ((a
>>>>= 0x000d0002) && (a <= 0x000d0006)))
>>>+#define IS_INPUT_APPLICATION(a) (\
>>>+((a >= 0x00010000) && (a <= 0x00010008)) ||\
>>>+(a == 0x00010080) ||\
>>>+(a == 0x000b0005) ||\
>>
>>This should be a range from 0x000b0001 through 0x000b0005 to include Phone (1), Answering Machine (2), Message Controls (3),
>Handset (4), as well as Headset (5) collections.
>
>Agreed. Coming in V2.
>
>>
>>>+(a == 0x000c0001) ||\
>>>+((a >= 0x000d0002) && (a <= 0x000d0006)))
>>>+
>>>
>>> /* HID core API */
>>>
>>>diff --git a/include/linux/mod_devicetable.h
>>>b/include/linux/mod_devicetable.h index ed84c07..e342d3f 100644
>>>--- a/include/linux/mod_devicetable.h
>>>+++ b/include/linux/mod_devicetable.h
>>>@@ -288,7 +288,7 @@ struct pcmcia_device_id {
>>> #define INPUT_DEVICE_ID_REL_MAX0x0f
>>> #define INPUT_DEVICE_ID_ABS_MAX0x3f
>>> #define INPUT_DEVICE_ID_MSC_MAX0x07
>>>-#define INPUT_DEVICE_ID_LED_MAX0x0f
>>>+#define INPUT_DEVICE_ID_LED_MAX0x11
>>> #define INPUT_DEVICE_ID_SND_MAX0x07
>>> #define INPUT_DEVICE_ID_FF_MAX0x7f
>>> #define INPUT_DEVICE_ID_SW_MAX0x0f
>>>diff --git a/include/uapi/linux/input-event-codes.h
>>>b/include/uapi/linux/input-event-codes.h
>>>index d6d071f..eaa368b 100644
>>>--- a/include/uapi/linux/input-event-codes.h
>>>+++ b/include/uapi/linux/input-event-codes.h
>>>@@ -593,6 +593,15 @@
>>>
>>> #define KEY_ALS_TOGGLE0x230/* Ambient light sensor */
>>>
>>>+#define KEY_HOOK_SWITCH0x231
>>>+#define KEY_FLASH0x232
>>>+#define KEY_HOLD0x233
>>>+#define KEY_REDIAL0x234
>>>+#define KEY_PROGRAMMABLE0x235
>>>+#define KEY_LINE0x236
>>>+#define KEY_SPEAKER_PHONE0x237
>>>+#define KEY_SPEED_DIAL0x238
>>>+
>>> #define KEY_BUTTONCONFIG0x240/* AL Button Configuration */
>>> #define KEY_TASKMANAGER0x241/* AL Task/Project Manager */
>>> #define KEY_JOURNAL0x242/* AL Log/Journal/Timecard */
>>>@@ -812,7 +821,14 @@
>>> #define LED_MISC0x08
>>> #define LED_MAIL0x09
>>> #define LED_CHARGING0x0a
>>>-#define LED_MAX0x0f
>>>+#define LED_OFF_HOOK0x0b
>>>+#define LED_RING0x0c
>>>+#define LED_RINGER0x0d
>>
>>As previous comments on duplicate functionality of LED_RINGER and LED_RING.
>
>See reply at the top.
>
>>
>>>+#define LED_HOLD0x0e
>>>+#define LED_MICROPHONE0x0f
>>
>>As previous comments on duplicate functionality of LED_MICROPHONE and LED_MUTE.
>
>See reply at the top.
>
>>
>>>+#define LED_SPEAKER0x10
>>>+#define LED_ONLINE0x11
>>>+#define LED_MAX0x11
>>> #define LED_CNT(LED_MAX+1)
>>>
>>> /*
>>>--
>>>2.7.4
>>>
>>
>>Thanks,
>>
>>Terry Junge
>>Plantronics
>
>Thanks,
>
>Niels Skou Olsen
>Jabra
>
>**** GN GROUP NOTICE - AUTOMATICALLY INSERTED**** The information in this e-mail (including attachments, if any) is
>considered confidential and is intended only for the recipient(s) listed above. Any review, use, disclosure, distribution or copying of
>this e-mail is prohibited except by or on behalf of the intended recipient. If you have received this email in error, please notify me
>immediately by reply e-mail, delete this e-mail, and do not disclose its contents to anyone. Any opinions expressed in this e-mail are
>those of the individual and not necessarily the GN group. Thank you. ******************** DISCLAIMER END
>************************
