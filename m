From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hiddev: use IS_ENABLED() for USB_HIDDEV
Date: Fri, 24 Jun 2016 11:01:52 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606241101000.6874@cbobk.fhfr.pm>
References: <alpine.LNX.2.00.1606241027520.6874@cbobk.fhfr.pm> <5023053.7F6zTHqVIR@wuerfel>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5023053.7F6zTHqVIR@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 24 Jun 2016, Arnd Bergmann wrote:

> On Friday, June 24, 2016 10:28:50 AM CEST Jiri Kosina wrote:
> > From: Jiri Kosina <jkosina@suse.cz>
> > 
> > Use IS_ENABLED() for checking USB_HIDDEV to make sure compilation works 
> > for all possible config combinations.
> > 
> > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> > ---
> >  include/linux/hiddev.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/hiddev.h b/include/linux/hiddev.h
> > index a5dd814..b6f48d6 100644
> > --- a/include/linux/hiddev.h
> > +++ b/include/linux/hiddev.h
> > @@ -37,7 +37,7 @@ struct hid_usage;
> >  struct hid_field;
> >  struct hid_report;
> >  
> > -#ifdef CONFIG_USB_HIDDEV
> > +#if IS_ENABLED(CONFIG_USB_HIDDEV)
> >  int hiddev_connect(struct hid_device *hid, unsigned int force);
> >  void hiddev_disconnect(struct hid_device *);
> >  void hiddev_hid_event(struct hid_device *hid, struct hid_field *field,
> > 
> > 
> 
> CONFIG_USB_HIDDEV is a 'bool' option, so the two look completely
> equivalent.
> 
> If we wanted to make USB_HIDDEV a loadable module by itself,
> we'd also need to export those functions and change both the Kconfig
> and Makefile files to ensure that you can't have USB_HIDDEV=m
> in combination with USB_HID=y.
> 
> What problem are you trying to fix specifically?

This mail was by my mistake generated from my private git tree; sorry for 
the noise, feel free to ignore it.

-- 
Jiri Kosina
SUSE Labs
