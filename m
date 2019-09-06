From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input - elan_i2c: remove Lenovo Legion Y7000 PnpID
Date: Fri, 6 Sep 2019 12:09:21 -0700
Message-ID: <20190906190921.GQ187474@dtor-ws>
References: <20190906085948.27470-1-benjamin.tissoires@redhat.com>
 <20190906190334.GP187474@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190906190334.GP187474@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Sep 06, 2019 at 12:03:34PM -0700, Dmitry Torokhov wrote:
> On Fri, Sep 06, 2019 at 10:59:48AM +0200, Benjamin Tissoires wrote:
> > Looks like the Bios of the Lenovo Legion Y7000 is using ELAN061B
> > when the actual device is supposed to be used with hid-multitouch.
> > 
> > Remove it from the list of the supported device, hoping that
> > no one will complain about the loss in functionality.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=203467
> > Fixes: Fixes: 738c06d0e456 ("Input: elan_i2c - add hardware ID for multiple Lenovo laptops")
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> I suppose this one should go to stable?

Gah, I am not very attentive, as you just said it below. Sorry.

> 
> > ---
> > 
> > Note to self: once this gets in, we need to send a similar patch
> > to stable, as there are a few stable branches with this PnpID.
> > 
> > 
> >  include/linux/input/elan-i2c-ids.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/input/elan-i2c-ids.h b/include/linux/input/elan-i2c-ids.h
> > index ceabb01a6a7d..1ecb6b45812c 100644
> > --- a/include/linux/input/elan-i2c-ids.h
> > +++ b/include/linux/input/elan-i2c-ids.h
> > @@ -48,7 +48,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
> >  	{ "ELAN0618", 0 },
> >  	{ "ELAN0619", 0 },
> >  	{ "ELAN061A", 0 },
> > -	{ "ELAN061B", 0 },
> > +/*	{ "ELAN061B", 0 }, not working on the Lenovo Legion Y7000 */
> >  	{ "ELAN061C", 0 },
> >  	{ "ELAN061D", 0 },
> >  	{ "ELAN061E", 0 },
> > -- 
> > 2.21.0
> > 
> 
> -- 
> Dmitry

-- 
Dmitry
