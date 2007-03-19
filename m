From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [PATCH 0/7] usbhid: add load-time and run-time USB HID quirks
 configuration
Date: Mon, 19 Mar 2007 14:24:26 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0703191408400.5030@twin.jikos.cz>
References: <Pine.LNX.4.64.0703182032400.21893@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0703182032400.21893@utopia.booyaka.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Paul Walmsley <paul@booyaka.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Sun, 18 Mar 2007, Paul Walmsley wrote:

> The USB HID quirk list ('hid_blacklist') is a compile-time fixed array 
> in the current kernel.  Any modifications require editing the module 
> source and recompiling.  Some distributions compile the usbhid code into 
> the kernel, thus requiring that the entire kernel be rebuilt. For most 
> HID devices, this is not a major problem, since quirks are unlikely to 
> change often.  Some devices, however, have multiple drivers available, 
> requiring different HID quirks.  For example, the LabJack U12 data 
> acquisition device requires HID_QUIRK_IGNORE for one driver and 
> HID_QUIRK_HIDDEV for another.  With a static hid_blacklist array, 
> switching between the two is quite difficult.

Hi Paul,

I agree that current quirk handling in usbhid is not the best thing on 
earth and needs improving - this should be acomplished in future by 
converting HID layer to bus.

However, I am not sure whether your solution is not over-designed.

You can currently "force" HID_QUIRK_IGNORE for the device that has been 
already bound to usbhid driver through 'unbind' file in sysfs. This lets 
you to ask usbhid driver to release the device. So you can just have 
HID_QUIRK_HIDDEV quirk set, and bind/unbind the device depending whether 
you want to use hiddev driver or a separate driver. I agree that with 
other quirks it's not so easy, but I am not aware of any device/driver 
which would need to change other quirks in runtime.

Also your solution cosumes significantly more memory (adding 16 bits to 
every hid_blacklist entry, duplicating the information into list that in 
most cases will stay intact and just mirror the contents of 
hid_blacklist). Not that it's a big issue, but still worth noting.

There are also some CodingStyle issues (like inconsistent usage of "return 
something" and "return(something);" and over-commenting on some places (no 
need to say that we are going to allocate memory before calling kmalloc(), 
etc.), but these are not that important now.

To summarize: do you see any other application of your aproach, for any 
currently existing devices/drivers, that can't be accomplished by 
unbinding the usbhid driver from the device?

> This series of patches fixes this problem by adding a new module
> parameter 'hid_quirks' which allows quirks to be modified at boot or
> module load-time.  These quirks can also be reviewed and configured at
> runtime via a procfs file, /proc/usbhid/device_quirks. 

This is unfortunately also not going to fly - the general rule of thumb is 
that no new entries should be added into /proc. You could acomplish the 
very same functionality through sysfs, right?

Thanks,

-- 
Jiri Kosina
