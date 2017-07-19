From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/2] use correct values for startup time bits for
 AXP22X/AXP8XX PEKs
Date: Wed, 19 Jul 2017 08:46:25 +0100
Message-ID: <20170719074625.mzdl4y6mojaolweq@dell>
References: <20170717095307.15986-1-quentin.schulz@free-electrons.com>
 <ce4d0385-a88b-d0cf-ee99-8b4b93f11244@free-electrons.com>
 <20170718071847.bkujmrmna72wqwb7@dell>
 <1f2d37bd-b4a1-2653-c1c6-6dced95b814a@free-electrons.com>
 <CAGb2v66Y6D+qsmuUifU5md433F25=ZqaeXRG4hVULnaZGG+b_w@mail.gmail.com>
 <20170718095309.k7ndcgjfs6m5btu7@dell>
 <CAGb2v67C10hmbqSaEXxxoiaCQcN1sXSTO5+mhTjomt+tFXTVBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:33833 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752500AbdGSHq3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 19 Jul 2017 03:46:29 -0400
Received: by mail-wr0-f172.google.com with SMTP id 12so54922589wrb.1
        for <linux-input@vger.kernel.org>; Wed, 19 Jul 2017 00:46:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGb2v67C10hmbqSaEXxxoiaCQcN1sXSTO5+mhTjomt+tFXTVBg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>

On Wed, 19 Jul 2017, Chen-Yu Tsai wrote:

> On Tue, Jul 18, 2017 at 5:53 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Tue, 18 Jul 2017, Chen-Yu Tsai wrote:
> >
> >> On Tue, Jul 18, 2017 at 3:25 PM, Quentin Schulz
> >> <quentin.schulz@free-electrons.com> wrote:
> >> > Hi Lee,
> >> >
> >> > On 18/07/2017 09:18, Lee Jones wrote:
> >> >> On Mon, 17 Jul 2017, Quentin Schulz wrote:
> >> >>
> >> >>> Hi all,
> >> >>>
> >> >>> On 17/07/2017 11:53, Quentin Schulz wrote:
> >> >>>> According to their datasheets, the AXP221, AXP223, AXP288, AXP803,
> >> >>>> AXP809 and AXP813 PEK have different values for startup time bits from
> >> >>>> the AXP20X PEK (which are currently used for all the aforementioned PMICs).
> >> >>>>
> >> >>>> This patch series adds support for platform_device_id to axp20x-pek driver
> >> >>>> to support different startup time bits depending on PMIC's variant and set
> >> >>>> the correct platform_device_id in the mfd.
> >> >>>>
> >> >>>> This has been tested on AXP813. To perform the test, modify the value of
> >> >>>> startup and/or shutdown of the pek in sysfs. Press the button soldered to
> >> >>>> PEK input of the AXP the amount of time you set in sysfs. The PMIC shuts
> >> >>>> down the board without needing to unplug any power supply. Press PEK button
> >> >>>> the amount of time you set in sysfs for startup and the PMIC will start the
> >> >>>> board. Note that the time bits are obivoulsy hardware reset to their
> >> >>>> default when you unplug all power supplies from the board.
> >> >>>>
> >> >>>
> >> >>> I forgot to add that it depends on this patch series (particularly the
> >> >>> third patch (3/6) "mfd: axp20x: Add support for AXP813 PMIC") from
> >> >>> Chen-Yu:
> >> >>> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1428284.html
> >> >>
> >> >> So you are going to re-send?
> >> >>
> >> >
> >> > You put your acked-by just yesterday on this patch. Do I need to resend
> >> > it anyway?
> >> >
> >> > The link I provided seems to be really slow/not working today, so I give
> >> > you another one for reference: https://patchwork.kernel.org/patch/9803439/
> >>
> >> Or rather, would you like me to merge the AXP813 changes into my next
> >> version, and you resend the rest for faster separate inclusion?
> >
> > What I'd really like is for one of you to collect up the patches which
> > depend on each other (in the correct order of course), along with the
> > Acks you've obtained and send as a single set.  That way, I am less
> > likely to mess up the ordering when applying.
> 
> I'll include the mfd patch in my axp813 series.

Wonderful, thank you!

> Quentin, please send only the input driver for v2.
> 
> ChenYu
> 
> >
> >> >>>> Quentin Schulz (2):
> >> >>>>   Input: axp20x-pek: add support for AXP221 PEK
> >> >>>>   mfd: axp20x: use correct platform device id for many PEK
> >> >>>>
> >> >>>>  drivers/input/misc/axp20x-pek.c | 62 ++++++++++++++++++++++++++++++++++-------
> >> >>>>  drivers/mfd/axp20x.c            | 12 ++++----
> >> >>>>  2 files changed, 58 insertions(+), 16 deletions(-)
> >> >>>>
> >> >>>
> >> >>
> >> >
> >

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
