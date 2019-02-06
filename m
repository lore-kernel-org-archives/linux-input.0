From: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH v3 2/3] Input: add new vibrator driver for various MSM
 SOCs
Date: Tue, 5 Feb 2019 19:52:16 -0500
Message-ID: <20190206005216.GA16650@basecamp>
References: <20181025012937.2154-1-masneyb@onstation.org>
 <20181025012937.2154-3-masneyb@onstation.org>
 <20190205194246.GA19151@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190205194246.GA19151@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, jonathan@marek.ca
List-Id: linux-input@vger.kernel.org

On Tue, Feb 05, 2019 at 11:42:46AM -0800, Dmitry Torokhov wrote:
> > +		dev_err(&pdev->dev, "Failed to lookup pwm clock: %ld\n",
> > +			PTR_ERR(vibrator->clk));
> > +		return PTR_ERR(vibrator->clk);
> > +	}
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "Failed to get platform resource\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	vibrator->base = devm_ioremap(&pdev->dev, res->start,
> > +				     resource_size(res));
> > +	if (IS_ERR(vibrator->base)) {
> 
> devm_ioremap() returns NULL on error. You either need to check for NULL
> or see of you can use devm_ioremap_resource().

I originally tried to use devm_ioremap_resource() but the call to
devm_request_mem_region() would fail. I'll go with the NULL check here
for devm_ioremap().

Thanks for the review!

Brian
