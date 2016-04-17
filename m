From: Lauri Kasanen <cand@gmx.com>
Subject: [hid-sony] sony_controller_battery led triggers not working
Date: Sun, 17 Apr 2016 17:27:16 +0300
Message-ID: <20160417172716.b9ba5813cab5d26a6a3bb8ca@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:64059 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831AbcDQO1N (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Apr 2016 10:27:13 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: ao2@ao2.it, frank.praznik@oh.rr.com

Hi,

The battery triggers aren't working for some reason, trying to write
them comes back with -EINVAL. I'm on somewhat old kernel, 3.17, but the
relevant parts haven't changed from the commit Frank made in 2014
adding the MAC address to the name.

# cat trigger
none timer heartbeat backlight [default-on]
sony_controller_battery_00:26:5c:31:a2:c8-charging-or-full
sony_controller_battery_00:26:5c:31:a2:c8-charging
sony_controller_battery_00:26:5c:31:a2:c8-full
sony_controller_battery_00:26:5c:31:a2:c8-charging-blink-full-solid

# echo sony_controller_battery_00:26:5c:31:a2:c8-charging-blink-full-solid > trigger
bash: echo: write error: Invalid argument

The shorter triggers do work. Is it something caused by the long name,
or the colons? Do they work for others?

My controller is the Gasia one:
sony 0003:054C:0268.0005: input: USB HID v1.11 Joystick [Gasia Co.,Ltd
PS(R) Gamepad] on usb-0000:00:12.2-2.3/input0

- Lauri
