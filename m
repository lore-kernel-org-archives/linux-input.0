From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 3/4] input - wacom : support one finger touch the
 touchscreen way
Date: Fri, 11 Feb 2011 14:58:00 -0600
Message-ID: <AANLkTimsRQF7cpUWXS3VfvFUm3NpB=0yuRccbc+FfvKV@mail.gmail.com>
References: <1297387962-13723-1-git-send-email-pinglinux@gmail.com>
	<20110211195656.GA2287@polaris.bitmath.org>
	<AANLkTin0PWuMaB1T9sXj-VF9JUST3U=fHszR0RXG=ih4@mail.gmail.com>
	<AANLkTimBwdRE1xqpD0gRzp7+Q-ML1HyJmn6szo_Soz0s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50475 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758085Ab1BKU6C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Feb 2011 15:58:02 -0500
Received: by gyb11 with SMTP id 11so1257312gyb.19
        for <linux-input@vger.kernel.org>; Fri, 11 Feb 2011 12:58:01 -0800 (PST)
In-Reply-To: <AANLkTimBwdRE1xqpD0gRzp7+Q-ML1HyJmn6szo_Soz0s@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On Fri, Feb 11, 2011 at 2:40 PM, Ping Cheng <pinglinux@gmail.com> wrote=
:
> On Fri, Feb 11, 2011 at 12:24 PM, Ping Cheng <pinglinux@gmail.com> wr=
ote:
>> On Fri, Feb 11, 2011 at 11:56 AM, Henrik Rydberg <rydberg@euromail.s=
e> wrote:
>>>> @@ -1180,7 +1144,6 @@ void wacom_setup_input_capabilities(struct i=
nput_dev *input_dev,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(inpu=
t_dev, ABS_Y,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom_=
calculate_touch_res(features->y_max,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->y_phy));
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_DOUBL=
ETAP, input_dev->keybit);
>>>
>>> Where is doubletap set now?
>>
>> Oops. I must have missed that in 4/4. I'll add it in the new version
>> after I hear from you for the other comments.
>
> Well, DOUBLETAP has been added in 4/4 already. Please take a close
> look. Too soon to admit an error ;).
>

Extra clarification on whats going on here:

Patch #1 removes BTN_TOOL_TRIPLETAP; among other supporting 2 finger
touch code.  In that context, it was used as an awkward indication to
xf86-input-wacom that device supported 2 finger touch.

In this patch #3, it removes BTN_TOOL_DOUBLETAP; which was an awkward
indication to xf86-input-wacom that device supports 1 finger touch.
Once this patch is applied, applications must deduce touchscreen input
supports 1 finger touch same way as they do for other touchscreens
(not seeing BTN_TOOL_FINGER and no stylus related BTN_'s as well).

Patch #4 adds BTN_TOOL_DOUBLETAP back but using normal meaning that
the device supports 2 finger touch.

I had reviewed this patch series in context of some related changes
from Ping to xf86-input-wacom.  I wanted to document doubletap part of
that review on this list though.

Ping originally didn't want to add that back in.  At least one of the
reasons was that there were no known applications that supported both
"touchscreens" (absolute mode) and the BTN_TOOL_DOUBLETAP at same
time.

I did look around quite a bit after Ping's comment and I couldn't come
up with anything (mtdev, xf86-input-evdev, etc).  So its a good point.
 When something supports ABS_MT_*, thats given much more weight then
BTN_TOOL_DOUPLETAP would; which is the case here.

Anyways, I requested if Ping would add BTN_TOOL_DOUBLETAP in to align
with current hid-ntrig and since it didn't seem to hurt and could
possibly help some future app.  Please double check me here if it is
in fact a good idea to add DOUBLETAP in for touchscreens.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
