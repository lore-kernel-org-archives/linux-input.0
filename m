From: Moritz Fischer <moritz.fischer@ettus.com>
Subject: [PATCH v2 3/3] Update MAINTAINERS file with e3x0-button info.
Date: Thu,  8 Jan 2015 23:43:11 +0100
Message-ID: <1420756991-16506-4-git-send-email-moritz.fischer@ettus.com>
References: <1420756991-16506-1-git-send-email-moritz.fischer@ettus.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420756991-16506-1-git-send-email-moritz.fischer@ettus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Moritz Fischer <moritz.fischer@ettus.com>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddb9ac8..65358d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3466,6 +3466,14 @@ M:	"Maciej W. Rozycki" <macro@linux-mips.org>
 S:	Maintained
 F:	drivers/tty/serial/dz.*
 
+E3X0 POWER BUTTON DRIVER
+M:	Moritz Fischer <moritz.fischer@ettus.com>
+L:	usrp-users@lists.ettus.com
+W:	http://www.ettus.com
+S:	Supported
+F:	drivers/input/misc/e3x0-button.c
+F:	Documentation/devicetree/bindings/input/e3x0-button.txt
+
 E4000 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-- 
1.9.3
