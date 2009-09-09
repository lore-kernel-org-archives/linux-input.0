From: Jinsung Yang <jsgood.yang@samsung.com>
Subject: [PATCH 0/4] Fixed keypad driver for Samsung SoC
Date: Wed, 09 Sep 2009 20:13:14 +0900
Message-ID: <000d01ca313e$867e7bd0$937b7370$%yang@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:43906 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbZIILKa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Sep 2009 07:10:30 -0400
Received: from epmmp1 (mailout2.samsung.com [203.254.224.25])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KPP00DQGB1KD9@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Wed, 09 Sep 2009 20:10:32 +0900 (KST)
Received: from JSGOODMAIN ([12.23.109.106])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KPP00KANB1K5V@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Wed, 09 Sep 2009 20:10:32 +0900 (KST)
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, ben-linux@fluff.org
Cc: linux-input@vger.kernel.org, laforge@gnumonks.org, =?utf-8?B?J+q5gOqyveydvC9BUOqwnOuwnO2MgChTWVMuTFNJKS9FMyjsgqzsm5Ap?= =?utf-8?B?L+yCvOyEseyghOyekCc=?= <ki0351.kim@samsung.com>, =?utf-8?B?J+q5gOq1reynhC9BUOqwnOuwnO2MgChTWVMuTFNJKS9FNSjssYXsnoQp?= =?utf-8?B?L+yCvOyEseyghOyekCc=?= <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org

From: Jinsung Yang <jsgood.yang@samsung.com>

To Dmitry:
This patch series are including new Samsung SoC keypad driver with fixing wrong implementations which commented by you.
All changes and adds are in single patch.

[PATCH 1/4] [INPUT][KEYBOARD] Samsung keypad driver support

This patch depends on following architecture patches:

[PATCH 2/4] [ARM][S3C] Add definition for keypad platform data
[PATCH 3/4] [ARM][S3C] Add definition for keypad register
[PATCH 4/4] [ARM][S3C] Add support keypad platform data

To Ben:
As you know, I sent to you 12 patches for keypad driver some days ago,
however I need to change several patch files with following guidance:

This [PATCH 2/4] must be used instead of old [PATCH 07/12]
This [PATCH 3/4] must be used instead of old [PATCH 09/12]
This [PATCH 4/4] must be used instead of old both [PATCH 11/12] and [PATCH 12/12]

Best Regards
--
Jinsung, Yang <jsgood.yang@samsung.com>
AP Development Team
System LSI, Semiconductor Business
SAMSUNG Electronics Co., LTD



