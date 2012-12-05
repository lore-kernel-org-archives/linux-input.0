From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH 04/14] HID: i2c-hid: fix checkpatch.pl warning
Date: Wed, 5 Dec 2012 10:55:50 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1212051055440.17055@pobox.suse.cz>
References: <1354634875-5182-1-git-send-email-benjamin.tissoires@gmail.com> <1354634875-5182-5-git-send-email-benjamin.tissoires@gmail.com> <20121204224349.2cefa121@endymion.delvare>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121204224349.2cefa121-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 4 Dec 2012, Jean Delvare wrote:

> > We should not initialize to 0 static declarations.
> > 
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/hid/i2c-hid/i2c-hid.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> > index ad771a7..9ee6555 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid.c
> > @@ -46,7 +46,7 @@
> >  #define I2C_HID_PWR_SLEEP	0x01
> >  
> >  /* debug option */
> > -static bool debug = false;
> > +static bool debug;
> >  module_param(debug, bool, 0444);
> >  MODULE_PARM_DESC(debug, "print a lot of debug information");
> >  
> 
> Reviewed-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
