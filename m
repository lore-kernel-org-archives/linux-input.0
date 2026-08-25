Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C53488212;
	Tue, 25 Aug 2026 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787677740; cv=none; b=C8jgY5TvvAdGtL60hq1Oqcl+d49ywS1sZmcvWARQzbob4cFxLferDQbWglt3UXWC3FUzhGZ8gDdKXNVotKCwXHVJjY2h3jRetPMIGOEeHLFdQEXV3O1fdUTvhbYOmsuZ87l9lysrRwnVYSUEhOne1CdMt6aJzDV4xR/ssz6MuKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787677740; c=relaxed/simple;
	bh=o9BB9ARGiRoQ1E3qw5IEDFYVZo/2xdRwAaPb5+mf1H0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYQhto+p0SUXEyF/g0ikdmV/1pF2ceHGENshPQ4+iOGsQl+swuHJ0HabxMLTBFqLdB4+2X1b/EKWf5uY1dsuSHXZIPzF3AkgxCNqDzMGYXtQjq2bjLk7V6HRONzxMJGLaj3WlkfPUvWaL2/NhZxaLvSlM9zUdBpEeFl5kn8x/mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrK1OxzX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrK1OxzX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474D31F00ADB;
	Tue, 25 Aug 2026 17:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787677739;
	bh=gpLum3n6ur12cVbkrJ8Syt/r5xkU22lFWODzSqPnUI0=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=hrK1OxzXAZX399uZNkVtegvAv6Yt0me544zrMcOTfHHsxXh6NvdnVGPzV2G1FbRXK
	 LHqw0m3rptfu8xyjxMuLePjgpj288lA9Ocuuh3urxbosQNgaWmMNQRLwfhJSrrLKk/
	 Q+iumDrIwygDpLq/GTVqi9vrmQPR0LxyNKJYF1pjoXthockjNqNaZsHpIA/3+l8NFi
	 DZG5DPLY4VrbtkX+o6QmL8+cp05r1gnYR663NGRzMNUld5iLJJ91chW3orUg/NaqYY
	 LQiKKhw5OgT6Qu54LW/YdTyVNgnNVVT3GW/tFyOzwQCrDn8Te1bRYnGRxRv2SkN0ks
	 9jVdkmax3SK/A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Aaron Skomra <aaron.skomra@wacom.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration
Date: Tue, 25 Aug 2026 15:12:30 +0000
Message-ID: <20260825151242.576456-2-lee@kernel.org>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
In-Reply-To: <20260825151242.576456-1-lee@kernel.org>
References: <20260825151242.576456-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Input subsystem guidelines require that device capabilities are advertised
before the input device is registered.  The Wacom driver was violating
this by advertising the SW_MUTE_DEVICE capability post-registration in
wacom_set_shared_values() (and duplicating it in device-specific setup
cases).

Resolve this by moving the SW_MUTE_DEVICE capability setup to
wacom_setup_touch_input_capabilities() for all touch devices that support
it.

For generic touch devices whose capabilities depend on mute switch
usages parsed from a sibling Pen/Pad interface, defer registration
with -EPROBE_DEFER until the sibling has parsed its descriptors and
initialized shared capabilities.

Fixes: d2ec58aee8b1 ("HID: wacom: generic: support generic touch switch")
Signed-off-by: Lee Jones <lee@kernel.org>
---

v4 -> v5: New patch used to split out SW_MUTE_DEVICE as per Jason's request
v5 -> v6: Unconditionally advertise SW_MUTE_DEVICE on generic touch devices
v6 -> v7: Only advertise SW_MUTE_DEVICE on composite USB generic touch devices
v7 -> v8: Replace heuristic with probe deferral until sibling Pen/Pad is parsed
          Split out 'hdev->product' cleanups into a separate standalone patch

 drivers/hid/wacom_sys.c | 46 ++++++++++++++++++++++++++++++++++++-----
 drivers/hid/wacom_wac.c |  4 ++++
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 0eafa483b7f7..2738d4f515e6 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2358,13 +2358,44 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
 		if (wacom_wac->is_soft_touch_switch)
 			wacom_wac->shared->is_touch_on = true;
 	}
+}
 
-	if (wacom_wac->shared->has_mute_touch_switch &&
-	    wacom_wac->shared->touch_input) {
-		set_bit(EV_SW, wacom_wac->shared->touch_input->evbit);
-		input_set_capability(wacom_wac->shared->touch_input, EV_SW,
-				     SW_MUTE_DEVICE);
+static bool wacom_sibling_pending(struct wacom *wacom)
+{
+	struct hid_device *hdev = wacom->hdev;
+	const struct wacom_features *features = &wacom->wacom_wac.features;
+	struct usb_host_config *actconfig;
+	int i;
+
+	if (features->type != HID_GENERIC ||
+	    !(features->device_type & WACOM_DEVICETYPE_TOUCH))
+		return false;
+
+	if (wacom->wacom_wac.shared &&
+	    rcu_access_pointer(wacom->wacom_wac.shared->pen))
+		return false;
+
+	if (!hid_is_usb(hdev) || !wacom->usbdev)
+		return false;
+
+	if (features->oPid != HID_ANY_ID && features->oPid != 0)
+		return true;
+
+	actconfig = wacom->usbdev->actconfig;
+	if (actconfig && actconfig->desc.bNumInterfaces > 1) {
+		for (i = 0; i < actconfig->desc.bNumInterfaces; i++) {
+			struct usb_interface *sibling_intf = actconfig->interface[i];
+
+			if (!sibling_intf || sibling_intf == wacom->intf)
+				continue;
+
+			if (sibling_intf->cur_altsetting->desc.bInterfaceClass ==
+			    USB_INTERFACE_CLASS_HID)
+				return true;
+		}
 	}
+
+	return false;
 }
 
 static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
@@ -2444,6 +2475,11 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 	if (error)
 		goto fail;
 
+	if (wacom_sibling_pending(wacom)) {
+		error = -EPROBE_DEFER;
+		goto fail;
+	}
+
 	error = wacom_setup_inputs(wacom);
 	if (error)
 		goto fail;
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 4436faf2d2bb..a7e3817aa2c4 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3965,6 +3965,10 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 
 	if (features->type == HID_GENERIC) {
 		hid_dbg(hdev, "generic touch setup\n");
+		if (wacom_wac->shared && wacom_wac->shared->has_mute_touch_switch) {
+			input_set_capability(input_dev, EV_SW, SW_MUTE_DEVICE);
+			wacom_wac->has_mute_touch_switch = true;
+		}
 		/* setup has already been done */
 		return 0;
 	}
-- 
2.55.0.887.g758fc8c411-goog

