Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428E6381EBB;
	Tue, 28 Jul 2026 06:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221017; cv=none; b=hwPdDVeYiOxy1LiC2RFFO7kVOKdXSY/TdT7Hifn5IIVb5C52QcP1ME6n+ZNEKF0VDLcvX/SOwHzETHEUfUuiF6xxLF8vsDtbX31H1XzCL6++7+0fGLAOrGapp6JWu1hY9FfP1ICNwa3nUihoAemfxp6P53XnMYDVF3jp5+8gxsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221017; c=relaxed/simple;
	bh=J8Dov7z6LLHZwzehRAu4XdGG2ErrXopdJ4OGSnW7AMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L3XvuunX2ZkgAoisTHuQVeTN/Djk6JU9KWGuuuBodCKPXSbdK6WayBlX2WCm54B/EsLkh1M91Xahx++HDXUHlTIZfdVtyc8e1BIcTYVrnlZT5V1RbwgOpnOrj7Tw++ZCARnfbsh+ZJ93oQQKdCuCziEjlCIrKA1P5vYyBQar6JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mvU+JvZZ; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mvU+JvZZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=uc
	rZ7rbWxAnx4KG5vmhUlTD3XdNcUvWnlnQv2q7XJYg=; b=mvU+JvZZ6xkgfZMjD9
	v1vfjqfl+bJBgZAGVJ2HQACHefBKKj6MrJkk7Hk+nTSEm1mp4gblTROUPcDkx/Zk
	CkJ1Fk8LgPIRZJDehmkgnwTQWPlVSUCUYdFT3JpInV/OpnQfMuEKED/7R7ddg2yu
	6e8hehWeiM8HXdfv5vUT0ccIc=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD33114T2hq+5HxKw--.28687S2;
	Tue, 28 Jul 2026 14:43:05 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Miao Li <limiao@kylinos.cn>,
	Nguyen Dinh Dang Duong <dangduong31205@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] HID: huawei/rapoo: reject non-USB transports before to_usb_interface()
Date: Tue, 28 Jul 2026 14:43:02 +0800
Message-Id: <20260728064302.3853953-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33114T2hq+5HxKw--.28687S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr1fAryfWry5Cr13ArWfGrg_yoW5GrWUpa
	1UWFWqyrWDtr1rCw4jyF4kXryF9F1kJa4xuFyxCw1Svw1YyFyYqrySy34jqF1rCrZayr12
	gr4Ut3yUWa4jgw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRIzuLUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8Bqm4GpoT3oM-QAA3q

hid-huawei's huawei_report_fixup() unconditionally calls
to_usb_interface(hdev->dev.parent) without first verifying the
device is actually a USB HID device.  When uhid spoofs bus = BUS_USB
with matching VID/PID, hdev->dev.parent points to a uhid_device,
not a usb_interface.  to_usb_interface() returns a garbage pointer,
triggering:

  BUG: KASAN: slab-out-of-bounds in huawei_report_fixup
  Read of size 8 at 1176 bytes beyond an 800-byte kmalloc-1k region
  BUG: KASAN: null-ptr-deref in huawei_report_fixup

  Call Trace:
   huawei_report_fixup
   hid_open_report
   hid_device_probe
   really_probe
   uhid_device_add_worker

hid-rapoo's rapoo_probe() guards the to_usb_interface() call with
hdev->bus == BUS_USB, but uhid can forge hdev->bus, trivially
bypassing this check and causing the same type confusion.

Fix both drivers by adding the proper hid_is_usb() guard -- a helper
that inspects the actual parent device type rather than trusting the
forgeable bus field -- before any to_usb_interface() dereference.

Fixes: e93faaca84b7 ("HID: huawei: fix CD30 keyboard report descriptor issue")
Fixes: b3b1c68fb726 ("HID: rapoo: Add support for side buttons on RAPOO 0x2015 mouse")
Assisted-by: Claude:deepseek-v4-pro
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hid/hid-huawei.c | 7 ++++++-
 drivers/hid/hid-rapoo.c  | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-huawei.c b/drivers/hid/hid-huawei.c
index 6a616bf21b38..d2f9f15871a2 100644
--- a/drivers/hid/hid-huawei.c
+++ b/drivers/hid/hid-huawei.c
@@ -44,7 +44,12 @@ static const __u8 huawei_cd30_kbd_rdesc_fixed[] = {
 static const __u8 *huawei_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 				  unsigned int *rsize)
 {
-	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+	struct usb_interface *intf;
+
+	if (!hid_is_usb(hdev))
+		return rdesc;
+
+	intf = to_usb_interface(hdev->dev.parent);
 
 	switch (hdev->product) {
 	case USB_DEVICE_ID_HUAWEI_CD30KBD:
diff --git a/drivers/hid/hid-rapoo.c b/drivers/hid/hid-rapoo.c
index 4c81f3086de4..5c9c396fabf7 100644
--- a/drivers/hid/hid-rapoo.c
+++ b/drivers/hid/hid-rapoo.c
@@ -36,7 +36,7 @@ static int rapoo_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
-	if (hdev->bus == BUS_USB) {
+	if (hid_is_usb(hdev)) {
 		struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
 
 		if (intf->cur_altsetting->desc.bInterfaceNumber != 1)
-- 
2.34.1

