Received: from mx0b-0046e701.pphosted.com (mx0b-0046e701.pphosted.com [67.231.157.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74B132B9B5;
	Wed, 20 May 2026 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293883; cv=none; b=N7An9+cr7MoJK/OHdndX/qtkzC5/45ykWu4JPTI9FevxoUKXKaKomqDAutNJBQbSYs51EiypBxFnOYMSevCtiT2iNWeSQ/myBQ9ZIvItObB4StTHkjwxNQgn8OtRIcUjku1ljIlrXeAs4EMR0FW090gPfzY0waOxRHWDI2V9BR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293883; c=relaxed/simple;
	bh=eHYhB2clJfoKg8jf7dBeeLvIArn85UxMtZh8CHUuWNY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JafXatHLyl156fc6Wndn0n04hotRzZf7ccN6fALzpbZt8x96nSKvxEWuguaPkpRj2zT6Rl/iwBbSG36pxxlgv6WuxIMckCjrsqc2YvHbXnYWpnrYYNJJmwlfSTMYDBSv0La578nm6Sk1puPaBnuzqtTEV1b824h7YEm+l5QhEoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com; spf=pass smtp.mailfrom=plexus.com; dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b=O88rqr2O; arc=none smtp.client-ip=67.231.157.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=plexus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plexus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plexus.com header.i=@plexus.com header.b="O88rqr2O"
Received: from pps.filterd (m0425992.ppops.net [127.0.0.1])
	by mx0b-0046e701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K9cVpf3075051;
	Wed, 20 May 2026 11:14:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plexus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps1; bh=BBLqLl9v1je1QoEBcfuz1P6Blux
	uf+XhNU4LngnfXYE=; b=O88rqr2O8VVl7JA3ypxTfwVNf+1mklMWsGIGGYq3TPr
	0TjaxPk002UHIT9syJubPvMINAqQ/fK2GZm2qKZ/5PBvW5d/yQ8Hw7+vMaP5OeYg
	qFDGHj1sipR6jiyPt//90krpEGwyiTXZHnKH+UVJlFtNbpevk4NgWxEfVx0U+j4z
	rnjp2G+yLrgq6kFYQ/O3Zk0n+Np+n4JE43GnH1MBXNFDz3TRMpIvHBrVH9Uo/aXO
	QBrJLLXBB2D2OsLuuWbCLdiiuPeCgKZnRvEnQiQ05z+AViJrCP+Gv4j4lkOvfMIm
	U41fU/modL+iCV1i6KsEjS9m5m70ypTNYz9J+TWmzKg==
Received: from intranet-smtp.plexus.com ([64.215.193.254])
	by mx0b-0046e701.pphosted.com (PPS) with ESMTPS id 4e8k8jkfja-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 11:14:39 -0500 (CDT)
Received: from LNDCL34533.neenah.na.plexus.com (unknown [10.255.48.203])
	by intranet-smtp.plexus.com (Postfix) with ESMTP id 621F33C84C;
	Wed, 20 May 2026 11:14:38 -0500 (CDT)
From: Danny Kaehn <danny.kaehn@plexus.com>
Subject: [PATCH v14 0/2] Firmware Support for USB-HID Devices and CP2112
Date: Wed, 20 May 2026 11:13:05 -0500
Message-Id: <20260520-cp2112-dt-v14-0-b1b4b6734b6f@plexus.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJHdDWoC/22Qy07DMBBFf6XyGkfjie3ErPgPxMLxg1hQJ7JD1
 KrKvzOpVEEEy3mcM1dzYzWUFCp7Pt1YCWuqacpUCPl0Ym60+T3w5KnBEFCCBsXdjEIg9wvvnHd
 GSdmH3jLan0uI6XKXvb5RHct05stYgv0xICjRgUFoTCuN4SSyOV+bDxvG/DJ/hstXbdx03n1jq
 stUrvdsqxC79r8YNOLAvVIRopHKavzt2YOsAh+wIkgfYCQYnR+slr3wQ/sXbh+wBoHdAW4J1vQ
 B770cIh4vb9v2DU/Cq4RgAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779293611; l=5198;
 i=danny.kaehn@plexus.com; s=20260127; h=from:subject:message-id;
 bh=eHYhB2clJfoKg8jf7dBeeLvIArn85UxMtZh8CHUuWNY=;
 b=ENv2g0ewd3vUTTF4mlFp/FLR8UvbV0ujJ/CGQ1jseFwR9I0djnb8/a6UbwSyGswkiQIPfoAN8
 SpX/tHYUiMYDYz6C/IP4vLaXyINOGYYM8CxI8dKNEEeeUFK4MYFGX/W
X-Developer-Key: i=danny.kaehn@plexus.com; a=ed25519;
 pk=cbcR30mXg2VNyXtpE2SxVSXEDWLYwrxgnPCjJZn6A8s=
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: _hzKR_qyFnMnU_4fTfdCq86LRHudqWSm
X-Authority-Analysis: v=2.4 cv=IZe3n2qa c=1 sm=1 tr=0 ts=6a0dddef cx=c_pps
 a=356DXeqjepxy6lyVU6o3hA==:117 a=356DXeqjepxy6lyVU6o3hA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=SL0Da4cj2IsybHzvybfz:22 a=6wD_j1z14G4eGgT9AmLd:22 a=VwQbUJbxAAAA:8
 a=Y_joWELsAAAA:8 a=vTRGXHgeZHtxvjYglKwA:9 a=QEXdDO2ut3YA:10
 a=g_BQsM8wYJVSTWLOHH1t:22
X-Proofpoint-ORIG-GUID: ofbbJgE7yNinnMkCsrcQZl_WMYquKE0Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1NyBTYWx0ZWRfX4if0RXwShdW1
 hTOaKEmp2tTkwPHEetVGnxxg2FEb9xHU1EdG4P5jwQcmMVZUPxtaTkONJo6AiHc8tyF6RCuJWok
 r9TN07NGCMjxnt2pfnIwy5Niq+kaIM0egq4wVa0BWNzzAUpIPPuAde05Akk8Z3dqePCwu7QpLfw
 ojVC625Oqud+6BVKiXjpq9Jn5/N6HqYbgbbDEoT1hlUqpDo42G3/u+w/EdHI9BwU9haMpOvK8G8
 BNLapjg9vzZaMzqVCLrLmc+XTuZjyTzwSDKkDJOQKWHIXZCJH0chbsjr5L6lgEUTvq5wKZgcyp7
 RK10JoW8uh7B39aAWqW3uSCL5gSvWjZ1uV/Ly/94BgjaVFZs5wvWCFyxVD0Y6n5flNabI3fJgJf
 m0bFqSjMTDRZlwfO86zMkTTHn3lAcY+nE/xOSNR6tMNUf3A4/aGri8VLMH+7AOtR4EBK4VvqXXG
 YoZXOiFsVYAanTUmDAQ==
X-Proofpoint-Spam-Reason: orgsafe

This patchset allows USB-HID devices to have Firmware bindings through sharing
the USB fwnode with the HID driver, and adds such a binding and driver
implementation for the CP2112 USB to SMBus Bridge (which necessitated the
USB-HID change). This change allows a CP2112 permanently attached in hardware to
be described in DT and ACPI and interoperate with other drivers.

Changes in v14:
- Drop DT binding patch (merged upstream) (remove DT mailing lists and
  maintainers from email chain)
- Refactor logic in cp2112_probe() to reduce extra duplicate
  dev_fwnode() calls by retrieving and storing the CP2112's fwnode once
- Update comment on cp2112_child_acpi_cell_addrs enum to explain why
  values are explicitly defined
- Edit commit message for 1/2 per Andy's comments (lowercase letters in
  description; _ADR "equal to" Zero, etc..
- Edit commit message for 2/2 to use lowercase letters
- Link to v13: https://lore.kernel.org/r/20260127-cp2112-dt-v13-0-6448ddd4bf22@plexus.com

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
Danny Kaehn (2):
      HID: cp2112: Add fwnode support
      HID: cp2112: Configure I2C bus speed from firmware

 drivers/hid/hid-cp2112.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
---
base-commit: 70eda68668d1476b459b64e69b8f36659fa9dfa8
change-id: 20240605-cp2112-dt-7cdc95448e8a

Best regards,
-- 
Danny Kaehn <danny.kaehn@plexus.com>

