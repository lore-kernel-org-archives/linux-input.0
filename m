Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794835947;
	b=bkb7w/O8DvQQQpxPS4q8AzCxgD5QBA6uoSXZTpBJO5uni7k4KoCPLo3Ro9RnZZ1rfnRG
	 gNuEakLZH/rnBjb2AFJWd35/BSoHC7lkOt+vaeivFdroYOTDMhzYjsXILPpcEm5yjgxd9
	 zv5CDQESeOV5aB1FBD3R9CQ8ArhQXClVWBUO+uzeZULmTN9qoaPR1B2a5kSU+QHSSIonS
	 p2dP9N4iXkdR46W9QKLwF37foZq077QMnOD14T9S+7D02YTNNmFpYWu8sSF67Ly82YaTn
	 NyfGKM/1LKqwM4ceSiFOQitjxqUIjKpVJM6GVnEiEaRzHoZy+GV2o70f/BvJZkXmGVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835947;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=Bgkc39IDaycgdB/Ca8fxrvvhdFUDzcjoKXvCphbnqfs=;
	b=a2o/WmzCQ1LjafPGAjSLRDVd1wZseCmp3KbQb1y6kxEmPUGlSXoh5RSJmOgdH4GBuC/P
	 j9bFB5HRKTS8E5bhUbsQbs7kty8JEJejkBbWHBLwOjOAba3s+u7Bdk3z+oA2uzQvRMa97
	 yjfY1X0Dc+qZQFmtKiRNVlIvCPf//vdwUTyifkNeRlY1eBfjPi1tT/ICh9gVA6t0hPaPA
	 IR7KEMvXU26zwl8I5BqaFopu6BLtfROgfyhSHk7J7kiupaxUQNXrxEXqK9wFtjDike3UL
	 /s6pX0cKCSEv3FXxvY+g+pGP7B9F1LwxNMyAvXnxZaASrj/wEcUv2DsdHIBuyHVU0LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=vvfTX2nz;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE39606A31C;
	Mon, 16 Nov 2026 13:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AE39606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=vvfTX2nz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Bgkc39IDaycgdB/Ca8fxrvvhdFUDzcjoKXvCphbnqfs=; b=vvfTX2nz9VsSRP2USwD6YlCa4t
	WsWgoCHvOaPg5TKyu6Ahva/VN0lh8vQ7NpEDi7MCSPlHn6UNuib9YYbgJFzNcKU0eHFjCSNh6lJ+C
	E84nhEOCL8xgT8gstfJfIvXWxG4yn9s4+P/kVDRVRnGaHUm8AZn53QJthN/e3oG+SEBwxSgNPawxE
	PmT1s+/pXFolLBcRh1qng3qk6qtqhVNeLmJxVvaNkOj3xRpb7HSZU5CFHr5b5iukSyg0Pl7GYzUd5
	Y90HjuhsWCdNjhw78Q1SjKLE5+8+iFFtmsuqHE5vEmH/t4mEulvFAtYtjzi9wb5fuKYV5sErosQh/
	47ck6VdQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xSwoo-00HCUK-1T;
	Mon, 16 Nov 2026 13:32:23 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] HID: intel-thc-hid: intel-thc: add the slow SPI gears
Date: Mon, 16 Nov 2026 21:31:31 +0800
Message-ID: <20261116133132.1282020-5-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116133132.1282020-1-emfox@debian.org>
References: <20261116133132.1282020-1-emfox@debian.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Debian-User: emfox

The frequency table stops at 7.8125 MHz, so a device that asks for a
slower clock is rejected with -EINVAL. The divider enum already covers
that range: with the low frequency bit set the divider is multiplied by
eight (see intel-thc-hw.h), which brings DIV_7 down to 2.23 MHz.

Add the five missing gears. The half divider check exempts the new 5.2083
MHz gear, which is already DIV_3 with the eighth divider enabled, so the
extra half divider would land on top of it. The 10.4167 MHz gear is low
frequency as well but keeps the half divider; it is not part of this
change.

The read and write configuration carried identical copies of that check,
so move it to thc_spi_needs_half_div().

Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 .../intel-thc-hid/intel-thc/intel-thc-dev.c   | 43 +++++++++++++++----
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
index 7429f851c..e9c3462e6 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
@@ -1111,6 +1111,12 @@ int thc_port_select(struct thc_device *dev, enum thc_port_type port_type)
 }
 EXPORT_SYMBOL_NS_GPL(thc_port_select, "INTEL_THC");
 
+/* 125 MHz / (8 * N), with the low frequency bit set. */
+#define THC_SPI_FREQUENCY_2M2	2232143
+#define THC_SPI_FREQUENCY_2M6	2604167
+#define THC_SPI_FREQUENCY_3M1	3125000
+#define THC_SPI_FREQUENCY_3M9	3906250
+#define THC_SPI_FREQUENCY_5M2	5208333
 #define THC_SPI_FREQUENCY_7M	7812500
 #define THC_SPI_FREQUENCY_10M	10416700
 #define THC_SPI_FREQUENCY_15M	15625000
@@ -1127,6 +1133,11 @@ EXPORT_SYMBOL_NS_GPL(thc_port_select, "INTEL_THC");
 static u8 thc_get_spi_freq_div_val(struct thc_device *dev, u32 spi_freq_val)
 {
 	static const int frequency[] = {
+		THC_SPI_FREQUENCY_2M2,
+		THC_SPI_FREQUENCY_2M6,
+		THC_SPI_FREQUENCY_3M1,
+		THC_SPI_FREQUENCY_3M9,
+		THC_SPI_FREQUENCY_5M2,
 		THC_SPI_FREQUENCY_7M,
 		THC_SPI_FREQUENCY_10M,
 		THC_SPI_FREQUENCY_15M,
@@ -1139,6 +1150,11 @@ static u8 thc_get_spi_freq_div_val(struct thc_device *dev, u32 spi_freq_val)
 		THC_SPI_FREQUENCY_50M,
 	};
 	static const u8 frequency_div[] = {
+		THC_SPI_FRQ_DIV_7,
+		THC_SPI_FRQ_DIV_6,
+		THC_SPI_FRQ_DIV_5,
+		THC_SPI_FRQ_DIV_4,
+		THC_SPI_FRQ_DIV_3,
 		THC_SPI_FRQ_DIV_2,
 		THC_SPI_FRQ_DIV_1,
 		THC_SPI_FRQ_DIV_1,
@@ -1174,6 +1190,23 @@ static u8 thc_get_spi_freq_div_val(struct thc_device *dev, u32 spi_freq_val)
 	return freq_div;
 }
 
+/*
+ * 10M, 35M and 50M take the half divider; 5.2083 MHz is already DIV_3, and
+ * 10.4167 MHz keeps it.
+ */
+static bool thc_spi_needs_half_div(u8 freq_div, u32 spi_freq_val,
+				   bool is_low_freq)
+{
+	if (freq_div == THC_SPI_FRQ_DIV_2)
+		return spi_freq_val >= THC_SPI_FREQUENCY_50M;
+
+	if (freq_div == THC_SPI_FRQ_DIV_3)
+		return spi_freq_val < THC_SPI_FREQUENCY_41M && !is_low_freq;
+
+	return freq_div == THC_SPI_FRQ_DIV_1 &&
+	       spi_freq_val < THC_SPI_FREQUENCY_15M;
+}
+
 /**
  * thc_spi_read_config - Configure SPI bus read attributes
  *
@@ -1199,10 +1232,7 @@ int thc_spi_read_config(struct thc_device *dev, u32 spi_freq_val,
 	if (spi_freq_val < THC_SPI_LOW_FREQUENCY)
 		is_low_freq = true;
 
-	/* 10M, 35M and 50M CLK need 1.5, 3.5 and 2.5 half divider */
-	if ((freq_div == THC_SPI_FRQ_DIV_2 && spi_freq_val >=  THC_SPI_FREQUENCY_50M) ||
-		(freq_div == THC_SPI_FRQ_DIV_3 && spi_freq_val <  THC_SPI_FREQUENCY_41M) ||
-		(freq_div == THC_SPI_FRQ_DIV_1 && spi_freq_val <  THC_SPI_FREQUENCY_15M)) {
+	if (thc_spi_needs_half_div(freq_div, spi_freq_val, is_low_freq)) {
 		regmap_write_bits(dev->thc_regmap, THC_M_PRT_SPI_DUTYC_CFG_OFFSET,
 				  THC_M_PRT_SPI_DUTYC_CFG_SPI_TCRF_HALF_DIV_EN,
 				  THC_M_PRT_SPI_DUTYC_CFG_SPI_TCRF_HALF_DIV_EN);
@@ -1271,10 +1301,7 @@ int thc_spi_write_config(struct thc_device *dev, u32 spi_freq_val,
 	if (spi_freq_val < THC_SPI_LOW_FREQUENCY)
 		is_low_freq = true;
 
-	/* 10M, 35M and 50M CLK need 1.5, 3.5 and 2.5 half divider */
-	if ((freq_div == THC_SPI_FRQ_DIV_2 && spi_freq_val >=  THC_SPI_FREQUENCY_50M) ||
-		(freq_div == THC_SPI_FRQ_DIV_3 && spi_freq_val <  THC_SPI_FREQUENCY_41M) ||
-		(freq_div == THC_SPI_FRQ_DIV_1 && spi_freq_val <  THC_SPI_FREQUENCY_15M)) {
+	if (thc_spi_needs_half_div(freq_div, spi_freq_val, is_low_freq)) {
 		regmap_write_bits(dev->thc_regmap, THC_M_PRT_SPI_DUTYC_CFG_OFFSET,
 				  THC_M_PRT_SPI_DUTYC_CFG_SPI_TCWF_HALF_DIV_EN,
 				  THC_M_PRT_SPI_DUTYC_CFG_SPI_TCWF_HALF_DIV_EN);
