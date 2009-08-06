From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/2] input: Add support for filtering input events
Date: Thu, 6 Aug 2009 09:49:10 -0300
Message-ID: <20090806124910.GA15867@khazad-dum.debian.net>
References: <1249007207-27392-1-git-send-email-mjg@redhat.com>
 <20090803170453.F0DF9526EA5@mailhub.coreip.homeip.net>
 <20090804100158.GA14530@srcf.ucam.org>
 <20090805044923.6AE71526EA5@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090805044923.6AE71526EA5@mailhub.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 04 Aug 2009, Dmitry Torokhov wrote:
> On Tue, Aug 04, 2009 at 11:01:58AM +0100, Matthew Garrett wrote:
> > On Mon, Aug 03, 2009 at 10:04:51AM -0700, Dmitry Torokhov wrote:
> > > I don't think this is the proper layer to do the filtering, the filter
> > > should be done in i8042, not input core. The way you done it would kill
> > > any possibility of user assigning KEY_WLAN to a spare key on his or her
> > > keyboard and using it to control wireless cards that are not hardwired.
> > 
> > Ok, that seems fine.
> > 
> > > I would accept the patch that would add a filter in the form
> > > 
> > > 	bool (*i8042_fillter)(unsigned char data, unsigned int flags,
> > > 			struct serio *port);
> > > 
> > > I don't think we'd need to chain them into a list or something, one hook
> > > should be enough since I don't expect we'll have several platform
> > > drivers loaded on one box.
> > 
> > So filter on the raw i8042 data rather than after any processing? 
> > Wouldn't this require some level of state machine in the driver using 
> > this functionality?
> 
> Yes, but it should not be too complex - with laptops you can be pretty
> much sure keyboard is in translated set 2 mode.

But don't we have a crapload of implementation weirdness work-arounds in the
i8042 drivers, including some for problems with the raw protocol itself?  We
wouldn't want to duplicate THAT...  will the filter be placed somewhere that
doesn't have to deal with that kind of bogosity?

With laptops, you can be sure that 99% of the time, the i8042 is just
firmware running inside the EC, and subject to a LOT MORE bugs and
incompetence than an emulated i8042 inside the chipset would be...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
