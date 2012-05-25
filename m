From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Subject: HID Output and Feature Reports
Date: Fri, 25 May 2012 17:51:28 -0300
Message-ID: <CAAngNMZDfgcaf+pO+Lx=c+BLYCXKWP5k4bUKhmTyiiheiUH+3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34120 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756401Ab2EYUv3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 May 2012 16:51:29 -0400
Received: by pbbrp8 with SMTP id rp8so2210480pbb.19
        for <linux-input@vger.kernel.org>; Fri, 25 May 2012 13:51:28 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>, Andre Guedes <andre.guedes@openbossa.org>, David Herrmann <dh.herrmann@googlemail.com>

Hello all,

I'm working to support HID over GATT (HoG), which is HID over
Bluetooth Low Energy links, both on kernel and userspace. Traffic
coming from the remote peripheral through a L2CAP socket will be
handled in usespace, where the HID input reports are decapsulated from
GATT and injected back into the kernel through the new uHID module
written by David Herrmann. This module works similar to uinput, but
dealing with HID traffic.

The input part is working without problems and now I looking how to
support Output and Feature reports. Doing some basic testing it seems
we don't support Output reports very well. A basic use-case for that
is synchronizing keyboard leds (CAPS, NUM, etc) when there is more
than one keyboard connected, and I couldn't get this to work on my
tests. I didn't try to test feature reports since it's still not very
clear to me when they're used. The HID spec says that they exist for
setting values/controls on the peripheral that are not visible to the
user, but I haven't discovered any real-world use case for them. What
is the current state for these reports, do we support them somehow?

Also, I've found usbhid-dump by Greg K-H, but it doesn't seem to dump
data coming from the host to the device. Is this on the plans for this
tool? I can try to send a patch for it, if someone can guide me on how
this whole output/feature reports thing should work.

--=20
Jo=C3=A3o Paulo Rechi Vita
Openbossa Labs - INdT
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
