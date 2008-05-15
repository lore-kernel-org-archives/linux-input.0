From: Tino Keitel <tino.keitel@gmx.de>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Thu, 15 May 2008 15:21:08 +0200
Message-ID: <20080515132108.GA9327@dose.home.local>
References: <20080514221519.GA6575@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757527AbYEONVW@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080514221519.GA6575@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, jkosina@suse.cz, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, May 14, 2008 at 15:15:19 -0700, Greg KH wrote:
> From: Greg Kroah-Hartman <gregkh@suse.de>
> 
> This driver was originally written by James McKenzie but forward ported
> and cleaned up by me to get it to work with modern kernel versions.
> 
> Tested on my mac mini and it actually works!
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
> 
> Jiri, is it ok for this quirks addtion to go through Dmitry's triee?  Or
> do you want me to split it out into two different patches?
> 
> Dmitry, is this ok to go through your tree?  Or I can take it as well if
> you don't want it :)
> 
>  drivers/hid/usbhid/hid-quirks.c |    2 
>  drivers/input/misc/Kconfig      |   12 +
>  drivers/input/misc/Makefile     |    1 
>  drivers/input/misc/appleir.c    |  361 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 376 insertions(+)
> 
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -77,6 +77,7 @@
>  #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_JIS   0x022e
>  #define USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY	0x030a
>  #define USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY	0x030b
> +#define USB_DEVICE_ID_APPLE_IRCONTROL	0x8240
>  #define USB_DEVICE_ID_APPLE_IRCONTROL4	0x8242
>  
>  #define USB_VENDOR_ID_ASUS		0x0b05
> @@ -443,6 +444,7 @@ static const struct hid_blacklist {
>  	{ USB_VENDOR_ID_AFATECH, USB_DEVICE_ID_AFATECH_AF9016, HID_QUIRK_FULLSPEED_INTERVAL },
>  
>  	{ USB_VENDOR_ID_BELKIN, USB_DEVICE_ID_FLIP_KVM, HID_QUIRK_HIDDEV },
> +	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL, HID_QUIRK_IGNORE },
>  	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IRCONTROL4, HID_QUIRK_HIDDEV | HID_QUIRK_IGNORE_HIDINPUT },
>  	{ USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE, HID_QUIRK_HIDDEV | HID_QUIRK_IGNORE_HIDINPUT },
>  	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_SIDEWINDER_GV, HID_QUIRK_HIDINPUT },

Hi,                                                                             
                                                                                
I'm pretty sure that this breaks the macmini LIRC driver again, see             
commit 3e1928e8793208802589aae851b6685671187242.                                
                                                                                
Regards,                                                                        
Tino                                                                            
