From: "Shaun Jackman" <sjackman@gmail.com>
Subject: Re: USB: driver for CM109 chipset
Date: Sun, 26 Aug 2007 22:57:56 -0700
Message-ID: <7f45d9390708262257h2cddf51cva423b339a78ae554@mail.gmail.com>
References: <7f45d9390708252128p48c30b38we59ca2b6496997dd@mail.gmail.com>
	 <46D1CB97.5030000@db.org>
Reply-To: "Shaun Jackman" <sjackman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <46D1CB97.5030000@db.org>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: "Alfred E. Heggestad" <aeh@db.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 8/26/07, Alfred E. Heggestad <aeh@db.org> wrote:
> I have made a new version of the CM109 driver which updates the
> usb hid-quirks.c blacklist, please find it here:
>
>    http://aeh.db.org/patch/cm109-20070826.patch
>
> (All versions here: http://aeh.db.org/patch/)

In fact, I already tried adding the CM109 to the blacklist. Oddly
enough, the usbhid driver still grabs the CM109 HID device. I must be
doing something wrong...

$ grep -1 CMEDIA drivers/hid/usbhid/hid-quirks.c

#define USB_VENDOR_ID_CMEDIA            0x0d8c
#define USB_DEVICE_ID_CMEDIA_CM109      0x000e

--
        { USB_VENDOR_ID_CIDC, 0x0103, HID_QUIRK_IGNORE },
        { USB_VENDOR_ID_CMEDIA, USB_DEVICE_ID_CMEDIA_CM109, HID_QUIRK_IGNORE },
        { USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_HIDCOM,
HID_QUIRK_IGNORE },
$ make modules
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CC [M]  drivers/hid/usbhid/hid-quirks.o
  LD [M]  drivers/hid/usbhid/usbhid.o
  Building modules, stage 2.
  MODPOST 1648 modules
  LD [M]  drivers/hid/usbhid/usbhid.ko
$ sudo cp drivers/hid/usbhid/usbhid.ko
/lib/modules/2.6.23-rc3/kernel/drivers/hid/usbhid/usbhid.ko

> You can also try to unload the usbhid.ko module (while the USB phone
> is plugged in), and then manually load the cm109.ko driver

That's difficult for me, as both my keyboard and mouse are HID
devices. The detach-usb utility is working for me until I can get the
blacklist working.

> Another outstanding issue with the CM109 driver is that it seems
> like all phone vendors have different key-mappings. That means
> that the keymapping defined in my version of the cm109 driver
> works with the KIP-1000 USB phone. I have got reports from other
> users with other phones, that the keymapping is different. It
> would be very interesting to see which keymapping your phone
> (Genius G-talk) has.

It's one of the guarantees in electronics that if two people are given
an arbitrary binary choice, they will certainly choose opposite each
other. A keyboard matrix, which is well more than a binary choice,
will yield endless different key arrangements. The Genius G-Talk
keymap follows this mail.

> I am not sure how to fix this problem, does anyone on this list
> have any good suggestions?

I haven't been able to dump the EEPROM yet. I'll think on it.

Cheers,
Shaun

/*
 Genius G-Talk keyboard matrix
    0 1 2 3
 4: 0 4 8 Talk
 5: 1 5 9 End
 6: 2 6 # Up
 7: 3 7 * Down
*/

	case 0x11: return KEY_0;
	case 0x21: return KEY_1;
	case 0x41: return KEY_2;
	case 0x81: return KEY_3;
	case 0x12: return KEY_4;
	case 0x22: return KEY_5;
	case 0x42: return KEY_6;
	case 0x82: return KEY_7;
	case 0x14: return KEY_8;
	case 0x24: return KEY_9;
	case 0x44: return KEY_LEFTSHIFT | KEY_3 << 8; /* # */
	case 0x84: return KEY_KPASTERISK;
	case 0x18: return KEY_ENTER; /* Talk (green handset) */
	case 0x28: return KEY_ESC; /* End (red handset) */
	case 0x48: return KEY_UP; /* Menu up (rocker switch) */
	case 0x88: return KEY_DOWN; /* Menu down (rocker switch) */
