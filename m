From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Add MacBookAir4,1 keyboard support
Date: Fri, 16 Sep 2011 19:20:26 +0100
Message-ID: <1316197227.10576.9.camel@novo.hadess.net>
References: <20110907201552.GA1962@Caligula>
	 <1316189156.10576.6.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:44378 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285Ab1IPSUa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Sep 2011 14:20:30 -0400
In-Reply-To: <1316189156.10576.6.camel@novo.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pieter-Augustijn Van Malleghem <p-a@scarlet.be>
Cc: linux-input@vger.kernel.org

On Fri, 2011-09-16 at 17:05 +0100, Bastien Nocera wrote:
> On Wed, 2011-09-07 at 16:15 -0400, Pieter-Augustijn Van Malleghem wrote:
> > This patch adds support for the Apple MacBookAir4,1 released in July 
> > 2011. It was inspired by Joshua Dillon's patch for the MacBookAir4,2
> > posted on http://www.almostsure.com/mba42/hid-apple-dkms.patch.
> 
> > Signed-off-by: Pieter-Augustijn Van Malleghem <p-a@scarlet.be>
> > diff -uNr linux/drivers/hid/hid-apple.c patched/drivers/hid/hid-apple.c
> > --- linux/drivers/hid/hid-apple.c	2011-09-06 23:41:58.000000000 -0400
> > +++ patched/drivers/hid/hid-apple.c	2011-09-06 23:53:05.000000000 -0400
> > @@ -183,6 +183,9 @@
> >  		if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING4_ANSI &&
> >  				hid->product <= USB_DEVICE_ID_APPLE_WELLSPRING4A_JIS)
> >  			table = macbookair_fn_keys;
> > +		else if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING6A_ANSI &&
> > +				hid->product <= USB_DEVICE_ID_APPLE_WELLSPRING6A_JIS)
> > +			table = macbookair_fn_keys;
> >  		else if (hid->product < 0x21d || hid->product >= 0x300)
> >  			table = powerbook_fn_keys;
> >  		else
> 
> This is broken, the macbookair_fn_keys above are for earlier revisions
> of the MacBook Air. MacBookAir4,1 and 4,1 don't have an eject button
> anymore, so should use the apple_fn_keys[] translation table.

Works with this patch applied on top of yours:
@@ -59,7 +59,7 @@ diff -uNr linux/drivers/hid/hid-apple.c patched/drivers/hid/hid-apple.c
                        table = macbookair_fn_keys;
 +              else if (hid->product >= USB_DEVICE_ID_APPLE_WELLSPRING6A_ANSI &&
 +                              hid->product <= USB_DEVICE_ID_APPLE_WELLSPRING6A_JIS)
-+                      table = macbookair_fn_keys;
++                      table = apple_fn_keys;
                else if (hid->product < 0x21d || hid->product >= 0x300)
                        table = powerbook_fn_keys;
                else

Tested-by: Bastien Nocera <hadess@hadess.net>

