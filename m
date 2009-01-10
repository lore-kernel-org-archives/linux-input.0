From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.28-rc9: USB Mouse unhappy
Date: Sat, 10 Jan 2009 01:19:27 +0100
Message-ID: <200901100119.28198.rjw@sisk.pl>
References: <f7848160812201911k7988221asd095ce873fd8105f@mail.gmail.com> <200901100011.35332.rjw@sisk.pl> <alpine.LNX.1.10.0901100014450.5377@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760498AbZAJAUf@vger.kernel.org>
In-Reply-To: <alpine.LNX.1.10.0901100014450.5377@jikos.suse.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Parag Warudkar <parag.lkml@gmail.com>, Anssi Hannula <anssi.hannula@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Saturday 10 January 2009, Jiri Kosina wrote:
> On Sat, 10 Jan 2009, Rafael J. Wysocki wrote:
> 
> > > >   usbmouse on 2.6.28-rc with the exact same mouse? (either check 
> > > >   /sys/bus/usb/devices or even lsusb shouldn't ideally show usbmouse 
> > > >   loaded at all)
> > > Sorry for the above typo, 'lsusb' should of course be 'lsmod' here.
> > Can you tell me what the status of this issue is, please?
> 
> Parag was using incorrect driver -- usbmouse -- (which is intended to be 
> used only under very special circumstances) instead of standard HID 
> driver.
> 
> Kconfig help text clearly states how special the usbmouse driver is, but 
> many people still try to use it, probably because of its name. Therefore 
> we now have
> 
> Author: Parag Warudkar <parag.lkml@gmail.com>
> Date:   Mon Dec 22 22:50:52 2008 +0100
> 
>     HID: make boot protocol drivers depend on EMBEDDED
> 
> which is already in Linus tree and which makes the possibility of chosing 
> this special driver dependent on CONFIG_EMBEDDED.

OK, thanks!

Rafael
