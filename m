From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH 0/2] Input: mcs_touchkey: Adding device tree support for mcs
 touch key
Date: Wed, 21 May 2014 14:51:40 +0900
Message-ID: <537C3EEC.8090905@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:53973 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbaEUFvm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 May 2014 01:51:42 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, Joonyoung Shim <jy0922.shim@samsung.com>, mark.rutland@arm.com
Cc: Myungjoo Ham <myungjoo.ham@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

This patch adds the possibility to get the data from the device tree.
It is based on next branch. and tested on exynos4412 board.

Beomho Seo (2):
  Input: mcs_touchkey: add device tree support
  Input: mcs_touchkey: add device tree binding document

 .../devicetree/bindings/input/mcs-touchkey.txt     |   25 +++++++
 drivers/input/keyboard/mcs_touchkey.c              |   73 ++++++++++++++++++--
 2 files changed, 94 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/mcs-touchkey.txt

-- 
1.7.9.5
