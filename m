From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: Re: [PATCH v2 1/2] input: Add Qualcomm PM8941 power key driver
Date: Sun, 20 Sep 2015 21:48:58 -0700
Message-ID: <20150921044858.GP13472@usrtlx11787.corpusers.net>
References: <1422058747-13486-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1422058747-13486-2-git-send-email-bjorn.andersson@sonymobile.com>
 <1442316985.15519.7.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1442316985.15519.7.camel@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Cc: "Cavin, Courtney" <Courtney.Cavin@sonymobile.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue 15 Sep 04:36 PDT 2015, Ivan T. Ivanov wrote:

> 
> On Fri, 2015-01-23 at 16:19 -0800, Bjorn Andersson wrote:
> > From: Courtney Cavin cavin@sonymobile.com>
> > 
> > Signed-off-by: Courtney Cavin cavin@sonymobile.com>
> > Signed-off-by: Bjorn Andersson andersson@sonymobile.com>
> > 
> 
> <snip>
> 
> > 
> > +config INPUT_PM8941_PWRKEY
> > +       tristate "Qualcomm PM8941 power key support"
> > +       depends on MFD_SPMI_PMIC
> > +       help
> > +                       Say Y here if you want support for the power key usually found
> > +                       on boards using a Qualcomm PM8941 compatible PMIC.
> > +
> 
> Hi Bjorn, Courtney, 
> 
> Do you plan to extend this driver to support RESIN_N PMIC input?
>  

It's way down on the todo-list, so not right now.

> It looks like the same downstream "qcom,qpnp-power-on" handle
> this functionality for recent PMIC versions.
> 

Right, it seems to be functionality in the PON block.

> What will be the best way to add this new functionality, extend
> this driver, write new one...?
> 

Perhaps the naming of the driver isn't the best in the end, but I think
it should be implemented by the same driver...

Regards,
Bjorn
