From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 1/3] cap1106: Add support for various cap11xx devices
Date: Sun, 21 Sep 2014 12:53:33 +0200
Message-ID: <541EAE2D.2080700@zonque.org>
References: <1411268469-21283-1-git-send-email-mranostay@gmail.com> <1411268469-21283-2-git-send-email-mranostay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411268469-21283-2-git-send-email-mranostay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>, galak@codeaurora.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On 09/21/2014 05:01 AM, Matt Ranostay wrote:
>  	priv->regmap = devm_regmap_init_i2c(i2c_client, &cap1106_regmap_config);
>  	if (IS_ERR(priv->regmap))
>  		return PTR_ERR(priv->regmap);
>  
> -	error = regmap_read(priv->regmap, CAP1106_REG_PRODUCT_ID, &val);
> -	if (error)
> -		return error;
> -
> -	if (val != CAP1106_PRODUCT_ID) {
> -		dev_err(dev, "Product ID: Got 0x%02x, expected 0x%02x\n",
> -			val, CAP1106_PRODUCT_ID);
> -		return -ENODEV;
> -	}
> -

Btw - the purpose of this code was to detect board configuration
mismatch. After all, I2C lacks a way to properly identify peripherals,
so the more runtime checks we do at probe time, the more of a chance we
have to detect wrong setups. This device is actually well implemented
and tells us something about itself.

Hence, I'd propose to define a structure like this:

struct cap11xx_hw_model {
	uint8_t product_id;
	unsigned int num_channels;
};

... and attach instances of that to the members of cap1106_dt_ids[] and
cap1106_i2c_ids[]. In the probe function, check that the contents of
CAP1106_PRODUCT_ID match what is expected by the configured model.


Thanks,
Daniel
