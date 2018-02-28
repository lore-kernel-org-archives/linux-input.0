From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC 2/4] mfd: add Gateworks System Controller core driver
Date: Wed, 28 Feb 2018 19:53:02 +0100
Message-ID: <20180228185302.GD1203@lunn.ch>
References: <1519780874-8558-1-git-send-email-tharvey@gateworks.com>
 <1519780874-8558-3-git-send-email-tharvey@gateworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1519780874-8558-3-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Harvey <tharvey@gateworks.com>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> +		dev_err(&client->dev, ">> 0x%02x %d\n", reg, ret);
> +		return ret;
> +	}
> +	dev_dbg(&client->dev, ">> 0x%02x=0x%02x (%d)\n", reg, val, retry);
> +
> +        return 0;

Hi Tim

There appears to be a few spaces vs tabs issues in this file.

      Andrew
 
