From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH 4/4 v2] Input: mms114 - add support for mms152
Date: Fri, 26 Jan 2018 14:14:38 +0900
Message-ID: <20180126051438.GS7575@gangnam.samsung>
References: <20180124193804.155654-1-dmitry.torokhov@gmail.com>
        <20180124193804.155654-5-dmitry.torokhov@gmail.com>
        <20180124200408.GB705@gmail.com>
        <CGME20180124213208epcas5p12b0a71e1013b861b5f7dd9a6060c41ac@epcas5p1.samsung.com>
        <20180124213201.vemutoltuz43hiwr@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:54774 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbeAZFOl (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 26 Jan 2018 00:14:41 -0500
Content-disposition: inline
In-reply-to: <20180124213201.vemutoltuz43hiwr@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>, Simon Shields <simon@lineageos.org>, Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Simon and Dmitry,

On Wed, Jan 24, 2018 at 01:32:01PM -0800, Dmitry Torokhov wrote:
> From: Simon Shields <simon@lineageos.org>
> 
> MMS152 has no configuration registers, but the packet format used in
> interrupts is identical to mms114.
> 
> Signed-off-by: Simon Shields <simon@lineageos.org>
> Patchwork-Id: 10125841
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

also here

Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
Tested-by: Andi Shyti <andi.shyti@samsung.com>

one small nitpick:

> @@ -239,14 +249,33 @@ static int mms114_get_version(struct mms114_data *data)
>  {
>  	struct device *dev = &data->client->dev;
>  	u8 buf[6];
> +	int group;
>  	int error;

do we really need to define a new 'group' variable?

Andi

> -	error = __mms114_read_reg(data, MMS114_TSP_REV, 6, buf);
> -	if (error < 0)
> -		return error;
> +	switch (data->type) {
> +	case TYPE_MMS152:
> +		error = __mms114_read_reg(data, MMS152_FW_REV, 3, buf);
> +		if (error)
> +			return error;
> +
> +		group = i2c_smbus_read_byte_data(data->client,
> +						  MMS152_COMPAT_GROUP);
> +		if (group < 0)
> +			return group;
> +
> +		dev_info(dev, "TSP FW Rev: bootloader 0x%x / core 0x%x / config 0x%x, Compat group: %c\n",
> +			 buf[0], buf[1], buf[2], group);
> +		break;
> +
> +	case TYPE_MMS114:
> +		error = __mms114_read_reg(data, MMS114_TSP_REV, 6, buf);
> +		if (error)
> +			return error;
>  
> -	dev_info(dev, "TSP Rev: 0x%x, HW Rev: 0x%x, Firmware Ver: 0x%x\n",
> -		 buf[0], buf[1], buf[3]);
> +		dev_info(dev, "TSP Rev: 0x%x, HW Rev: 0x%x, Firmware Ver: 0x%x\n",
> +			 buf[0], buf[1], buf[3]);
> +		break;
> +	}
>  
>  	return 0;
>  }
