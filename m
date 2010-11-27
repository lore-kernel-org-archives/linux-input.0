From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [RFC] Adding BTN_TOOL_TOUCH to input.h
Date: Sat, 27 Nov 2010 16:22:21 -0600
Message-ID: <AANLkTik7hdFxaXrnBwMXz1tYCBt-0FratFQzvgCXN8CY@mail.gmail.com>
References: <4CEE6D2A.9040408@euromail.se>
	<20101127081515.GD28667@core.coreip.homeip.net>
	<4CF13A39.2080709@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48998 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab0K0WWV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Nov 2010 17:22:21 -0500
Received: by ywl5 with SMTP id 5so1442922ywl.19
        for <linux-input@vger.kernel.org>; Sat, 27 Nov 2010 14:22:21 -0800 (PST)
In-Reply-To: <4CF13A39.2080709@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pinglinux@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suze.cz>

On Sat, Nov 27, 2010 at 11:04 AM, Henrik Rydberg <rydberg@euromail.se> =
wrote:
> On 11/27/2010 09:15 AM, Dmitry Torokhov wrote:
>
>> On Thu, Nov 25, 2010 at 03:05:30PM +0100, Henrik Rydberg wrote:
>
>>>
>>> In short, my suggestion is to build a struct for device properties,=
 like this:
>>>
>>> struct input_devinfo {
>>> =A0 =A0 =A0__u32 =A0 type; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* b=
itmask of possible dev types */
>>> =A0 =A0 =A0__u32 =A0 capabilities; =A0 =A0 =A0 =A0 =A0 /* bitmask o=
f special device caps */
>>> =A0 =A0 =A0__u32 =A0 phys_abs_width; =A0 =A0 =A0 =A0 /* physical wi=
dth of surface (mm) */
>>> =A0 =A0 =A0__u32 =A0 phys_abs_height; =A0 =A0 =A0 =A0/* physical he=
ight of surface (mm) */
>>> };
>>>
>>> Adding more stuff here seems plausible. For instance, special devic=
es like
>>> clickpads or integrated buttons would fit nicely in capabilities. T=
he call would
>>> be very similar, like
>>>
>>> =A0 =A0 =A0ioctl(fd, EVIOCGDEVINFO, &info);
>>>
>>
>> Yep, should work, although the dimensions could be retrieved from
>> absinfo.
>>
>
>
> I'll see if I can fit that (minus physical dimensions) into the upcom=
ing patch sets.
>

Thanks, Henrik.  That will help move things along for up coming wacom
changes needed.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
