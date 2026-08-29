Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27B12E229F;
	Sat, 29 Aug 2026 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788015503; cv=none; b=LDjsbetKfydZ4BjEN/jo/+yFhQuxvOwWNdkJQ/Ms9Y2FGnszmSEsR4EWAVH5qqRwt03t7usvg/Dw1rBPhg/zVtXb6Xowz/EDsOq4a8RyrqXljbQhhfBpy5TSwxq7hPhqlRGjKOb60Ko1PvkcCCfu6KnRYakvuUeMrTMSaVfQgWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788015503; c=relaxed/simple;
	bh=XVj62RasfKXWqodTEsLUJXHp5CREdrfkaz6n/eby8YU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fdoe/D7Wu46QbiyrUjXXB3t36xKYNkSW1Zia9NXixe47QSgYqMn1QYCI5mubwnvhzKoDB55+RZXIvceCNHaU9y0zhFbOkH0xbNN2mFJY8tcaoDXbtXrE6cMOQyiH+CfrUh+jKFdeDQzpxVRZDDDSFqZzJzs3W6M0mz1457l7ETs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPpCgJuC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPpCgJuC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6659DC2BCB9;
	Sat, 29 Aug 2026 14:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788015502;
	bh=XVj62RasfKXWqodTEsLUJXHp5CREdrfkaz6n/eby8YU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=BPpCgJuCTXUxEZTl6hsi25ernZ/25nLVlLR6VM8MjlYrFoqi6b1S5F0/jp67gB8YO
	 loYfk1lEIV3phpPjDnd3UAI59QOUvgnpw57V/oiE0SS8aqzOrhyAqToO8yEt1jtEM5
	 Vz8MN3tDNrm/kVDJrX4bN2p42P0bnxjQ1V/LscjliVbwZvdL99kuDFutu8uUmV8IRp
	 DXzng4OXjIo01tY6ab9phFkd9sqaC8NNAC/q6GQcZEa97H3OaxdpXW683RMknoxDzA
	 AOurr+Lwayr8fxeIlbA8tqfH0hWaDwZJuBNEXmYrl6C4iT8CiZgzh7TSPlhw7NUsCu
	 CcdCVI99UIs3Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437BDC61DD6;
	Sat, 29 Aug 2026 14:58:22 +0000 (UTC)
From: Lucas Martins via B4 Relay <devnull+snowniak.gmail.com@kernel.org>
Date: Sat, 29 Aug 2026 11:58:22 -0300
Subject: [PATCH] HID: multitouch: ignore unstable pen serial on ELAN
 04f3:2dd2
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-elan-2dd2-pen-serial-fix-v1-1-33009e6189d1@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQqDMBAFf0X27IKuYpv+ivSQmGe7RVJJrBTEf
 2+sxxmY2SghKhLdio0iVk36DhnqsqDhacMDrD4zSSVddRXDmGxg8V54RuCjthOP+uW6NaNrL9a
 YBpTzOSLr/7q/n5w+7oVhOX607z8R/FlwfAAAAA==
X-Change-ID: 20260829-elan-2dd2-pen-serial-fix-149fb47a993e
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lucas Martins <snowniak@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788015501; l=3530;
 i=snowniak@gmail.com; h=from:subject:message-id;
 bh=vfER/qBdpj+nhmymPxxMWI3uvD55CW3aifSCqH2cVko=;
 b=lwtnXWuy0XmbhREyFnHRQZXl/oC2Q0dnUB/2eilTB5RLrf6oYIyeNHg63j8EyLj4BGBiGsmi0
 RDhurXvo7hgCyTJ2jXgMErWJ+1FKEBqky2a1oIxkhIU8w8O93NhhmjU
X-Developer-Key: i=snowniak@gmail.com; a=ed25519;
 pk=OoXh7Tb/xo0kP/5cFFoV6YuINTDnhe3WN3hr7I986Fs=
X-Endpoint-Received: by B4 Relay for snowniak@gmail.com/default with
 auth_id=988
X-Original-From: Lucas Martins <snowniak@gmail.com>
Reply-To: snowniak@gmail.com

From: Lucas Martins <snowniak@gmail.com>

The ELAN 04f3:2dd2 touchscreen declares its stylus serial number as a
64-bit field. It initially sends zero and populates the field roughly
200 ms after tip-down while the stroke remains active.

The generic HID input path truncates fields wider than 32 bits. On this
device the delayed update is exposed as an MSC_SERIAL change from 1 to
255. Tablet consumers interpret that as a tool replacement, terminate
the current stroke, and leave subsequent motion visible only as hover.

Replace the serial field in this device's report descriptor with two
32-bit constant fields. This preserves the 64-bit report layout while
preventing both the mid-stroke MSC_SERIAL update and the
hid_field_extract() width warning.

Tested on an ASUS CX5400FM (Google Copano). Before the fix, a raw HID
serial change occurred during every stroke and evdev emitted MSC_SERIAL
values 1 and 255. After the fix, evdev emitted no MSC_SERIAL events while
X, Y, pressure, tip, hover, and touchscreen input continued to work.

Signed-off-by: Lucas Martins <snowniak@gmail.com>
---
 drivers/hid/hid-multitouch.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 2c41bacab..874d74085 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1718,6 +1718,48 @@ static void mt_yogabook9_fixup(struct hid_device *hdev, __u8 *rdesc,
 static const __u8 *mt_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			     unsigned int *size)
 {
+	/*
+	 * ELAN 04f3:2dd2 delays populating its 64-bit Transducer Serial
+	 * Number until after tip-down. The generic HID input path can only
+	 * extract 32-bit values and exports the resulting mid-contact change
+	 * through MSC_SERIAL, causing userspace to switch tablet tools while a
+	 * stroke is active.
+	 *
+	 * Keep the field's full 64 bits in the report layout, but describe them
+	 * as two 32-bit constant values. This prevents both MSC_SERIAL events
+	 * and hid_field_extract(..., 64), without moving any later fields.
+	 */
+	if (hdev->vendor == USB_VENDOR_ID_ELAN && hdev->product == 0x2dd2) {
+		static const u8 elan_bad_serial[] = {
+			0x09, 0x5b,       /* Usage (Transducer Serial Number) */
+			0x25, 0xff,       /* Logical Maximum (255) */
+			0x75, 0x40,       /* Report Size (64) */
+			0x81, 0x02,       /* Input (Data,Var,Abs) */
+		};
+		static const u8 elan_ignored_serial[] = {
+			0x09, 0x00,       /* Usage (Undefined) */
+			0x75, 0x20,       /* Report Size (32) */
+			0x95, 0x02,       /* Report Count (2) */
+			0x81, 0x03,       /* Input (Const,Var,Abs) */
+		};
+		unsigned int i;
+
+		for (i = 0; i + sizeof(elan_bad_serial) <= *size; i++) {
+			if (!memcmp(&rdesc[i], elan_bad_serial,
+				    sizeof(elan_bad_serial))) {
+				memcpy(&rdesc[i], elan_ignored_serial,
+				       sizeof(elan_ignored_serial));
+				hid_info(hdev,
+					 "ignoring unstable 64-bit pen serial number\n");
+				break;
+			}
+		}
+
+		if (i + sizeof(elan_bad_serial) > *size)
+			hid_warn(hdev,
+				 "expected pen serial descriptor pattern not found\n");
+	}
+
 	if (hdev->vendor == I2C_VENDOR_ID_GOODIX &&
 	    (hdev->product == I2C_DEVICE_ID_GOODIX_01E8 ||
 	     hdev->product == I2C_DEVICE_ID_GOODIX_01E9)) {

---
base-commit: a93f3bf4e1d60777b1659b812c9e818cfc53b449
change-id: 20260829-elan-2dd2-pen-serial-fix-149fb47a993e

Best regards,
--  
Lucas Martins <snowniak@gmail.com>


