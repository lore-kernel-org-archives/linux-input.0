From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Subject: Re: [PATCH v2 1/2] input: Add Qualcomm PM8941 power key driver
Date: Tue, 15 Sep 2015 14:36:25 +0300
Message-ID: <1442316985.15519.7.camel@linaro.org>
References: <1422058747-13486-1-git-send-email-bjorn.andersson@sonymobile.com>
	 <1422058747-13486-2-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1422058747-13486-2-git-send-email-bjorn.andersson@sonymobile.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Courtney Cavin <courtney.cavin@sonymobile.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-input@vger.kernel.org


On Fri, 2015-01-23 at 16:19 -0800, Bjorn Andersson wrote:
> From: Courtney Cavin cavin@sonymobile.com>
> 
> Signed-off-by: Courtney Cavin cavin@sonymobile.com>
> Signed-off-by: Bjorn Andersson andersson@sonymobile.com>
> 

<snip>

> 
> +config INPUT_PM8941_PWRKEY
> +       tristate "Qualcomm PM8941 power key support"
> +       depends on MFD_SPMI_PMIC
> +       help
> +                       Say Y here if you want support for the power key usually found
> +                       on boards using a Qualcomm PM8941 compatible PMIC.
> +

Hi Bjorn, Courtney, 

Do you plan to extend this driver to support RESIN_N PMIC input?
 
It looks like the same downstream "qcom,qpnp-power-on" handle
this functionality for recent PMIC versions.

What will be the best way to add this new functionality, extend
this driver, write new one...?

Regards,
Ivan
