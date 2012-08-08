From: Hui Wang <jason77.wang@gmail.com>
Subject: [PATCH v2 0/2] Input: egalax_ts: parse devicetree to get gpio
Date: Wed, 8 Aug 2012 17:10:32 +0800
Message-ID: <1344417034-30175-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:55211 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932330Ab2HHJLJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Aug 2012 05:11:09 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, jiejing.zhang@freescale.com
Cc: linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

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


Hui Wang (2):
  Input: egalax_ts: get gpio from devicetree node
  Input: add devicetree binding note for egalax_ts

 .../bindings/input/touchscreen/egalax-ts.txt       |   17 +++++++++++++++++
 drivers/input/touchscreen/egalax_ts.c              |   19 ++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt

-- 
1.7.6

