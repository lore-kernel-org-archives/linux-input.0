From: Andi Shyti <andi@etezian.org>
Subject: Re: [PATCH 3/3] Input: mms114 - add support for mms345l
Date: Tue, 8 Oct 2019 14:35:11 +0300
Message-ID: <20191008113511.GA4015@jack.zhora.eu>
References: <20191007203343.101466-1-stephan@gerhold.net>
 <20191007205021.104402-1-stephan@gerhold.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191007205021.104402-1-stephan@gerhold.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andi Shyti <andi@etezian.org>, Simon Shields <simon@lineageos.org>, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Stephan,

On Mon, Oct 07, 2019 at 10:50:21PM +0200, Stephan Gerhold wrote:
> MMS345L is another first generation touch screen from Melfas,
> which uses the same registers as MMS152.
> 
> However, using I2C_M_NOSTART for it causes errors when reading:
> 
> 	i2c i2c-0: sendbytes: NAK bailout.
> 	mms114 0-0048: __mms114_read_reg: i2c transfer failed (-5)
> 
> The driver works fine as soon as I2C_M_NOSTART is removed.
> 
> Add a separate melfas,mms345l binding, and make use of I2C_M_NOSTART
> only for MMS114 and MMS152.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Reviewed-by: Andi Shyti <andi@etezian.org>

just a nitpick in case you will resend it (but you don't need
to).

> -	if (!i2c_check_functionality(client->adapter,
> -				I2C_FUNC_PROTOCOL_MANGLING)) {
> +	type = (enum mms_type)device_get_match_data(&client->dev);

you don't need any cast here.

Thanks,
Andi
