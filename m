From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH v2 0/3] Input: fix typo error in MELFAS touch device driver
Date: Thu, 22 May 2014 09:02:24 +0900
Message-ID: <537D3E90.1020805@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:15908 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbaEVACc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 May 2014 20:02:32 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5Y002CK840J9B0@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Thu, 22 May 2014 09:02:24 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Myungjoo Ham <myungjoo.ham@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

This patchset fix typo error in MELFAS touch device drivers.

Changes in v2:
- Add patch set for mms114 and mcs5000_ts drivers.

Beomho Seo (3):
  Input: mcs_touchkey: fix incorrect input device name
  Input: mms114: fix incorrect input device name
  Input: mcs5000_ts: fix incorrect input device name

 drivers/input/keyboard/mcs_touchkey.c  |    2 +-
 drivers/input/touchscreen/mcs5000_ts.c |    2 +-
 drivers/input/touchscreen/mms114.c     |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.7.9.5
