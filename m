From: Tino Keitel <tino.keitel@tikei.de>
Subject: Re: HID blacklist for the Apple IR sensor
Date: Wed, 11 Jul 2007 08:00:16 +0200
Message-ID: <20070711060016.GA27746@dose.home.local>
References: <20070710182636.GA12522@dose.home.local> <Pine.LNX.4.64.0707102227020.31463@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707102227020.31463@twin.jikos.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Soeren Sonnenburg <kernel@nn7.de>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Tue, Jul 10, 2007 at 22:29:55 +0200, Jiri Kosina wrote:
> On Tue, 10 Jul 2007, Tino Keitel wrote:
> 
> > in commit a417a21e10831bca695b4ba9c74f4ddf5a95ac06, the Apple IR sensor 
> > was added to a blacklist so that no HID device is created anymore. 
> > However, as of lirc 0.8.2, there is a lirc driver called "macmini" that 
> > requires that HID device to work. There is also a driver that creates an 
> > input device for the Apple IR sensor. It can be found in the 
> > mactel-linux patches[1], but it is not in the kernel yet. I also don't 
> > know how both sides behave if they are used concurrently.
> 
> Hi Tino,
> 
> so do I understand it correctly that there are two ways to use this device
> 
> - through lirc, which of course requires input device to be created by hid
> - using appleir.patch, but this one is not yet upstream (what are the 
>   obstacles?)

Correct.

I've tried to enable both, and it looks like the appleir driver doesn't
work. The appleir driver was loaded as a module. Removing the device
from the blacklist would introduce a regression for all users of the
appleir driver with kernels >= 2.6.21 and CONFIG_USB_HIDDEV enabled.

Isn't there a convenient way to (1) use the HID device if desired and
(2) use the appleir and deacticate this particular HID device in this
case?

> 
> If it is so, and the device is not handled properly by any other in-tree 
> driver, we should remove the ignore quirk.

I don't know of any other in-tree driver.

> 
> > I think that the blacklist entry for USB_DEVICE_ID_APPLE_IR should be 
> > removed at least as long as the appleir.patch is not part of the 
> > mainline kernel.
> 
> Would you care to send me a patch with proper changelog and Signed-off-by 
> line?

See the attachment.

Regards,
Tino
