From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [RFC/PATCH 2/3] DT: input: adp5589: add adp5589 include file
Date: Wed,  7 May 2014 10:00:43 -0300
Message-ID: <1399467644-27222-3-git-send-email-guido@vanguardiasur.com.ar>
References: <1399467644-27222-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1399467644-27222-1-git-send-email-guido@vanguardiasur.com.ar>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
List-Id: linux-input@vger.kernel.org

Add include file with macros ADP_COL and ADP_ROW, used to specify pull
configuration for the adp5589.

Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
---
 include/dt-bindings/input/adp5589.h | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 include/dt-bindings/input/adp5589.h

diff --git a/include/dt-bindings/input/adp5589.h b/include/dt-bindings/=
input/adp5589.h
new file mode 100644
index 0000000..5285003
--- /dev/null
+++ b/include/dt-bindings/input/adp5589.h
@@ -0,0 +1,7 @@
+#ifndef _DT_BINDINGS_INPUT_ADP5589_H
+#define _DT_BINDINGS_INPUT_ADP5589_H
+
+#define ADP_ROW(x)	(1 << (x))
+#define ADP_COL(x)	(1 << (8+(x)))
+
+#endif
--=20
2.0.0.rc0
