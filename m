From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH 2/4] Input: pmic8xxx-keypad - use regmap_field for
 register access
Date: Wed, 08 Oct 2014 12:13:04 +0300
Message-ID: <1412759584.13569.0.camel@iivanov-dev>
References: <1412675448-11990-1-git-send-email-iivanov@mm-sol.com>
	 <1412675448-11990-3-git-send-email-iivanov@mm-sol.com>
	 <20141007172606.GG16469@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20141007172606.GG16469@dtor-ws>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 2014-10-07 at 10:26 -0700, Dmitry Torokhov wrote:
> Hi Ivan,
> 
> On Tue, Oct 07, 2014 at 12:50:46PM +0300, Ivan T. Ivanov wrote:
> > @@ -527,10 +538,55 @@ static int pmic8xxx_kp_probe(struct platform_device *pdev)
> >  

> > +
> > +	kp->row_hold = devm_regmap_field_alloc(kp->dev, kp->regmap,
> > +					       info->row_hold);
> > +	if (IS_ERR(kp->row_hold))
> > +		return PTR_ERR(kp->row_hold);
> 
> Why do we have to allocate all regmap fields separately instead of
> embedding them into keypad structure?
> 

No particular reason. Will rework it.

Thank you,
Ivan

> Thanks.
> 
