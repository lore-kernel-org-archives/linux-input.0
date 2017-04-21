From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v2 3/5] MAINTAINERS: add Atmel PTC entries
Date: Fri, 21 Apr 2017 10:39:22 +0200
Message-ID: <20170421083924.15096-4-ludovic.desroches@microchip.com>
References: <20170421083924.15096-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:18883 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036961AbdDUIk1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 21 Apr 2017 04:40:27 -0400
In-Reply-To: <20170421083924.15096-1-ludovic.desroches@microchip.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>

Add entries for the Atmel PTC Subsystem.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 860dacb..e1b8b0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2323,6 +2323,13 @@ F:	Documentation/devicetree/bindings/input/atmel,maxtouch.txt
 F:	drivers/input/touchscreen/atmel_mxt_ts.c
 F:	include/linux/platform_data/atmel_mxt_ts.h
 
+ATMEL PTC SUBSYSTEM DRIVER
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+L:	linux-input@vger.kernel.org
+S:	Supported
+F:	drivers/input/misc/atmel_ptc.c
+F:	include/uapi/linux/atmel_ptc.h
+
 ATTO EXPRESSSAS SAS/SATA RAID SCSI DRIVER
 M:	Bradley Grove <linuxdrivers@attotech.com>
 L:	linux-scsi@vger.kernel.org
-- 
2.9.0

