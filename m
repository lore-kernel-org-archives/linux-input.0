From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [PATCH 0/7] usbhid: add load-time and run-time USB HID quirks
 configuration
Date: Mon, 19 Mar 2007 14:10:15 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0703191322010.9906@utopia.booyaka.com>
References: <Pine.LNX.4.64.0703182032400.21893@utopia.booyaka.com>
 <Pine.LNX.4.64.0703191408400.5030@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0703191408400.5030@twin.jikos.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jikos@jikos.cz>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hello Jiri,

thanks for the review.

On Mon, 19 Mar 2007, Jiri Kosina wrote:

> You can currently "force" HID_QUIRK_IGNORE for the device that has been
> already bound to usbhid driver through 'unbind' file in sysfs. This lets
> you to ask usbhid driver to release the device. So you can just have
> HID_QUIRK_HIDDEV quirk set, and bind/unbind the device depending whether
> you want to use hiddev driver or a separate driver.

Thanks, I was unaware of that 'unbind' feature.  Defining HID_QUIRK_HIDDEV 
by default seems sort of kludgy, but it would probably work for my 
purposes.  Certainly my preference would still be for some sort of boot or 
runtime configuration for this, so the device is associated with the 
proper driver upon initial plugin.

> Also your solution cosumes significantly more memory (adding 16 bits to
> every hid_blacklist entry, duplicating the information into list that in
> most cases will stay intact and just mirror the contents of
> hid_blacklist). Not that it's a big issue, but still worth noting.

Right now there are about 160 entries in the hid_blacklist, so adding the 
mask costs about 320 bytes extra.  If that's a concern, a bigger issue is 
the list_head added to each hid_blacklist entry - two pointers per entry - 
so, 1280 bytes on a 32-bit machine (not counting the list head itself)

If you'd rather not to have the mask code in the patch, I'll drop it. 
It's only in there to remove the runtime-immutable special-case code for 
Wacom and Codemercs devices, so it's not really useful for my specific 
concern.

> There are also some CodingStyle issues (like inconsistent usage of "return
> something" and "return(something);" and over-commenting on some places (no
> need to say that we are going to allocate memory before calling kmalloc(),
> etc.), but these are not that important now.

If you ultimately decide you want the patchset, I'll respin it with these 
issues resolved to your satisfaction.

> To summarize: do you see any other application of your aproach, for any
> currently existing devices/drivers, that can't be accomplished by
> unbinding the usbhid driver from the device?

Aside from other devices that have a similar HIDDEV/IGNORE situation, 
there are two other possible uses that occur to me - but I don't know if 
either one is compelling enough to justify the extra code involved in the 
patchset.  I suspect that runtime quirks configuration would probably be 
useful for testing new HID devices.  I can also foresee a situation where 
a manufacturer revises a device, and an existing quirk is no longer 
applicable for some users, or a new quirk needs to be added for particular 
users.  But, these are both theoretical use cases.  Since the patches have 
been useful for me, I wouldn't mind seeing them in mainline, but I don't 
have any stake in it either way.

(re procfs usage)
> This is unfortunately also not going to fly - the general rule of thumb is
> that no new entries should be added into /proc. You could acomplish the
> very same functionality through sysfs, right?

Yes - if you decide that you want the patchset, I'll convert it to sysfs.


regards,

- Paul
