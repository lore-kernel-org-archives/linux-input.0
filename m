From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 12/17] Input: tsc2005 - do not use 0 in place of NULL
Date: Wed, 16 Mar 2011 00:19:02 -0700
Message-ID: <20110316071902.25664.96420.stgit@hammer.corenet.prv>
References: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36065 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1CPHTG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 03:19:06 -0400
Received: by mail-yw0-f46.google.com with SMTP id 3so546490ywj.19
        for <linux-input@vger.kernel.org>; Wed, 16 Mar 2011 00:19:06 -0700 (PDT)
In-Reply-To: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

Sparse in unhappy when people use 0 instead of NULL for pointers so
let's rework the way we initialize spi_transfer structure in
tsc2005_cmd() and tsc2005_write().

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/tsc2005.c |   36 ++++++++++++++++-------------------
 1 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index bfcff96..8a9c072 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -148,16 +148,13 @@ struct tsc2005 {
 
 static void tsc2005_cmd(struct tsc2005 *ts, u8 cmd)
 {
-	u8 tx;
+	u8 tx = TSC2005_CMD | TSC2005_CMD_12BIT | cmd;
+	struct spi_transfer xfer = {
+		.tx_buf		= &tx,
+		.len		= 1,
+		.bits_per_word	= 8,
+	};
 	struct spi_message msg;
-	struct spi_transfer xfer = { 0 };
-
-	tx = TSC2005_CMD | TSC2005_CMD_12BIT | cmd;
-
-	xfer.tx_buf = &tx;
-	xfer.rx_buf = NULL;
-	xfer.len = 1;
-	xfer.bits_per_word = 8;
 
 	spi_message_init(&msg);
 	spi_message_add_tail(&xfer, &msg);
@@ -166,17 +163,13 @@ static void tsc2005_cmd(struct tsc2005 *ts, u8 cmd)
 
 static void tsc2005_write(struct tsc2005 *ts, u8 reg, u16 value)
 {
-	u32 tx;
+	u32 tx = ((reg | TSC2005_REG_PND0) << 16) | value;
+	struct spi_transfer xfer = {
+		.tx_buf		= &tx,
+		.len		= 4,
+		.bits_per_word	= 24,
+	};
 	struct spi_message msg;
-	struct spi_transfer xfer = { 0 };
-
-	tx = (reg | TSC2005_REG_PND0) << 16;
-	tx |= value;
-
-	xfer.tx_buf = &tx;
-	xfer.rx_buf = NULL;
-	xfer.len = 4;
-	xfer.bits_per_word = 24;
 
 	spi_message_init(&msg);
 	spi_message_add_tail(&xfer, &msg);
@@ -185,6 +178,8 @@ static void tsc2005_write(struct tsc2005 *ts, u8 reg, u16 value)
 
 static void tsc2005_setup_read(struct tsc2005_spi_rd *rd, u8 reg, bool last)
 {
+	memset(rd, 0, sizeof(*rd));
+
 	rd->spi_tx		   = (reg | TSC2005_REG_READ) << 16;
 	rd->spi_xfer.tx_buf	   = &rd->spi_tx;
 	rd->spi_xfer.rx_buf	   = &rd->spi_rx;
@@ -195,14 +190,15 @@ static void tsc2005_setup_read(struct tsc2005_spi_rd *rd, u8 reg, bool last)
 
 static void tsc2005_read(struct tsc2005 *ts, u8 reg, u16 *value)
 {
+	struct tsc2005_spi_rd spi_rd;
 	struct spi_message msg;
-	struct tsc2005_spi_rd spi_rd = { { 0 }, 0, 0 };
 
 	tsc2005_setup_read(&spi_rd, reg, true);
 
 	spi_message_init(&msg);
 	spi_message_add_tail(&spi_rd.spi_xfer, &msg);
 	spi_sync(ts->spi, &msg);
+
 	*value = spi_rd.spi_rx;
 }
 

