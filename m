From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2] Input: palmas: add support for palmas power button
Date: Mon, 18 Aug 2014 15:13:28 -0500
Message-ID: <1408392810-16011-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36102 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353AbaHRUOc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Aug 2014 16:14:32 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

Many Palmas PMIC variants have support for power button feature. This
feature depends on certain One Time Program (OTP) and board pull configurations
(POWERHOLD signal). However, on many platforms such as DRA72-evm, OMAP5-uevm,
this may be used to generate input events similar to twl4030-pwrbutton.c

Series is based on v3.17-rc1
Nishanth Menon (2):
  doc: dt/bindings: input: introduce palmas power button description
  Input: misc: introduce palmas-pwrbutton

 .../bindings/input/ti,palmas-pwrbutton.txt         |   32 ++
 drivers/input/misc/Kconfig                         |   10 +
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/palmas-pwrbutton.c              |  313 ++++++++++++++++++++
 4 files changed, 356 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/ti,palmas-pwrbutton.txt
 create mode 100644 drivers/input/misc/palmas-pwrbutton.c

-- 
1.7.9.5

