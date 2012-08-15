From: Hui Wang <jason77.wang@gmail.com>
Subject: [PATCH v3 0/3] Input: egalax_ts: parse devicetree to get gpio
Date: Wed, 15 Aug 2012 18:31:45 +0800
Message-ID: <1345026708-14139-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:54091 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab2HOKcg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Aug 2012 06:32:36 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, jiejing.zhang@freescale.com, shawn.guo@linaro.org
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

V3:

Although have got Ack-by from driver author in the V2, i have to send
V3 since the driver is changed due to the change of a property name
in the dts.

As Shawn.guo suggested, i renamed property "irq-gpio" to "wakeup-gpios".
The reason is that, firstly the idiom of gpio naming in DT is *-gpios,
even though most of time, it could be just one gpio, secondly as the pin is
accessed as a gpio only in egalax_wake_up_device for waking up the device.

This time i send the patches both to linux-input and linux-arm, 0001 and
0002 belongs to linux-input, while the 0003 belongs to linux-arm.

V2:

Add return value checking for waking up the controller in the probe
function.

V1:

eeti touch screen controller is an external chip for most platforms,
it connect to CPU via i2c bus, and it has a irq request pin need to be
connected to a gpio of the CPU, this irq request pin also act as a
wake up signal for touch screen controller, we need to get this gpio
number and operate it to wake up the controller, the old way to get
gpio is irq_to_gpio(), this API is dying and most platforms don't support
it, we change it to a more generic way to use devcietree.

Hui Wang (3):
  Input: egalax_ts: get gpio from devicetree node
  Input: add devicetree binding note for egalax_ts
  ARM: dts: imx6q-sabrelite: add eeti egalax touchscreen

 .../bindings/input/touchscreen/egalax-ts.txt       |   19 +++++++++++++++++++
 arch/arm/boot/dts/imx6q-sabrelite.dts              |   16 ++++++++++++++++
 arch/arm/boot/dts/imx6q.dtsi                       |    7 +++++++
 drivers/input/touchscreen/egalax_ts.c              |   19 ++++++++++++++++---
 4 files changed, 58 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt

-- 
1.7.6

