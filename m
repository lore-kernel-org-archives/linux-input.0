From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: [PATCH 06/13] IR: nec decoder: fix repeat.
Date: Sat, 31 Jul 2010 17:59:19 +0300
Message-ID: <1280588366-26101-7-git-send-email-maximlevitsky@gmail.com>
References: <1280588366-26101-1-git-send-email-maximlevitsky@gmail.com>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1280588366-26101-1-git-send-email-maximlevitsky@gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: lirc-list@lists.sourceforge.net
Cc: Jarod Wilson <jarod@wilsonet.com>, linux-input@vger.kernel.org, linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab@redhat.com>, Christoph Bartelmus <lirc@bartelmus.de>, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: linux-input@vger.kernel.org

Repeat space is 4 units, not 8.
Current code would never trigger a repeat.

However that isn't true for NECX, so repeat there
must be handled differently.

Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
Reviewed-by: Andy Walls <awalls@md.metrocast.net>
---
 drivers/media/IR/ir-nec-decoder.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/IR/ir-nec-decoder.c b/drivers/media/IR/ir-nec-decoder.c
index 52e0f37..1c0cf03 100644
--- a/drivers/media/IR/ir-nec-decoder.c
+++ b/drivers/media/IR/ir-nec-decoder.c
@@ -20,7 +20,7 @@
 #define NEC_HEADER_PULSE	(16 * NEC_UNIT)
 #define NECX_HEADER_PULSE	(8  * NEC_UNIT) /* Less common NEC variant */
 #define NEC_HEADER_SPACE	(8  * NEC_UNIT)
-#define NEC_REPEAT_SPACE	(8  * NEC_UNIT)
+#define NEC_REPEAT_SPACE	(4  * NEC_UNIT)
 #define NEC_BIT_PULSE		(1  * NEC_UNIT)
 #define NEC_BIT_0_SPACE		(1  * NEC_UNIT)
 #define NEC_BIT_1_SPACE		(3  * NEC_UNIT)
-- 
1.7.0.4
