From: Sangwon Jee <jeesw@melfas.com>
Subject: Input: melfas_mip4 - add maintainer information
Date: Thu,  6 Oct 2016 15:48:03 +0900
Message-ID: <1475736483-5150-1-git-send-email-jeesw@melfas.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sbs.melfas.com ([39.118.242.30]:44523 "EHLO sbs.melfas.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753329AbcJFGrr (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 6 Oct 2016 02:47:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, jeesw@melfas.com

Add maintainer information.

Signed-off-by: Sangwon Jee <jeesw@melfas.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 630151f..f88e97e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7155,6 +7155,13 @@ F:	Documentation/scsi/megaraid.txt
 F:	drivers/scsi/megaraid.*
 F:	drivers/scsi/megaraid/
 
+MELFAS MIP4 TOUCHSCREEN DRIVER
+M:	Sangwon Jee <jeesw@melfas.com>
+W:	http://www.melfas.com
+S:	Supported
+F:	drivers/input/touchscreen/melfas_mip4*
+F:	Documentation/devicetree/bindings/input/touchscreen/melfas_mip4*
+
 MELLANOX ETHERNET DRIVER (mlx4_en)
 M: 	Eugenia Emantayev <eugenia@mellanox.com>
 L:	netdev@vger.kernel.org
-- 
1.9.1

