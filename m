From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH v2 0/2] Use devm_* functions for Melfas touch device.
Date: Mon, 26 May 2014 22:29:10 +0900
Message-ID: <1401110952-25602-1-git-send-email-beomho.seo@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:13807 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbaEZN3Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 May 2014 09:29:16 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N66002VBO4QWA50@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Mon, 26 May 2014 22:29:14 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, jy0922.shim@samsung.com, sachin.kamat@linaro.org
Cc: myungjoo.ham@samsung.com, jh80.chung@samsung.com, cw00.choi@samsung.com, Beomho Seo <beomho.seo@samsung.com>

This patch set devm_* functions in Melfas touche device driver.
As a result, error path and remove() function is simplified.

Changes in v2:
- Additionally use devm_kzalloc mcs_[touchkey/ts]_data struct.

Beomho Seo (2):
  Input: mcs_touchkey: use devm_* functions
  Input: mcs5000_ts: use devm_* functions.

 drivers/input/keyboard/mcs_touchkey.c  |   53 +++++++++-----------------------
 drivers/input/touchscreen/mcs5000_ts.c |   42 ++++++++-----------------
 2 files changed, 26 insertions(+), 69 deletions(-)

-- 
1.7.9.5

