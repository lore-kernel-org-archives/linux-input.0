From: "Oskar Schirmer" <os@emlix.com>
Subject: [PATCH] ad7877: keep dma rx buffers in seperate cache lines
Date: Thu,  6 May 2010 12:37:45 +0200
Message-ID: <1273142265-11929-2-git-send-email-os@emlix.com>
References: <1273142265-11929-1-git-send-email-os@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1273142265-11929-1-git-send-email-os@emlix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mike Frysinger <vapier@gentoo.org>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Oskar Schirmer <os@emlix.com>, =?utf-8?q?Daniel=20Gl=C3=B6ckner?= <dg@emlix.com>, Oliver Schneidewind <osw@emlix.com>, Johannes Weiner <jw@emlix.com>
List-Id: linux-input@vger.kernel.org

With dma based spi transmission, data corruption
is observed occasionally. With dma buffers located
right next to msg and xfer fields, cache lines
correctly flushed in preparation for dma usage
may be polluted again when writing to fields
in the same cache line.

Make sure cache fields used with dma do not
share cache lines with fields changed during
dma handling. As both fields are part of a
struct that is allocated via kzalloc, thus
cache aligned, moving the fields to the 1st
position and insert padding for alignment
does the job.

Signed-off-by: Oskar Schirmer <os@emlix.com>
Signed-off-by: Daniel Gl=C3=B6ckner <dg@emlix.com>
Signed-off-by: Oliver Schneidewind <osw@emlix.com>
Signed-off-by: Johannes Weiner <jw@emlix.com>
---
 drivers/input/touchscreen/ad7877.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchsc=
reen/ad7877.c
index 92acd85..9719368 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -153,15 +153,21 @@ enum {
  */
=20
 struct ser_req {
+	u16			sample;
+	char			__padalign[L1_CACHE_BYTES - sizeof(u16)];
+
 	u16			reset;
 	u16			ref_on;
 	u16			command;
-	u16			sample;
 	struct spi_message	msg;
 	struct spi_transfer	xfer[6];
 };
=20
 struct ad7877 {
+	u16			conversion_data[AD7877_NR_SENSE];
+	char			__padalign[L1_CACHE_BYTES
+					- AD7877_NR_SENSE * sizeof(u16)];
+
 	struct input_dev	*input;
 	char			phys[32];
=20
@@ -182,8 +188,6 @@ struct ad7877 {
 	u8			averaging;
 	u8			pen_down_acc_interval;
=20
-	u16			conversion_data[AD7877_NR_SENSE];
-
 	struct spi_transfer	xfer[AD7877_NR_SENSE + 2];
 	struct spi_message	msg;
=20
--=20
1.5.3.7
