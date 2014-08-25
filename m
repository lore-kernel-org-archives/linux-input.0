From: vichy <vichy.kuo@gmail.com>
Subject: Re: [PATCH 1/1] HID: usbhid: add usb_clear_halt determination for
 next hid_start_in
Date: Mon, 25 Aug 2014 20:49:25 +0800
Message-ID: <CAOVJa8F6cn1+pDz09B9LUMinV4iUOiyZn8SEjmx=ttMsWe5+Zg@mail.gmail.com>
References: <CAOVJa8FgtSDM-F=Nu1kOU_Ax_6a0_U3jKU6_PKPDoVD9zW+JWg@mail.gmail.com>
	<Pine.LNX.4.44L0.1408241127320.26310-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:59419 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880AbaHYMt0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Aug 2014 08:49:26 -0400
In-Reply-To: <Pine.LNX.4.44L0.1408241127320.26310-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Kosina <jkosina@suse.cz>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-input@vger.kernel.org

hi Alan:
>> "usb_unbind_and_rebind_marked_interfaces" is called if config
>> parameter is not null,
>> it seems no matter post_reset routine fail or not.
>
> Yes, that's right.  I should have said: "Because the post_reset routine
> failed, usb_unbind_and_rebind_marked_interfaces indirectly calls
> usbhid_disconnect.

Even post_reset routine failed,
usb_unbind_and_rebind_marked_interfaces will still indirectly calls
usbhid_disconnect, right?


> I don't remember the entire call chain.  It was pretty long.
> hid_destroy_device calls hid_remove_device, which calls device_del,
> which calls lots of other things.  If you really want to see all the
> details, put a dump_stack() call in usbhid_close and examine what it
> prints in the kernel log when you unplug an HID device.
I found what you mentioned ^^

Thanks for your kind help,
