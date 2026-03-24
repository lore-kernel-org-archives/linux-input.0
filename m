Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A083318EF4;
	Tue, 24 Mar 2026 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381238; cv=none; b=E09TvC/xV90PQjJcQpPwSDcTSOKa3a7iNK750/YHHE6z2lBxREOgz1aksycnqhuduxuLQ6yHhkgs4LKLaPO2gBFT6ghh0uZRUWzo6C42Odz2I2tpitY6DVnkuxN6ZJyRw0LFb4FzfkcEt0I1VtZSVGSfovKt7i9RQIefggxPrdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381238; c=relaxed/simple;
	bh=vv7Jx5f+p3CbVVrajot+2Qq9/m4eiTjIeY+O7y7B8LA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DxQXyisuT36xhKnsNBSYVsFlhaEMPaQXI5RI8zqEkDDkZnMIEp+mLCHAKJw0eAyVI0R/6b9NC8HbhC1khEEbiWlVzq8U6XcB3ZCsFhq6q5EjWmXtfjDPDO49Onr1LysBbVM5XKDCvRNymzFexU+BnSJ882UD9WmOEonKRnlhUwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTHwaOTh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTHwaOTh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09AB2C2BCB4;
	Tue, 24 Mar 2026 19:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774381238;
	bh=vv7Jx5f+p3CbVVrajot+2Qq9/m4eiTjIeY+O7y7B8LA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JTHwaOThiYKOWS0iXVeC0jyhB967r3WwbIP8ijcGIY7TpI9zDAIrTwZGvIuGhZxLw
	 du9YKGoFoLoZTEupr8Avh4PMgZxdiEr3uNIa0EOnDVBzB0V63F59WgzTUc0qZakptQ
	 Rtyj0smxObX+gFg2iOnHEhjjnUrQG3g2B/mH+pAPmcYxyHB/2GOpzEQxxDgT3UNX18
	 UDN1E4WTt49FebYJAwLVQSCVe1akCcSuyIqhbm7Msj7CF9wrf0Nf8q56GoQVnQOM5P
	 tWLzOZwLZ5U35LJL+Zuk/6q4oowj1yMiBsJGPFRwWSUpC2zvxsu1LR97My2LeKIuHk
	 NEw6oqtaBD03Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014B9FEC109;
	Tue, 24 Mar 2026 19:40:38 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Tue, 24 Mar 2026 20:40:40 +0100
Subject: [PATCH v8 7/7] Input: synaptics-rmi4 - support fallback values for
 PDT descriptor bytes
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-synaptics-rmi4-v8-7-2168d2df68f5@ixit.cz>
References: <20260324-synaptics-rmi4-v8-0-2168d2df68f5@ixit.cz>
In-Reply-To: <20260324-synaptics-rmi4-v8-0-2168d2df68f5@ixit.cz>
To: Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: David Heidelberg <david@ixit.cz>, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5957; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=oycBmO6+alAHChTgcVntFPjFGi9MJgeIlaP3WOd+GKk=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpwuizJps7ZgGmFw/XEevWBPL92vIX6eVe2vcnH
 +CpwnZyzTSJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCacLoswAKCRBgAj/E00kg
 crM9D/93iexmaEYWmKFC7sNr44+vewYC7OIpu3sufVWsGHFUq44LzxHHQpMCGtcU9IjCwTF94kj
 yFcJM/KvKu8UMPCngS3+ttekoRBkhiZhUGYhVMGZAH4MeAQyEHyo4SfydT4rN7vOIqPnfY0RDTU
 elfPW4uUr6go/PdBmbzEcQS5KZi1XpWIq6Br4K6YVfMbJHofRtTibNPBvbr5m/6JzmMCmOJHYEQ
 8Jgz7UNqfsZjWHvY5ye36kK4uzR5YoujnBMj4cS5zbsjk7Nts41lxnxjv1Qlrs6zcJ5oSfLGQ9k
 +Tu+/zUegB+hKROxfxQT3FO3OH3hI/l07pjJjvO05zaiygrAH+PpwFluDgbLhu2o5RkVBbLCgRT
 a8AGQTJuHGfo3WYrKahc14s3ZtJdLQ8sup/hDYeaHY85PIOVSSMk6WKPpchrPOPNzwwk6qQdw2G
 PYm+REAJm99W2TT9WKHAv4+wqiE3u0Cj2iQ4z+EPLKrdp+8vMUEAf1evVHKm2FpJThCu9uOcKsU
 AUwMhB/5D2CyzBqSD1TLihXlm2snipzPgKDsvr1zwGx5jt309mf/uJC4q+LmWciGs9/Xu9Gu2PX
 F67NwWoUjqnsTbeEYIiYeKwwRMubuXsBM5L2+I0CfqNIkP/+pCL7k1Bkd7pXU9BuZeUHSA1aaC0
 8UrgcD2SR05OrgQ==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Kaustabh Chakraborty <kauschluss@disroot.org>

Some replacement displays include third-party touch ICs which do not
expose the function number and the interrupt status in its PDT entries.

OnePlus 6 (original touch IC)
  rmi4_i2c 12-0020: read 6 bytes at 0x00e3: 0 (2b 22 0d 06 01 01)

OnePlus 6 (aftermarket touch IC)
  rmi4_i2c 12-0020: read 6 bytes at 0x00e3: 0 (2c 23 0d 06 00 00)

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
[codeflow adjustments, checkpatch fixes, wording]
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Co-developed-by: David Heidelberg <david@ixit.cz>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/input/rmi4/rmi_driver.c | 63 +++++++++++++++++++++++++++++++++++------
 drivers/input/rmi4/rmi_driver.h |  3 ++
 include/linux/rmi.h             |  3 ++
 3 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index fc84799c36e04..bb1db5bbb3abb 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -462,9 +462,10 @@ static int rmi_driver_reset_handler(struct rmi_device *rmi_dev)
 	return 0;
 }
 
-static int rmi_read_pdt_entry(struct rmi_device *rmi_dev,
-			      struct pdt_entry *entry, u16 pdt_address)
+static int rmi_read_pdt_entry(struct rmi_device *rmi_dev, struct pdt_entry *entry,
+			      struct pdt_scan_state *state, u16 pdt_address)
 {
+	const struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
 	u8 buf[RMI_PDT_ENTRY_SIZE];
 	int error;
 
@@ -475,6 +476,21 @@ static int rmi_read_pdt_entry(struct rmi_device *rmi_dev,
 		return error;
 	}
 
+	if (pdata->pdt_fallback_size > state->pdt_count * RMI_OF_PDT_DESC_CELLS + 1) {
+		/* Use the description bytes from the driver */
+		buf[5] = pdata->pdt_fallback_desc[state->pdt_count * RMI_OF_PDT_DESC_CELLS];
+		buf[4] = pdata->pdt_fallback_desc[state->pdt_count * RMI_OF_PDT_DESC_CELLS + 1];
+
+		error = rmi_read_block(rmi_dev, pdt_address, buf,
+				RMI_PDT_ENTRY_SIZE - 2);
+		if (error) {
+			dev_err(&rmi_dev->dev,
+					"Read PDT entry at %#06x failed, code: %d.\n",
+					pdt_address, error);
+			return error;
+		}
+	}
+
 	entry->page_start = pdt_address & RMI4_PAGE_MASK;
 	entry->query_base_addr = buf[0];
 	entry->command_base_addr = buf[1];
@@ -522,6 +538,7 @@ static bool rmi_pdt_entry_is_valid(struct rmi_device *rmi_dev,
 	}
 
 	state->pdts[fn] = true;
+	state->pdt_count++;
 	return true;
 }
 
@@ -546,7 +563,7 @@ static int rmi_scan_pdt_page(struct rmi_device *rmi_dev,
 	int retval;
 
 	for (addr = pdt_start; addr >= pdt_end; addr -= RMI_PDT_ENTRY_SIZE) {
-		error = rmi_read_pdt_entry(rmi_dev, &pdt_entry, addr);
+		error = rmi_read_pdt_entry(rmi_dev, &pdt_entry, state, addr);
 		if (error)
 			return error;
 
@@ -1023,9 +1040,13 @@ static int rmi_driver_remove(struct device *dev)
 }
 
 #ifdef CONFIG_OF
-static int rmi_driver_of_probe(struct device *dev,
-				struct rmi_device_platform_data *pdata)
+static const u8 rmi_s3706_fallback_pdt[] = {34, 41, 01, 01, 12, 01};
+
+static int rmi_driver_of_probe(struct rmi_device *rmi_dev,
+			       struct rmi_device_platform_data *pdata)
 {
+	struct device *dev = rmi_dev->xport->dev;
+	u8 buf[RMI_PDT_ENTRY_SIZE];
 	int retval;
 
 	retval = rmi_of_property_read_u32(dev, &pdata->reset_delay_ms,
@@ -1033,11 +1054,37 @@ static int rmi_driver_of_probe(struct device *dev,
 	if (retval)
 		return retval;
 
+	/*
+	 * In some aftermerket touch ICs, the first PDT entry is empty and
+	 * the function number register is 0. If so, the driver
+	 * may have provide backup PDT entries.
+	 */
+
+	retval = rmi_read_block(rmi_dev, PDT_START_SCAN_LOCATION,
+			buf, RMI_PDT_ENTRY_SIZE);
+	if (retval) {
+		dev_err(dev, "Read PDT entry at %#06x failed, code: %d.\n",
+			PDT_START_SCAN_LOCATION, retval);
+		return retval;
+	}
+
+	if (!RMI4_END_OF_PDT(buf[5]))
+		return 0;
+
+	/* List of known PDT entries per compatible. */
+	if (of_device_is_compatible(dev->of_node, "syna,rmi4-s3706b")) {
+		pdata->pdt_fallback_desc = rmi_s3706_fallback_pdt;
+		pdata->pdt_fallback_size = ARRAY_SIZE(rmi_s3706_fallback_pdt);
+	} else {
+		dev_err(dev, "First PDT entry is empty and no backup values provided.\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 #else
-static inline int rmi_driver_of_probe(struct device *dev,
-					struct rmi_device_platform_data *pdata)
+static inline int rmi_driver_of_probe(struct rmi_device *rmi_dev,
+				      struct rmi_device_platform_data *pdata)
 {
 	return -ENODEV;
 }
@@ -1158,7 +1205,7 @@ static int rmi_driver_probe(struct device *dev)
 	pdata = rmi_get_platform_data(rmi_dev);
 
 	if (rmi_dev->xport->dev->of_node) {
-		retval = rmi_driver_of_probe(rmi_dev->xport->dev, pdata);
+		retval = rmi_driver_of_probe(rmi_dev, pdata);
 		if (retval)
 			return retval;
 	}
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index 2c47373c3d177..a6a29fde49f35 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -31,6 +31,8 @@
 #define RMI_PDT_FUNCTION_VERSION_MASK   0x60
 #define RMI_PDT_INT_SOURCE_COUNT_MASK   0x07
 
+#define RMI_OF_PDT_DESC_CELLS 2
+
 #define PDT_START_SCAN_LOCATION 0x00e9
 #define PDT_END_SCAN_LOCATION	0x0005
 #define RMI4_END_OF_PDT(id) ((id) == 0x00 || (id) == 0xff)
@@ -50,6 +52,7 @@ struct pdt_entry {
 
 struct pdt_scan_state {
 	u8 empty_pages;
+	u8 pdt_count;
 	bool pdts[RMI_PDT_MAX + 1];
 };
 
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index ab7eea01ab427..4ba2cefac8558 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -214,6 +214,9 @@ struct rmi_device_platform_data {
 	int reset_delay_ms;
 	int irq;
 
+	unsigned int pdt_fallback_size;
+	const u8 *pdt_fallback_desc;
+
 	struct rmi_device_platform_data_spi spi_data;
 
 	/* function handler pdata */

-- 
2.53.0


