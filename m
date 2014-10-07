From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: Add Qualcomm PM8941 power key driver
Date: Mon, 6 Oct 2014 18:30:01 -0700
Message-ID: <20141007013001.GD39707@dtor-ws>
References: <1412644321-27683-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1412644321-27683-2-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412644321-27683-2-git-send-email-bjorn.andersson@sonymobile.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, Courtney Cavin <courtney.cavin@sonymobile.com>
List-Id: linux-input@vger.kernel.org

Hi Bjorn,

On Mon, Oct 06, 2014 at 06:12:00PM -0700, Bjorn Andersson wrote:
> +
> +	rc = devm_request_threaded_irq(&pdev->dev, pwrkey->irq,
> +				NULL, pm8941_pwrkey_irq,
> +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |

Do we need to hard-code IRQ flags like this? I'd rather we respect DT
data.

Thanks.

-- 
Dmitry
