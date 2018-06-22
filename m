From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [RESEND PATCH v2] MAINTAINERS: add PhoenixRC Flight Controller Adapter
Date: Fri, 22 Jun 2018 19:06:05 +0200
Message-ID: <20180622170605.8411-1-marcus.folkesson@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S . Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
List-Id: linux-input@vger.kernel.org

Add MAINTAINERS entry for PhoenixRC Flight Controller Adapter

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v2:
    	Add proper mailing list

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ce5062dc028..d8b5d9f810e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11103,6 +11103,13 @@ S:	Maintained
 F:	include/linux/personality.h
 F:	include/uapi/linux/personality.h
 
+PHOENIX RC FLIGHT CONTROLLER ADAPTER
+M:	Marcus Folkesson <marcus.folkesson@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/input/devices/pxrc.rst
+F:	drivers/input/joystick/pxrc.c
+
 PHONET PROTOCOL
 M:	Remi Denis-Courmont <courmisch@gmail.com>
 S:	Supported
-- 
2.16.2
