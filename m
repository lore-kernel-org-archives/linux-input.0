From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4 v2] Input: mms114 - add support for mms152
Date: Fri, 26 Jan 2018 11:25:49 -0800
Message-ID: <20180126192549.g3kwn7amb7bkndgg@dtor-ws>
References: <20180124193804.155654-1-dmitry.torokhov@gmail.com>
 <20180124193804.155654-5-dmitry.torokhov@gmail.com>
 <20180124200408.GB705@gmail.com>
 <CGME20180124213208epcas5p12b0a71e1013b861b5f7dd9a6060c41ac@epcas5p1.samsung.com>
 <20180124213201.vemutoltuz43hiwr@dtor-ws>
 <20180126051438.GS7575@gangnam.samsung>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:35000 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753111AbeAZTZx (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 26 Jan 2018 14:25:53 -0500
Content-Disposition: inline
In-Reply-To: <20180126051438.GS7575@gangnam.samsung>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>, Simon Shields <simon@lineageos.org>, Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 26, 2018 at 02:14:38PM +0900, Andi Shyti wrote:
> Hi Simon and Dmitry,
> 
> On Wed, Jan 24, 2018 at 01:32:01PM -0800, Dmitry Torokhov wrote:
> > From: Simon Shields <simon@lineageos.org>
> > 
> > MMS152 has no configuration registers, but the packet format used in
> > interrupts is identical to mms114.
> > 
> > Signed-off-by: Simon Shields <simon@lineageos.org>
> > Patchwork-Id: 10125841
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> also here
> 
> Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
> Tested-by: Andi Shyti <andi.shyti@samsung.com>
> 
> one small nitpick:
> 
> > @@ -239,14 +249,33 @@ static int mms114_get_version(struct mms114_data *data)
> >  {
> >  	struct device *dev = &data->client->dev;
> >  	u8 buf[6];
> > +	int group;
> >  	int error;
> 
> do we really need to define a new 'group' variable?

I like it, that's why I added it ;)

As Marcus mentioned, we cant use 'buf' to store the value as buf is
unsigned and i2c_smbus_read_byte_data() may return negative error code.
And I do not want to use 'error' variable because logically we are
trying to get group value, not error. Hence a dedicated variable. It's
gonna be optimized away anyway.

Thanks.

> 
> Andi
> 
> > -	error = __mms114_read_reg(data, MMS114_TSP_REV, 6, buf);
> > -	if (error < 0)
> > -		return error;
> > +	switch (data->type) {
> > +	case TYPE_MMS152:
> > +		error = __mms114_read_reg(data, MMS152_FW_REV, 3, buf);
> > +		if (error)
> > +			return error;
> > +
> > +		group = i2c_smbus_read_byte_data(data->client,
> > +						  MMS152_COMPAT_GROUP);
> > +		if (group < 0)
> > +			return group;
> > +
> > +		dev_info(dev, "TSP FW Rev: bootloader 0x%x / core 0x%x / config 0x%x, Compat group: %c\n",
> > +			 buf[0], buf[1], buf[2], group);
> > +		break;
> > +
> > +	case TYPE_MMS114:
> > +		error = __mms114_read_reg(data, MMS114_TSP_REV, 6, buf);
> > +		if (error)
> > +			return error;
> >  
> > -	dev_info(dev, "TSP Rev: 0x%x, HW Rev: 0x%x, Firmware Ver: 0x%x\n",
> > -		 buf[0], buf[1], buf[3]);
> > +		dev_info(dev, "TSP Rev: 0x%x, HW Rev: 0x%x, Firmware Ver: 0x%x\n",
> > +			 buf[0], buf[1], buf[3]);
> > +		break;
> > +	}
> >  
> >  	return 0;
> >  }

-- 
Dmitry
