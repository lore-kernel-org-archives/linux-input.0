Return-Path: <SRS0=VgpC=DH=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83BFC4727F
	for <linux-input@archiver.kernel.org>; Wed, 30 Sep 2020 15:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5938A2071E
	for <linux-input@archiver.kernel.org>; Wed, 30 Sep 2020 15:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgI3PNf (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:13:35 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:9476 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbgI3PNS (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 30 Sep 2020 11:13:18 -0400
IronPort-SDR: nSLQ961igttQQFDXguzwLhOQoqV+OJ5/NRMVroTHD56kizVKBIwc+0oNmhIPNQ7mW+MVfcf2t8
 WxdYs3LjqCQtwOSv6urZPipKWzS4gY17MNrim2daIZghZ/O9narY7GoH73mbsFHgrk8SBC7vhl
 o5IYmM4M+fud6s+lD4eJm7WwCMXOH2TpGouXvMf9IEMRi7j+lv8ezbHSIva8sLIWe3KWiAx/KF
 yi5BOyvZFW8qoTX4cn/lmqGfwiCdghoO1trO9rxWiEgPRr0xBcV7UPSshp5i2sNjaxx/tBfwO7
 ENQ=
X-IronPort-AV: E=Sophos;i="5.77,322,1596528000"; 
   d="scan'208";a="53484685"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa2.mentor.iphmx.com with ESMTP; 30 Sep 2020 07:13:16 -0800
IronPort-SDR: AhD9Pi2PvHyXGBdiXvnDQJCnZU0KZeP70Ol0MF3R+NbwGTd4NGhvoTiCkEETjpslS11JaScN5l
 d8qGYNkmdEsw/Z7Hu3ii5bJK6FNdHq1oz5I0NZHrkKOBqMVb1WWvVTaWUtDZcsd63bMdkDxfN9
 rmvBDbowvTb7IsP3UO/kG6Ue97WMoaKDblImtA9qHJS1FRtnbidWAz2ykAb01irAKznV596fUC
 KZRypC5kGLkjOpMJ6mS9dy+rF56GFt0nGk+jqM6oMaLQhvlLvksajJ13dzdA5pO384zezuhvSJ
 Yos=
From:   Jiada Wang <jiada_wang@mentor.com>
To:     <dmitry.torokhov@gmail.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <digetx@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <nick@shmanahar.org>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <erosca@de.adit-jv.com>, <andrew_gabbasov@mentor.com>,
        <jiada_wang@mentor.com>
Subject: [PATCH v3 3/3] ARM: tegra: add mXT1386 compatible
Date:   Thu, 1 Oct 2020 00:12:59 +0900
Message-ID: <20200930151259.18119-4-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930151259.18119-1-jiada_wang@mentor.com>
References: <20200930151259.18119-1-jiada_wang@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Add mXT1386 compatible for "touchscreen@4c".

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 arch/arm/boot/dts/tegra20-acer-a500-picasso.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
index 2d683c9a1a5d..a9eed5f6973b 100644
--- a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
+++ b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
@@ -428,7 +428,7 @@
 		};
 
 		touchscreen@4c {
-			compatible = "atmel,maxtouch";
+			compatible = "atmel,mxt1386", "atmel,maxtouch";
 			reg = <0x4c>;
 
 			atmel,cfg_name = "maxtouch-acer-iconia-tab-a500.cfg";
-- 
2.17.1

