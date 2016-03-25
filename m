From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCHv14 03/18] dts: exynos4412-odroid*: enable the HDMI CEC device
Date: Fri, 25 Mar 2016 14:10:01 +0100
Message-ID: <1458911416-47981-4-git-send-email-hverkuil@xs4all.nl>
References: <1458911416-47981-1-git-send-email-hverkuil@xs4all.nl>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lb1-smtp-cloud2.xs4all.net ([194.109.24.21]:41674 "EHLO
	lb1-smtp-cloud2.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752392AbcCYNKf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Mar 2016 09:10:35 -0400
In-Reply-To: <1458911416-47981-1-git-send-email-hverkuil@xs4all.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, lars@opdenkamp.eu, linux@arm.linux.org.uk, Marek Szyprowski <m.szyprowski@samsung.com>, Hans Verkuil <hans.verkuil@cisco.com>

From: Marek Szyprowski <m.szyprowski@samsung.com>

Add a dts node entry and enable the HDMI CEC device present in the Exynos4
family of SoCs.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 395c3ca..c9b1425 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -500,3 +500,7 @@
 &watchdog {
 	status = "okay";
 };
+
+&hdmicec {
+	status = "okay";
+};
-- 
2.7.0

