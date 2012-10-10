From: Hui Wang <jason77.wang@gmail.com>
Subject: [PATCH v4 RESEND 0/3] Input: egalax_ts: parse devicetree to get gpio
Date: Wed, 10 Oct 2012 17:12:00 +0800
Message-ID: <1349860323-12786-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:63543 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab2JJJMM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Oct 2012 05:12:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, jiejing.zhang@freescale.com, shawn.guo@linaro.org
Cc: linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

Hi Dmitry,

The patchset was sent out for review during the time you were away
from the maillist. Now you are back, i rebase the patchset to the latest
upstream and i resend them to you to catch your notice.

The patchset has been reviewed by JieJing and Shawn, if you are OK
for the patchset, please apply 0001-xxx.patch and 0002-xxx.patch to
your tree. Shawn will merge 0003-xxx.patch from his tree.

Thanks,
Hui.

Hui Wang (3):
  Input: egalax_ts: get gpio from devicetree node
  Input: add devicetree binding note for egalax_ts
  ARM: dts: imx6q-sabrelite: add eeti egalax touchscreen

 .../bindings/input/touchscreen/egalax-ts.txt       |   19 +++++++++++++++
 arch/arm/boot/dts/imx6q-sabrelite.dts              |   16 ++++++++++++
 arch/arm/boot/dts/imx6q.dtsi                       |    9 +++++++
 drivers/input/touchscreen/egalax_ts.c              |   25 +++++++++++++++++--
 4 files changed, 66 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt

-- 
1.7.6

