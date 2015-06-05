From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/9] input: goodix: add ACPI IDs for GT911 and GT9271
Date: Fri, 5 Jun 2015 09:41:45 -0700
Message-ID: <20150605164145.GB26708@dtor-ws>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
 <1432817265-23891-5-git-send-email-irina.tirdea@intel.com>
 <1433422260.5346.15.camel@hadess.net>
 <1F3AC3675D538145B1661F571FE1805F19A79DA8@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35630 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbbFEQlu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Jun 2015 12:41:50 -0400
Content-Disposition: inline
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F19A79DA8@irsmsx105.ger.corp.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Tirdea, Irina" <irina.tirdea@intel.com>
Cc: 'Bastien Nocera' <hadess@hadess.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jun 05, 2015 at 04:36:24PM +0000, Tirdea, Irina wrote:
> 
> 
> > -----Original Message-----
> > From: Bastien Nocera [mailto:hadess@hadess.net]
> > Sent: 04 June, 2015 15:51
> > To: Tirdea, Irina
> > Cc: Dmitry Torokhov; linux-input@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 4/9] input: goodix: add ACPI IDs for GT911 and GT9271
> > 
> > On Thu, 2015-05-28 at 15:47 +0300, Irina Tirdea wrote:
> > > Add ACPI IDs to support Goodix GT911 and GT9271
> > > touchscreens.
> > 
> > Those devices are present on which systems which you would have tested
> > this on?
> > 
> 
> I have been using a custom setup by connecting the touchscreen directly
> to a virtual Linux environment through an USB-I2C adapter (https://diolan.com/dln-2).
> So these ACPI IDs do not correspond to any device publicly available.
> However, once in upstream we can use this IDs for our future platforms.

I'd rather wait until they become available then.

Thanks.

> 
> > > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > > ---
> > >  drivers/input/touchscreen/goodix.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/input/touchscreen/goodix.c
> > > b/drivers/input/touchscreen/goodix.c
> > > index 9561396..9e7d215 100644
> > > --- a/drivers/input/touchscreen/goodix.c
> > > +++ b/drivers/input/touchscreen/goodix.c
> > > @@ -392,6 +392,8 @@ static const struct i2c_device_id goodix_ts_id[]
> > > = {
> > >  #ifdef CONFIG_ACPI
> > >  static const struct acpi_device_id goodix_acpi_match[] = {
> > >       { "GDIX1001", 0 },
> > > +     { "GDIX0911", 0 },
> > > +     { "GDIX9271", 0 },
> > >       { }
> > >  };
> > >  MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);

-- 
Dmitry
