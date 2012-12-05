From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 06/14] HID: i2c-hid: remove unused static declarations
Date: Wed, 5 Dec 2012 11:03:44 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1212051103360.17055@pobox.suse.cz>
References: <1354634875-5182-1-git-send-email-benjamin.tissoires@gmail.com> <1354634875-5182-7-git-send-email-benjamin.tissoires@gmail.com> <20121204225132.2b7b6f6f@endymion.delvare>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121204225132.2b7b6f6f-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 4 Dec 2012, Jean Delvare wrote:

> > These definitions are not used here, but are defined by the specification.
> > Keeping some of them for documentation purposes.
> > 
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/hid/i2c-hid/i2c-hid.c | 25 ++++++++++---------------
> >  1 file changed, 10 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> > index 54950be..4452611 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid.c
> > @@ -106,22 +106,17 @@ static const struct i2c_hid_cmd hid_reset_cmd =		{ I2C_HID_CMD(0x01),
> >  							  .wait = true };
> >  static const struct i2c_hid_cmd hid_get_report_cmd =	{ I2C_HID_CMD(0x02) };
> >  static const struct i2c_hid_cmd hid_set_report_cmd =	{ I2C_HID_CMD(0x03) };
> > -static const struct i2c_hid_cmd hid_get_idle_cmd =	{ I2C_HID_CMD(0x04) };
> > -static const struct i2c_hid_cmd hid_set_idle_cmd =	{ I2C_HID_CMD(0x05) };
> > -static const struct i2c_hid_cmd hid_get_protocol_cmd =	{ I2C_HID_CMD(0x06) };
> > -static const struct i2c_hid_cmd hid_set_protocol_cmd =	{ I2C_HID_CMD(0x07) };
> >  static const struct i2c_hid_cmd hid_set_power_cmd =	{ I2C_HID_CMD(0x08) };
> > -/* read/write data register */
> > -static const struct i2c_hid_cmd hid_data_cmd = {
> > -		.registerIndex = offsetof(struct i2c_hid_desc, wDataRegister),
> > -		.opcode = 0x00,
> > -		.length = 2 };
> > -/* write output reports */
> > -static const struct i2c_hid_cmd hid_out_cmd = {
> > -		.registerIndex = offsetof(struct i2c_hid_desc,
> > -			wOutputRegister),
> > -		.opcode = 0x00,
> > -		.length = 2 };
> > +
> > +/*
> > + * These definitions are not used here, but are defined by the spec.
> > + * Keeping them here for documentation purposes.
> > + *
> > + * static const struct i2c_hid_cmd hid_get_idle_cmd = { I2C_HID_CMD(0x04) };
> > + * static const struct i2c_hid_cmd hid_set_idle_cmd = { I2C_HID_CMD(0x05) };
> > + * static const struct i2c_hid_cmd hid_get_protocol_cmd = { I2C_HID_CMD(0x06) };
> > + * static const struct i2c_hid_cmd hid_set_protocol_cmd = { I2C_HID_CMD(0x07) };
> > + */
> >  
> >  /* The main device structure */
> >  struct i2c_hid {
> 
> Reviewed-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

Applied.

-- 
Jiri Kosina
SUSE Labs
