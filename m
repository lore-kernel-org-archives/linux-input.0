From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCHv5 3/6] mfd: da9052: add register details for TSI
Date: Tue, 18 Jul 2017 08:08:50 +0100
Message-ID: <20170718070850.rvu2iq4nsdwtnrb2@dell>
References: <20170703084003.31184-1-sebastian.reichel@collabora.co.uk>
 <20170703084003.31184-4-sebastian.reichel@collabora.co.uk>
 <20170717143245.qvcshsnodtk7pi2h@dell>
 <20170717152017.gtqa6g657k232z5k@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170717152017.gtqa6g657k232z5k@earth>
Sender: linux-hwmon-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Support Opensource <support.opensource@diasemi.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 17 Jul 2017, Sebastian Reichel wrote:

> Hi,
> 
> On Mon, Jul 17, 2017 at 03:32:45PM +0100, Lee Jones wrote:
> > On Mon, 03 Jul 2017, Sebastian Reichel wrote:
> > 
> > > Add register details an channels definition for using the TSI
> > > registers in the hwmon driver.
> > > 
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > > ---
> > >  include/linux/mfd/da9052/da9052.h |  6 ++++++
> > >  include/linux/mfd/da9052/reg.h    | 11 ++++++++++-
> > >  2 files changed, 16 insertions(+), 1 deletion(-)
> > 
> > Do other patches in this set depend on this change?
> 
> Patch 6 has a compile-time dependency on 3 (this one) + 5
> and a runtime-dependency on patch 4. My proposed merge
> solution would be an immutable branch for the mfd changes,
> that can be pulled by hwmon.

I'm happy to do that.  Please fix patch 4 and I'll take them in.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
