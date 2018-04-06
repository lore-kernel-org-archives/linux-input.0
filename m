From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 07/10] input: touchscreen: touch_adc: add generic
 resistive ADC touchscreen
Date: Fri, 6 Apr 2018 16:13:22 +0100
Message-ID: <20180406161322.00006190@huawei.com>
References: <1522153963-1121-1-git-send-email-eugen.hristev@microchip.com>
        <1522153963-1121-8-git-send-email-eugen.hristev@microchip.com>
        <20180330135835.6a8f57f1@archlinux>
        <20180330180911.GA143703@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180330180911.GA143703@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Eugen Hristev <eugen.hristev@microchip.com>, ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, nicolas.ferre@microchip.com
List-Id: linux-input@vger.kernel.org

> > > +
> > > +	input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> > > +	input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
> > > +
> > > +	st->input = input;
> > > +	input_set_drvdata(input, st);
> > > +
> > > +	ret = input_register_device(input);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to register input device.");
> > > +		return ret;
> > > +	}
> > > +
> > > +	st->iio_cb = iio_channel_get_all_cb(&pdev->dev, grts_cb, st);  
> 
> Hmm, we don't have devm-variant for this? Then you could use
> devm_add_action_or_reset() to add cleanup action and completely remove
> grts_remove().
Not yet, but I'm not adverse to having one...
