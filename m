From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 1/2] devicetree: i2c-hid: Add Wacom digitizer + regulator support
Date: Wed, 30 Nov 2016 17:21:27 -0800
Message-ID: <1480555288-142791-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36303 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbcLABWY (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 30 Nov 2016 20:22:24 -0500
Received: by mail-pf0-f173.google.com with SMTP id 189so42337704pfz.3
        for <linux-input@vger.kernel.org>; Wed, 30 Nov 2016 17:22:24 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Caesar Wang <wxt@rock-chips.com>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Doug Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>

From: Caesar Wang <wxt@rock-chips.com>

Add a compatible string and regulator property for Wacom W9103
digitizer. Its VDD supply may need to be enabled before using it.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
v1 was a few months back. I finally got around to rewriting it based on
DT binding feedback.

v2:
 * add compatible property for wacom
 * name the regulator property specifically (VDD)

 Documentation/devicetree/bindings/input/hid-over-i2c.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.txt b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
index 488edcb264c4..eb98054e60c9 100644
--- a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
+++ b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
@@ -11,12 +11,16 @@ If this binding is used, the kernel module i2c-hid will handle the communication
 with the device and the generic hid core layer will handle the protocol.
 
 Required properties:
-- compatible: must be "hid-over-i2c"
+- compatible: must be "hid-over-i2c", or a device-specific string like:
+    * "wacom,w9013"
 - reg: i2c slave address
 - hid-descr-addr: HID descriptor address
 - interrupt-parent: the phandle for the interrupt controller
 - interrupts: interrupt line
 
+Optional properties:
+- vdd-supply: phandle of the regulator that provides the supply voltage.
+
 Example:
 
 	i2c-hid-dev@2c {
-- 
2.8.0.rc3.226.g39d4020

