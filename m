From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 08/14] HID: i2c-hid: fix error messages
Date: Wed, 5 Dec 2012 11:07:38 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1212051107290.17055@pobox.suse.cz>
References: <1354634875-5182-1-git-send-email-benjamin.tissoires@gmail.com> <1354634875-5182-9-git-send-email-benjamin.tissoires@gmail.com> <20121205105158.666a19a8@endymion.delvare>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121205105158.666a19a8-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 5 Dec 2012, Jean Delvare wrote:

> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/hid/i2c-hid/i2c-hid.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> > index d6fdb3e..da04948 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid.c
> > @@ -741,10 +741,10 @@ static int __devinit i2c_hid_init_irq(struct i2c_client *client)
> >  			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> >  			client->name, ihid);
> >  	if (ret < 0) {
> > -		dev_dbg(&client->dev,
> > +		dev_warn(&client->dev,
> >  			"Could not register for %s interrupt, irq = %d,"
> >  			" ret = %d\n",
> > -		client->name, client->irq, ret);
> > +			client->name, client->irq, ret);
> >  
> >  		return ret;
> >  	}
> > @@ -770,7 +770,8 @@ static int __devinit i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
> >  			__func__, 4, ihid->hdesc_buffer);
> >  
> >  	if (ret) {
> > -		dev_err(&client->dev, "HID_DESCR_LENGTH_CMD Fail (ret=%d)\n",
> > +		dev_err(&client->dev,
> > +			"unable to fetch the size of HID descriptor (ret=%d)\n",
> >  			ret);
> >  		return -ENODEV;
> >  	}
> > @@ -785,7 +786,7 @@ static int __devinit i2c_hid_fetch_hid_descriptor(struct i2c_hid *ihid)
> >  	/* check bcdVersion == 1.0 */
> >  	if (le16_to_cpu(hdesc->bcdVersion) != 0x0100) {
> >  		dev_err(&client->dev,
> > -			"unexpected HID descriptor bcdVersion (0x%04x)\n",
> > +			"unexpected HID descriptor bcdVersion (0x%04hx)\n",
> >  			le16_to_cpu(hdesc->bcdVersion));
> >  		return -ENODEV;
> >  	}
> > @@ -871,7 +872,7 @@ static int __devinit i2c_hid_probe(struct i2c_client *client,
> >  	hid->vendor = le16_to_cpu(ihid->hdesc.wVendorID);
> >  	hid->product = le16_to_cpu(ihid->hdesc.wProductID);
> >  
> > -	snprintf(hid->name, sizeof(hid->name), "%s %04X:%04X",
> > +	snprintf(hid->name, sizeof(hid->name), "%s %04hX:%04hX",
> >  		 client->name, hid->vendor, hid->product);
> >  
> >  	ret = hid_add_device(hid);
> 
> Reviewed-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

Applied.

-- 
Jiri Kosina
SUSE Labs
