From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: USB: driver for CM109 chipset
Date: Mon, 27 Aug 2007 11:46:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708271143310.2460@twin.jikos.cz>
References: <7f45d9390708252128p48c30b38we59ca2b6496997dd@mail.gmail.com>
 <46D1CB97.5030000@db.org> <7f45d9390708262257h2cddf51cva423b339a78ae554@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <7f45d9390708262257h2cddf51cva423b339a78ae554@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Shaun Jackman <sjackman@gmail.com>
Cc: "Alfred E. Heggestad" <aeh@db.org>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Sun, 26 Aug 2007, Shaun Jackman wrote:

> In fact, I already tried adding the CM109 to the blacklist. Oddly 
> enough, the usbhid driver still grabs the CM109 HID device. I must be 
> doing something wrong...

Hi,

first, it is now also possible to pass additional quirks to the usbhid 
module using the 'quirks' parameter.

> $ grep -1 CMEDIA drivers/hid/usbhid/hid-quirks.c
> #define USB_VENDOR_ID_CMEDIA            0x0d8c
> #define USB_DEVICE_ID_CMEDIA_CM109      0x000e
> 
> --
>         { USB_VENDOR_ID_CIDC, 0x0103, HID_QUIRK_IGNORE },
>         { USB_VENDOR_ID_CMEDIA, USB_DEVICE_ID_CMEDIA_CM109, HID_QUIRK_IGNORE },
>         { USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_HIDCOM,
> HID_QUIRK_IGNORE },

Adding a HID_QUIRK_IGNORE entry to the blacklist is sufficient. Could you 
please double check that this patched driver really binds to the device?

If so, could you please compile with CONFIG_HID_DEBUG enabled and modprobe 
the usbhid module with 'debug=1' parameter and send me the kernel output?

-- 
Jiri Kosina
