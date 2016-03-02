From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: How to use ACPI for touchscreen
Date: Wed, 2 Mar 2016 15:17:31 +0000
Message-ID: <CA+V1LzoZ9DEJsqKNggQHQ9B_tW8ZPMMuydsBma_jDdsKEJ6G0Q@mail.gmail.com>
References: <CA+V1LzqohgdNChrBUO+VqUiPD-9gPGvSCiu0t3L7aUk5dRyD1w@mail.gmail.com>
	<56D568C7.20203@gmail.com>
	<CA+V1LzpzJ1P3E_Rm4bRRegV0+ZMLs9befCXmA7PTSEn8umQsBw@mail.gmail.com>
	<56D61E05.3060407@gmail.com>
	<CA+V1Lzr09-GU8yS9RHU=qO=200DiCTCXEqc3zP0953uLOWaoKQ@mail.gmail.com>
	<56D6E5A0.9080509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33158 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754719AbcCBPRc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Mar 2016 10:17:32 -0500
Received: by mail-qk0-f175.google.com with SMTP id s5so83443206qkd.0
        for <linux-input@vger.kernel.org>; Wed, 02 Mar 2016 07:17:31 -0800 (PST)
In-Reply-To: <56D6E5A0.9080509@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gregor Riepl <onitake@gmail.com>
Cc: linux-input@vger.kernel.org

"Umm... Ok, this seems a bit weird. Normally, you wouldn't create devices from
user space, as the kernel should automatically instantiate them when parsing
the DSDT or DT."

Hi Gregor,

Probably I know the reason of this - I have taken chuwi vi8 with
gsl1680, after modprobe i2c-dev, i2cdetect -r 3  - detects gsl1680 on
0x40 PERMANENTLY! In Android touch is on i2c-4, but on the same
address.
AFAIK - i2c devices could switch bus number but not their port on bus,
this means that if you have chipone icn85xx it should answer on 0x48
on one of the i2c bus.
Am I right?

In case of Chuwi Vi10 with Chipone icn8528 situation with i2cdetect is
very very strange.
On kernels 4.4.2 and 4.0.1 - modprobe i2c-dev and then i2cdetect -r X
(1,2,3,4) does NOT!!!!!!!! Detect NOTHING permanently on 0x48 on any
bus!
This make me confused completely! To wake up something it should be
visible on i2c bus but it is NOT!

Regards,
                Serge Kolotylo.
