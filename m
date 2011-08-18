From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH BlueZ 3/4] Link to udev only when needed
Date: Thu, 18 Aug 2011 16:18:57 -0700
Message-ID: <1313709545.3373.196.camel@aeonflux>
References: <1312553358-26280-1-git-send-email-ospite@studenti.unina.it>
	 <1312553358-26280-4-git-send-email-ospite@studenti.unina.it>
	 <20110818124438.40e3e125c8de872e1320f511@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:40211 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab1HRXT1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Aug 2011 19:19:27 -0400
In-Reply-To: <20110818124438.40e3e125c8de872e1320f511@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>, Mikko Virkkila <virkkila@kapsi.fi>, Simon Wood <simon@mungewell.org>, Arc Riley <arcriley@gmail.com>

Hi Antonio,

> 
> > Don't link bluetoothd to udev unconditionally, but only when it is
> > needed. For now bluetoothd needs to be linked to udev only when the
> > sixaxis plugin is enabled.
> 
> Any comment on this change? If it looks OK I'll fold it in v5.
> 
> Thanks,
>    Antonio
> 
> > ---
> >  Makefile.am |    6 +++++-
> >  1 files changed, 5 insertions(+), 1 deletions(-)
> > 
> > diff --git a/Makefile.am b/Makefile.am
> > index dbe0170..219ca0f 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -288,7 +288,11 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
> >  			src/event.h src/event.c \
> >  			src/oob.h src/oob.c src/eir.h src/eir.c
> >  src_bluetoothd_LDADD = lib/libbluetooth.la @GLIB_LIBS@ @DBUS_LIBS@ \
> > -							@CAPNG_LIBS@ @UDEV_LIBS@ -ldl -lrt
> > +							@CAPNG_LIBS@ -ldl -lrt
> > +if SIXAXISPLUGIN
> > +src_bluetoothd_LDADD += @UDEV_LIBS@
> > +endif
> > +
> >  src_bluetoothd_LDFLAGS = -Wl,--export-dynamic \
> >  				-Wl,--version-script=$(srcdir)/src/bluetooth.ver

I rather have the Sixaxis plugin being an external plugin only then. So
you are not allowed to make this builtin.

Regards

Marcel


