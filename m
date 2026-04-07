Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F5C286D4D;
	Tue,  7 Apr 2026 20:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595599; cv=pass; b=J3xApefUC521EgNWq1eR7ha6FS6tV5UKXC3+F0f6Y/iQnsQ+n/5Jf3xaMS7S4e7GXb0DK4OFbS6ZOOLbKm+evAEW3LyeF2Qh4v776ak6XEjGPatmd06tU0UshsnJmAOzQ4ZM7bcr2YpMdEP16/l8L3kRZLup7D7YH0X66JtcvZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595599; c=relaxed/simple;
	bh=0tFn4yNCXlDsMFWLlCMxKy8hAuf1D+gUVNDNCi7qWNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BzvR3ZmIpuGptXO8UOz39MCWyPBlzbvm7PVNZAUSHX6lb1gw+nHe2vSDMt42p2jpOcMRbpyxiF2ysGfWscmS/B98X2bH6NewTW9OzDAW04TWDwYWf0Ae3whIup/nibaPof3iINIJWs2q683ELfMj/mZAWAjusKB9jk6/T3UjI6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=UFJA+SGh; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="UFJA+SGh"
ARC-Seal: i=1; a=rsa-sha256; t=1775595587; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bcYOoIL79LJpAs1FWY6Lctv+gH8KmffX5oi2Bg5i3fVl8qGfOqUHYwU+a+nFC/9BRvAS676nsP6xGhkoBUJJ/RBFy6aOxLo0EEQrX/FlTUwVo2l86pSgsaJy+sNtWqeOvzsBEaPTjHG0ideofu3XEX5OG34B8jgTt7CXXZisBd4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775595587; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bAvykgs9czbUIgmWbpfltONWSBxOyO9DGFwZ/4BKhwI=; 
	b=a4GbbGyE3xKIvSkUASKncQmUpVxDlyTYe5GXiSSS5ImjyC0sbpd+eTLcp7KP8+gjRvkEcKIRl473+0Z6AuQ9/ev2fgnekXrH420mXYdBF2yfDlOux8e9MYPgblJE2/l8hLu5ljSOUGbdw5mqTLHLGh9UMAw28uM6LUrfggErKEI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775595587;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=bAvykgs9czbUIgmWbpfltONWSBxOyO9DGFwZ/4BKhwI=;
	b=UFJA+SGhgJ4vV2ABE5/IflovgGX+PCbtqcSZdB5gW0eeKISuAHhmo/bUMNuYp9Bx
	SVVOg5gA/CtGwnibc5yPMhgAFiQm0q5Nt19tVrXvL92zQXhEG9SZDsxS0jUD3/tMpRD
	PR6A0ea1gQ4JqNd+9yYaazznoTjq9eBdsB1ee+g4=
Received: by mx.zohomail.com with SMTPS id 1775595585948874.4083395664982;
	Tue, 7 Apr 2026 13:59:45 -0700 (PDT)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 07 Apr 2026 16:59:28 -0400
Subject: [PATCH] HID: quirks: Set ALWAYS_POLL for LOGITECH_BOLT_RECEIVER
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260407-logi-bolt-hid-quirk-always-poll-v1-1-4dae0fda344e@collabora.com>
X-B4-Tracking: v=1; b=H4sIAC9w1WkC/x2NywqDMBAAf0X23IUYtWp/pfQQzVYXF2OT+kL8d
 4OXgbnMHBDIMwV4JQd4WjiwG6OkjwTa3owdIdvooJV+qlyVKK5jbJz8sWeLv5n9gEZWswecnAg
 Wtm5rnVUROcTK5OnL2314f87zAnwxbSRxAAAA
X-Change-ID: 20260407-logi-bolt-hid-quirk-always-poll-5d9c9238c924
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: kernel@collabora.com, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.3
X-ZohoMailClient: External

The Logitech Bolt receiver once connected to a wireless device will
generate data on interface 2. If this data isn't polled, when the USB
port it is connected to gets suspended (and if that happens within 5
minutes of the last input from the wireless device), it will trigger a
remote wakeup 3 seconds later, which will result in a spurious system
wakeup if the port was suspended as part of system sleep.

Set the ALWAYS_POLL quirk for this device to ensure interface 2 is
always polled and this spurious wakeup never happens.

With this change in place the system can be suspended with the receiver
plugged in and the system can be woken up when an input is sent from the
wireless device.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Hi,

Given that the polling only needs to happen before the device goes into
suspend, I wonder if it might make sense to introduce a new quirk type
that only does a poll before the device goes into suspend (both for
system sleep and runtime suspend). It would reduce the extra bit of USB
traffic that ends up happening in this case with ALWAYS_POLL every time
a wireless device connects to the receiver.
---
 drivers/hid/hid-quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 02f7db5c1056..eb811b1fb80f 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -134,6 +134,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_6019), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_602E), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_6093), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_BOLT_RECEIVER), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_C007), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_C077), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_KEYBOARD_G710_PLUS), HID_QUIRK_NOGET },

---
base-commit: 816f193dd0d95246f208590924dd962b192def78
change-id: 20260407-logi-bolt-hid-quirk-always-poll-5d9c9238c924

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>

