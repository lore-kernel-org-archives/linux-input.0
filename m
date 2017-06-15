From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/2] Input: pm8941-pwrkey: Introduce reboot mode support
Date: Thu, 15 Jun 2017 11:33:42 -0700
Message-ID: <20170615183342.GX12920@tuxbook>
References: <20170527065130.3456-1-bjorn.andersson@linaro.org>
 <20170527065130.3456-2-bjorn.andersson@linaro.org>
 <20170530025324.GD32841@dtor-ws>
 <20170530044711.GP12920@tuxbook>
 <20170608163243.j4dfpa6swoz27ofd@earth>
 <20170612233203.GT12920@tuxbook>
 <20170615162657.dgjsriesdzlqwzux@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170615162657.dgjsriesdzlqwzux@earth>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, John Stultz <john.stultz@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu 15 Jun 09:26 PDT 2017, Sebastian Reichel wrote:

> Hi,
> 
> On Mon, Jun 12, 2017 at 04:32:03PM -0700, Bjorn Andersson wrote:
[..]
> > As such if we split the non-input related handling into another driver
> > we would need to make the input driver create a subdevice during probe -
> > or create a new pon-driver with a new compatible that internally spawns
> > the pwrkey driver. Neither seems desirable to me...
> 
> The pon-driver would have been the proper solution, but with the
> binding already being defined that's no longer a nice option :(
> 

We have a binding for the "qcom,pm8941-pwrkey", but as long as we
maintain the compatibility in the input driver with this we could come
up with a new binding for the "pon" block.

> > The features of the PON block not yet shown on LKML are status registers
> > to indicate the reason for powering up the PMIC and a watchdog (which I
> > don't believe is used or exposed today).
> 
> So we have a block, which has watchdog, powerdown, reboot, boot-reason,
> reboot-mode and power key. To me that does not look like it should be
> one driver.
> 

Unfortunately I do agree with this.

It would make sense to describe the pon in a single DT-node and have a
pon-driver spawning off individual driver for each functionality. That
way we get a clean representation in DT and we get clean implementation
of each component...

Regards,
Bjorn
