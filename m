From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH 0/2] Use devm_* functions for Melfas touch device.
Date: Thu, 22 May 2014 20:26:18 +0900
Message-ID: <1400757980-15156-1-git-send-email-beomho.seo@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:34712 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767AbaEVL0Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 May 2014 07:26:24 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5Z006PC3RY1I90@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Thu, 22 May 2014 20:26:22 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, jy0922.shim@samsung.com
Cc: sachin.kamat@linaro.org, myungjoo.ham@samsung.com, jh80.chung@samsung.com, cw00.choi@samsung.com, Beomho Seo <beomho.seo@samsung.com>

This patch set devm_* functions in Melfas touche device driver.
As a result, error path and remove() function is simplified.

Beomho Seo (2):
  Input: mcs_touchkey: use devm_* functions
  Input: mcs5000_ts: use devm_* functions.

 drivers/input/keyboard/mcs_touchkey.c  |   49 +++++++++-----------------------
 drivers/input/touchscreen/mcs5000_ts.c |   40 +++++++-------------------
 2 files changed, 24 insertions(+), 65 deletions(-)
-- 
1.7.9.5
