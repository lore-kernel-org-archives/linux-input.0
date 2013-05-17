From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: HID vendor access from user space
Date: Fri, 17 May 2013 13:47:42 +0200
Message-ID: <CAE7qMrrtyzUy0h-jeC8b6vLRq10w165=JgEJsj6CKyviFZDaSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:38506 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755864Ab3EQLxa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 May 2013 07:53:30 -0400
Received: by mail-vb0-f50.google.com with SMTP id w15so1032890vbb.23
        for <linux-input@vger.kernel.org>; Fri, 17 May 2013 04:53:29 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <btissoires@logitech.com>, Andrew de los Reyes <adlr@chromium.org>, David Herrmann <dh.herrmann@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Olivier Gay <ogay@logitech.com>

Hi,

In today's linux HID subsystem, a HID device can be accessed for
control and configuration via dev/hidraw, via a hid-specific driver,
as well as /dev/input (setting leds on a kbd for instance)

Some HID devices share multiple functionality in the same HID
interface, think of a keyboard with a touchpad and a vendor specific
collection for configuration, special status, etc.

For such device, there will be one hidraw node, and hid-input will
take care of parsing the keyboard/mouse collections into the proper
input objects.

The vendor collection will be ignored.

If a user wants to configure/control the device there are two choices,
either write a hid-specific driver to deal with the vendor specific
collection, or open the corresponding /hidraw node from userspace.

But a hidraw node that carries system input data requires root priviledges.

I'm interested in hearing your opinions on how to add the capability
for a normal user process to control/configure a HID device via
reports exchanged with a vendor collection.

I have one proposal, which is to create, say  "/dev/hidvendorX", nodes
for all top level HID collections which are today ignored by hid-input
and/or other subsystems.

These nodes would not require root priviledge by default and thus,
users could control/reconfigure their devices from a standard
application while keeping the "standard" input functionality intact.

Cheers,
Nestor
