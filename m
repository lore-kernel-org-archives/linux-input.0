Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D48391E43
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434862; cv=none; b=j+keTr/nli0J0s0nkxLDtzkak3IVgnlt/0rkD6vXhRSmhv47IRlNw6jo1sKyaNSEBzQjYF6v1kqXJCu5p7dV3Fn4kRXTl0UKO9Ea2Z60/bfFPGfnDCcPgP6bkAawrCnbZuAwiVgjLGAjr+mdLHzh2DRaoySJMNmKvp/N5SPshHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434862; c=relaxed/simple;
	bh=QPQz+OgTmgC1KaCD/XgPz2pDEBSmMGR36tdcIU1HSwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWZ+uxDCEc6vOD2PeLXiQWiGvpD6UHAxw6DTDYGpYIPbG9HlMbCJNOwXwA8coLYSkpfXAnbcQx6BhASajpW8xLcwNZC1upF1aDq2AzdTIQWHqrYnJ0Y6e5qkkBbhg4Fi3zqCf6IrqEPC0W+Hk+3pT2QAMZqNpOvJ9pWh+Ba+QnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHRBRis0; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHRBRis0"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a082b3671fso3594181a12.3
        for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 14:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787434850; x=1788039650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PIZ8vk7AvIlf+MJCS8KXSoMKwVDTGVsLnVhkK3vPSy4=;
        b=SHRBRis0lBZaK8GBErHz7T18BK35h22ZcZcu+TDgtay7MDsMHlYFoHQ3UQA3jK1k05
         6+gC7j3e06Zvxap0oESMTZx7pngyy3MydoouUFwTzCJYBchgzqlNMUgComaYa2p34CKx
         E3sYOI598yEV/lna3TyYvtuj3t4CC/6PJ1EeuPFzew7wvdnAab5V/C2vToqhyCSls/mD
         tutylu2sISSB04LOHg6JZD0c0/Cey3GPIb6fY1aEAhuKgtt3OswUTc9TG85rbNC1hJ3d
         RVPP+HRNwkeGdob7Rirs1BVgohW2hwovXkhhL2escZ8Joq7in/89+f+a6fE0pvAwZQ7r
         2gEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787434850; x=1788039650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PIZ8vk7AvIlf+MJCS8KXSoMKwVDTGVsLnVhkK3vPSy4=;
        b=MKQlfFKBsJT1lkQc/MDSu3o18KAgOcg0/xgJEQkYN35pmP5OLnQtd+syGrIyFnRKFg
         Fn5MLM35AiJDfDz9EkqLfzafhJlDOAOizxVhKluQL5wMF0AIuM1WK2WmHnWV/Yn2qBVk
         PeRer0kGaip3yC0nW7ESc4mvZDcAfaQL4NFggxey4GatFZq/+nNBqscLzJvZCQ2uK2H9
         PI3hji7FNv3rowalpbrXkg37pvx77ne6EOuviiAXbYR6PV/p2stzD3rQSBtbr8iowKrl
         F/qDAO6L0Fw4870XRxlc09A3KVFPjzH9H2l+Kp6ZsXufz8OFXcv5gNC72dQhQU+RU9Rd
         jzzA==
X-Forwarded-Encrypted: i=1; AHgh+RoTdrLFWH30uoabUfBlP78xLtn2BhoIGdporwbu07z3dpTft6/y56N+cjHIyjFepsYpkgQxmPX+EU4X0w==@vger.kernel.org
X-Gm-Message-State: AFuF++k28mWzx8uhsLY6ihIHVgFEUnH33NbYxZm/SdzR5OJvS1/v9cgE
	cioN4yFK8dKeM10gTXf9FtygCa26VfOYaKgJeFoITqTbM6IydBOUnop9
X-Gm-Gg: AR+sD11pr/GaT4ws78EcGP+iDaXKZ/ZDd9lLq8vRWuTliVHVkKqnUAiSUjXeLYaI2vC
	OCCMwM3IY6h8hP8AlJyem++7Ux0shhBv8YM/TTaBHbYqZYUjqoxzbw1ZVvS3IyrDfiWsb7+2xOc
	J1+jB828zXARzIvBK4xsZzzxXZouQBWK5dhytOZeJowxJk4AOdRcZ4lcL29JU2z7rjourIsq3Ab
	Y8I88BRh3Xaj+lF2EXrLTohtCmFKpFusdsDTBBQtJVfMRicUpYMiLNHH1HVAMH8/cPHRLhCRODs
	Zbs8tK56YmaCbjbczy+uCRSgWsPHklbx7r68mTnVDG7gmHodZoJ6Sfu7h1hRztJ6qRgt2x3dfJB
	CLScHAvo0t5IrKSZcZlEW/xohBygPbE5EH1oKVNqTezBIAzJNK6+3qO8Vt0FlVMnwd55ObZusZQ
	eD6PHzIzgpHQCraU/WNsazuNFfVsT4QPkla8F3v3GFdkKO6RYGvBkH6NrPmhM=
X-Received: by 2002:a17:907:7283:b0:c24:b11a:470f with SMTP id a640c23a62f3a-c24b11a493emr163528966b.0.1787434849751;
        Sat, 22 Aug 2026 14:40:49 -0700 (PDT)
Received: from m2.. ([37.142.151.124])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c24966f99basm466778466b.37.2026.08.22.14.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 14:40:49 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	Christina Quast <contact@christina-quast.de>,
	linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>,
	Andreas Boose <Andreas.Boose@almex.de>
Subject: [PATCH 12/13] HID: ft260: workaround for TN_189 errata endpoint STALL after enumeration
Date: Sun, 23 Aug 2026 00:39:40 +0300
Message-ID: <20260822213941.98882-13-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260822213941.98882-1-michael.zaidman@gmail.com>
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FTDI errata TN_189 (Section 2.1) documents a silicon bug where the
FT260's USB interrupt endpoints are occasionally halted right after
enumeration. When this happens, Clear-Feature ENDPOINT_HALT does not
recover the endpoint and the only known recovery is a USB device reset.

This patch implements an in-driver workaround:

  1. ft260_check_intr_ep_health() observes the STALL by attempting an
     actual interrupt IN transfer. The FT260 does not honestly report
     its halt state via USB_REQ_GET_STATUS (returns 0 even when
     STALLed; confirmed separately by FTDI engineering with a USB
     analyzer trace), so we cannot rely on it; instead we let the
     host controller return -EPIPE when it sees the STALL handshake.

  2. ft260_check_dev_responsive() catches the broader broken state
     where the interrupt endpoint may look healthy but the device
     still fails to respond to control transfers. A USB_REQ_GET_STATUS
     to the device with a short 500 ms timeout fails fast on a broken
     device, preventing later probe stages from hanging on usbhid's
     default 10 s timeouts and starving the usb_hub_wq workqueue.

  3. When either check fails, probe schedules a deferred work item
     and returns -ENODEV so that hub_event releases the device lock
     quickly. The work item retries usb_lock_device_for_reset() up to
     10 times (~10 s; each attempt already polls for up to one second)
     before giving up, then calls usb_reset_device() and explicitly
     unbinds/rebinds all USB interfaces to force usbhid to recreate
     the HID devices and trigger a fresh ft260_probe(). The
     unbind+rebind step is needed because usbhid's pre_reset and
     post_reset both return 0, so usb_reset_device() alone keeps
     usbhid bound to stale HID device state.

FTDI engineering tested this on a Raspberry Pi 4 Model B Rev 1.5
running Linux 6.12.62-v8+ on an xhci_hcd host, with the FT260 connected
at full-speed through a downstream USB 2.0 hub. Across 28,684
re-enumeration cycles, 350 cycles triggered the recovery path. Two of
those required two consecutive USB resets before the device returned.
All 28,684 cycles recovered to a fully functional state with I2C and
UART working end-to-end.

Reported-by: Andreas Boose <Andreas.Boose@almex.de>
Closes: https://github.com/MichaelZaidman/hid-ft260/issues/40
Link: https://ftdichip.com/wp-content/uploads/2026/05/TN_189-FT260-Errata-Technical-Note.pdf
Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 229 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 229 insertions(+)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 36687c086b40..9ae688f6208f 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -2359,15 +2359,227 @@ static int ft260_uart_probe(struct ft260_device *dev,
 	return ret;
 }
 
+/*
+ * FT260 errata TN_189 Section 2.1: the USB interrupt endpoints are
+ * occasionally halted right after enumeration. When this happens:
+ *  - Standard Clear-Feature ENDPOINT_HALT does not recover the endpoint
+ *  - Subsequent communication with the device is dead
+ *  - The only known recovery is a USB device reset
+ *
+ * A separate finding from FTDI engineering (confirmed by USB analyzer
+ * trace while testing this workaround) is that the FT260 does NOT
+ * honestly report the halt state via USB_REQ_GET_STATUS: it returns 0
+ * even when the endpoint is STALLed. Detection must therefore observe
+ * the STALL handshake at the host controller level rather than ask
+ * the device.
+ *
+ * Recovery is performed by a deferred work item that resets the USB
+ * device and unbinds/rebinds all interfaces to force usbhid to
+ * destroy stale HID devices and create fresh ones, which triggers a
+ * new ft260_probe() that succeeds.
+ *
+ * https://ftdichip.com/wp-content/uploads/2026/05/TN_189-FT260-Errata-Technical-Note.pdf
+ */
+struct ft260_reset_work {
+	struct work_struct work;
+	struct usb_interface *usbif;
+};
+
+static void ft260_reset_and_rebind(struct work_struct *ws)
+{
+	struct ft260_reset_work *rw =
+		container_of(ws, struct ft260_reset_work, work);
+	struct usb_interface *usbif = rw->usbif;
+	struct usb_device *usbdev = interface_to_usbdev(usbif);
+	struct usb_host_config *actconfig;
+	int ret, i, attempt;
+
+	/*
+	 * Retry the device lock for up to ~10 seconds. The lock is held
+	 * by hub_event for the duration of device enumeration; with the
+	 * fast-fail responsiveness check in probe, both interfaces should
+	 * abort within ~1-2 seconds, after which the lock becomes free.
+	 * Each usb_lock_device_for_reset() attempt already polls for up to
+	 * one second internally.
+	 */
+	for (attempt = 0; attempt < 10; attempt++) {
+		ret = usb_lock_device_for_reset(usbdev, NULL);
+		if (ret >= 0)
+			break;
+		if (ret == -ENODEV || ret == -EHOSTUNREACH) {
+			dev_dbg(&usbif->dev,
+				"device gone before reset (%d), abort\n", ret);
+			goto out;
+		}
+		/* -EBUSY: someone else holds the lock; retry. */
+	}
+	if (ret < 0) {
+		dev_err(&usbif->dev,
+			"failed to acquire USB device lock for reset after %d attempts: %d\n",
+			attempt, ret);
+		goto out;
+	}
+
+	ret = usb_reset_device(usbdev);
+	if (ret < 0) {
+		dev_err(&usbif->dev, "USB reset failed: %d\n", ret);
+		usb_unlock_device(usbdev);
+		goto out;
+	}
+
+	/*
+	 * usb_reset_device() keeps usbhid bound (its pre_reset/post_reset
+	 * both return 0) and does not re-trigger HID-level driver probing.
+	 * Unbind and rebind all USB interfaces to force usbhid to destroy
+	 * stale HID devices and create new ones, which triggers fresh
+	 * ft260_probe() calls.
+	 */
+	actconfig = usbdev->actconfig;
+	for (i = 0; actconfig && i < actconfig->desc.bNumInterfaces; i++) {
+		struct usb_interface *intf = actconfig->interface[i];
+
+		if (intf && intf->dev.driver)
+			device_release_driver(&intf->dev);
+	}
+	for (i = 0; actconfig && i < actconfig->desc.bNumInterfaces; i++) {
+		struct usb_interface *intf = actconfig->interface[i];
+
+		if (!intf)
+			continue;
+		ret = device_attach(&intf->dev);
+		if (ret < 0)
+			dev_err(&intf->dev,
+				"failed to rebind USB interface: %d\n", ret);
+	}
+
+	usb_unlock_device(usbdev);
+out:
+	usb_put_intf(usbif);
+	kfree(rw);
+}
+
+static int ft260_schedule_reset(struct usb_interface *usbif)
+{
+	struct ft260_reset_work *rw;
+
+	rw = kmalloc_obj(*rw, GFP_KERNEL);
+	if (!rw)
+		return -ENOMEM;
+
+	usb_get_intf(usbif);
+	rw->usbif = usbif;
+	INIT_WORK(&rw->work, ft260_reset_and_rebind);
+	schedule_work(&rw->work);
+
+	return 0;
+}
+
+/*
+ * Detect whether the device's interrupt IN endpoint is in the STALL
+ * state described by TN_189. GET_STATUS is unreliable on the FT260
+ * (returns 0 even when halted, confirmed by FTDI with a USB analyzer
+ * trace), so observe the STALL handshake by attempting an actual
+ * interrupt IN transfer. The host controller returns -EPIPE when it
+ * receives a STALL handshake.
+ *
+ * Must be called before hid_hw_open() so it does not race against
+ * usbhid's own interrupt IN URB.
+ */
+static int ft260_check_intr_ep_health(struct hid_device *hdev)
+{
+	struct usb_interface *usbif = to_usb_interface(hdev->dev.parent);
+	struct usb_device *usbdev = interface_to_usbdev(usbif);
+	struct usb_host_interface *iface_desc = usbif->cur_altsetting;
+	struct usb_endpoint_descriptor *ep = NULL;
+	unsigned int pipe;
+	u8 *buf;
+	int ret, actual_length, i;
+
+	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++) {
+		if (usb_endpoint_is_int_in(&iface_desc->endpoint[i].desc)) {
+			ep = &iface_desc->endpoint[i].desc;
+			break;
+		}
+	}
+	if (!ep)
+		return 0;
+
+	buf = kmalloc(FT260_REPORT_MAX_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	pipe = usb_rcvintpipe(usbdev, ep->bEndpointAddress);
+	ret = usb_interrupt_msg(usbdev, pipe, buf, FT260_REPORT_MAX_LEN,
+				&actual_length, 100);
+	kfree(buf);
+
+	if (ret == -EPIPE) {
+		hid_warn(hdev,
+			 "interrupt IN ep %#x halted (TN_189 errata), scheduling USB reset and rebind\n",
+			 ep->bEndpointAddress);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+/*
+ * Quick check that the device responds to a standard control transfer.
+ * When the FT260 is in the buggy post-enumeration state, control
+ * transfers initiated by later probe stages (chip version retrieval,
+ * UART/I2C configuration, etc.) can hang for very long periods,
+ * starving the usb_hub_wq workqueue and preventing the reset work
+ * from acquiring the device lock.
+ *
+ * Issue USB_REQ_GET_STATUS to the device (any compliant USB device
+ * must answer immediately) with a short explicit timeout. If it
+ * fails, treat the device as broken and bail out before reaching
+ * anything that can block.
+ *
+ * The interrupt-endpoint health check above only catches STALLs on
+ * the interrupt IN path; this check catches the broader broken state
+ * that affects the other interface even when its interrupt endpoint
+ * happens to look healthy.
+ */
+static int ft260_check_dev_responsive(struct hid_device *hdev)
+{
+	struct usb_interface *usbif = to_usb_interface(hdev->dev.parent);
+	struct usb_device *usbdev = interface_to_usbdev(usbif);
+	__le16 *status;
+	int ret;
+
+	status = kmalloc_obj(*status, GFP_KERNEL);
+	if (!status)
+		return -ENOMEM;
+
+	ret = usb_control_msg(usbdev, usb_rcvctrlpipe(usbdev, 0),
+			      USB_REQ_GET_STATUS,
+			      USB_DIR_IN | USB_RECIP_DEVICE,
+			      0, 0, status, sizeof(*status), 500);
+	kfree(status);
+
+	if (ret < 0) {
+		hid_warn(hdev,
+			 "device unresponsive to GET_STATUS (%d), suspected TN_189 errata, scheduling USB reset and rebind\n",
+			 ret);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct ft260_device *dev;
+	struct usb_interface *usbif;
 	struct ft260_get_chip_version_report version;
 	struct ft260_get_system_status_report cfg;
 	int ret;
 
 	if (!hid_is_usb(hdev))
 		return -EINVAL;
+
+	usbif = to_usb_interface(hdev->dev.parent);
 	/*
 	 * We cannot use devm_kzalloc here because the port has to survive
 	 * until destroy function call.
@@ -2392,6 +2604,23 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto hid_fail;
 	}
 
+	/*
+	 * TN_189 errata workaround: bail out fast on a broken device so
+	 * that hub_event releases the device lock quickly, allowing the
+	 * scheduled reset work to acquire it and recover the device.
+	 */
+	ret = ft260_check_intr_ep_health(hdev);
+	if (ret) {
+		ft260_schedule_reset(usbif);
+		goto err_hid_stop;
+	}
+
+	ret = ft260_check_dev_responsive(hdev);
+	if (ret) {
+		ft260_schedule_reset(usbif);
+		goto err_hid_stop;
+	}
+
 	ret = hid_hw_open(hdev);
 	if (ret) {
 		hid_err(hdev, "failed to open HID HW\n");
-- 
2.43.0

