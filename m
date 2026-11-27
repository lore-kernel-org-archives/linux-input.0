Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791614;
	b=HRuSy0y1ptu5qNPVq+J1deXeLrBUBPoV0DUOu9YSJ3/10JrrkxQjbjzWyhgfas+HjqK5
	 URMV0GLi4aygTrK/GDHQAFnNFg44ZUExx2PxgHzeiyoXBdtmXadNOMiiyjwKEbhp0v4qd
	 2ubwuUTSqp8TgOwyQNDmrusBxSbjlOxOVwMXmXBpT99elrdak2XO8ZCVSWLwhyWscoYJI
	 nu7pOF8oxYFLTtAyiJ+1xj6/s11rnjLPVXHEAV1i/av2fYORjwS3n8JtYgiK33Ij/tVMb
	 gFTd+q0msIlLjNL5+QoQV9jirNxQuD2A5W4drq+D42G9SVnoNtyiGV+5Xb/PgcQSbOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791614;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=7MHE4DsABzir314JnlHgXrOD3pwhBzGh2rmqJkccc84=;
	b=KDTkSLI5IjNplMi0QUV2blwsMqemBP0UZS2K75voYYCt0c5pwNCFZePoixOeG4w17R8K
	 0l6eoJTGCKeH/qKSSUR4TfLeQdUdtuBKYM6AVcLjT8cxZhGSRrDicupfc9mEJ9ahiFxk1
	 1NHjTdU8CJUPVoRTCMyYyKcnx9BpiYhKoRbHkzByzDWH15JnzAKAgYy83i5xAeaRy93TS
	 4xGmiXOV1PZE6Rp82NFKaOxusv8KkFJp/P5najKDjM0I34ij59oxMbpLsUubg+BcW299f
	 ToUtDCjh77nt06chCGHwvSiKtocki/yzIMFjIhhfVOggY0SfQUmRmKzACOqfX8hujEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=TmebAFPq;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C881B606A327;
	Fri, 27 Nov 2026 15:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C881B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=TmebAFPq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=7MHE4DsABzir314JnlHgXrOD3pwhBzGh2rmqJkccc84=; b=TmebAFPqM8PQagNu1315X/kfsR
	AXy/3HUaRvBmf7egRCyUHBo3b3hOPJs6eFN/HmGApCY37gspk/EbTc3Mix7DozOU+POm3ilxTvY9C
	/wEcB3Ptt9ZAktdnwhDcBXYmhLCwigWPkKtJBO8gd66Q/fNUvKT0eoT35cFay92bNXjIz6TyJcs07
	umXaMZV3shMlZ0hmsNEmH3LcVfAsZCNVIv90+uml4bVIHaJ/sxgZhB8nTsISUGn5bI9mm/GRQ19iV
	WP4QxLjB9oNf6YFoDOxvPh4cRJERwu72Q+hEnj6xylfl9hu8hJvJ7m/KJyJ4dGIL+Hx2ENecXyQiv
	yyT+8WtQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xWxQk-008Q0t-2U;
	Fri, 27 Nov 2026 15:00:07 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] HID: intel-thc-hid: intel-thc: add the slow SPI gears
Date: Fri, 27 Nov 2026 22:59:20 +0800
Message-ID: <a09969dafddf2eb7086c4db8c8c18eb44b0dc5f9.1795791500.git.emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795791500.git.emfox@debian.org>
References: <cover.1795791500.git.emfox@debian.org>
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
index 75b63a3b9..03d3b60b3 100644
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
