Received: from mx0b-0046e701.pphosted.com (mx0b-0046e701.pphosted.com [67.231.157.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC4D2264A9;
	Tue, 27 Jan 2026 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525522; cv=none; b=Rpf5j7XXp0S9ZZsmxCTzM9PBKJ8yifbOIMawvr0OAkYbCtRgnxFqiCn5+MtzrjLZxAe1ZhzT4k4jefR5qdShZeP3jOiGZ99SSI6/SgjjiUiSdNKGCbSv62MS7bpwkz3CB+8aT8ZGlaWAxobkYPH2DdWUPHFvpZsFfGUmznF96yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525522; c=relaxed/simple;
	bh=HJJYRUvdMmPuj3Cq1bg3W40kKCjYk5QhoGsJqhjfatA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uAJGJ52sEVhZ9Y8k4b9BDx6KK6qU7d8DJ+k2rnMrEw2kUoHAjM7D4cOzYf9RrarkPPDconTitoANL7tuYKDIF8L7ftQ0ap/lerdSPUW+s9yUBfxwA39qQbIFeWxHzw6xy7mbnabj+6/F9xwPDT0Zof+h7TYMDp4m2O3jmB8sXO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com; spf=pass smtp.mailfrom=plexus.com; dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b=Iz2iEN4D; arc=none smtp.client-ip=67.231.157.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plexus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b="Iz2iEN4D"
Received: from pps.filterd (m0425993.ppops.net [127.0.0.1])
	by mx0b-0046e701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R3F5U82411442;
	Tue, 27 Jan 2026 08:51:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plexus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=U25PI
	jG5bqh7F5nJn+Y7T5LroIAB8LxvKkGQPhyfsWA=; b=Iz2iEN4DvZiTvofdkhN0g
	K4B0gP5KSFfMAcUuBL9pflkWOQByj5KaYeQksRMgaRIoOaTcDcNwXuPYm+8TnNVT
	WsH5lA8omV6hZXfIVOR11YSjrwUnOxPvEqZ7ZCjq9OtcxdgjX2YlXlIihqjRm6S0
	t0U8C554KomNS8+HYuzjWwR4HeJ9Z9udwJRZvCLCFVyRp+COpnPaJh318vumagwU
	q7Z8CdTQ+J9xOiyeY4HDFHfou6JN13SRTGG65LJxXzAgDqkf9ZKZbzOuWu2Z/2i4
	8esXhVaTN6wTwK61WBAXleVGl4p/rVUeuODrRItvmYYzOr2tqGEnPBaBMG8ifkZ2
	Q==
Received: from intranet-smtp.plexus.com ([64.215.193.254])
	by mx0b-0046e701.pphosted.com (PPS) with ESMTPS id 4bwe1vc1d4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 08:51:42 -0600 (CST)
Received: from LNDCL34533.neenah.na.plexus.com (unknown [10.255.48.203])
	by intranet-smtp.plexus.com (Postfix) with ESMTP id D538D580C3;
	Tue, 27 Jan 2026 08:51:41 -0600 (CST)
From: Danny Kaehn <danny.kaehn@plexus.com>
Date: Tue, 27 Jan 2026 08:47:49 -0600
Subject: [PATCH v13 2/3] HID: cp2112: Fwnode Support
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-cp2112-dt-v13-2-6448ddd4bf22@plexus.com>
References: <20260127-cp2112-dt-v13-0-6448ddd4bf22@plexus.com>
In-Reply-To: <20260127-cp2112-dt-v13-0-6448ddd4bf22@plexus.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Danny Kaehn <danny.kaehn@plexus.com>,
        Andi Shyti <andi.shyti@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Ethan Twardy <ethan.twardy@plexus.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Leo Huang <leohu@nvidia.com>,
        Arun D Patil <arundp@nvidia.com>, Willie Thai <wthai@nvidia.com>,
        Ting-Kai Chen <tingkaic@nvidia.com>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769525272; l=2353;
 i=danny.kaehn@plexus.com; s=20260127; h=from:subject:message-id;
 bh=HJJYRUvdMmPuj3Cq1bg3W40kKCjYk5QhoGsJqhjfatA=;
 b=xzI4ZRgrlQqV0JVhyBQ7Q4uFNrhbhHRGp7pO74y518o8JVQakCnxoU4lvhiLnjPgkfurnqihv
 5zE0P+hXYGDDSIXNVHDlVuBL/FH5rMyHd0ZjJKwA0f/7Hj0Dv+2P7c8
X-Developer-Key: i=danny.kaehn@plexus.com; a=ed25519;
 pk=cbcR30mXg2VNyXtpE2SxVSXEDWLYwrxgnPCjJZn6A8s=
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=c6CmgB9l c=1 sm=1 tr=0 ts=6978d0fe cx=c_pps
 a=356DXeqjepxy6lyVU6o3hA==:117 a=356DXeqjepxy6lyVU6o3hA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Y_joWELsAAAA:8 a=pVqXFfmJREZmDo3ecgYA:9 a=QEXdDO2ut3YA:10
 a=g_BQsM8wYJVSTWLOHH1t:22
X-Proofpoint-ORIG-GUID: Oh2C83xSz3kiHDDvzEIhShc8oqOXaTK0
X-Proofpoint-GUID: 7DoEXa_cFaXPT2pe2V1CZnQLggOD5Hl9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyMSBTYWx0ZWRfX6hNtwZmSblaP
 obyqZ/0c7v3uqzOI/nOhWljJTbr0I65e5qfFdoAV+OtCdTKOuDz/BJffz1/yEZ0VGHB1jnn9Srf
 t73cqZNzNqdD8sFUrBksaF2AASH6Aab38G+UGHmUBw3t0U3QG6xnzIolldHebKkc9qkBQgOiIrg
 qDqgFLtnnbA/g46JGg3v5fsV5+018QLtqof/DBR+ZIX0HKVVKserTvxFXJhvkBPAUmdWPXxIWVI
 +Sz7s8KGTdp3CEYKAoAvIPaZzXmto5UGp2BpLpPUvG6IAKAv8zItDgXolOOL1UQAZOEdWmuUb+h
 X+6bWbMRNZfkGqZnyh2CglU4SJccTZ7uYRVXBOzOQhk7oaIzhZVzF5HhuYK/54bb+2p06zlkjsY
 OdrUV/JBYqKtIdblploU+tlLICZpepOGZNmSuIfE3X/l7k1IuUHq/lLkTiXbbpGYd13jS5paI64
 ubNDcsjWmqCwStc2a3g==
X-Proofpoint-Spam-Reason: orgsafe

Support describing the CP2112's I2C and GPIO interfaces in firmware.

Bindings between the firmware nodes and the functions of the device
are distinct between ACPI and DeviceTree.

For ACPI, the i2c_adapter will use the child with _ADR Zero and the
gpio_chip will use the child with _ADR One. For DeviceTree, the
i2c_adapter will use the child with name "i2c", but the gpio_chip
will share a firmware node with the CP2112.

Signed-off-by: Danny Kaehn <danny.kaehn@plexus.com>
---
 drivers/hid/hid-cp2112.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 803b883ae875..ea19b5cb58f9 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -29,6 +29,16 @@
 #include <linux/usb/ch9.h>
 #include "hid-ids.h"
 
+/**
+ * enum cp2112_child_acpi_cell_addrs - Child ACPI addresses for CP2112 sub-functions
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
@@ -1208,7 +1218,9 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct cp2112_device *dev;
 	u8 buf[3];
 	struct cp2112_smbus_config_report config;
+	struct fwnode_handle *child;
 	struct gpio_irq_chip *girq;
+	u32 addr;
 	int ret;
 
 	dev = devm_kzalloc(&hdev->dev, sizeof(*dev), GFP_KERNEL);
@@ -1226,6 +1238,27 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
+	if (is_acpi_device_node(dev_fwnode(&hdev->dev))) {
+		device_for_each_child_node(&hdev->dev, child) {
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
+	} else {
+		child = device_get_named_child_node(&hdev->dev, "i2c");
+		device_set_node(&dev->adap.dev, child);
+		fwnode_handle_put(child);
+	}
+
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "parse failed\n");

-- 
2.25.1

