From: David =?utf-8?b?SMOkcmRlbWFu?= <david@hardeman.nu>
Subject: [PATCH 3/4] Add NECx support to ir-core
Date: Fri, 09 Apr 2010 01:04:35 +0200
Message-ID: <20100408230435.14453.56505.stgit@localhost.localdomain>
References: <20100408230246.14453.97377.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100408230246.14453.97377.stgit@localhost.localdomain>
Sender: linux-media-owner@vger.kernel.org
To: mchehab@redhat.com
Cc: linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This patch adds NECx support to drivers/media/IR/ir-nec-decoder.c

Signed-off-by: David H=C3=A4rdeman <david@hardeman.nu>
---
 drivers/media/IR/ir-nec-decoder.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/media/IR/ir-nec-decoder.c b/drivers/media/IR/ir-ne=
c-decoder.c
index f22d1af..d128c19 100644
--- a/drivers/media/IR/ir-nec-decoder.c
+++ b/drivers/media/IR/ir-nec-decoder.c
@@ -18,6 +18,7 @@
 #define NEC_NBITS		32
 #define NEC_UNIT		562500  /* ns */
 #define NEC_HEADER_PULSE	PULSE(16)
+#define NECX_HEADER_PULSE	PULSE(8) /* Less common NEC variant */
 #define NEC_HEADER_SPACE	SPACE(8)
 #define NEC_REPEAT_SPACE	SPACE(4)
 #define NEC_BIT_PULSE		PULSE(1)
@@ -152,7 +153,7 @@ static int ir_nec_decode(struct input_dev *input_de=
v, s64 duration)
 	switch (data->state) {
=20
 	case STATE_INACTIVE:
-		if (u =3D=3D NEC_HEADER_PULSE) {
+		if (u =3D=3D NEC_HEADER_PULSE || u =3D=3D NECX_HEADER_PULSE) {
 			data->count =3D 0;
 			data->state =3D STATE_HEADER_SPACE;
 		}
