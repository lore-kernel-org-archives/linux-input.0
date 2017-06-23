From: Sibren Vasse <sibren.vasse@gmail.com>
Subject: Missing pnpID rmi-smbus
Date: Fri, 23 Jun 2017 22:27:23 +0200
Message-ID: <CAF=iVcvnt2foacp7UoTfGvWQjfctZ5E1yEhio=rKY9VGahAQbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36030 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932090AbdFWU1p (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 23 Jun 2017 16:27:45 -0400
Received: by mail-vk0-f68.google.com with SMTP id y70so2387286vky.3
        for <linux-input@vger.kernel.org>; Fri, 23 Jun 2017 13:27:44 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

When testing 4.12-rc6 on my HP EliteBook 8570w I noticed the following
in my dmesg output:

[   10.377828] psmouse serio4: synaptics: queried max coordinates: x
[..5648], y [..4806]
[   10.414770] psmouse serio4: synaptics: queried min coordinates: x
[1292..], y [1048..]
[   10.414775] psmouse serio4: synaptics: Your touchpad (PNP: SYN019b
SYN0100 SYN0002 PNP0f13) says it can support a different bus. If
i2c-hid and hid-rmi are not used, you might want to try setting
psmouse.synaptics_intertouch to 1 and report this to
linux-input@vger.kernel.org.
[   10.485294] psmouse serio4: synaptics: Touchpad model: 1, fw: 8.1,
id: 0x1e2b1, caps: 0xd40123/0x840300/0x26c00/0x0, board id: 2009, fw
id: 1119621
[   10.529272] input: SynPS/2 Synaptics TouchPad as
/devices/platform/i8042/serio4/input/input32

So here I am, reporting in. I recompiled 4.12-rc6 with the following
patch, and enabled CONFIG_RMI4_SMB in my kernel config:

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 16c30460ef04..2cd536b523ad 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -173,6 +173,10 @@ static const char * const smbus_pnp_ids[] = {
  "LEN0046", /* X250 */
  "LEN004a", /* W541 */
  "LEN200f", /* T450s */
+ "SYN019b",
+ "SYN0100",
+ "SYN0002",
+ "PNP0f13",
  NULL
 };

After booting the touchpad worked fine, with the following dmesg output.

[   15.852288] psmouse serio4: synaptics: queried max coordinates: x
[..5648], y [..4806]
[   15.891374] psmouse serio4: synaptics: queried min coordinates: x
[1292..], y [1048..]
[   15.891385] psmouse serio4: synaptics: Trying to set up SMBus access
[   15.901853] rmi4_smbus 11-002c: registering SMbus-connected sensor
[   15.938373] rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer:
Synaptics, product: TM2009-001, fw id: 0
[   15.978114] input: Synaptics TM2009-001 as /devices/rmi4-00/input/input33

If you need any more information, I'd be happy to provide it.

Kind regards,

Sibren Vasse
