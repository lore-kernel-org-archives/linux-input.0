From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [PATCH][hid] Fix a NULL pointer dereference when we fail to
 allocate memory
Date: Mon, 30 Jul 2007 15:19:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0707301518530.5747@twin.jikos.cz>
References: <200707220006.20359.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200707220006.20359.jesper.juhl@gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michael Haboustak <mike-@cinci.rr.com>, Andreas Gal <gal@uci.edu>, Vojtech Pavlik <vojtech@suse.cz>, Greg Kroah-Hartman <greg@kroah.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Sun, 22 Jul 2007, Jesper Juhl wrote:

> If, in usb_hid_configure(), we fail to allocate storage for 'usbhid', 
>  "if (!(usbhid = kzalloc(sizeof(struct usbhid_device), GFP_KERNEL)))", 
> then we'll jump to the 'fail:' label where we have this code:
>         usb_free_urb(usbhid->urbin);
>         usb_free_urb(usbhid->urbout);
>         usb_free_urb(usbhid->urbctrl);
> Since we got here because we couldn't allocate storage for 'usbhid', 
> what we have here is a NULL pointer dereference - ouch...

Hi Jesper,

thanks a lot for noticing this, I have queued your patch in HID tree.

(and sorry for late reply, I was offline on vacation for some time).

-- 
Jiri Kosina
