From: Gregor Riepl <onitake@gmail.com>
Subject: Re: [PATCH] Add generic driver for Silead tochscreens
Date: Mon, 13 Jul 2015 14:21:17 +0200
Message-ID: <55A3AD3D.4040008@gmail.com>
References: <55A18959.7050502@gmail.com> <CAFPB+YdNTUCRsQZZVCZQGyAdmOnSGs_fqOFxRm9u8rFPLDobCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35380 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbbGMMWN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2015 08:22:13 -0400
Received: by wgjx7 with SMTP id x7so294510252wgj.2
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2015 05:22:11 -0700 (PDT)
In-Reply-To: <CAFPB+YdNTUCRsQZZVCZQGyAdmOnSGs_fqOFxRm9u8rFPLDobCQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robert Dolca <robert.dolca@gmail.com>
Cc: linux-input@vger.kernel.org

> The firmware has to be calibrated by the vendor for each chip-panel
> combination. If you change the panel even if you keep the same chip it
> is very likely to need some calibration. This might be the reason why
> the finger ID is not working properly.

I see.

So, while your new driver is sufficiently generic, it would still need a
device specific firmware image and there is no way to work around that?

That's kind of a bummer.

Would it be possible to modify the driver in a way that it would work with
different types of panels/chips, even those where finger tracking does not
work correctly?

Also, I see one particular problem concerning existing hardware.
You're retrieving the dimensions, maximum number of trackable fingers and the
name of the firmware image from the DSDT or DTS using device_property_read_*.
The Baytrail tablet I'm testing on does not include such information, and
injecting a modified DSDT is maybe not the best option. Also, the DSDT shipped
I have here does not use GPIO definitions for the control pins, but instead
executes the shutdown/wakeup sequences through _PS3/_PS0 methods. At least
that was my assumption when I looked at it. There are GPIO definitions as
well, but it's not clear what those are used for. Please take a look at the
stanza yourself, if you can:
https://github.com/onitake/gslx680-acpi/blob/master/acpi/gsl-dsdt.aml
I can also send you the complete decompiled DSDT if it helps.
