From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [hid:for-next 63/64] drivers/hid/hid-logitech-hidpp.c:1504:46:
 error: 'HIDPP_QUIRK_MULTI_INPUT' undeclared here (not in a function)
Date: Mon, 1 Jun 2015 15:16:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1506011516290.16120@pobox.suse.cz>
References: <201506012135.r2k0hbPI%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201506012135.r2k0hbPI%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 1 Jun 2015, kbuild test robot wrote:

> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git for-next
> head:   856bfcac85d56f45bc24439eb236d9faeb84970a
> commit: 1fb1c98e3be33a119e2b1dff03786ec356546d0e [63/64] Merge branch 'for-4.2/logitech' into for-next
> config: i386-allyesconfig (attached as .config)
> reproduce:
>   git checkout 1fb1c98e3be33a119e2b1dff03786ec356546d0e
>   # save the attached .config to linux build tree
>   make ARCH=i386 
> 
> All error/warnings:
> 
> >> drivers/hid/hid-logitech-hidpp.c:1504:46: error: 'HIDPP_QUIRK_MULTI_INPUT' undeclared here (not in a function)
>        .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_MULTI_INPUT |
>                                                  ^
> 
> vim +/HIDPP_QUIRK_MULTI_INPUT +1504 drivers/hid/hid-logitech-hidpp.c
> 
> 2f31c525 Benjamin Tissoires  2014-09-30  1498  	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
> 2f31c525 Benjamin Tissoires  2014-09-30  1499  		USB_DEVICE_ID_LOGITECH_T651),
> 2f31c525 Benjamin Tissoires  2014-09-30  1500  	  .driver_data = HIDPP_QUIRK_CLASS_WTP },
> 3a61e975 Benjamin Tissoires  2014-09-30  1501  	{ /* Keyboard TK820 */
> 3a61e975 Benjamin Tissoires  2014-09-30  1502  	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
> 3a61e975 Benjamin Tissoires  2014-09-30  1503  		USB_VENDOR_ID_LOGITECH, 0x4102),
> 3a61e975 Benjamin Tissoires  2014-09-30 @1504  	  .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_MULTI_INPUT |
> 3a61e975 Benjamin Tissoires  2014-09-30  1505  			 HIDPP_QUIRK_CLASS_WTP },
> 8a09b4fa Goffredo Baroncelli 2015-05-30  1506  	{ /* Mouse logitech M560 */
> 8a09b4fa Goffredo Baroncelli 2015-05-30  1507  	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
> 
> :::::: The code at line 1504 was first introduced by commit
> :::::: 3a61e97563d78a2ca10752902449570d8433ce76 HID: logitech-hidpp: support combo keyboard touchpad TK820
> 
> :::::: TO: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> :::::: CC: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>

Thanks a lot for the report. That was a mismerge on my side. Now fixed.

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
