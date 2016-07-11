From: Cameron Gutman <aicommander@gmail.com>
Subject: Supporting the new Xbox One controller with wireless/BT connectivity
Date: Mon, 11 Jul 2016 10:47:38 -0700
Message-ID: <5783DBBA.8070503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35880 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755286AbcGKRrl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2016 13:47:41 -0400
Received: by mail-pf0-f179.google.com with SMTP id t190so38208629pfb.3
        for <linux-input@vger.kernel.org>; Mon, 11 Jul 2016 10:47:40 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, jikos@kernel.org
Cc: linux-input@vger.kernel.org

I'm trying to come up with the best way to support wirelessly connected Xbox
One controllers. Microsoft has previously released a wireless adapter that
uses a proprietary protocol to talk to the Xbox One controllers. Recently,
they have also announced an Xbox One controller with Bluetooth connectivity. 
Though we can't be sure yet since it hasn't come out yet, I would guess that
they're using the same protocol as they do when attached via USB. If it's a
standard HID gamepad, we don't have any work to do but I'm not holding my
breath ;)

Unfortunately, our xpad driver is quite tied to USB so it will be difficult to
support HID communication over Bluetooth. My initial thinking is that we can
add a new hid-xpad driver that will initially take over this single Bluetooth
Xbox One controller. After it is tested and feature parity with xpad, we can
possibly expand it to handle all Xbox One controllers to avoid duplicated
logic.

The wrinkle in these plans is the Xbox One wireless adapter which seems to be
simply a MediaTek WLAN adapter that MS is binding a protocol driver to in order
to emulate the HID protocol for the rest of their device stack. Fortunately, it
looks like people are started to have success reverse engineering the wireless
protocol, so we should be able to do something similar to how MS implements it.

In order to support the proprietary wireless adapter, I see two options:

1) Write a driver for the Xbox One wireless adapter that will expose a virtual
   USB controller that enumerates Xbox One controllers and allows our existing
   xpad driver to run them. The OZWPAN driver in staging does something like
   this and would be a good reference. The advantage is that it doesn't require
   a new hid-xpad driver. The disadvantages are that there's a bunch of
   complexity in writing a virtual USB host controller driver and even after
   doing it, we still can't support Bluetooth Xbox One Controllers.

2) Write a HID transport for the Xbox One wireless adapter that enumerates HID
   devices for the hid-xpad driver. By moving the abstracting up a layer, it
   really cuts down on the amount of code required. This would also let us
   support USB, proprietary wireless, and Bluetooth attached Xbox One
   controllers with a single xpad driver.

As far as I'm concerned, #2 seems like the obvious choice.

Jiri and Dmitry, do either of you see anything wrong with #2 or have any other
comments or concerns?


Thanks,
Cameron
