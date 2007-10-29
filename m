From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC: 2.6 patch] remove the
 USB_STORAGE_ONETOUCH driver
Date: Mon, 29 Oct 2007 10:22:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0710291017520.4550-100000@iolanthe.rowland.org>
References: <200710282238.11692.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200710282238.11692.dtor@insightbb.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Adrian Bunk <bunk@kernel.org>, linux-usb-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Nick Sillik <n.sillik@temple.edu>, David Brownell <david-b@pacbell.net>, Torsten Kaiser <just.for.lkml@googlemail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Sun, 28 Oct 2007, Dmitry Torokhov wrote:

> On Sunday 28 October 2007 16:39, Jiri Kosina wrote:
> > On Sun, 28 Oct 2007, Torsten Kaiser wrote:
> > 
> > > But it looks like that uses another driver:
> > > hiddev0hidraw1: USB HID v1.10 Device [Western Digital External HDD] on
> > > usb-0000:00:02.1-5.2
> > > Otherwise I would be willing to try to test this, if someone would tell 
> > > me how to check that the second commit did fix the suspend problem.
> > 
> > If you need to unbind usbhid driver from the device and bind another one, 
> > you can use the 'unbind' and 'bind' files in sysfs.
> > 
> > As soon as the driver you are willing to test is bound to the device, you 
> > can go ahead with testing any functionality you wish (probably 
> > suspend/resume cycle is needed here?).
> > 
> > If the device is claimed by usbhid driver (because its descriptor probably 
> > states that it's HID-compliant device) and should be claimed by another 
> > driver, it's necessary to add it to usbhid blacklist -- just let me know.
> > 
> 
> Maybe onetouch driver is not needed after all. I wonder what key/button does
> HID deriver reports when it binds to it... Torsten, could you please post
> your /proc/bus/input/devices?

You guys all sound confused about this.

The original reason writing for the onetouch driver was because the
button on this disk drive isn't an HID device!  That is, the drive
doesn't include any of the usual HID descriptors for the button and the
button doesn't send HID-style reports.

Torsten's assessment was correct.  Originally there was no PM support 
for the onetouch driver.  Now there is (although it isn't very good), 
so it would be legitimate to remove the !PM condition.

As far as I know, the only person who ever used the onetouch driver was 
its author.

Alan Stern


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
