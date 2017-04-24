From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V7 4/7] mfd: da9061: MFD core support
Date: Mon, 24 Apr 2017 13:38:39 +0100
Message-ID: <20170424123839.pjgbmz36nwcgfvn4@dell>
References: <cover.1491230802.git.stwiss.opensource@diasemi.com>
 <b39c8c3f42a01a00f93292c569e8d30ce69ff3ab.1491230802.git.stwiss.opensource@diasemi.com>
 <20170404083902.ywo3pdxptgfcqvga@dell>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD71434@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:36315 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1169941AbdDXMip (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Apr 2017 08:38:45 -0400
Received: by mail-wr0-f177.google.com with SMTP id l50so17004590wrc.3
        for <linux-input@vger.kernel.org>; Mon, 24 Apr 2017 05:38:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7018CD71434@SW-EX-MBX02.diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>, DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>

On Mon, 24 Apr 2017, Steve Twiss wrote:

> On 04 April 2017 09:39, Lee Jones wrote:
> > Subject: Re: [PATCH V7 4/7] mfd: da9061: MFD core support
> > 
> > On Mon, 03 Apr 2017, Steve Twiss wrote:
> > > From: Steve Twiss <stwiss.opensource@diasemi.com>
> > > MFD support for DA9061 is provided as part of the DA9062 device driver.
> > >
> > > The registers header file adds two new chip variant IDs defined in DA9061
> > > and DA9062 hardware. The core header file adds new software enumerations
> > > for listing the valid DA9061 IRQs and a da9062_compatible_types enumeration
> > > for distinguishing between DA9061/62 devices in software.
> > >
> > > The core source code adds a new .compatible of_device_id entry. This is
> > > extended from DA9062 to support both "dlg,da9061" and "dlg,da9062". The
> > > .data entry now holds a reference to the enumerated device type.
> > >
> > > A new regmap_irq_chip model is added for DA9061 and this supports the new
> > > list of regmap_irq entries. A new mfd_cell da9061_devs[] array lists the
> > > new sub system components for DA9061. Support is added for a new DA9061
> > > regmap_config which lists the correct readable, writable and volatile
> > > ranges for this chip.
> > >
> > > The probe function uses the device tree compatible string to switch on the
> > > da9062_compatible_types and configure the correct mfd cells, irq chip and
> > > regmap config.
> > >
> > > Kconfig is updated to reflect support for DA9061 and DA9062 PMICs.
> > >
> > > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> > 
> > Ah, here it is.
> > 
> > Applied, thanks.
> 
> Hi Lee,
> 
> I noticed the DA9061 core support has been added into linux-next, however
> the commit message was changed from the original title:
> 
> "mfd: da9061: MFD core support"
> 
> to add the mistake:
> 
> "mfd: Add suppfor for DA9061"
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=d3fe0806025cacdab1462d5704e1c98ab9db4564
> 
> Can this be fixed please?
> This patch has not been upstreamed into linux-mainline and is still in linux-next.

You're right, thanks for pointing that out.

Now fixed.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
