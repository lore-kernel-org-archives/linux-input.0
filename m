From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: st1232 - switch to gpiod API
Date: Fri, 8 Feb 2019 00:05:55 -0800
Message-ID: <20190208080555.GD31622@dtor-ws>
References: <20190129102347.27754-1-martink@posteo.de>
 <20190129102347.27754-2-martink@posteo.de>
 <83a86244-f40b-44b1-d7be-1fcbeb4c359e@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <83a86244-f40b-44b1-d7be-1fcbeb4c359e@ginzinger.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc: Martin Kepplinger <martink@posteo.de>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Martin,

On Tue, Feb 05, 2019 at 11:20:16AM +0100, Martin Kepplinger wrote:
> On 29.01.19 11:23, Martin Kepplinger wrote:
> > From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> > 
> > Use devm_gpiod_get_optional() and gpiod_set_value_cansleep() instead
> > of the old API. The st1232_ts_power() now passes on the inverted "poweron"
> > value to reflect the correct logical value.
> > 
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> > ---
> > 
> > Tested and works. thanks for your help Dmitry,
> > 
> 
> is this what you had in mind? any problems or questions?

Yes, that is what I wanted, with one exception:

> > +	ts->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
> > +						 GPIOD_OUT_HIGH);

This breaks compatibility with old DTSes, please try changing to:

	devm_gpiod_get_optional(&client->dev, NULL, GPIOD_OUT_HIGH);

Thanks.

-- 
Dmitry
