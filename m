From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [linux-usb-devel] [RFC: 2.6 patch] remove the USB_STORAGE_ONETOUCH
 driver
Date: Mon, 29 Oct 2007 15:28:31 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0710291527130.18815@twin.jikos.cz>
References: <Pine.LNX.4.44L0.0710291017520.4550-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.44L0.0710291017520.4550-100000@iolanthe.rowland.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-input@atrey.karlin.mff.cuni.cz, Adrian Bunk <bunk@kernel.org>, linux-usb-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Nick Sillik <n.sillik@temple.edu>, David Brownell <david-b@pacbell.net>, Torsten Kaiser <just.for.lkml@googlemail.com>
List-Id: linux-input@vger.kernel.org

On Mon, 29 Oct 2007, Alan Stern wrote:

> You guys all sound confused about this. The original reason writing for 
> the onetouch driver was because the button on this disk drive isn't an 
> HID device!  That is, the drive doesn't include any of the usual HID 
> descriptors for the button and the button doesn't send HID-style 
> reports.

The only reason I was talking about it in terms of being a HID device was 
because Thorsten stated that usbhid driver gets bound to it.

Now that we know that Torsten was having different HW, my point is of 
course invalid :)

Thanks,

-- 
Jiri Kosina
