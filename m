From: "Jiejing.Zhang " <kzjeef@gmail.com>
Subject: Re: [PATCH v2] input: add EETI eGalax I2C capacitive multi touch driver.
Date: Fri, 12 Aug 2011 21:24:29 +0800
Message-ID: <CACrgxGCodzp+2TqOCHQPRFTN4oT+DuqsZ8qKCahQ5bcXS+9dkA@mail.gmail.com>
References: <20110801063409.GB32118@core.coreip.homeip.net>
 <1312370963-24965-1-git-send-email-jiejing.zhang@freescale.com> <20110811203449.GA6162@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56217 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab1HLNYt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Aug 2011 09:24:49 -0400
Received: by vws1 with SMTP id 1so2438050vws.19
        for <linux-input@vger.kernel.org>; Fri, 12 Aug 2011 06:24:49 -0700 (PDT)
In-Reply-To: <20110811203449.GA6162@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Zhang Jiejing <jiejing.zhang@freescale.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, dima@android.com

Hi Henrik,

2011/8/12 Henrik Rydberg <rydberg@euromail.se>:
> Hi Zhang,
>
>> This is the patch after change to mt Protocol-B.
>> but I have a issue with test tool, in the orignal patch, I use
>> android to do the test, but android still not support Protocol B.
>
> The device seems to send finger changes sequentually, resulting in one
> packet (terminated with input sync) for each finger change. Is this
> the intention/necessary? Some egalax firmware (hid version) seems to
> work this way.

When I make v2 patch, I've a look the Protocol B's driver in upstream,
but there were two type of multi-point report fashion,
One type is report all the finger status in one input sync(), and
separate each mt point with mt_input_slot(), like wocom driver.

But there was some driver (like egalax hid version), send each mt
point with one input_sync(), but I'm worry about if main stream user
space frameworks(xorg mtouch etc,) support this behavior well.

What's your point of view about this ?

>
> The usage of REPORT_MODE_* is unclear to me too.

In the programming manual this mode 's name is "single touch mouse
mode", may be it will be a better name for this mode ?

>
> Other than that, the patch looks nice (at first glance).
>
> Thanks,
> Henrik
>

Thanks,
Jiejing
