From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] Input: mms114 - add support for mms152
Date: Wed, 24 Jan 2018 13:27:34 -0800
Message-ID: <20180124212734.qeud4pv2i6jqjb34@dtor-ws>
References: <20180124193804.155654-1-dmitry.torokhov@gmail.com>
 <20180124193804.155654-5-dmitry.torokhov@gmail.com>
 <20180124200408.GB705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34534 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932238AbeAXV1i (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 24 Jan 2018 16:27:38 -0500
Content-Disposition: inline
In-Reply-To: <20180124200408.GB705@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Simon Shields <simon@lineageos.org>, Andi Shyti <andi.shyti@samsung.com>, Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 24, 2018 at 09:04:08PM +0100, Marcus Folkesson wrote:
> Hello Dmitry,
> 
> On Wed, Jan 24, 2018 at 11:38:04AM -0800, Dmitry Torokhov wrote:
> > From: Simon Shields <simon@lineageos.org>
> > 
> > @@ -241,12 +251,28 @@ static int mms114_get_version(struct mms114_data *data)
> >  	u8 buf[6];
> >  	int error;
> >  
> > -	error = __mms114_read_reg(data, MMS114_TSP_REV, 6, buf);
> > -	if (error < 0)
> > -		return error;
> > +	switch (data->type) {
> > +	case TYPE_MMS152:
> > +		error = __mms114_read_reg(data, MMS152_FW_REV, 3, buf);
> > +		if (error)
> > +			return error;
> > +		buf[3] = i2c_smbus_read_byte_data(data->client,
> > +						  MMS152_COMPAT_GROUP);
> > +		if (buf[3] < 0)
> > +			return buf[3];
> 
> buf is unsigned.
> 
> Maybe
> 		error = i2c_smbus_read_byte_data(data->client,
> 						  MMS152_COMPAT_GROUP);
> 		if (error < 0)
> 			return error;
> Instead?

Good catch. I think I'd rather have a separate variable "group" for
this.

Thank you.

> 
> 
> > +		dev_info(dev, "TSP FW Rev: bootloader 0x%x / core 0x%x / config 0x%x, Compat group: %c\n",
> > +			 buf[0], buf[1], buf[2], buf[3]);
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
> 
> 
> Best regards
> Marcus Folkesson



-- 
Dmitry
