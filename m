From: "Jiejing.Zhang " <kzjeef@gmail.com>
Subject: Re: [PATCH v2] input: add EETI eGalax I2C capacitive multi touch driver.
Date: Thu, 8 Sep 2011 19:39:01 +0800
Message-ID: <CACrgxGDr-07to49iz=dr-yRmpmyNEM8mTgABWDxTskqThMpWmg@mail.gmail.com>
References: <20110801063409.GB32118@core.coreip.homeip.net>
 <1312370963-24965-1-git-send-email-jiejing.zhang@freescale.com>
 <20110811203449.GA6162@polaris.bitmath.org> <CACrgxGCodzp+2TqOCHQPRFTN4oT+DuqsZ8qKCahQ5bcXS+9dkA@mail.gmail.com>
 <20110812203003.GA8995@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f43.google.com ([209.85.212.43]:56226 "EHLO
	mail-vw0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758281Ab1IHLjV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Sep 2011 07:39:21 -0400
Received: by vws10 with SMTP id 10so1037159vws.2
        for <linux-input@vger.kernel.org>; Thu, 08 Sep 2011 04:39:21 -0700 (PDT)
In-Reply-To: <20110812203003.GA8995@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Zhang Jiejing <jiejing.zhang@freescale.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, dima@android.com

Hi Henrik,

2011/8/13 Henrik Rydberg <rydberg@euromail.se>:
>> > The device seems to send finger changes sequentually, resulting in one
>> > packet (terminated with input sync) for each finger change. Is this
>> > the intention/necessary? Some egalax firmware (hid version) seems to
>> > work this way.
>>
>> When I make v2 patch, I've a look the Protocol B's driver in upstream,
>> but there were two type of multi-point report fashion,
>> One type is report all the finger status in one input sync(), and
>> separate each mt point with mt_input_slot(), like wocom driver.
>>
>> But there was some driver (like egalax hid version), send each mt
>> point with one input_sync(), but I'm worry about if main stream user
>> space frameworks(xorg mtouch etc,) support this behavior well.
>
> Sequential reporting works reasonably well, although there are
> potential problems (applying methods for smooth motion, for
> instance). Wakeups and cpu intensity also increases.
>
>> What's your point of view about this ?
>
> If possible, I think batched reporting is preferred, i.e., using the
> same method as all hid drivers _but_ the egalax one.
After go through the code, I found HID driver's batched report is hard
to implement in this driver.
Although, since I already use threaded irq to deal with the new event
information, and it will perform i2c read every time, i2c is a slow
bus, I think the CPU cause of this kind of device is relative lower
then some device via USB.
>
>> > The usage of REPORT_MODE_* is unclear to me too.
>>
>> In the programming manual this mode 's name is "single touch mouse
>> mode", may be it will be a better name for this mode ?
>
> Ok, sounds like the equivalent of the hid generic mouse, which could
> either be ignored or assigned its own input device node. Nothing out
> of the ordinary, in other words, and the patch looks good in this
> respect. Thanks for clarifying.
>
I've already change the MODE_SINGLE to MODE_MOUSE to avoid confusion
in next version.
> Henrik
>

Thanks,
Jiejing
