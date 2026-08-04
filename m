Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D0A31ED81
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785822630; cv=none; b=gIIyYdBf94NDntVs5PcEGoGrzcfZOVwSU9n1Ltu5Co/Yp89E8xpGkBWWTXq3oN3RiE2UdvQXsUE1xrXQV0vNwaYwxk/dG66x7qh1xSbLKBcQUN8OwoDXhBku2y/eknb5jWuyZiB73mL+uTkDLKgvDeQAJa8gDlav7Doc4jHQJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785822630; c=relaxed/simple;
	bh=DWX+/lzHy+yz84GSu3YNgH9I3gz5cwhLPEe0cpvpCKI=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type; b=a1QA7tinRaMaYrTWHpZ0P1ehsHMBPuPJZ+QXF7HwpDCwdrmiwy5b/2F9eEhTyJ3MMmZWb2oxo3FwEnsDc4RqAr4+urj1La3xQXoHwlfkqwO6Glon7/pClxpAKTuQQaoBlC7m19/bB5uFWlfA7f0BpoKRUAb9spXjeaO23XomvRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=a3CGntfj; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="a3CGntfj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1785822617;
	bh=RYxG4LSJ3lvkQC7UimyZBv3c9DnaUw7eeMv51jY0xRk=;
	h=Date:From:To:Cc:Subject;
	b=a3CGntfjsNh4IyLpUnYvUj4r8DfMBV+OL3SOEtV8VXpSOoOnvq1uOIwAv9hen/bdy
	 t1UcEQhqji8mhjgWjN0Y8E0SBpd++7/bU9Agdp7yjXUtpM7tZu3z/q1pBN+EMNyVLD
	 m5lJ5WpsqCGxDsvY1pu0dhCxJ3tWoZE38fGPEiNQ=
Received: from localhost ([182.91.99.53])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id C8FA921D; Tue, 04 Aug 2026 13:50:15 +0800
X-QQ-mid: xmsmtpt1785822615tu4ry862g
Message-ID: <tencent_72D4D10513DFB685733F4F75EDA62F6EE107@qq.com>
X-QQ-XMAILINFO: MpzImNZj21owFx604LigbkN/F0aVNo5pfKRK2YEXNDW2U7etrJRZMOyZqvTWJA
	 Yj9Nj1j9BORweSkWCkCK1GDujSzEuy6zOR7ai+hNfIc8NfzIEex5OqfoljVoQdbhJXlL9JGJvDrP
	 zXghcMlUMRDOlNMVzEGVOp32lLZ9A20HAGgpvlmDWgbHR15FYy9dX4BLFomHw5FLlZ0e99EkF1MG
	 7A/DULaQBUjeushy6z88wTNBrvmF9Z8i4S/P54UZ8kKLnzTpBx/hxH4lNKVIB5j2PM13JqauoIv9
	 uLw8GC07Vc143DXxrTcxjmRuZoVXwGmioqrTAkHQI7GYdVutSUR931N6ijVtiscWqp6UU9sJqAJa
	 6Io1yUdKRahMAa8i5xDWZw/yMZfmQX2hM8LoFER1cPHlPb3tE0MqomJR48GWcLnFgGD7mpP/bTRn
	 aR6peBhK9u9xZlqgT2U8/W+fKNzbAN54KLngK1ihIr4nLIhm2PselkJD8qv/7cIJJmTj3Yg5TYje
	 zVOtVvIbIfOgnOBmk35tdbMFTg5Ae872JCUnTkbr6MQbPIC9iq+bZ+Xdy2xa+03P+eqBbbTXP3jR
	 8O1zK3fBeYOYBlK77CI8PKSnoboG6wnmhPeavCMRfexT9CgneweRgqci90dPEIE6s4DjNdJ9Nkk4
	 omZbdDP8ZriiB/k1cEMS/1awb80DqiH9H919njDk2S/WUPqDMaAp8rsrcTGF/GyYcQzixWy5Y2uS
	 w0RwIriaPV5g3nh75Gy6S2TpJHVBpnXd9PVZKa/jdfQppqn9QBsy6lnxVsBGmoA1rAkgvJzGSQvj
	 rlwASIZt9aUcN0Pi77SGXzcVb2XLB5GEU/ngr8kAntnUKbrlUv7AjyDZaO7045siFiTQY1d9/VP0
	 o+q6g+6pPE66OESbrxCTnFdZRb7l75iVEwrlBZL+YtXJ0SIHgTDytCrNVk1gOWhszNa+SmPATrMH
	 qSqSfdxEhMSFDZTQpCywiSHE86SI+JhpGS2Cggth9qn8hkJzuzOxF3sw4oC4/kSTJgC7GRJdQtCO
	 9JtYCH70Qvz7OzF1VNV9lNFFKNvfZCtNCA6f/yU/h9nysLSNOo+M7j9Fembq0gpBQnXVoEfW2RTP
	 vEBRLmMul02Ze994MJhj0CnuKbZAZlzrTb+JWU1OihhHd6SeB/lyoUAlIpNw==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
Date: Tue, 04 Aug 2026 13:50:15 +0800
X-OQ-MSGID: <7246fdb9818bcc5402f403128f126889@foxmail.com>
From: vegetablecat@foxmail.com
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Ma <mapengyu@gmail.com>, Shengyu Qu <wiagn233@outlook.com>, Zixing Liu <liushuyu@aosc.io>
Subject: [PATCH v4] Input: xpad - add support for Beitong KP series controllers
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_v4_patch_1785822615"

------=_v4_patch_1785822615
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Subject: [PATCH v4] Input: xpad - add support for Beitong KP series controllers

[This email contains both English and Chinese versions.]
[本邮件包含英语和中文两个版本。]

Hi Dmitry, Aaron, Shengyu, Zixing,

This is v4 of the Beitong KP series support patch. Changes since v3
based on feedback from Aaron and Shengyu:

Lock mechanism — combined MS OS 1.0 sequence
---------------------------------------------
Aaron suggested using the standard GET_DESCRIPTOR for the Microsoft OS
string descriptor (index 0xEE) instead of issuing the Extended Compat ID
request directly. Test results:

  - KP20 (5126/5128): string descriptor alone does NOT lock; Extended
    Compat ID is required.
  - KP40 (515b/515c): either request alone locks the device.

This differs from Aaron's finding on 5158/5159 — the trigger condition
varies across models. The probe therefore sends both requests in MS OS
1.0 sequence order (string descriptor first, Extended Compat ID second).
Each warns on failure without blocking probe.

Aaron, could you confirm the second request doesn't cause regressions
on 5158/5159?

Device table — converged to tested PIDs only
---------------------------------------------
Shengyu pointed out the 28-entry list was inflated. The full list
originated from Zixing Liu's earlier patch [1] and was not fabricated,
but since most were untested, the table is reduced to 6 entries (see
above). Wired-direct (Controller) and wireless-dongle (Dongle)
connections enumerate as different PIDs, hence paired entries.
Remaining PIDs from Liu's patch can be added after individual testing.

KP40D receiver keepalive — HID_QUIRK_ALWAYS_POLL
-------------------------------------------------
Aaron's suggested HID_QUIRK_ALWAYS_POLL approach was tested on
20dd:515c (KP40D) via usbhid.quirks kernel cmdline (GRUB). The
hid-ids.h and hid-quirks.c changes in the accompanying patch reflect
the intended merged form but have not been compile-tested as part of
a kernel build. KP20 wireless (5128) does not need keepalive — it
works without the quirk. Only KP40D IDs were added.

Naming — Controller vs. Dongle
-------------------------------
5126/515b are the physical controller connected via USB → "Controller".
5128/515c are wireless dongles → "Dongle". This matches the fact that
the controller body uses a different VID: in wired mode the USB device
is the controller itself. The previously incorrect naming for wireless
mode has been fixed.

[1] https://lore.kernel.org/linux-input/20260102030154.197749-2-liushuyu@aosc.io/

Signed-off-by: VegetablCat <vegetablecat@foxmail.com>

---

中文版本

Dmitry、Aaron、Shengyu、Zixing，你们好：

这是 Beitong KP 系列支持补丁的 v4 版本。基于 Aaron 和 Shengyu 的反馈，
v3 以来的改动如下：

锁模机制 — 组合 MS OS 1.0 序列

Aaron 建议用标准 GET_DESCRIPTOR 读取 Microsoft OS 字符串描述符
（index 0xEE）代替直接发 Extended Compat ID 请求。实测结果：

  - KP20（5126/5128）：字符串描述符无法锁模，必须 Extended Compat ID。
  - KP40（515b/515c）：字符串描述符或 Extended Compat ID 单独发均可。

这与 Aaron 在 5158/5159 上的结果不同——不同型号的触发条件不完全一致。
因此当前 probe 按 MS OS 1.0 协议顺序两个请求都发（字符串描述符在前，
Extended Compat ID 在后）。单个请求失败仅 dev_warn 警告，不阻断 probe。

Aaron，方便帮忙确认第二个请求不会在 5158/5159 上导致错误吗？

设备表 — 收敛为实测 PID

Shengyu 指出 28 个 ID 的列表过于膨胀，完整列表源自 Zixing Liu 的
早期补丁 [1]，并非凭空编造，但因大部分未实机验证，已缩减为 6 个条目
（见上表）。有线直连（Controller）与无线接收器（Dongle）枚举为不同 PID，
因此成对出现。Liu 补丁中的其余 PID 可在逐一实测后追加。

KP40D 接收器保活 — HID_QUIRK_ALWAYS_POLL

Aaron 提到的 ALWAYS_POLL 方案在 20dd:515c（KP40D）上通过 usbhid.quirks
内核 cmdline（GRUB）验证，未经过内核完整编译测试。附带的 hid-ids.h 和
hid-quirks.c 修改为预期合入后的最终形态，实际运行时验证仅通过 cmdline
完成。KP20 无线（5128）无需保活即可正常工作。仅添加了 KP40D 的 ID。

命名 — Controller 与 Dongle 区分

5126/515b 是有线直连手柄本体 → "Controller"。5128/515c 是无线接收器 →
"Dongle"。这与"手柄本体使用不同 VID"的事实一致——有线模式下 USB 设备
就是手柄本身，已经修改无线模式下错误的命名。

[1] https://lore.kernel.org/linux-input/20260102030154.197749-2-liushuyu@aosc.io/

Signed-off-by: VegetablCat <vegetablecat@foxmail.com>

------=_v4_patch_1785822615
Content-Type: text/x-patch; charset=UTF-8; name="v4-0001-Input-xpad-add-support-for-Beitong-KP-series.patch"
Content-Disposition: attachment; filename="v4-0001-Input-xpad-add-support-for-Beitong-KP-series.patch"
Content-Transfer-Encoding: 8bit

--- a/drivers/input/joystick/xpad.c	2026-07-26 01:34:34.503850264 +0800
+++ b/drivers/input/joystick/xpad.c	2026-08-04 13:48:07.034309653 +0800
@@ -72,6 +72,7 @@
 #define PKT_XBE2_FW_5_11    4
 
 #define FLAG_DELAY_INIT BIT(0)
+#define FLAG_READ_MS_OS_DESC BIT(1)
 
 static bool dpad_to_buttons;
 module_param(dpad_to_buttons, bool, S_IRUGO);
@@ -332,8 +333,12 @@ static const struct xpad_device {
 	{ 0x1bad, 0xfd00, "Razer Onza TE", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0xfd01, "Razer Onza", 0, XTYPE_XBOX360 },
 	{ 0x1ee9, 0x1590, "ZOTAC Gaming Zone", 0, XTYPE_XBOX360 },
+	{ 0x20bc, 0x5126, "BETOP BTP-KP20A Xinput Controller", 0, XTYPE_XBOX360, FLAG_READ_MS_OS_DESC },
+	{ 0x20bc, 0x5128, "BETOP BTP-KP20A Xinput Dongle", 0, XTYPE_XBOX360, FLAG_READ_MS_OS_DESC },
 	{ 0x20bc, 0x5134, "BETOP BTP-KP50B Xinput Dongle", 0, XTYPE_XBOX360 },
 	{ 0x20bc, 0x514a, "BETOP BTP-KP50C Xinput Dongle", 0, XTYPE_XBOX360 },
+	{ 0x20bc, 0x515b, "BETOP BTP-KP40D Xinput Controller", 0, XTYPE_XBOX360, FLAG_READ_MS_OS_DESC },
+	{ 0x20bc, 0x515c, "BETOP BTP-KP40D Xinput Dongle", 0, XTYPE_XBOX360, FLAG_READ_MS_OS_DESC },
 	{ 0x20d6, 0x2001, "BDA Xbox Series X Wired Controller", 0, XTYPE_XBOXONE },
 	{ 0x20d6, 0x2009, "PowerA Enhanced Wired Controller for Xbox Series X|S", 0, XTYPE_XBOXONE },
 	{ 0x20d6, 0x2064, "PowerA Wired Controller for Xbox", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
@@ -778,6 +783,7 @@ struct usb_xpad {
 	time64_t mode_btn_down_ts;
 	bool delay_init;		/* init packets should be delayed */
 	bool delayed_init_done;
+	bool read_ms_os_desc;		/* read Microsoft OS descriptors during probe */
 };
 
 static int xpad_init_input(struct usb_xpad *xpad);
@@ -2044,6 +2050,7 @@ static int xpad_probe(struct usb_interfa
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct usb_xpad *xpad;
 	struct usb_endpoint_descriptor *ep_irq_in, *ep_irq_out;
+	u8 ms_os_desc[128];
 	int i, error;
 
 	if (intf->cur_altsetting->desc.bNumEndpoints != 2)
@@ -2082,6 +2089,8 @@ static int xpad_probe(struct usb_interfa
 	xpad->name = xpad_device[i].name;
 	if (xpad_device[i].flags & FLAG_DELAY_INIT)
 		xpad->delay_init = true;
+	if (xpad_device[i].flags & FLAG_READ_MS_OS_DESC)
+		xpad->read_ms_os_desc = true;
 
 	xpad->packet_type = PKT_XB;
 	INIT_WORK(&xpad->work, xpad_presence_work);
@@ -2148,6 +2157,41 @@ static int xpad_probe(struct usb_interfa
 	xpad->irq_in->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
 	usb_set_intfdata(intf, xpad);
+	if (xpad->read_ms_os_desc) {
+		/*
+		 * Microsoft OS 1.0 sequence: first read the OS string
+		 * descriptor at index 0xEE, then the Extended Compat ID
+		 * descriptor. Some devices (e.g. 20bc:5158/5159) lock into
+		 * XInput mode on the string descriptor read alone; others
+		 * (e.g. 20bc:5126/515b) require the Extended Compat ID read.
+		 * Send both to cover the whole family; each may fail on
+		 * devices that do not implement it, which is harmless.
+		 */
+		error = usb_control_msg_recv(udev, 0,
+					     USB_REQ_GET_DESCRIPTOR,
+					     USB_DIR_IN,
+					     (USB_DT_STRING << 8) | 0xee,
+					     0x0000,
+					     ms_os_desc,
+					     sizeof(ms_os_desc), 25,
+					     GFP_KERNEL);
+		if (error)
+			dev_warn(&intf->dev,
+				 "unable to read Microsoft OS string descriptor: %d\n",
+				 error);
+
+		error = usb_control_msg_recv(udev, 0, 0xee,
+					     USB_TYPE_VENDOR | USB_DIR_IN |
+						USB_RECIP_DEVICE,
+					     0x0000, 0x0004,
+					     ms_os_desc,
+					     sizeof(ms_os_desc), 25,
+					     GFP_KERNEL);
+		if (error)
+			dev_warn(&intf->dev,
+				 "unable to read Microsoft feature descriptor: %d\n",
+				 error);
+	}
 
 	/* Packet type detection */
 	if (le16_to_cpu(udev->descriptor.idVendor) == 0x045e) { /* Microsoft controllers */

------=_v4_patch_1785822615
Content-Type: text/x-patch; charset=UTF-8; name="v4-0002-HID-quirks-Add-ALWAYS_POLL-for-Beitong-KP40D.patch"
Content-Disposition: attachment; filename="v4-0002-HID-quirks-Add-ALWAYS_POLL-for-Beitong-KP40D.patch"
Content-Transfer-Encoding: 8bit

--- a/drivers/hid/hid-ids.h	2026-08-04 13:39:41.345525174 +0800
+++ b/drivers/hid/hid-ids.h	2026-08-04 13:23:25.386480463 +0800
@@ -273,6 +273,8 @@
 #define USB_VENDOR_ID_BETOP_2185PC	0x11c0
 #define USB_VENDOR_ID_BETOP_2185V2PC	0x8380
 #define USB_VENDOR_ID_BETOP_2185V2BFM	0x20bc
+#define USB_VENDOR_ID_BETOP_20DD		0x20dd
+#define USB_DEVICE_ID_BETOP_KP40D	0x515c
 
 #define USB_VENDOR_ID_BIGBEN	0x146b
 #define USB_DEVICE_ID_BIGBEN_PS3OFMINIPAD	0x0902
--- a/drivers/hid/hid-quirks.c	2026-08-04 13:39:41.345525174 +0800
+++ b/drivers/hid/hid-quirks.c	2026-08-04 13:08:23.930343250 +0800
@@ -45,6 +45,8 @@ static const struct hid_device_id hid_qu
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS682), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_CS692), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_UC100KM), HID_QUIRK_NOGET },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_BETOP_20DD,
+			 USB_DEVICE_ID_BETOP_KP40D), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_MULTI_TOUCH), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE2), HID_QUIRK_ALWAYS_POLL },

------=_v4_patch_1785822615--

