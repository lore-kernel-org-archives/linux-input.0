From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: yet another buggy ELAN touchscreen
Date: Wed, 19 Nov 2014 17:39:00 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1411191738500.4454@pobox.suse.cz>
References: <1416240702-28988-1-git-send-email-oneukum@suse.de> <alpine.LNX.2.00.1411191551160.4454@pobox.suse.cz> <20141119163324.GA2418@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20141119163324.GA2418@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oliver Neukum <oneukum@suse.de>, linux-input@vger.kernel.org, stable@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 19 Nov 2014, Greg Kroah-Hartman wrote:

> > On Mon, 17 Nov 2014, Oliver Neukum wrote:
> > 
> > > The touchscreen needs the same quirk as the other models.
> > > 
> > > Signed-off-by: Oliver Neukum <oneukum@suse.de>
> > > Reported-by: Bryan Poling <poli0048@umn.edu>
> > > CC: stable@vger.kernel.org
> > > ---
> > >  drivers/hid/hid-ids.h           | 1 +
> > >  drivers/hid/usbhid/hid-quirks.c | 1 +
> > >  drivers/usb/core/quirks.c       | 3 +++
> > 
> > Greg, are you OK with me taking the whole lot through hid.git in one 
> > commit? (USB quirks and HID quirks for Elan devices have been merged 
> > independently for previous 3 devices, but I don't think it's worth the 
> > hassle splitting it).
> 
> Yes, no objection from me:
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks, now applied.

-- 
Jiri Kosina
SUSE Labs
