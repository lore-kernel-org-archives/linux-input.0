From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - check if device is there before really
 probing
Date: Mon, 8 May 2017 15:47:04 -0700
Message-ID: <20170508224704.GC31381@dtor-ws>
References: <20170504062938.GA30771@dtor-ws>
 <bfb8af3c-c338-5942-ab61-31cf298aa410@roeck-us.net>
 <20170508211031.GA31381@dtor-ws>
 <20170508214425.GA27206@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33147 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdEHWrI (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 8 May 2017 18:47:08 -0400
Content-Disposition: inline
In-Reply-To: <20170508214425.GA27206@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-input@vger.kernel.org, KT Liao <ktalex.liao@gmail.com>, linux-kernel@vger.kernel.org

On Mon, May 08, 2017 at 02:44:25PM -0700, Guenter Roeck wrote:
> On Mon, May 08, 2017 at 02:10:31PM -0700, Dmitry Torokhov wrote:
> > On Wed, May 03, 2017 at 11:42:54PM -0700, Guenter Roeck wrote:
> > > On 05/03/2017 11:29 PM, Dmitry Torokhov wrote:
> > > >Before trying to properly initialize the touchpad and generate bunch of
> > > >errors, let's first see it there is anything at the given address. If we
> > > >get error, fail silently with -ENXIO.
> > > >
> > > >Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > >---
> > > > drivers/input/mouse/elan_i2c_core.c | 9 +++++++++
> > > > 1 file changed, 9 insertions(+)
> > > >
> > > >diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> > > >index 5d3b53dd2fa2..0479730e7c5c 100644
> > > >--- a/drivers/input/mouse/elan_i2c_core.c
> > > >+++ b/drivers/input/mouse/elan_i2c_core.c
> > > >@@ -1040,6 +1040,7 @@ static int elan_probe(struct i2c_client *client,
> > > > 	const struct elan_transport_ops *transport_ops;
> > > > 	struct device *dev = &client->dev;
> > > > 	struct elan_tp_data *data;
> > > >+	union i2c_smbus_data dummy;
> > > > 	unsigned long irqflags;
> > > > 	int error;
> > > >
> > > >@@ -1091,6 +1092,14 @@ static int elan_probe(struct i2c_client *client,
> > > > 		return error;
> > > > 	}
> > > >
> > > >+	/* Make sure there is something at this address */
> > > >+	error = i2c_smbus_xfer(client->adapter, client->addr, 0,
> > > >+			       I2C_SMBUS_READ, 0, I2C_SMBUS_BYTE, &dummy);
> > > 
> > > Can't you just call i2c_smbus_read_byte_data(client, 0); and check if it returns
> > > an error ?
> > 
> > Are we guaranteed to get a result from command "0"? I am not sure, and
> > looking at least at i2c_smbus_xfer_emulated() I2C_SMBUS_READ with
> > I2C_SMBUS_BYTE modifier works differently form
> > I2C_SMBUS_READ/I2C_SMBUS_BYTE_DATA (the former uses a single i2c message
> > vs 2 for the latter).
> > 
> > Also the form above is what i2c core uses to do detection when adapter
> > does not implement I2C_SMBUS_QUICK, so I'd rather leave it as it was.
> > 
> 
> How about i2c_smbus_read_byte() ?
> 
> 	status = i2c_smbus_xfer(client->adapter, client->addr, client->flags,
> 	                        I2C_SMBUS_READ, 0,
> 				I2C_SMBUS_BYTE, &data);
> 	return (status < 0) ? status : data.byte;

Yeah, I think this will work.

Thanks.

-- 
Dmitry
