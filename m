From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 2/2] input: gt801_2plus1 - Add initial support for
 Goodix GT801 2+1
Date: Tue, 08 Dec 2015 13:14:58 +0100
Message-ID: <1449576898.28364.16.camel@hadess.net>
References: <1449473161-3535-1-git-send-email-plaes@plaes.org>
	 <1449473161-3535-3-git-send-email-plaes@plaes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449473161-3535-3-git-send-email-plaes@plaes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Priit Laes <plaes@plaes.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Aleksei Mamlin <mamlinav@gmail.com>, linux-sunxi@googlegroups.com
List-Id: linux-input@vger.kernel.org

Hey Priit,

On Mon, 2015-12-07 at 09:26 +0200, Priit Laes wrote:
> This patch adds Goodix GT801 2+1 touchscreen controller support.
> 
> GT801 2+1 is a 10-finger touch controller consisting of
> ARM controller interfacing two GT801 5-finger controllers.

This would implement support for the "Guitar" protocol used by a few
more variants of the GT80x devices. Can you rename the driver/docs to that effect?
<snip>
> +
> +static const struct i2c_device_id gt801x_ts_id[] = {
> +	{ "GDIX1001:00", 0 },

This clashes with the ID used in the goodix.c driver.

Cheers
