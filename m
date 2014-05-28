From: Beomho Seo <beomho.seo@samsung.com>
Subject: [RESEND PATCH v4 0/2] Use devm_* functions for Melfas touch device
Date: Wed, 28 May 2014 18:13:14 +0900
Message-ID: <1401268396-23072-1-git-send-email-beomho.seo@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:44147 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbaE1JNT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 May 2014 05:13:19 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N6A008XT1M6JUA0@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Wed, 28 May 2014 18:13:18 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, jy0922.shim@samsung.com, sachin.kamat@linaro.org
Cc: myungjoo.ham@samsung.com, jh80.chung@samsung.com, cw00.choi@samsung.com, Beomho Seo <beomho.seo@samsung.com>

This patch set devm_* functions in Melfas touche device driver.
As a result, error path and remove() function is simplified.

Changes in v4:
- mcs_touchkey: add free_irq for equivalent transformation.

Changes in v3:
- mcs_touchkey: Some codes are back again.

Changes in v2:
- Additionally use devm_kzalloc mcs_[touchkey/ts]_data struct.

Beomho Seo (2):
  Input: mcs_touchkey: use devm_* functions
  Input: mcs5000_ts: use devm_* functions

 drivers/input/keyboard/mcs_touchkey.c  |   34 +++++++++-----------------
 drivers/input/touchscreen/mcs5000_ts.c |   42 +++++++++-----------------------
 2 files changed, 24 insertions(+), 52 deletions(-)

-- 
1.7.9.5

