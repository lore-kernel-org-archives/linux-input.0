From: Aleksei Mamlin <mamlinav@gmail.com>
Subject: [PATCH 1/2] devicetree: bindings: Add vendor prefix for Domintech Co., Ltd.
Date: Mon, 18 Jul 2016 15:48:11 +0300
Message-ID: <1468846092-18914-2-git-send-email-mamlinav@gmail.com>
References: <1468846092-18914-1-git-send-email-mamlinav@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36014 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbcGRMsh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jul 2016 08:48:37 -0400
In-Reply-To: <1468846092-18914-1-git-send-email-mamlinav@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksei Mamlin <mamlinav@gmail.com>

Add vendor-prefix for Domintech Co., Ltd.

Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index d2bce22..0c12f2d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -75,6 +75,7 @@ digilent	Diglent, Inc.
 dlg	Dialog Semiconductor
 dlink	D-Link Corporation
 dmo	Data Modul AG
+domintech	Domintech Co., Ltd.
 dptechnics	DPTechnics
 dragino	Dragino Technology Co., Limited
 ea	Embedded Artists AB
-- 
2.7.3

