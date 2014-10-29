From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH 0/2] Qualcomm PM8941 power key driver
Date: Wed, 29 Oct 2014 18:07:28 +0200
Message-ID: <1414598848.32383.4.camel@mm-sol.com>
References: <1412644321-27683-1-git-send-email-bjorn.andersson@sonymobile.com>
	 <1412672510.1027.57.camel@iivanov-dev>
	 <20141007184640.GB31125@sonymobile.com>
	 <1412761807.13569.12.camel@iivanov-dev>
	 <20141024152350.GD28611@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141024152350.GD28611@sonymobile.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-input@vger.kernel.org



Hi Bjorn,

On Fri, 2014-10-24 at 08:23 -0700, Bjorn Andersson wrote:
> On Wed 08 Oct 02:50 PDT 2014, Ivan T. Ivanov wrote:
> 
> > On Tue, 2014-10-07 at 11:46 -0700, Bjorn Andersson wrote:
> > > On Tue 07 Oct 02:01 PDT 2014, Ivan T. Ivanov wrote:
> > > 
> > > > Hi Bjorn,
> > > > 
> > > > On Mon, 2014-10-06 at 18:11 -0700, Bjorn Andersson wrote:
> [..]
> > > > >  create mode 100644 drivers/input/misc/pm8941-pwrkey.c
> > > > 
> > > > Any reason why we cannot reuse pm8xxx-pwrkey driver? It have been
> > > > converted to regmap already.
> > > > 
> > > 
> > > The boilerplate code is the same,
> > 
> > The boilerplate code is almost 100% :-)
> > 
> > >  but configuration registers have different
> > > layout and values written in them are different.
> > 
> > We talk about 3 registers and 2 bit defines. struct regmap_field
> > should be able to help here.
> > 
> 
> You're totally right, we could rewrite the driver to use regmap_field and make
> the rest of the differences conditional. In my eyes we end up with two drivers
> in one file - but it can be done.
> 
> A difference however is that in pm8941 the ps hold behavious (reboot vs power
> off) is controlled by this same block. So I have an additional patch that adds
> a restart handler here that sets the pmic in the right state before we pull
> pshold (but I haven't been able to test it properly).
> 
> In pm8xxx this is handled in the pmic misc block and does not belong in this
> driver.

Ok, Your plan is to bring up support for QPNP power-on PMIC sub function into this
driver. In this case, I agree, it will be cleaner to have separate driver for this.

Regards,
Ivan
