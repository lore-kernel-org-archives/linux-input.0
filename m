From: Chase Douglas <chasedouglas@gmail.com>
Subject: Re: Mixed "pen" and multitouch input devices
Date: Thu, 15 Mar 2012 11:29:37 -0700
Message-ID: <4F623511.3040907@gmail.com>
References: <20120315155235.GA6783@stud.informatik.uni-erlangen.de> <CAGzDe_b0XPUBZKAGnj9kxzuRb9Fw7aph_Q+VgmdVbpVNU2Sf3w@mail.gmail.com> <20120315175635.GA23155@stud.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58643 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873Ab2COS3N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Mar 2012 14:29:13 -0400
Received: by dajr28 with SMTP id r28so4878471daj.19
        for <linux-input@vger.kernel.org>; Thu, 15 Mar 2012 11:29:13 -0700 (PDT)
In-Reply-To: <20120315175635.GA23155@stud.informatik.uni-erlangen.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thorsten Wissmann <re06huxa@stud.informatik.uni-erlangen.de>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, =?ISO-8859-1?Q?Maximilian_Kr=FCger?= <maxfragg@gmail.com>, i4passt@lists.informatik.uni-erlangen.de

On 03/15/2012 10:56 AM, Thorsten Wissmann wrote:
> On Thu, Mar 15, 2012 at 12:27:22PM -0500, Chris Bagwell wrote:
>> Its also true that sharing ABS_X/Y events between both a BTN_TOOL_PEN
>> and a BTN_TOOL_FINGER will confuse most user land apps (they think
>> only touchpads can declare BTN_TOOL_FINGER's but this is a
>> touchscreen) and it also has bad side affects to the kernel's MT
>> pointer emulation functions.
>>
>> You can look at kernel drivers/input/touchscreen/wacom_w8001.c for an
>> example touchscreen that supports pen and at least 2 MT touches on a
>> single /dev/input device (because HW packets come over single serial
>> interface).  It does not declare a BTN_TOOL_FINGER nor use pointer
>> emulation to overcome issues I mentioned and xf86-input-wacom
>> understands how to handle this device.
>>
>> If you want to work with other unmodified user land apps (perhaps
>> xf86-input-evdev for touches) then its probably easiest to split pen
>> and touch to separate input devices.  drivers/input/tablet/wacom_wac.c
>> shows some examples of that approach but that driver doesn't have to
>> work to hard to split in to 2 input devices because the USB device
>> already puts the events on separate USB  interfaces.
> 
> OK. We want the device to work with the xf86-input-evdev driver. So we
> will split it into two devices.

Or you could teach evdev to know how to handle mixed devices :). I think
that's the "better" approach over all, but it's up to you.

-- Chase
