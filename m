From: Jamie Lentin <jm@lentin.co.uk>
Subject: Re: Mapping of F11 and F12 on new lenovo laptops and Lenovo Compact
 Keyboard
Date: Fri, 20 Jun 2014 13:00:58 +0100 (BST)
Message-ID: <alpine.DEB.2.02.1406201238550.4059@marmot.wormnet.eu>
References: <53A2A231.4030700@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <53A2A231.4030700@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Antonio Ospite <ao2@ao2.it>, linux-usb <linux-input@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, 19 Jun 2014, Hans de Goede wrote:

> Hi Jamie,
>
> I saw your patch-set for the Lenovo Compact Keyboard on the lwn.net
> kernel page.
>
> This spiked my interest as I'm the author of this patch:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/platform/x86/thinkpad_acpi.c?id=8b9dd4fab26a0f328420cbda0845a325f45bcd92
>
> Which adds mapping for the F9 - F12 on the Lenovo *40 series
> laptops, which have the same weird symbols on F11 and F12 as the
> Lenovo Compact Keyboard, the ones which you describe as:
>
> /* Fn-F11: View open applications (3 boxes) */
> /* Fn-F12: Open My computer (6 boxes) USB-only */
>
> You map these to:
> KEY_FN_F11
> KEY_FILE
>
> Where as my (already merged into Linus tree) patch maps these to:
>
> KEY_SCALE
> KEY_COMPUTER
>
> Which are defined in linux/uapi/input.h as:
>
> #define KEY_SCALE               120     /* AL Compiz Scale (Expose) */
> #define KEY_COMPUTER            157
>
> Which I believe maps closes to View open applications (which to me
> sounds like expose mode) and Open My computer.

Yes, the Function keys look the same:-
http://www.lenovo.com/images/gallery/1060x596/lenovo-laptop-thinkpad-t440-overhead-keyboard-2.jpg
https://c2.staticflickr.com/6/5467/9092693533_440cfcf311_z.jpg

I went with KEY_FILE on the USB keyboard, since this is what it's mapped 
to on the Bluetooth keyboard, as part of the CONSUMER usage page:-
http://lxr.free-electrons.com/source/drivers/hid/hid-input.c#L694

Personally I've no fondness to what the keys map to, since I remap them to 
how they are labelled on an Thinkpad X230, which is pause/nexttrack. 
However, it seems somewhat silly customising something that appears to be 
a standard mapping.

> Note that on the laptops the keys have their special meaning by
> default and using Fn turns them back into normal F11 keys, so
> KEY_FN_F11 seems like a particular bad match as that suggests
> a key combo which it is not on the laptops.

That's true. It works fine with Fn-ESC but yes, on these keyboards they 
are labelled such that F11 is the Fn-modified version.

> Anyways lets discuss and coordinate, so that we end up with the
> same mappings for the weird symbols on F11 and F12 for the laptops
> and for the Lenovo Compact Keyboard.

I think there are also some Apple keyboards using the same symbols, it 
might be worth seeing if these are supported and what they produce.

>
> Regards,
>
> Hans
>
>

-- 
Jamie Lentin
