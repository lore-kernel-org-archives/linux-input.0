Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794752480;
	b=cmXYNtSvFK7UzKesoi2AOLc2tez5WodxjEdIc33WEeFrJKlR58nMR6c2OWt8SjdEdZo6
	 lQgFtL6zd+jKSC4EdyluVW02mYayl//2bJW/B8Yu2k9d4qg1jvvBce9iUqzd+e8MXaGtO
	 Y1gEgvV7TzSbKmYZjADD+BWBGQxwabOHCVCdSqLA3ZAHTjU7HlsxBVh142c9jT567q+Ni
	 a5kekV7NTQqwwop5C254Xm7UiTqwLTfT8VN2G49TBK4/20YdJqRDcvDbhIObekDn2M6Cg
	 Hj1Cgs/75IW3Gya6lShKGEqMKb82716vss9U7yvRBfoDbi2/FPcXJllJhZLEkParyZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794752480;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=aGZrSdqMYZ08b1Sh60Gjeh0Br7eIQV/7kLiiTVwcwu0=;
	b=XQxVLWMBS0IhJBkFrf6FO9FaBJKySIHNnFSPDtIAfvoK1/zcU7W93N7ypFQuZGiH2Rmn
	 cHRTeHWmJ4tbD6si068qnfrlnMk9Ut7tObEJ60KVOtB61+GGi8BQhiirVKnW7K3i4Lwqk
	 O4TSTU9pZ3zSHylQ4C94NPfd2JJmIOlY8vPPePw9AnIJ7Z71tGf2UdQuZGjFTM14y5Rw8
	 oRhhziPjHFqQFvKMe91RTfASizRoHRn7yqlRD+2OpyZ8I7ZTWwW+5ixd48CyvZNuTLDdK
	 3+mrC/s9K5Hr3s8YGPJWRdLQO9QQKMtJsku272o5APBiY0YosMiVMTbmkp4ga6zwM+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=VQ3MzpeI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jhAxK3E8;
	arc=none smtp.remote-ip=202.12.124.136
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4590A606A31E
	for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 14:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4590A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=VQ3MzpeI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jhAxK3E8
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.stl.internal (Postfix) with ESMTP id 5E42D1302C02
	for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 09:21:19 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 15 Nov 2026 09:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1794752478; x=
	1794759678; bh=aGZrSdqMYZ08b1Sh60Gjeh0Br7eIQV/7kLiiTVwcwu0=; b=V
	Q3MzpeIfYMSLfJOkQBFD/0wtLIAtmGudY7e3LVemI0QToramgRUio6YMAWlX6ItZ
	INfREWYSxl9JSPDOwfGXbFJ2drrBhanZ+zFmtsgIQjaZB2Hcq4Rp061c3CbgfIVo
	Jf2fDJ1LlslC+oDmxCnMRiMPt0Cyvvhuowvti29dTHBSvr7Gpf5Izg7DgWoocAh5
	iU8JpapnaxGH92FBb6wueJmxO0+RyCh3Hr7nYvPIxJuOkAXOsipNI+/PjXMV7vp7
	knlST4x+UJ3KAOrS3nylBdwGZ7grRGV+gqwlRKR6u/RXRY6M+Fbdx6a4VGP0o91A
	Qrr/dEU0YxDbTDII3ltiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794752478; x=1794759678; bh=a
	GZrSdqMYZ08b1Sh60Gjeh0Br7eIQV/7kLiiTVwcwu0=; b=jhAxK3E8bWDPvjC5+
	ULBP7KSa9W/Gkm1aoThEsB6N7kFndcTaX3Spw/2TOIfoRzhHukzoocN6rEiUsM9i
	O4G6dsUpwAeT1EPuCdgpG9ddTNzgsM0wTHg0JiDgXhORh2rJZ6dhWdb21LgZMfDy
	MCaPj/Lg1Xil8PBUGGMAdVfb46Qd0pF5U5ZvYDgdNj7wbVsRHeEjOAJta4Zijk4L
	MK8Wrni8NnqDt+egzLMGwQknUbTMIqiWI2n43KHCd7Ev1ekvOS56SXE8UlZr4BqH
	6FRFEjBqL9/U//a1ZxrRWxcih07B274UOF3hZBP4K5e8dxaNOdpfzRt7cO8NBXo9
	8kGgQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794752478; d=fastmail.com;
	mf=PGdyZWVuLmtvYWxhMjk3OUBmYXN0bWFpbC5jb20+;
	rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
	s=fm3:rsa-sha256:mF3YegBvls32e8/5U9mrDaczKsppraaLeSPrwNNH6EITp1B
	t1PNbk42xMh2Nm01BH4zdxbVRMBDFSk2a2VlPaSpaJa72EeK5GnOktAUDkLrisi6
	iw1HhDXVANgDoZEtp6LCjBTKxAjp2OldiGyc2x3WifFgnnQwxblBqe+keRppPT7v
	4m5nK4SwYiNrP7UDACfDeMyZGyq2/9cAdxnn5R0ZVDoa8Sd61U95GbQ4IJzIgPS2
	dOCS9luzaL4+82mnPY0ph7wSsUemWvwxmnKeac7zI/JKNjgdyRIzFqW9X+xt94XF
	mYeAHpwqx2kx3FIS4S7jw46+VcKE8BYkof6BU/w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:qRLKC47ClSzGvYSNLnfcdD9oxgrZFj/1Mvk+v2oXNdo=:UqyOyyvi/+IQWLZJu+/ytjz17lekALiMSNkk9lyxd3Q=;
X-ME-Sender: <xms:3r_5amgTFhqLOA7BQQ3zily_SynpdNqgT4ofN7BaEcNsEUz1r9SubA>
    <xme:3r_5agUjo-jqFGTubZagqOj6gwz46Dc-8K_8a6RSkrtvL6vjpjpfvxLXHO1HmYUEG
    iLNRLlT_-kPxOncilcTcn-4KQQsFyrn7IPKLTbhz1RjT6FidsRdmlfU>
X-ME-Received: <xmr:3r_5alU2_qNLVsJNX5dnIzQYKzHXdTsq9goAtOKp8Oa5mc7N-T-G6s6-Em435f9ZPpsL7SFY1A5cEiEyKj3Lz8wnhgbgaDo5VAhY6UpeiJnHa8U>
X-ME-Proxy-Cause: dmFkZTG2fbdK1rv7Qtjm7ID0RYi7jyfz4jWJTQGPRiTmjxEuLYFmR/3dJO7CqRkBa7C/53
    ZubchNPe3hxJewPaQ9PIcEMPPGLVuAgDuYicaek1oNh0XFUVaCq44eGjMDbxKkYGVO2Cj4
    JYyyarAcCDo7eBmtNAvbdUTIL73rJZW+eDYvw5jOrbAA3o9FWVWEwciE6HZzheGLpdhW7e
    Gzd31s/pPZ56/F0J43ZHYymeT+BJ+SyJ5twlIlUNHgB0EPrGpNSSf4UzcjIWqxgkPfE8hY
    pIm8uCiib6rLdBtFYIDFXfa2qHfrJs/tdZvpY8zcuJaxNNAuq57SI8AvMWWOAScu5Q3ULa
    4S3Q68GQYov6LdvJFS0K6OUEs803xRWGZJlYo67/eBt7zV32tUyuHqyUNqfwyG6BLuv6HV
    ThJyYU+jmFggzmK2JjmM5i3GWh5REKGm4Maelk1Uysa+yNAOm0Sa8gSJQuQG7ILKjsh7F2
    6wLwKaHTwj3J8KbzLdcjumUQwb+CmcPjwpNA+blWJw+gAVvlMRBJqVi1FZnvgFJQoudUd1
    drnz4Hwi1g7TRQqnoTPvdXLyTqDTAUbq+qqh8N5RaC5GN75I6Td8K6b5LRBfPoIdNf5fKF
    PYR2EwUbEJN47RrupErD7jNLkGngrdFT+3cUAAu0YI5QRupI46wrnfFqOoag
X-ME-Proxy: <xmx:3r_5agifmZOOasIjL6QfcMT2bgSfl0yjQso-GOBS915fawTlEGDRyg>
    <xmx:3r_5agZdsnbqdpmKN0VVvWBCYOGcEi4sf54JJ1NhdM6d3KSrIjB1tg>
    <xmx:3r_5atoD273sGbkBWKHSRZnaeZAyYfxXe06iFir9XhGsWj5qpBd9VA>
    <xmx:3r_5atNb8h-jfdWJ7uQmgQUABAXGCcBbq8nF3r2OZSgDxiDgDv9IFQ>
    <xmx:3r_5amX31nsxWzKmFnKY2rxHMFZF50ArfekxbjwyKS9p2p9Fmo29ghi_>
Feedback-ID: ib51446d9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Nov 2026 09:21:17 -0500 (EST)
From: Ana Veto <green.koala2979@fastmail.com>
To: derekjohn.clark@gmail.com,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Ana Veto <green.koala2979@fastmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] HID: hid-msi: Send a uevent when the MCU changes the mode by itself
Date: Sun, 15 Nov 2026 14:21:10 +0000
Message-ID: <20261115142110.65521-1-green.koala2979@fastmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261115032314.7094-1-green.koala2979@fastmail.com>
References: <20261115032314.7094-1-green.koala2979@fastmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MCU of the MSI Claw changes the M-key function by itself once a
second while View+LB is held, and the controller can end up in desktop
mode, where the sticks drive the mouse. The MCU reports the current
mode and M-key function in a GAMEPAD_MODE_ACK report, unsolicited after
such a change and in reply to a query, and the driver stores both, but
userspace is not told. udev rules that keep the controller usable run
only on add, change and bind (for example InputPlumber's rules that
switch desktop mode back to xinput and set the M-keys to macro), so the
controller stays in desktop mode or with M1/M2 disabled until it is
probed again.

Emit KOBJ_CHANGE from a work item whenever a report changes the stored
mode or M-key function. Store the new values after a successful
SWITCH_MODE write as well, so that the driver's own writes raise no
event. A report that comes in during the write was sent either before
the MCU applied the write or after the MCU changed the state again, so
neither it nor the written values can be trusted: read the state back
and emit the event, so that userspace checks the state.

Tested on an MSI Claw 8 EX AI+ (0db0:1901) with a v7.3.3-based kernel and
InputPlumber's rules. The controller was switched to desktop mode by a
SWITCH_MODE report written to hidraw, bypassing the driver. A read of
gamepad_mode then returned desktop and raised a change uevent, and the
rule wrote xinput 66 ms later. After another such switch, View+LB made
the MCU report mode 4 by itself, and the rule wrote xinput within
0.3 s. While View+LB was held in xinput mode, the MCU reported the
M-keys disabled once a second, and the M-key rule set macro again each
time. A mode report with the state from before a SWITCH_MODE write was
also made to arrive during the write, by a query written to hidraw while
the driver waited to send it: the driver read the state back and raised
an event, and the next change of the M-key function by the MCU raised
one as well.

Fixes: a9517958e828 ("HID: hid-msi: Add MSI Claw configuration driver")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ana Veto <green.koala2979@fastmail.com>
---

Notes:
    Based on hid.git for-next. This changes lines near "HID: hid-msi: Drain orphan MCU ACKs by issuing a query" (v2, posted 2026-11-14); the two patches apply in either order.
    
    v4: if a GAMEPAD_MODE_ACK comes in during the SWITCH_MODE write, the driver now reads the state back and emits the uevent. In v3 such a report raised no event when it carried the state from before the write, and the stored state could stay wrong, so a later change by the MCU could go unreported as well (Sashiko review: https://lore.kernel.org/r/sashiko-outbox-215202@kernel.org). Tested on the Claw with the report forced into the write: with v3, no event in 2 of 2 runs; with v4, an event in 4 of 4.
    v3: https://lore.kernel.org/r/20261115032314.7094-1-green.koala2979@fastmail.com
    v2: https://lore.kernel.org/r/20261114221440.12580-1-green.koala2979@fastmail.com

 drivers/hid/hid-msi.c | 65 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
index 3225d3b..6f14647 100644
--- a/drivers/hid/hid-msi.c
+++ b/drivers/hid/hid-msi.c
@@ -350,6 +350,8 @@ struct claw_drvdata {
 	/* Gamepad Variables */
 	enum claw_mkeys_function_index mkeys_function;
 	enum claw_gamepad_mode_index gamepad_mode;
+	struct work_struct mode_event; /* uevent when the MCU changes the mode */
+	unsigned int mode_reports; /* Mode reports stored, guarded by mode_lock */
 	u8 m1_codes[CLAW_KEYS_MAX];
 	u8 m2_codes[CLAW_KEYS_MAX];
 	u8 rumble_intensity_right;
@@ -387,19 +389,46 @@ static int get_endpoint_address(struct hid_device *hdev)
 	return -ENODEV;
 }
 
+static void claw_mode_event_fn(struct work_struct *work)
+{
+	struct claw_drvdata *drvdata = container_of(work, struct claw_drvdata, mode_event);
+
+	kobject_uevent(&drvdata->hdev->dev.kobj, KOBJ_CHANGE);
+}
+
+static void claw_queue_mode_event(struct claw_drvdata *drvdata)
+{
+	guard(spinlock_irqsave)(&drvdata->registration_lock);
+	/* Pairs with smp_store_release from cfg_setup_fn and claw_remove */
+	if (smp_load_acquire(&drvdata->gp_registered))
+		schedule_work(&drvdata->mode_event);
+}
+
 static int claw_gamepad_mode_event(struct claw_drvdata *drvdata,
 				   struct claw_command_report *cmd_rep)
 {
+	bool changed;
+
 	if (cmd_rep->data[0] >= ARRAY_SIZE(claw_gamepad_mode_text) ||
 	    !claw_gamepad_mode_text[cmd_rep->data[0]] ||
 	    cmd_rep->data[1] >= ARRAY_SIZE(claw_mkeys_function_text))
 		return -EINVAL;
 
 	scoped_guard(spinlock_irqsave, &drvdata->mode_lock) {
+		changed = drvdata->gamepad_mode != cmd_rep->data[0] ||
+			  drvdata->mkeys_function != cmd_rep->data[1];
 		drvdata->gamepad_mode = cmd_rep->data[0];
 		drvdata->mkeys_function = cmd_rep->data[1];
+		drvdata->mode_reports++;
 	}
 
+	/*
+	 * The MCU changes the mode or M-key function by itself, e.g. while
+	 * View+LB is held. Userspace learns of changes only through uevents.
+	 */
+	if (changed)
+		claw_queue_mode_event(drvdata);
+
 	return 0;
 }
 
@@ -656,11 +685,15 @@ static int claw_hw_output_report(struct hid_device *hdev, u8 index, u8 *data,
 static int claw_switch_mode(struct hid_device *hdev, enum claw_mode_field field, u8 val)
 {
 	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	unsigned int reports;
+	bool raced;
 	u8 data[2];
+	int ret;
 
 	guard(mutex)(&drvdata->cfg_mutex);
 
 	scoped_guard(spinlock_irqsave, &drvdata->mode_lock) {
+		reports = drvdata->mode_reports;
 		switch (field) {
 		case CLAW_FIELD_GAMEPAD_MODE:
 			data[0] = val;
@@ -673,8 +706,32 @@ static int claw_switch_mode(struct hid_device *hdev, enum claw_mode_field field,
 		}
 	}
 
-	return __claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SWITCH_MODE, data,
-				       ARRAY_SIZE(data), 0);
+	ret = __claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SWITCH_MODE, data,
+				      ARRAY_SIZE(data), 0);
+	if (ret)
+		return ret;
+
+	/* The driver's own change is no change to report */
+	scoped_guard(spinlock_irqsave, &drvdata->mode_lock) {
+		raced = drvdata->mode_reports != reports;
+		if (!raced) {
+			drvdata->gamepad_mode = data[0];
+			drvdata->mkeys_function = data[1];
+		}
+	}
+
+	/*
+	 * A report came in during the transfer. The MCU sent it either before
+	 * it applied the write or after it changed the state again by itself,
+	 * so the stored state may be wrong and a change may have gone
+	 * unreported. Read the state back and let userspace check it.
+	 */
+	if (raced) {
+		__claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_GAMEPAD_MODE, NULL, 0, 25);
+		claw_queue_mode_event(drvdata);
+	}
+
+	return 0;
 }
 
 static ssize_t gamepad_mode_store(struct device *dev, struct device_attribute *attr,
@@ -1871,6 +1928,7 @@ static int claw_probe(struct hid_device *hdev, u8 ep)
 	INIT_DELAYED_WORK(&drvdata->cfg_resume, &cfg_resume_fn);
 	INIT_DELAYED_WORK(&drvdata->cfg_setup, &cfg_setup_fn);
 	INIT_DELAYED_WORK(&drvdata->rgb_queue, &claw_rgb_queue_fn);
+	INIT_WORK(&drvdata->mode_event, &claw_mode_event_fn);
 
 	/* For control interface: open the HID transport for sending commands. */
 	ret = hid_hw_open(hdev);
@@ -1946,6 +2004,9 @@ static void claw_remove(struct hid_device *hdev)
 		smp_store_release(&drvdata->rgb_registered, false);
 	}
 
+	/* gp_registered is false now, so no new mode event can be queued */
+	cancel_work_sync(&drvdata->mode_event);
+
 	if (gp_registered)
 		device_remove_group(&hdev->dev, &claw_gamepad_attr_group);
 
-- 
2.56.0

