Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794718;
	b=kKboyra6ThGHQBrtrWJC6G5t3uPhWCVpU850WSRup53BxC0LsBLwZ/o4FaI5Wc51F+tO
	 6m0GnTWIaiDZpYDesfdZGqbK1x+mzjGRUpU7ma7K5fhDyFv4YoD/cpE8dCQciENVB5Eds
	 PYxwcYeln8mU76ayOmHfoY2dXr13SC/LExvX9j8rJ/uCPsfWErzHRi2DiGWABpOwbMEtP
	 z8h8Y+f8kkMqNMJP8pVAvR37ePp0ZipJq1ohWJnad94sdp0lLePCPq3aUbOoy30Ofah2l
	 7kRpnVXcX5Fd9Ev0PF350s+bNivNC7crb8CaSgoRz3dwWi6gnthVi6vz/7DULCzOOzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794718;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Debian-User;
	bh=I2fA3GTPZCI7J0fu6kaqpBL2FzmctT1Zyw067GeTY1s=;
	b=1HiFwOvMe55inBvqPh+WHxuO+5C2gaEkMgfucYtdXsps1JQA1I4fhAZ4eNo21eSGsPYx
	 FYtphm+n2QjrBuhHghGcRy7kRhsNYf9nz52ROgJtvd4EmSmPV5kel35RZxm3U/zPohSyp
	 JOIDNNdxWzr5uGpzfi5SE4ubQP1Kt+m0536g7d63JQhGFaIJhw07MG/aWuyWRV1ncptqB
	 XWaPv6l6B05QSmb7Dbq66hLRMD3lvFEeGLrrnOJ83Nt8v4E/gYh2K7A25G2EC4RD+1Roj
	 09bL1oSM3JC0fxyJVxZY3jnq2APZC5fzSoYB3MCndsqtkkBFCfbh6Z3YbZg/3O1P0lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Seg0T9kJ;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E08E606A31E;
	Fri, 27 Nov 2026 15:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E08E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Seg0T9kJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=I2fA3GTPZCI7J0fu6kaqpBL2FzmctT1Zyw067GeTY1s=; b=Seg0T9kJJrCEvuDFs1rY2Z6sBs
	0sGhWWyNU33+x5uFFCN6VrWsVfOM4jzZSQ3ZXwf5sU/n2Bv45ZptIw1Zf2Tn/gtftC6TLe6bgqA1I
	dZNrmmWzgTUPX/AN5adnQ2SIjb/w+vbrBnAtnyu+7FNi9gu/HlO+RlNdaagqqofMKbX2IM6bdls/L
	VH3KJWts26DWQ1KC+PRwhJ+D6aeDvZJ1Vs9nT8iIrSf5Fb+KqBn+u0jVPChTSrDYcfHD10ADV/+d6
	Y4unXJKtg7HLLdPEg/3a+V14jmiHzDGCmNUzB8Wr2GClgraOzIAK44k5kVOxvCzpbVL98N7ylAhZa
	6Y35EeTg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <emfox@debian.org>)
	id 1xWyEq-008RrF-2k;
	Fri, 27 Nov 2026 15:51:53 +0000
From: Emfox Zhou <emfox@debian.org>
To: Even Xu <even.xu@intel.com>,
	Xinpeng Sun <xinpeng.sun@intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 1/6] HID: intel-thc-hid: intel-thc: expose the operations an IPTS port needs
Date: Fri, 27 Nov 2026 23:51:35 +0800
Message-ID: <306c05c7d1ddc7f96fd6d3aafb5d6645d04406ed.1795794049.git.emfox@debian.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795794049.git.emfox@debian.org>
References: <cover.1795794049.git.emfox@debian.org>
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

The IPTS backend sits on the same core but cannot reach everything it
needs through it: it writes the reset and port-supported bits of
THC_M_PRT_CONTROL itself, and keeps a copy of the SPI base clock to turn
the divisor in the configuration block into a frequency it can ask for.

Add the calls for those:

  - thc_port_supported() reads the capability bit. A port with nothing
    behind it answers nothing on the bus, so the question is worth asking
    before the port is brought up.

  - thc_port_reset_release() and thc_port_reset_hold() write the reset
    bit. It is the reset request, and reads as one while the port is out
    of reset, so it is written and never read-modify-written: the port
    has to be told either way, whatever the bit reads back.

  - thc_spi_hz_from_div() applies the base clock the gears are fractions
    of to a divisor a device reports. Keeping it next to the gear table
    is the point: a frequency computed from another base lands on the
    wrong gear, and the table compares rounded to 100 Hz, so this has to
    round the same way or divisor 3 falls just short of the 41 MHz gear.

thc_interrupt_quiesce() also stops warning when the port is already in
the state that was asked for. Every bring-up and teardown path calls it
on both ends, so being idle at either end is the normal case, and the
warning says nothing the caller can act on.

No existing signature changes, and nothing else changes for the two
modes already in tree; they can move over to the new calls later.

Signed-off-by: Emfox Zhou <emfox@debian.org>
---
 .../intel-thc-hid/intel-thc/intel-thc-dev.c   | 107 ++++++++++++++++--
 .../intel-thc-hid/intel-thc/intel-thc-dev.h   |   4 +
 2 files changed, 103 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
index 03d3b60b3..d98c450c2 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
@@ -642,16 +642,13 @@ int thc_interrupt_quiesce(const struct thc_device *dev, bool int_quiesce)
 	u32 ctrl;
 	int ret;
 
+	/* Every bring-up and teardown path calls this, and a port that is
+	 * already in the state that was asked for is the normal case there:
+	 * nothing to write, nothing to wait for, nothing to report.
+	 */
 	regmap_read(dev->thc_regmap, THC_M_PRT_CONTROL_OFFSET, &ctrl);
-	if (!(ctrl & THC_M_PRT_CONTROL_THC_DEVINT_QUIESCE_EN) && !int_quiesce) {
-		dev_warn(dev->dev, "THC interrupt already unquiesce\n");
+	if (!!(ctrl & THC_M_PRT_CONTROL_THC_DEVINT_QUIESCE_EN) == int_quiesce)
 		return 0;
-	}
-
-	if ((ctrl & THC_M_PRT_CONTROL_THC_DEVINT_QUIESCE_EN) && int_quiesce) {
-		dev_warn(dev->dev, "THC interrupt already quiesce\n");
-		return 0;
-	}
 
 	/* Quiesce device interrupt - Set quiesce bit and waiting for THC HW to ACK */
 	if (int_quiesce)
@@ -1117,6 +1114,66 @@ EXPORT_SYMBOL_NS_GPL(thc_port_select, "INTEL_THC");
 #define THC_SPI_FREQUENCY_3M1	3125000
 #define THC_SPI_FREQUENCY_3M9	3906250
 #define THC_SPI_FREQUENCY_5M2	5208333
+/**
+ * thc_port_supported - Tell whether the port has a touch device interface
+ *
+ * @dev: the pointer of THC private device context
+ * @supported: set to whether the port can drive a device at all
+ *
+ * Reads the capability bit of the port control register. A port that is not
+ * supported answers nothing on the bus, so this is worth asking before the
+ * port is brought up.
+ *
+ * Return: 0 on success, other error codes on failed
+ */
+int thc_port_supported(struct thc_device *dev, bool *supported)
+{
+	u32 ctrl;
+	int ret;
+
+	ret = regmap_read(dev->thc_regmap, THC_M_PRT_CONTROL_OFFSET, &ctrl);
+	if (ret)
+		return ret;
+
+	*supported = ctrl & THC_M_PRT_CONTROL_PORT_SUPPORTED;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(thc_port_supported, "INTEL_THC");
+
+/**
+ * thc_port_reset_release - Take the port out of reset
+ *
+ * @dev: the pointer of THC private device context
+ *
+ * The reset bit of the port control register is the reset request and reads
+ * one when the port is out of reset, so the bit is written and never
+ * read-modify-written: the port has to be told either way.
+ *
+ * Return: 0 on success, other error codes on failed
+ */
+int thc_port_reset_release(struct thc_device *dev)
+{
+	return regmap_write_bits(dev->thc_regmap, THC_M_PRT_CONTROL_OFFSET,
+				 THC_M_PRT_CONTROL_DEVRST,
+				 THC_M_PRT_CONTROL_DEVRST);
+}
+EXPORT_SYMBOL_NS_GPL(thc_port_reset_release, "INTEL_THC");
+
+/**
+ * thc_port_reset_hold - Put the port into reset
+ *
+ * @dev: the pointer of THC private device context
+ *
+ * Return: 0 on success, other error codes on failed
+ */
+int thc_port_reset_hold(struct thc_device *dev)
+{
+	return regmap_write_bits(dev->thc_regmap, THC_M_PRT_CONTROL_OFFSET,
+				 THC_M_PRT_CONTROL_DEVRST, 0);
+}
+EXPORT_SYMBOL_NS_GPL(thc_port_reset_hold, "INTEL_THC");
+
 #define THC_SPI_FREQUENCY_7M	7812500
 #define THC_SPI_FREQUENCY_10M	10416700
 #define THC_SPI_FREQUENCY_15M	15625000
@@ -1130,6 +1187,9 @@ EXPORT_SYMBOL_NS_GPL(thc_port_select, "INTEL_THC");
 
 #define THC_SPI_LOW_FREQUENCY	THC_SPI_FREQUENCY_17M
 
+/* Every gear above is the base clock divided by an integer. */
+#define THC_SPI_BASE_HZ		125000000
+
 static u8 thc_get_spi_freq_div_val(struct thc_device *dev, u32 spi_freq_val)
 {
 	static const int frequency[] = {
@@ -1207,6 +1267,37 @@ static bool thc_spi_needs_half_div(u8 freq_div, u32 spi_freq_val,
 	       spi_freq_val < THC_SPI_FREQUENCY_15M;
 }
 
+/**
+ * thc_spi_hz_from_div - Turn a base clock divisor into a bus frequency
+ *
+ * @div: divisor, zero when the device did not provide one
+ * @div8: divide the result by eight as well
+ *
+ * A device that describes its bus timing as a divisor has to come back
+ * through here rather than through a copy of the base clock of its own: the
+ * gears thc_spi_read_config() programs are fractions of that clock, and a
+ * frequency computed from another base lands on the wrong one.
+ *
+ * Return: the frequency in Hz, or 0 for a divisor of zero
+ */
+u32 thc_spi_hz_from_div(u8 div, bool div8)
+{
+	u32 hz;
+
+	if (!div)
+		return 0;
+
+	hz = THC_SPI_BASE_HZ / div;
+	if (div8)
+		hz /= 8;
+
+	/* Geared frequencies are compared rounded to 100 Hz: round the same
+	 * way here, or divisor 3 lands just below the 41 MHz gear.
+	 */
+	return DIV_ROUND_CLOSEST(hz, 100) * 100;
+}
+EXPORT_SYMBOL_NS_GPL(thc_spi_hz_from_div, "INTEL_THC");
+
 /**
  * thc_spi_read_config - Configure SPI bus read attributes
  *
diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h
index be8a9605d..e766bcef3 100644
--- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.h
@@ -134,7 +134,11 @@ void thc_change_ltr_mode(struct thc_device *dev, u32 ltr_mode);
 void thc_ltr_unconfig(struct thc_device *dev);
 u32 thc_int_cause_read(struct thc_device *dev);
 int thc_interrupt_handler(struct thc_device *dev);
+int thc_port_reset_hold(struct thc_device *dev);
+int thc_port_reset_release(struct thc_device *dev);
 int thc_port_select(struct thc_device *dev, enum thc_port_type port_type);
+int thc_port_supported(struct thc_device *dev, bool *supported);
+u32 thc_spi_hz_from_div(u8 div, bool div8);
 int thc_spi_read_config(struct thc_device *dev, u32 spi_freq_val,
 			u32 io_mode, u32 opcode, u32 spi_rd_mps);
 int thc_spi_write_config(struct thc_device *dev, u32 spi_freq_val,
