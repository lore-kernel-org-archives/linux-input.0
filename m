From: Andrey Panin <pazke@donpac.ru>
Subject: Re: Asus eee-top touch screen
Date: Mon, 25 May 2009 12:26:18 +0400
Message-ID: <20090525082618.GA5983@ports.donpac.ru>
References: <4A18F807.3080406@l39a.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ports.donpac.ru ([80.254.111.81]:57848 "EHLO ports.donpac.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754012AbZEYIzu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 May 2009 04:55:50 -0400
Content-Disposition: inline
In-Reply-To: <4A18F807.3080406@l39a.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabriele Turchi <gabriele.turchi@l39a.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org


Added linux-input@vger.kernel.org to the CC.

On 144, 05 24, 2009 at 09:32:23AM +0200, Gabriele Turchi wrote:
> Hi all.
> 
> I've done some tests to use the touch screen included in the Asus 
> eee-top PC under Fedora 10/11. From the first results, the touch screen 
> was detected, but only the mouse button events are generated. I've 
> googled around a bit to find a solution, but found nothing.
> 
> Looking into kernel and X sources, the more viable solution for me was 
> to write a little kernel module, to modify a bit the event's stream to 
> make them compatible with X needs.
> 
> My module is attached, even if I fully understand that this module could 
> be the worst conceived and worst written ever... :-)
> 
> To be serious: my choice was to make the less invasive solution, and 
> this module appear to reach the goal: my touch screen works well now. 
> Maybe mine was the wrong approach, but I've found so little 
> documentation on how to make a better one. I'll obviously accept any 
> useful suggestion.
> 
> I hope this could be useful.
> 
> Gabriele Turchi
> 
> P.S.: Please CC me, I'm not subscribed, and my apologies for my horrible 
> English.
> 
> 
> /*
>  *  HID driver for TouchPack touchscreen
>  *  (ASUS eee top touch screen)
>  *
>  *  Copyright (c) 2009 Gabriele Turchi - gabriele.turchi@l39a.com
>  */
> 
> /*
>  * This program is free software; you can redistribute it and/or modify it
>  * under the terms of the GNU General Public License as published by the Free
>  * Software Foundation; either version 2 of the License, or (at your option)
>  * any later version.
>  */
> 
> #include <linux/device.h>
> #include <linux/hid.h>
> #include <linux/module.h>
> 
> #include "hid-ids.h"
> 
> static int tp_input_mapping(struct hid_device *device, struct hid_input *hi,
> 		struct hid_field *field, struct hid_usage *usage,
> 		unsigned long **bit, int *max)
> {
> 	/* This is needed for evdev compatibility: these events are (apparently) never generated, but
>          * X11 evdev driver goes mad with it.
>          */
> 
> 	if ( (usage->hid & HID_USAGE_PAGE) == HID_UP_DIGITIZER) {
> 		printk(KERN_INFO "tp_input_mapping: discard HID_UP_DIGITIZER => 0x%04X\n", usage->hid);
> 		return -1;
> 	}
> 
> 	return 0;
> }
> 
> static int tp_event(struct hid_device *device, struct hid_field *field, struct hid_usage *usage, __s32 value)
> {
> 	/* "Somewere" the right axis number is changed with the wrong one.
>          * Here we restore the correct values.
>          */
> 
> 	if ( (usage->code == 0x02) || (usage->code == 0x03) )
> 		usage->code -= 2;
> 	return 0;
> }
> 
> 
> static const struct hid_device_id tp_devices[] = {
> 	{ HID_USB_DEVICE( 0x1bfd, 0x1688) },
> 	{ }
> };
> MODULE_DEVICE_TABLE(hid, tp_devices);
> 
> static struct hid_driver tp_driver = {
> 	.name = "touchpack",
> 	.id_table = tp_devices,
> 	.input_mapping = tp_input_mapping,
> 	.event = tp_event,
> };
> 
> static int tp_init(void)
> {
> 	return hid_register_driver(&tp_driver);
> }
> 
> static void tp_exit(void)
> {
> 	hid_unregister_driver(&tp_driver);
> }
> 
> module_init(tp_init);
> module_exit(tp_exit);
> MODULE_LICENSE("GPL");
> 
> HID_COMPAT_LOAD_DRIVER(touchpack);



