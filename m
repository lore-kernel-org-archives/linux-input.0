From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 21/54] MAINTAINERS: Add file patterns for serio device tree bindings
Date: Sun, 22 May 2016 11:05:58 +0200
Message-ID: <1463907991-7916-22-git-send-email-geert@linux-m68k.org>
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
---
Please apply this patch directly if you want to be involved in device
tree binding documentation for your subsystem.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5cf50bf461c4255e..528c5ecd59d50ab5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5885,6 +5885,7 @@ F:	include/linux/input.h
 F:	include/uapi/linux/input.h
 F:	include/linux/input/
 F:	Documentation/devicetree/bindings/input/
+F:	Documentation/devicetree/bindings/serio/
 
 INPUT MULTITOUCH (MT) PROTOCOL
 M:	Henrik Rydberg <rydberg@bitmath.org>
-- 
1.9.1
