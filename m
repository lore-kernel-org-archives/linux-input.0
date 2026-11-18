Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794979945;
	b=QBCWjaD3nTMFkBJC8ANK5dK+Cf2BCLhyUzQeFOG5Sq4XVoKNeSzdVNYyRlh+Fd+sEoJb
	 A9KiztqQwrG4Vg+nKJFEPzm3jwE9G01qtjKm9AZkeHa8fNG5+u43mCJfavuHyG1eG2Tsl
	 RtTcIhp7EZCf1QNr9JGfkO+fPS3f4znk1+1Le7tdkVLpnZ/LLP+aLGnxETWYErrtkg0H4
	 Nrk7jYgAmNlmB1zDnqlXjdWfGL2M6BC0vjNtK4+yCm8GVhB5lzTe210r53FQ1wMnM0ILy
	 3ozU12tu6oWso2M68mzS1zpqLuSqk5d5spy7GoJYz9ffcOlV2lzAqrKKmCtHyxNkP2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794979945;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=SD/u+A1pQEM1xmZ/umHMcWdS/xpen9SdrcaOKcFMceo=;
	b=tlr5yWjvHxoSK+eBEYAwRmIqnmgXPHbqGqQG3IGF5xJYN+g5bLZIOOdrkuQIEsJXy4Gw
	 QYBX/FvVTUlqobOIBK7M8LUSfsruX1TdqHci4fD4XctBTNy7jPTiQ+hMqvlxF9CJxA2/A
	 FgX3JTCBEDvQZLO+f8ByVJ8ohUz8uvIz4joC+HW1vK81W2FUsMUaqZfqq8ViaYpnCzUR4
	 8DwmwFgspdQbV9maYZKWj3yHySfGWmXEPsVQ+kBthakLiy/SVLk8kS79px3mo10qLanjj
	 2JNORDcfk6HbDlvCJOI7XPrwDW+qA0VGYfnRy+c5ufklWG8HJba8XtQ7ZF8CJkf1+BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=CyafWeuG;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C87D606A31C;
	Wed, 18 Nov 2026 05:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C87D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=CyafWeuG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=SD/u+A1pQEM1xmZ/umHMcWdS/xpen9SdrcaOKcFMceo=; b=CyafWeuGmy8pKB5GZ8oNX18Acq
	X35waweSzAwvyx3jmpF25YJalrHEFjy9l7oyR3QF9F4R3iTkcl28iRsr4EjIFfI9RO2K1j8QzJSTq
	F+6Pxo6puhPCnW8nzeXrrXkTl23eslzlFI09IH8LL5+L+gIhPIx17oOZhyNZK/YlKrUz+sbKuknlw
	NVE9VLnAA4fknyuW1yC9vDBR8OMpnpFDgwwBx4qfY/HXkATLV/IVGQhD0L4AyrzDG5MzWgpvJ59BE
	nnJminMwvSHVBo1ev7iPA0caUkOtHtz4ZwEeeO4aMx/IRgcj+3woCRK2Vp0jMVwvBVjpRHBNksMt0
	gqb3uxgw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xTYHM-00151y-2C;
	Wed, 18 Nov 2026 05:32:21 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] HID: intel-thc-hid: intel-thc: add the slow SPI gears
Date: Wed, 18 Nov 2026 13:31:31 +0800
Message-ID: <20261118053132.253448-5-emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118053132.253448-1-emfox@debian.org>
References: <20261118053132.253448-1-emfox@debian.org>
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

Add the five gears between 2.23 and 5.21 MHz. The half divider check has
to exempt the 5.2083 MHz one: it is already DIV_3 with the eighth divider,
so the extra half divider would halve it again. The 10.4167 MHz gear above
them is low frequency too but keeps the half divider and is left alone.

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
