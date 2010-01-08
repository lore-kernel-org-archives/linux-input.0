From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] hid: Logitech G13 driver 0.0.3
Date: Fri, 8 Jan 2010 09:13:29 -0800
Message-ID: <20100108171329.GA4711@kroah.com>
References: <201001071623.o07GNOB4022157@mustang.cs.nmsu.edu>
 <20100108083020.GB3696@core.coreip.homeip.net>
 <20100108163655.GA8328@elf.ucw.cz>
 <a3581fd32d39b5e86aba9ded88bd5f46.squirrel@intranet.cs.nmsu.edu>
 <20100108170450.GB8328@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753886Ab0AHROP@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100108170450.GB8328@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, felipe.balbi@nokia.com, jayakumar.lkml@gmail.com, linux-fbdev@vger.kernel.org, krzysztof.h1@wp.pl, akpm@linux-foundation.org, linux-usb@vger.kernel.org, oliver@neukum.org, linux-input@vger.kernel.org, jkosina@suse.cz
List-Id: linux-input@vger.kernel.org

On Fri, Jan 08, 2010 at 06:04:50PM +0100, Pavel Machek wrote:
> On Fri 2010-01-08 09:50:33, Rick L. Vinyard, Jr. wrote:
> > Pavel Machek wrote:
> > > Hi!
> > >
> > >> > +static DEVICE_ATTR(name, 0666, g13_name_show, g13_name_store);
> > >>
> > >> What this attribute is for?
> > >
> > > Actually, all the new files this added need to be documented.
> > 
> > Which is better? A hid-g13.txt file added to Documentation/ or comments in
> > the driver itself?
> 
> Documentation. Coordinate with sysfs maintainer (gregkh).

All sysfs files need to be documented in Documentation/ABI/  Please add
the documentation there for your new sysfs files.

thanks,

greg k-h
