From: Steve Twiss <stwiss.opensource@diasemi.com>
Subject: RE: [RESEND PATCH V7 5/7] regulator: da9061: BUCK and LDO regulator
 driver
Date: Wed, 7 Jun 2017 14:09:56 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CD927CE@SW-EX-MBX02.diasemi.com>
References: <cover.1496823229.git.stwiss.opensource@diasemi.com>
 <cb544b5c855ded286f2d0c824eb864630495c984.1496823229.git.stwiss.opensource@diasemi.com>
 <20170607094159.uua5zxmeq2z4zrbu@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170607094159.uua5zxmeq2z4zrbu@sirena.org.uk>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-input@vger.kernel.org

Hi Mark,

On 07 June 2017 10:42, Mark Brown wrote:

> Subject: Re: [RESEND PATCH V7 5/7] regulator: da9061: BUCK and LDO regulator driver
> 
> On Wed, Jun 07, 2017 at 09:13:48AM +0100, Steve Twiss wrote:
> > From: Steve Twiss <stwiss.opensource@diasemi.com>
> >
> > Regulator support for the DA9061 is added into the DA9062 regulator driver.
> 
> I'm missing the other patches in this series and the cover letter, what
> are the dependencies here?

My apologies Mark. I didn't re-send the cover letter because this regulator
patch is the last one and I assumed it would not add anything.
Am I confusing you here by not renaming the patch and leaving its subject
as [PATCH V7 5/7]?

This whole DA9061 patch set was a very long time in the submission process.
You Acked the DA9061 regulator patch back in 2016, but it had a compile
dependency with the DA9061 MFD patch so it had to wait until that got
approved. If the regulator patch had got in first, it would have broken
the build.

The MFD patch contained a change to the ./include/linux/mfd/da9062/core.h
file -- it had a new enum for da9062_compatible_types and these values were
used in the MFD, but also appeared in the regulator patch as part of the
da9062_regulator_probe().

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=656211b1dfb9e0b68d4e634931432e29a6facf46

According to my records, I think the MFD made it into linux-mainline/v4.12-rc1
as part of Lee Jones'  e-mail "[GIT PULL] MFD for v4.12"
https://lkml.org/lkml/2017/5/3/91 [I can't check that link, LKML is down atm].
Once the MFD change for DA9062/1 had been added, this unblocked the 
patch for the regulators.

In my test environment here, I've tested the DA9061 and the build by patching 
v4.12-rc2 with the remaining DA9061 regulator patch.

I'm not sure the cover letter for the original V7 patch set will explain much, but I
will resend again, this time with the cover letter.

Regards,
Steve

The original components of the PATCH V7 are as follows:
[v7,1] https://patchwork.kernel.org/patch/9649905/
[v7,2] https://patchwork.kernel.org/patch/9649921/
[v7,3] https://patchwork.kernel.org/patch/9649889/
[v7,4] https://patchwork.kernel.org/patch/9649927/
[v7,5] https://patchwork.kernel.org/patch/9649895/
[v7,6] https://patchwork.kernel.org/patch/9649917/
[v7,7] https://patchwork.kernel.org/patch/9649913/
