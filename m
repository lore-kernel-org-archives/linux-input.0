From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] input.h: Add BTN_SIDE2 button code
Date: Tue, 03 Feb 2015 09:13:27 +0100
Message-ID: <54D08327.9060509@redhat.com>
References: <1422008690-920-1-git-send-email-hdegoede@redhat.com> <20150130223537.GB23203@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57739 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753705AbbBCINe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Feb 2015 03:13:34 -0500
In-Reply-To: <20150130223537.GB23203@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi,

On 30-01-15 23:35, Dmitry Torokhov wrote:
> Hi Hans,
>
> On Fri, Jan 23, 2015 at 11:24:50AM +0100, Hans de Goede wrote:
>> Some mice report buttons with a MSC_SCAN of 589833 this maps to a button code
>> of 0x118, add a BTN_SIDE2 define for this to input.h
>>
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1184352
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> Looking at Logitech website it seems that one of teh buttons is marked
> "zoom", so why don't we use KEY_ZOOM for it?

Because we don't do any smart mapping on HID mouse buttons, see:
drivers/hid/hid-input.c: hidinput_configure_usage() where we do:

	switch (usage->hid & HID_USAGE_PAGE) {
	...
	case HID_UP_BUTTON:
		code = ((usage->hid - 1) & HID_USAGE);

		switch (field->application) {
		case HID_GD_MOUSE:
		case HID_GD_POINTER:  code += BTN_MOUSE; break;
		...
		}
		map_key(code);
		break;
	...
	}

So we basically assign any mouse buttons to evdev code 0x110 - 0x11f,
which by itself is the best the kernel can do really as the HUT is
not helpful here, simply saying the following on these buttons:

Button 1 (primary/trigger)
Button 2 (secondary)
Button 3 (tertiary)
Button 4
...
Button 65535

IOW it gives no guidance which button is what on mouse other then for
left / right / middle. This e.g. can clearly be seen on a cheap mouse
with prev / next buttons I have where the buttons send hut button code
4 & 5 which gets translated to BTN_SIDE / BTN_EXTRA

Given how these buttons are specified in the HUT, the kernel should
really just be sending BTN_0 (for hut button 4) - BTN_9 for them, as they
have no clearly assigned meaning.

It is too late to change this now though, as that would be a clear ABI
break.

Also note that given that the kernel just sends code + BTN_MOUSE, it is
already sending 0x118 (and potentially higher codes), and this is already
picked up by e.g. Xorg, all I'm trying to do here is assign a label to the
codes already being send.

Maybe we should do something like this:

--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -494,10 +494,23 @@ struct input_keymap_entry {
  #define BTN_RIGHT              0x111
  #define BTN_MIDDLE             0x112
  #define BTN_SIDE               0x113
+#define BTN_EXTRA0           0x113 /* Exact usage unknown on HID devices */
  #define BTN_EXTRA              0x114
+#define BTN_EXTRA1           0x114 /* Exact usage unknown on HID devices */
  #define BTN_FORWARD            0x115
+#define BTN_EXTRA2           0x115 /* Exact usage unknown on HID devices */
  #define BTN_BACK               0x116
+#define BTN_EXTRA3           0x116 /* Exact usage unknown on HID devices */
  #define BTN_TASK               0x117
+#define BTN_EXTRA4           0x117 /* Exact usage unknown on HID devices */
+#define BTN_EXTRA5           0x118
+#define BTN_EXTRA6           0x119
+#define BTN_EXTRA7           0x11a
+#define BTN_EXTRA8           0x11b
+#define BTN_EXTRA9           0x11c
+#define BTN_EXTRA10          0x11d
+#define BTN_EXTRA11          0x11e
+#define BTN_EXTRA12          0x11f

  #define BTN_JOYSTICK           0x120
  #define BTN_TRIGGER            0x120

Note that we could use udev hwdb entries to fix up things, I could e.g.
fix the prev / next buttons on my mouse to send the right codes by remapping
them through hwdb. I'm a bit divided on this, as this is going to be a bit of
whack a mole. This is somewhat orthogonal though, because we should at least
give some symbolic name to codes which we are actually emitting now already,
and will keep emitting for new mice without a hwdb entry.

Regards,

Hans





>
>> ---
>>   include/uapi/linux/input.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
>> index a1d7e93..27b0f6a 100644
>> --- a/include/uapi/linux/input.h
>> +++ b/include/uapi/linux/input.h
>> @@ -498,6 +498,7 @@ struct input_keymap_entry {
>>   #define BTN_FORWARD		0x115
>>   #define BTN_BACK		0x116
>>   #define BTN_TASK		0x117
>> +#define BTN_SIDE2		0x118
>>
>>   #define BTN_JOYSTICK		0x120
>>   #define BTN_TRIGGER		0x120
>> --
>> 2.1.0
>>
>
> Thanks.
>
