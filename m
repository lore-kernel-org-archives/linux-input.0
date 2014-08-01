From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: Re: [PATCH] input: Add ROHM BU21023/24 Dual touch support resistive
 touchscreens
Date: Fri, 1 Aug 2014 14:31:49 +0900
Message-ID: <20140801143149.954eb82a0835144f6eddf0e6@linux-mips.org>
References: <20140731195434.d141b39f3920686485c64191@linux-mips.org>
	<53DA2E82.1040704@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mo-sg1501.iij4u.or.jp ([210.130.239.6]:56461 "EHLO
	mo-sg.iij4u.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbaHAFcG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Aug 2014 01:32:06 -0400
In-Reply-To: <53DA2E82.1040704@smartplayin.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pramod Gurav <pramod.gurav@smartplayin.com>
Cc: yuasa@linux-mips.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi Pramod,

Thank you for your comments.

On Thu, 31 Jul 2014 17:24:42 +0530
Pramod Gurav <pramod.gurav@smartplayin.com> wrote:

> Hi Yoichi,
> 
> On Thursday 31 July 2014 04:24 PM, Yoichi Yuasa wrote:
> > Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> > ---
> >  drivers/input/touchscreen/Kconfig        |   11 +
> >  drivers/input/touchscreen/Makefile       |    1 +
> >  drivers/input/touchscreen/rohm_bu21023.c |  791 ++++++++++++++++++++++++++++++
> >  drivers/input/touchscreen/rohm_bu21023.h |  255 ++++++++++
> >  4 files changed, 1058 insertions(+)
> 
[snip]
> > +static inline int rohm_i2c_burst_read(struct i2c_adapter *adap,
> > +				      struct i2c_msg *msgs, int num)
> > +{
> > +	int ret, i;
> > +
> > +	if (!adap->algo->master_xfer) {
> > +		dev_dbg(&adap->dev, "I2C level transfers not supported\n");
> Should it be dev_err?

Yes it is.

> > +static int rohm_bu21023_i2c_probe(struct i2c_client *client,
> > +				  const struct i2c_device_id *id)
> > +{
> > +	struct rohm_ts_data *ts;
> > +	struct device *dev = &client->dev;
> > +	struct input_dev *input_dev;
> > +	int ret;
> > +
> > +	ts = kzalloc(sizeof(struct rohm_ts_data), GFP_KERNEL);
> Can you please move to managed resources? devm_kzalloc in this case?

I'll move these to managed resources.

> > +
> > +MODULE_DESCRIPTION("ROHM BU21023/24 Touchscreen driver");
> > +MODULE_LICENSE("GPL");
> Make it GPL v2.
> MODULE_AUTHOR missing.

I'll try to contact the original author.

Thanks,

Yoichi
