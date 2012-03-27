From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH] Input: tegra-kbc: Fix: Allocate pdata before using it
Date: Tue, 27 Mar 2012 11:24:49 +0530
Message-ID: <28d8716b43c5078b238638ba60a4b170807074b9.1332827588.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:39660 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756243Ab2C0GEU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Mar 2012 02:04:20 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, swarren@nvidia.com
Cc: olof@lixom.net, linux-input@vger.kernel.org, srasal@nvidia.com, Viresh Kumar <viresh.kumar@st.com>

Following commit broke DT support for tegra-kbc by removing pdata allocation
completely.

commit 023cea0ecfa2df034096c3f4afa796a0b2d1188a
Author: Shridhar Rasal <srasal@nvidia.com>
Date:   Fri Feb 3 00:27:30 2012 -0800

    Input: tegra-kbc - allow skipping setting up some of GPIO pins

This patch restores it.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/input/keyboard/tegra-kbc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 96ee31e..5827fbe 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -630,6 +630,7 @@ tegra_kbc_dt_parse_pdata(struct platform_device *pdev)
 	if (!np)
 		return NULL;
 
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return NULL;
 
-- 
1.7.10.rc2.10.gb47606

