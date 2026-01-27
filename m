Received: from mx0b-0046e701.pphosted.com (mx0b-0046e701.pphosted.com [67.231.157.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCB735CB97;
	Tue, 27 Jan 2026 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525523; cv=none; b=LKrMlTyj184FX7MVBSfSKFty6m51oyhl4jivj+oxzpCYjpzJHanWVGLFC2R7vMXviZWzqB+FTPDlO8hm5JX/2o3wUpK+CO27H79+giHbBcKU1cRlSCIk40dbRCQ65fPLl9Cnb8NwHO8sgk0KJP2RQCh52Y9yrhimPp0LEz5XK9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525523; c=relaxed/simple;
	bh=9q9vnUX2uSBAKHi8nMsekthpx6JABjcMHoNw1eNUqaY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TQwpX4QGWDJT1lr6mKif0UO15gQB68l/ps3Bg2caPm53UTsOYqs2c63g48shnOUMnPdaC5jKU454dntVaGJiQWV51YYYuUJDpx1k9eU+9yTweZhNIlDld8GMQYUTjv8CsvItQQKeqyTuFTv0DtaOWtC/sEvUgXyu3dftQU8g1mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com; spf=pass smtp.mailfrom=plexus.com; dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b=EuUH1q52; arc=none smtp.client-ip=67.231.157.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plexus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b="EuUH1q52"
Received: from pps.filterd (m0425994.ppops.net [127.0.0.1])
	by mx0b-0046e701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RA8TLY1320957;
	Tue, 27 Jan 2026 08:51:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plexus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=+mZvuYbBJ/+QcXA/VeK5e8mqEa9
	9TF8dPEbwRMJDEQQ=; b=EuUH1q52GnHfnCsDmg9ecEFZUFq1F17Qhvg4ccF5OZ+
	UhgcP+SD03KfadXRErobB0X2zjvJYo1H2r6U7Z6UnCRanYMg8fIfn7nRWJHBwjql
	hmrgBrlVuAT5ltdq4N7Eb73P9YRYeImyMPTXVwln28J/uusLivYWYmD8V0pRm5kL
	GuU/n81nN11vhBH1q0Xe6Pac1ZLQjwvUtQLfGN7bdZ5MXWwwAbdJI1fi4JzX48Uv
	FGiq99+veg3PLObqv22c2R6gArUcdeu9Cqz8PoBm58MOPmgbbSvsvWuYU95L7gj8
	1YOsMcrW+2rKYP2sOsKVfBc4JikZdOOI+M/K6cDbYCA==
Received: from intranet-smtp.plexus.com ([64.215.193.254])
	by mx0b-0046e701.pphosted.com (PPS) with ESMTPS id 4bxe9e9qeq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 08:51:42 -0600 (CST)
Received: from LNDCL34533.neenah.na.plexus.com (unknown [10.255.48.203])
	by intranet-smtp.plexus.com (Postfix) with ESMTP id C21FC580C1;
	Tue, 27 Jan 2026 08:51:41 -0600 (CST)
From: Danny Kaehn <danny.kaehn@plexus.com>
Subject: [PATCH v13 0/3] Firmware Support for USB-HID Devices and CP2112
Date: Tue, 27 Jan 2026 08:47:47 -0600
Message-Id: <20260127-cp2112-dt-v13-0-6448ddd4bf22@plexus.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABPQeGkC/22OQQ6CMBBFr0K6tqQdWqSuvIdxUdpBGqWQFgnGc
 HcLiVETl3/mv5f/JBGDw0gO2ZMEnFx0vU+BF7uMmFb7C1Jn04EAA8FKJqkZgHOgdqR7Y42SQlR
 YaZL6Q8DGzZvsdE65CX1Hxzag/hiASb5nCliuCqEUTSLt/SO/amz9cbjhfI+56bvV17o49uGxb
 Zs4X7X/ZqQXZdRK2bBGCalL+PasQyYOb1gmqPyBIcFgbK1LUXFbFz/wsiwv3Zi2CSMBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769525272; l=4705;
 i=danny.kaehn@plexus.com; s=20260127; h=from:subject:message-id;
 bh=9q9vnUX2uSBAKHi8nMsekthpx6JABjcMHoNw1eNUqaY=;
 b=ghN3zCdFHPPtw5xR+pwK7d75OSljkPxL/cADuzL4iQRM5t+WCLPqvowrpAdFE7Tr2peXPcRxI
 CjheE2dxVsoD7Xylj2X1l58cjc00TOa6c7r5c6fCHgdpNrVdy7K4RZi
X-Developer-Key: i=danny.kaehn@plexus.com; a=ed25519;
 pk=cbcR30mXg2VNyXtpE2SxVSXEDWLYwrxgnPCjJZn6A8s=
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyMSBTYWx0ZWRfX1oUcgDK8EGbI
 6TwS39Xi+eVpBAr0X21DLunOE/BNI2MS9hXnBt873+E0tvVD5baSfkKY164AsE87UZ2ldCJEe1/
 InE04lC/iQvbMq7gy0k2kNr5V43eMyroDKqKzXlyea//6+753I/cPMUEuYH6lHWIYCpHgyt1TE/
 NHEJ9oKcR4Qnr5u02WDjACx3lkPzDdofWAU5QRxwWcUPlwAB/e53OlvfSDqilTIo0WaJb/n+/1V
 5Qh+SsJ+DEK7MWxN17zHU7yGBQd2MOecO2JvvC2tnccbhpe5i3PymG8M747kpwJog187/gPAwUY
 8PKJUi64wAE0NpDXNueesJsh3A04WSFwVrxo5vkpIdZEO+gfEDz98/CAg8qjbjtgQ+1TBB5E/Ux
 ibtMpezjhgPxBf9eqUTUbUiJRCXW2hujSs85s8IvwWPujI6cdA5URegKmxlQv2XnWyZQUUPamVK
 dXCgyB2GkmDTcIIBaEA==
X-Proofpoint-ORIG-GUID: 1UDEr_vPvHT_TaeZ8T8tJm64bu_9_TUn
X-Proofpoint-GUID: vWhLUe03GWnF7faXI2PAJ3x9wwYq67K5
X-Authority-Analysis: v=2.4 cv=TeKbdBQh c=1 sm=1 tr=0 ts=6978d0fe cx=c_pps
 a=356DXeqjepxy6lyVU6o3hA==:117 a=356DXeqjepxy6lyVU6o3hA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=Y_joWELsAAAA:8 a=hxW2N2rBQJarcxKsw-IA:9 a=QEXdDO2ut3YA:10
 a=g_BQsM8wYJVSTWLOHH1t:22
X-Proofpoint-Spam-Reason: orgsafe

This patchset allows USB-HID devices to have Firmware bindings through sharing
the USB fwnode with the HID driver, and adds such a binding and driver
implementation for the CP2112 USB to SMBus Bridge (which necessitated the
USB-HID change). This change allows a CP2112 permanently attached in hardware to
be described in DT and ACPI and interoperate with other drivers.

Changes in v13:
- dt-binding changes:
  - drop scl-gpios and sda-gpios from binding, since they are included
      from the i2c-controller schena.
  - Set indentation to 4 spaces consistently for the DTS example
  - Fix alignment for gpio-line-names in the example
- Use dev_fwnode in hid-cp2112.c instead of directly accessing fwnode
- Immediately release the fwnode_handle from
    device_get_named_child_node() in hid-cp2112.c
- Link to v12: https://lore.kernel.org/r/20251126-cp2112-dt-v12-0-2cdba6481db3@plexus.com

Changes in v12:
- dt-binding changes:
  - Drop "on the host controller" from top-level description based on
      comment from Rob H.
  - Correct "Properties must precede subnodes" dt_binding_check error by
      moving gpio_chip-related properties above the i2c subnode in the
      binding and in the example.
  - Include `interrupt-controller` property in the example
- Modify hid-cp2112.c to support separate schemas for DT vs. ACPI - DT
  combines gpio subnode with the CP2112's node, but will have an I2C
  subnode; while ACPI will maintain separate child nodes for the GPIO
  I2C devices

Changes in v11:
- Eliminate 'gpio' subnode for DT and ACPI for the CP2112 per comment
    from Rob H.
- Edit hid-cp2112.c to match for ACPI index and fall back to matching by
    name (instead of the other way around)
- Separate CP2112 I2C bus speed configuration into a separate patch

Changes in v10:
- Define an enumeration and mapping for CP2112 ACPI _ADRs and devicetree
    child node names, and use these in the scanning of child nodes
- Address other miscellaneous

Changes in v9:
- Add _ADR-based ACPI binding of child nodes (I2C is _ADR Zero, GPIO is _ADR One)
- Use a loop-based approach for assigning child nodes within probe().
    As a consequence, hid-cp2112.c no longer maintains references to the
    child fwnodes during the lifetime of the device. (plese correct if this
    is actually needed for this use-case)

Changes in v8:
- Apply Review tags retroactively to patches previously reviewed

Changes in v7:
- Use dev_fwnode when calling fwnod_handle_put in i2c_adapter in hid-cp2112.c
- Capitalize I2C and GPIO in commit message for patch 0003

Changes in v6:
- Fix fwnode_handle reference leaks in hid-cp21112.c
- Simplify hog node pattern in silabs,cp2112.yaml

Changes in v5:
 - Use fwnode API instead of of_node api in hid-core.c and hid-cp2112.c
 - Include sda-gpios and scl-gpios in silabs,cp2112.yaml
 - Additional fixups to silabs,cp2112.yaml to address comments
   - Remove ngpios property
   - Constrain the hog pattern to a single naming scheme
   - Remove unneeded properties from the gpio hog which are provided by
       the parent schema
 - Submit threaded interrupt bugfix separately from this patchset, as requested

Changes in v4:
 - Moved silabs,cp2112.yaml to /Documentation/devicetree/bindings/i2c

Changes in v3:
 - Additional fixups to silabs,cp2112.yaml to address comments

Changes in v2:
 - Added more detail to silabs,cp2112.yaml dt-binding
 - Moved silabs,cp2112.yaml to /Documentation/devicetree/bindings/input
 - Added support for setting smbus clock-frequency from DT in hid-cp2112.c
 - Added freeing of of_nodes on error paths of _probe in hid-cp2112.c

Danny Kaehn (3):
  dt-bindings: i2c: Add CP2112 HID USB to SMBus Bridge
  HID: usbhid: Share USB device firmware node with child HID device
  HID: cp2112: Fwnode Support

 .../bindings/i2c/silabs,cp2112.yaml           | 113 ++++++++++++++++++
 drivers/hid/hid-cp2112.c                      |  50 ++++++++
 drivers/hid/usbhid/hid-core.c                 |   2 +
 3 files changed, 165 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/silabs,cp2112.yaml

--
2.25.1

---
Danny Kaehn (3):
      dt-bindings: i2c: Add CP2112 HID USB to SMBus Bridge
      HID: cp2112: Fwnode Support
      HID: cp2112: Configure I2C Bus Speed from Firmware

 .../devicetree/bindings/i2c/silabs,cp2112.yaml     | 100 +++++++++++++++++++++
 drivers/hid/hid-cp2112.c                           |  37 ++++++++
 2 files changed, 137 insertions(+)
---
base-commit: 1c772200c9dcb23a304f84a9334fe2e0d9529ab0
change-id: 20240605-cp2112-dt-7cdc95448e8a

Best regards,
-- 
Danny Kaehn <danny.kaehn@plexus.com>

