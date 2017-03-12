From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 18/23] MAINTAINERS: Add file patterns for serio device tree bindings
Date: Sun, 12 Mar 2017 14:17:02 +0100
Message-ID: <1489324627-19126-19-git-send-email-geert@linux-m68k.org>
References: <1489324627-19126-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:50046 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755766AbdCLNRO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 12 Mar 2017 09:17:14 -0400
In-Reply-To: <1489324627-19126-1-git-send-email-geert@linux-m68k.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
---
Please apply this patch directly if you want to be involved in device
tree binding documentation for your subsystem.

v2:
  - Add Acked-by.

Impact on next-20170310:

+Dmitry Torokhov <dmitry.torokhov@gmail.com> (maintainer:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)...)
 Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
 Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
+linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)...)
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
 linux-kernel@vger.kernel.org (open list)
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5346accadb97bde2..271b2df4bc27f28b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6489,6 +6489,7 @@ F:	include/linux/input.h
 F:	include/uapi/linux/input.h
 F:	include/linux/input/
 F:	Documentation/devicetree/bindings/input/
+F:	Documentation/devicetree/bindings/serio/
 
 INPUT MULTITOUCH (MT) PROTOCOL
 M:	Henrik Rydberg <rydberg@bitmath.org>
-- 
2.7.4

