From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [RFC] Adding BTN_TOOL_TOUCH to input.h
Date: Tue, 23 Nov 2010 14:40:00 -0800
Message-ID: <AANLkTi=sEJC9r=ZL7rJH9ojOjadmriNFbN97t+=HpTwy@mail.gmail.com>
References: <AANLkTinw2pyZOPuVsG6ovBTFKstozamfWX=6EcjyYTfX@mail.gmail.com>
	<20101123223018.GC20283@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38064 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359Ab0KWWkC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Nov 2010 17:40:02 -0500
Received: by eye27 with SMTP id 27so5007838eye.19
        for <linux-input@vger.kernel.org>; Tue, 23 Nov 2010 14:40:01 -0800 (PST)
In-Reply-To: <20101123223018.GC20283@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Tue, Nov 23, 2010 at 2:30 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Nov 23, 2010 at 12:48:07PM -0800, Ping Cheng wrote:
>> Hi all,
>>
>> I am not going to write a patch for this request before I get the
>> permission for the new tool type. It affects all touch screen device=
s
>> (under drivers/input/touchscreen) that support both pen and touch.
>>
>> Right now, in the user land, BTN_TOUCH is used to indicate a single
>> touch events. BTN_TOUCH and !BTN_TOOL_PEN
>> (http://udev.sourcearchive.com/documentation/161-1/input__id_8c-sour=
ce.html)
>> are used to determine if the device is a touch screen device or not =
a
>> pen. With both pen and touch on the same logical port (serial touch
>> screen with pen and touch enabled, refer to wacom_w8001.c), BTN_TOUC=
H
>> and !BTN_TOOL_PEN will always be false, which indicates a
>> non-touchscreen device. That is wrong.
>>
>> Unless we have other means to tell the user land a device is a
>> touchscreen, BTN_TOUCH with !BTN_TOOL_PEN won't do the job for us.
>>
>> I've already had a value for the new type:
>>
>> +#define BTN_TOOL_TOUCH =A0 =A0 =A0 0x149
>>
>> This new type resolves the confusion we had for the existing serial
>> pen and touch enabled touchscreen devices. Considering we are mergin=
g
>> the two logical ports for USB devices, the new type is required for
>> the future USB touchscreen support as well.
>
> How is BTN_TOOL_TOUCH is different from BTN_TOOL_FINGER?

Good question.

BTN_TOOL_FINGER is used for touchpad or trackpad, or whichever term
that works for you. It indicates a relative cursor movement. The touch
screen needs to translate the (x,y) events into absolute movement.
That's why none of those touchscreen drivers use BTN_TOOL_FINGER so
far.

Any more questions ;)?

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
