Received: from mx0b-0046e701.pphosted.com (mx0b-0046e701.pphosted.com [67.231.157.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C62348C7B;
	Wed, 20 May 2026 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293965; cv=none; b=hgKLZCyw6PTB2ckghUeQzmTYnDx2YWHU/fGxElHHKBEKGmZ+9r54rSvcD+Yj7mPVPZWqEcWo5uWv5p+cGipaAoYl/xlRgRKgkORF2AZ8VoWLOzWH1B1pEOR7BL275iCfdTgKIvqmGMvb8n6vfs7xDBJnIQsPcDXRz5+RLfbyepg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293965; c=relaxed/simple;
	bh=Vn/Ovhm5VhPLnxgZk2a2WANdeSJq9dzAZgsjAL2hnuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LoynmaGJplVgg7sDjowXw1s7PK1g0VIh103BkeqlkvsoQdhNKESBz1MnGX8PRe/s6mWTZtbsLZgQJJcqi0OAWNUy06ikcbId+NdcdUhkoNfLLOjTGMxk0rjcr9vj+v5S1P1BMZ8aekNOx0YpIR3M4Ut643dXmBQQMWmrmyNYTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com; spf=pass smtp.mailfrom=plexus.com; dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b=lNMAqVW7; arc=none smtp.client-ip=67.231.157.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plexus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b="lNMAqVW7"
Received: from pps.filterd (m0425993.ppops.net [127.0.0.1])
	by mx0b-0046e701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KA6Cdr3861369;
	Wed, 20 May 2026 11:14:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plexus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=i22HS
	W9zpYw15GmstHadUvDMsa016iWU0x6dfAxsT44=; b=lNMAqVW7yllznVA0QhWpP
	py4RgsJaY0PyQfH+xmCexMkO1HFPQPj3W5l1cxZAUDBkgpq2iF3uQfInIodLBbXk
	LX9eWdRXvg7GAmZJ2qSVqhu6KJh6kzd5fix9FG/VG6Vjzqmp1+8qMH2n84pl8azP
	MSr1Q3yyJx7xBxrHGy+O8ZfgHWKMoPtrKt8B71I5zTlo5My6iBrfQPQTSVFrBOFm
	x52Hci4VR9kxGGqXvt++V2W+XjFondwmeWIVmGFGmoXihtRfxwv9qgzEVqFrx74g
	+8fTVJnSC4qVzZrbpK/w8LmnklWwqw++aOkycH83rOJnNLPNq2xETCDasu4zINKY
	w==
Received: from intranet-smtp.plexus.com ([64.215.193.254])
	by mx0b-0046e701.pphosted.com (PPS) with ESMTPS id 4e8tdctk9n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 11:14:39 -0500 (CDT)
Received: from LNDCL34533.neenah.na.plexus.com (unknown [10.255.48.203])
	by intranet-smtp.plexus.com (Postfix) with ESMTP id 69A0939540;
	Wed, 20 May 2026 11:14:38 -0500 (CDT)
From: Danny Kaehn <danny.kaehn@plexus.com>
Date: Wed, 20 May 2026 11:13:06 -0500
Subject: [PATCH v14 1/2] HID: cp2112: Add fwnode support
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-cp2112-dt-v14-1-b1b4b6734b6f@plexus.com>
References: <20260520-cp2112-dt-v14-0-b1b4b6734b6f@plexus.com>
In-Reply-To: <20260520-cp2112-dt-v14-0-b1b4b6734b6f@plexus.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Danny Kaehn <danny.kaehn@plexus.com>,
        Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ethan Twardy <ethan.twardy@plexus.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Leo Huang <leohu@nvidia.com>,
        Arun D Patil <arundp@nvidia.com>, Willie Thai <wthai@nvidia.com>,
        Ting-Kai Chen <tingkaic@nvidia.com>,
        Bartosz Golaszewski <brgl@kernel.org>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779293611; l=2602;
 i=danny.kaehn@plexus.com; s=20260127; h=from:subject:message-id;
 bh=Vn/Ovhm5VhPLnxgZk2a2WANdeSJq9dzAZgsjAL2hnuY=;
 b=G/S8q4hj4pjXklnkTAzfPzquNO4H4vwZX8UYpinqN8ZgXg/G0FGkI7PP1CIJS91ZE+tHpGszS
 S/0E043Uy89AyZbVUr62Eqrw6Vb8C5Xpxb1uKj99VkwDMasGPZ/5elB
X-Developer-Key: i=danny.kaehn@plexus.com; a=ed25519;
 pk=cbcR30mXg2VNyXtpE2SxVSXEDWLYwrxgnPCjJZn6A8s=
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: PZzqbl7dvOcZTFJJMoR-8UzrMSaQZgM7
X-Proofpoint-GUID: qJxFiIvr5wtqRpdGokVsS3cXcc9clq0u
X-Authority-Analysis: v=2.4 cv=f5F4wuyM c=1 sm=1 tr=0 ts=6a0dddef cx=c_pps
 a=356DXeqjepxy6lyVU6o3hA==:117 a=356DXeqjepxy6lyVU6o3hA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=SL0Da4cj2IsybHzvybfz:22 a=bWp6hkYQOWa87JmFC6wa:22 a=Y_joWELsAAAA:8
 a=pVqXFfmJREZmDo3ecgYA:9 a=QEXdDO2ut3YA:10 a=g_BQsM8wYJVSTWLOHH1t:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1NyBTYWx0ZWRfXyV597Mn2eDt/
 WwG+9VVt4RPxW6tVpDNECIlLlejg9tlphS+FVQRTmv9CzPtBMvRxETqVqRr7JNXXBfAwkUzJyKv
 fEOo/efqUsJyifon8pNr5SimpqC40CQ/psoq4SW4KWFsuiEH2YaeHJzOB/rTk6zv1AxjP1fLWQp
 BCOV5lr7kWOfS85jr0VYeUuzthzQPbV+mSax5es6UPToW84u7mzHMYvW95ROs7c/pJ441bnUZw9
 u2ZN8NI460gxxxTvOukUhF5EnmrgwkTuXL0pdu/Xiz7a5+QpdfjbiIxJgWgtmK82QfkQgtCYAuM
 viFksxiLMOYdREn3Hc6OXCXXwAMNrQlUS38cPFHXOij4NkNQvvq0H6ugsPszLM7D6DHxi+/f+j7
 qYAD05gxQ2E5hmaaA5YoEX8H6bUL/ojuX+US1u/zkcz57Srcz4COfxOms7beD0OWmbd2XcWIzcB
 /CQrh+jY3ixWNDobGVQ==
X-Proofpoint-Spam-Reason: orgsafe

Support describing the CP2112's I2C and GPIO interfaces in firmware.

Bindings between the firmware nodes and the functions of the device
are distinct between ACPI and DeviceTree.

For ACPI, the i2c_adapter will use the child with _ADR equal to Zero
and the gpio_chip will use the child with _ADR equal to One.

For DeviceTree, the i2c_adapter will use the child with name "i2c",
but the gpio_chip will share a firmware node with the CP2112.

Signed-off-by: Danny Kaehn <danny.kaehn@plexus.com>
---
 drivers/hid/hid-cp2112.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 803b883ae875..e960fc988058 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -29,6 +29,18 @@
 #include <linux/usb/ch9.h>
 #include "hid-ids.h"
 
+/**
+ * enum cp2112_child_acpi_cell_addrs - Child ACPI addresses for CP2112 sub-functions
+ * Note that the enum values are explicitly defined, as this defines the interface
+ * between ACPI and Linux
+ * @CP2112_I2C_ADR: Address for I2C node
+ * @CP2112_GPIO_ADR: Address for GPIO node
+ */
+enum cp2112_child_acpi_cell_addrs {
+	CP2112_I2C_ADR = 0,
+	CP2112_GPIO_ADR = 1,
+};
+
 #define CP2112_REPORT_MAX_LENGTH		64
 #define CP2112_GPIO_CONFIG_LENGTH		5
 #define CP2112_GPIO_GET_LENGTH			2
@@ -1208,7 +1220,10 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct cp2112_device *dev;
 	u8 buf[3];
 	struct cp2112_smbus_config_report config;
+	struct fwnode_handle *cp2112_fwnode;
+	struct fwnode_handle *child;
 	struct gpio_irq_chip *girq;
+	u32 addr;
 	int ret;
 
 	dev = devm_kzalloc(&hdev->dev, sizeof(*dev), GFP_KERNEL);
@@ -1226,6 +1241,28 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
+	cp2112_fwnode = dev_fwnode(&hdev->dev);
+	if (is_acpi_device_node(cp2112_fwnode)) {
+		fwnode_for_each_child_node(cp2112_fwnode, child) {
+			ret = acpi_get_local_address(ACPI_HANDLE_FWNODE(child), &addr);
+			if (ret)
+				continue;
+
+			switch (addr) {
+			case CP2112_I2C_ADR:
+				device_set_node(&dev->adap.dev, child);
+				break;
+			case CP2112_GPIO_ADR:
+				dev->gc.fwnode = child;
+				break;
+			}
+		}
+	} else if (is_of_node(cp2112_fwnode)) {
+		child = fwnode_get_named_child_node(cp2112_fwnode, "i2c");
+		device_set_node(&dev->adap.dev, child);
+		fwnode_handle_put(child);
+	}
+
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "parse failed\n");

-- 
2.25.1

