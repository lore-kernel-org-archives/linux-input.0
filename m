From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Linux-usb-users] reset low speed USB device using uhci_hcd
 (fwd)
Date: Fri, 16 Mar 2007 11:10:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0703161109130.6067-100000@iolanthe.rowland.org>
References: <45FAA976.5050307@rootdir.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <45FAA976.5050307@rootdir.de>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Claas Langbehn <claas@rootdir.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

On Fri, 16 Mar 2007, Claas Langbehn wrote:

> Hello!
> 
> >> Going on a limb here - faulty USB cable causes USB resets which throws
> >> off legacy emulation (which is done in SMM as well as KBC controller)
> >> which causes KCB to lose bytes. I would expect also seeing some
> >> keypresses not being registered but losing release is much more
> >> visible...
> >>     
> >
> > It's possible.  But the USB drivers try to take control of the host 
> > controllers away from the SMM BIOS.  How could legacy support work with 
> > both SMM and the Linux USBHID system trying to handle it?
> >   
> Please tell me what I can do to help to debug this strange behaviour.
> Repuducing the USB resets is easy, but reproducing the PS/2 influence
> takes long, since its hardly visible.

My advice is don't do anything and don't worry about it.  It really isn't 
an important problem.

Alan Stern
