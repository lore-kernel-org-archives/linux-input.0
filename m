From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: joystick:   Adding Austria Microsystem AS5011
 joystick driver (second version)
Date: Sat, 1 Jan 2011 23:58:53 -0800
Message-ID: <20110102075852.GB5429@core.coreip.homeip.net>
References: <4D1C60F1.5090305@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D1C60F1.5090305@armadeus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Marteau <fabien.marteau@armadeus.com>
Cc: Scott Moreau <oreaus@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Dec 30, 2010 at 11:37:37AM +0100, Fabien Marteau wrote:
> +
> +	plat_dat->input_dev->name = "Austria Microsystem as5011 joystick";
> +	plat_dat->input_dev->uniq = "Austria0";

This is improper value for 'uniq' which has to be globally unique
identifier (across systems). like a serial number.

> +	plat_dat->input_dev->id.bustype = BUS_I2C;
> +	plat_dat->input_dev->phys = NULL;

No need to set this to NULL.

> +	plat_dat->input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> +	plat_dat->input_dev->keybit[BIT_WORD(BTN_JOYSTICK)] =
> +					BIT_MASK(BTN_JOYSTICK);

__set_bit() is shorter and generally safer (no chance of writing to
wrong longword).

-- 
Dmitry
