From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 2/2] input: touchscreen mc13xxx: Add mc34708 support
Date: Wed, 11 Apr 2018 09:01:01 -0700
Message-ID: <4690e30b3c4b97847123295f1994c6eafe4e0cbb.camel@perches.com>
References: <20180411141340.30939-1-lukma@denx.de>
         <20180411141340.30939-2-lukma@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180411141340.30939-2-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-input@vger.kernel.org

On Wed, 2018-04-11 at 16:13 +0200, Lukasz Majewski wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The mc34708 has a different bit to enable pen detection. This
> adds the driver data and devtype necessary to probe the device
> and to distinguish between the mc13783 and the mc34708.

style trivia:

> diff --git a/drivers/input/touchscreen/mc13783_ts.c b/drivers/input/touchscreen/mc13783_ts.c
[]
> @@ -96,6 +135,10 @@ static void mc13783_ts_report_sample(struct mc13783_ts_priv *priv)
>  
>  	cr0 = (cr0 + cr1) / 2;
>  
> +	if (priv->drvdata->type == MC13XXX_TYPE_MC34708)
> +		if (cr0 > 4080)
> +			cr0 = 0;

For easy of reading, this multiple if block should either
use braces around the first if like:

	if (foo) {
		if (bar)
			single_statement;
	}

or be written

	if (foo && bar)
		single_statement;

I generally prefer the latter style.
