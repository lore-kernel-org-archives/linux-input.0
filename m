From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH v5 0/1] Use devm_* functions for Melfas touch device
Date: Thu, 29 May 2014 23:15:47 +0900
Message-ID: <1401372948-13900-1-git-send-email-beomho.seo@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:42570 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935034AbaE2OPx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 May 2014 10:15:53 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N6C00984AAFM920@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 29 May 2014 23:15:51 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, jy0922.shim@samsung.com, sachin.kamat@linaro.org
Cc: myungjoo.ham@samsung.com, jh80.chung@samsung.com, cw00.choi@samsung.com, Beomho Seo <beomho.seo@samsung.com>

This patch set devm_* functions in Melfas touche device driver.
As a result, error path and remove() function is simplified.

Changes in v5:
- mcs_touchkey: use devm_add_action.
- mcs5000_ts: applied.

Changes in v4:
- mcs_touchkey: add free_irq for equivalent transformation.

Changes in v3:
- mcs_touchkey: Some codes are back again.

Changes in v2:
- Additionally use devm_kzalloc mcs_[touchkey/ts]_data struct.

*** BLURB HERE ***

Beomho Seo (1):
  Input: mcs_touchkey: use devm_* functions

 drivers/input/keyboard/mcs_touchkey.c |   60 ++++++++++++++-------------------
 1 file changed, 26 insertions(+), 34 deletions(-)

-- 
1.7.9.5

