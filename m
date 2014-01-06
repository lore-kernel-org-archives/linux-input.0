From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] HID: quirk for Saitek RAT7 and MMO7 mices' mode button
Date: Mon, 06 Jan 2014 12:54:43 -0500
Message-ID: <52CAEDE3.60901@gmail.com>
References: <52C5C488.3080106@braincalibration.de> <CAN+gG=EfhNrJYoaTcqa8bTEM1AbBzF2Roq=CWb7QSTVL3Ownfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qe0-f52.google.com ([209.85.128.52]:38655 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601AbaAFRyr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jan 2014 12:54:47 -0500
Received: by mail-qe0-f52.google.com with SMTP id ne12so18857040qeb.11
        for <linux-input@vger.kernel.org>; Mon, 06 Jan 2014 09:54:46 -0800 (PST)
In-Reply-To: <CAN+gG=EfhNrJYoaTcqa8bTEM1AbBzF2Roq=CWb7QSTVL3Ownfw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Conan <conan@braincalibration.de>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Sorry for the repost, my gmail decided to send HTML instead of plain
text... :(

On 06/01/14 12:24, Benjamin Tissoires wrote:
> Hi Conan,
> 
> Peter asked me to have a look at a similar device in the X bugzilla [1],
> so I will also comment here in the hope we will finally find an upstream
> solution.
> 
> 
> On Thu, Jan 2, 2014 at 2:56 PM, Conan <conan@braincalibration.de
> <mailto:conan@braincalibration.de>> wrote:
> 
>     -----BEGIN PGP SIGNED MESSAGE-----
>     Hash: SHA1
> 
>     Hi all,
> 
>     this patch adds support for some saitek mice which implement a tristate
>     button (for switching button mappings in the official windows driver) by
>     keeping one of three (non-physical) buttons constantly pressed. This
>     breaks X and probably other userspace software.
> 
>     The patch below implements a quirk which instantly sends a release event
>     for the affected buttons.
> 
>     Disclaimer: this is not entirely my own work, it is based on a patch for
>     the R.A.T.7. which was posted here:
>     http://us.generation-nt.com/answer/patch-2-6-38-mode-button-quirk-saitek-cyborg-t-7-help-202649672.html
> 
>     I merely added two usb ids and kept it up to date.
> 
> 
> Please add your Signed-off-by line and use your real name (see
> Documentation/SubmittingPatches in the kernel tree).
> 
> Also add Jiri in CC if you ever want it to be included in his tree
> (which I assume you want).
>  
> 
> 
>     - --- a/drivers/hid/hid-ids.h   2013-10-08 15:20:58.781792791 +0200
>     +++ b/drivers/hid/hid-ids.h     2013-10-08 15:22:17.815804729 +0200
>     @@ -714,6 +714,9 @@
>      #define USB_VENDOR_ID_SAITEK           0x06a3
>      #define USB_DEVICE_ID_SAITEK_RUMBLEPAD 0xff17
>      #define USB_DEVICE_ID_SAITEK_PS1000    0x0621
>     +#define USB_DEVICE_ID_SAITEK_RAT7      0x0ccb
>     +#define USB_DEVICE_ID_SAITEK_RAT7TOO   0x0cd7
>     +#define USB_DEVICE_ID_SAITEK_MMO7      0x0cd0
> 
>      #define USB_VENDOR_ID_SAMSUNG          0x0419
>      #define USB_DEVICE_ID_SAMSUNG_IR_REMOTE        0x0001
>     - --- a/drivers/hid/hid-input.c 2013-01-31 19:09:35.058570485 +0100
>     +++ b/drivers/hid/hid-input.c   2013-01-31 19:11:57.779833199 +0100
> 
> 
> This should go into hid-saitek, not hid-input. It is really specific and
> no other device will benefit from it, so move it where it belongs.
>  
> 
>     @@ -1039,6 +1039,25 @@
> 
>             if ((field->flags & HID_MAIN_ITEM_RELATIVE) && (usage->type
>     == EV_KEY))
>                     input_event(input, usage->type, usage->code, 0);
>     +
>     +       /* hack for Saitek RAT mice which report release events for
>     their
>     +        * mode button on the NEXT press event: instant release
>     +       */
>     +       if ((*quirks & HID_QUIRK_RAT_BROKEN_BUTTON_RELEASE) &&
>     +               value && usage->type == EV_KEY &&
>     +               /* RAT7 uses buttons 13,14,15 */
>     +               ((usage->code >= BTN_MOUSE + 8 && usage->code <=
>     BTN_MOUSE + 10) ||
>     +               /* MMO7 uses button 20 */
>     +               (usage->code == BTN_MOUSE + 15)) &&
>     +               test_bit(usage->code, input->key)) {
>     +               input_event(input, usage->type, usage->code, 0);
>     +               /* we'll get a real release event from the mouse
>     anyway, and
>     +                * userspace should cope with the extra input-layer
>     +                * button-up events anyway; just re-set the bit to stop
>     +                * spurious button-down events
>     +                */
>     +               set_bit(usage->code, input->key);
> 
> 
> This is just weird. input_event should take care of that. I bet you are
> missing an input_sync event before releasing the key (or after).
>  
> 
>     +       }
>      }
> 
> 
>      void hidinput_report_event(struct hid_device *hid, struct hid_report
>     *report)
>     - --- a/drivers/hid/usbhid/hid-quirks.c 2013-01-31
>     19:09:35.058570485 +0100
>     +++ b/drivers/hid/usbhid/hid-quirks.c   2013-01-31
>     19:12:58.195232311 +0100
>     @@ -82,6 +82,9 @@
>             { USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001,
>     HID_QUIRK_NOGET },
>             { USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008,
>     HID_QUIRK_NOGET },
>             { USB_VENDOR_ID_REALTEK, USB_DEVICE_ID_REALTEK_READER,
>     HID_QUIRK_NO_INIT_REPORTS },
>     +       { USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7,
>     HID_QUIRK_RAT_BROKEN_BUTTON_RELEASE },
>     +       { USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RAT7TOO,
>     HID_QUIRK_RAT_BROKEN_BUTTON_RELEASE },
>     +       { USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_MMO7,
>     HID_QUIRK_RAT_BROKEN_BUTTON_RELEASE },
>             { USB_VENDOR_ID_SENNHEISER, USB_DEVICE_ID_SENNHEISER_BTD500USB,
>     HID_QUIRK_NOGET },
>             { USB_VENDOR_ID_SIGMATEL, USB_DEVICE_ID_SIGMATEL_STMP3780,
>     HID_QUIRK_NOGET },
>             { USB_VENDOR_ID_SUN, USB_DEVICE_ID_RARITAN_KVM_DONGLE,
>     HID_QUIRK_NOGET },
>     - --- a/include/linux/hid.h     2013-05-18 03:16:26.713052127 +0200
>     +++ b/include/linux/hid.h       2013-05-18 03:17:23.407343351 +0200
>     @@ -283,6 +283,7 @@
>      #define HID_QUIRK_MULTI_INPUT                  0x00000040
>      #define HID_QUIRK_HIDINPUT_FORCE               0x00000080
>      #define HID_QUIRK_NO_EMPTY_INPUT               0x00000100
>     +#define HID_QUIRK_RAT_BROKEN_BUTTON_RELEASE    0x00000200
> 
> 
> Please do not add too specific fixup in the generic hid layer. (see the
> hid-saitek comment above).
>  
> 
>      #define HID_QUIRK_SKIP_OUTPUT_REPORTS          0x00010000
>      #define HID_QUIRK_FULLSPEED_INTERVAL           0x10000000
>      #define HID_QUIRK_NO_INIT_REPORTS              0x20000000
> 
>     - --
>     Regards,
>     C
> 
> 
> Two more comments:
> - given the Xorg bug, I think we should map the physical button to only
> one input button, not three (the goal is to remove the state, so we
> should do it correctly)
> - I can give you a hand in developing/debugging if you sent me some
> reports with hid-recorder [2]. Send some regular reports + the faulty
> button presses, and I'll be able to test it on my laptop.
> 
> Cheers,
> Benjamin
> 
> [1] https://bugs.freedesktop.org/show_bug.cgi?id=32200
> [2] http://bentiss.github.io/hid-replay-docs/
