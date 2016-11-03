From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Support for ACPI0011 Generic Buttons Device
Date: Thu, 03 Nov 2016 14:30:13 +0100
Message-ID: <1478179813.18960.46.camel@hadess.net>
References: <CAD8Lp4553c8U=XfzbiXsKYgj_PKnVjmk9MdB3j=O-pPt9yi7BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:39324 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbcKCNaV (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 3 Nov 2016 09:30:21 -0400
In-Reply-To: <CAD8Lp4553c8U=XfzbiXsKYgj_PKnVjmk9MdB3j=O-pPt9yi7BQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc: Linux Upstreaming Team <linux@endlessm.com>

On Thu, 2016-11-03 at 07:24 -0600, Daniel Drake wrote:
> Hi,
> 
> We are working with a new consumer laptop model which has physical
> volume up/down keys on the left side of the chassis.
> 
> It appears that these buttons are driven by the ACPI0011 Generic
> Buttons Device defined in section 9.19 of the ACPI spec. The _DSD has
> entries for the appropriate HID codes for volume up/down which can
> also be seen in examples here:
> 
> https://msdn.microsoft.com/en-us/windows/hardware/drivers/hid/acpi-bu
> tton-device
> 
> I can't see a Linux driver for this ACPI0011 interface, is one
> planned?

drivers/input/misc/soc_button_array.c has an implementation of the
"Windows compatible button array":
https://msdn.microsoft.com/en-us/windows/hardware/drivers/bringup/other-acpi-namespace-objects#windows-compatible-button-array

Looks pretty similar.
