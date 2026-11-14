Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794660679;
	b=wn3pvkCqZq+pRry6pwbXSOs47QAja1L8o1oLtLf97nIFQPVXaGOAuSAq+TplN8xSLcIF
	 yLoAKFcjE7++tJNrbiEe/L7iM87MmgBQmJH7Ys09j8bNG2Y41qd6p6t+retkFWMnBaBjq
	 MUE6uHc533SpQ1SQerGD7M0Q1F6xdyScljeVA+P5o8glLpojjolxkNxoz6iDhh3IFhRMa
	 lOKomtxpbQSdXew0Oa9Lu9dhyn141ntHhO3fCM3LjmnUDwJVj7jIjildvUJqYEypkyNBa
	 U6XqzhJ/NurCDfaBM7Kj38rq3/+I5fkOoxP93tAzLMNq6Eo2U8F58Tblr+l/A/MxP7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794660679;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zTE0rfV81tJa1B4KMy6Td9Ov/8P+5EVCpuN5n3QKOnw=;
	b=T4zWM1RHsZvXpGCNa3B0a3OLQWINYjWmKy+389VoEZrcF5mbZXPEuxnGJOGsJR+DHwIx
	 GyfisBT8Nomxlq12bQn9EEtibrj0Fy6NfnRXwBIZcp2b10DhrWFR0askZxySr9SO2YqBW
	 5TEI8SWQxI0GZUW9nYii97TyU2RYw/+7UYNJT7crq8GKJmKuCKgvJu6CzJJ4q87sE2Fau
	 OM0Tj7cGy16OErvNB7JZKDtFNdyL48xL+kfHybilTaXoA0hq+XCAN02sHFgBvJ9mxmeMA
	 AjtlFr0VXZbhaZE+MVbbogzlcyY+ywVOJ4l+2Zp6jigEf1XzZ60/lUn1nG/hsvTTaHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kenhou.net;
	spf=none smtp.mailfrom=kenhou.net;
	dkim=pass header.d=kenhou-net.20260707.gappssmtp.com header.i=@kenhou-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pO49Lsw0;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B57606A327
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 12:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5B57606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kenhou.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kenhou.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kenhou-net.20260707.gappssmtp.com header.i=@kenhou-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pO49Lsw0
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2eac4936dfdso3677525ad.2
        for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 04:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kenhou-net.20260707.gappssmtp.com; s=20260707; t=1794660677; x=1795265477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zTE0rfV81tJa1B4KMy6Td9Ov/8P+5EVCpuN5n3QKOnw=;
        b=pO49Lsw0t+AgAwzqW1tdC0vCDwYOVglEGq71HHfkMAlA29Jd078T20P1zNGwhLrgDL
         03g4/vL+Yl9P34jqI9++cuCGurpW+jqLe2CRWgaI16xXmaHgXhqZUMZaSIrrSNJQmurc
         ub5agkJLpAr7aw8YK0TTYQS00PqVms1UL0wJFVUTPEZCg77FNPH38WldZXkW3w4FyLyJ
         8wt6+Zy6GnJCSXTLTd7WfJL3+vYWp3cPAezEBR2mTslO4VLjunb3ofAP/VIuI4bSF+kp
         abBQvfWXmV5IIjU0GXoSpr1E8tjfvrms003mK9VEJ6K6E25zwDOe1dUQ7/+s8i0/nr1c
         QDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794660677; x=1795265477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zTE0rfV81tJa1B4KMy6Td9Ov/8P+5EVCpuN5n3QKOnw=;
        b=RemfhLHzIZ8kd0SU0TW+QDPvfBrkUxtXqDqqnP1bgvqUuqKdn16N8YeT4nrfy4nl1T
         Cl7z+zOSyZArVE24/3izhIL+Mb8rpnfqJjs6xRLkKbLseJK3fOSmk2YZtMp+GjCLjpYk
         34+hSLiS7W/oLAEd8aDgIBRCpRaDJeHag/GZIEKoV+h2TAaQBSrMNjhiksUmxaWKUxhe
         DWZm/oSvU3IahO+bVu0ZH6KNA2/bmyUhevp/21D3tO1Njwi/HhWSj7VgBfRZnSg+f74X
         iIExJPvqLxUGGhylbztAcZ4RFATYZdVOrvzS4lpXl6wORmma613l1+cJ2FSVDvoS7zAK
         6aDQ==
X-Forwarded-Encrypted: i=1; AL+hErHZ9yl90itRmMi8B1DIVFmO2c13Pmb9jZ96XorHkd4h95LsvtaQYGWQwck4Oh6X0MXH/QBZOOklJlRjkQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8P72Z2ilSonT0cTHGB1NpyUqp/9S7YMHgbzGTW3PZKYB8T8I+q
	Xo9eDUhEKdPw+6DRF82nla+4oiA9tWictAjR2TFG4gTcK/PRxgF6u++FKmRnZLfRZEdetW/9B69
	87Js6pptlJw==
X-Gm-Gg: AYBFou3hk3r1+gvwGcOHw6v2N5Azy0Xg0m196mU6xGwNX81ulKUIIVMvbXGkxSyGk7u
	b6v3iGNbfNQO3IGHZGcamu/a5zBlcZpyvy+eQ7tex7nRth8eh7AeoAb66pB3KGrHvFfUCXOSjRI
	TwsQAa/K/2JGiLZd9Vg7WqDI9hoktWEZQPLQxRQdnHfnnyCzIVe7iQ9LaSA0MhcRSCULaleLlWG
	kaMlktuTibPGDP3fonGQ1MWF391g/n0HbLHXHn5ZNKdk2VSbPp5pvOifFWjljtZfJvH3n4n8dVt
	7peXWM7JXydAeNNXhirqGvWvqzfV5OA4wFcIV1o4ogNzXnx+c6DjBJb0kcroRou4cb7kK1I5Agj
	THLbKtNPuALcGrxf4YREa+xHgmhhaz71Nf1jyGCaDLAgEGK1zWZlTWaT5tR1BNvQVXVhVY5iBnk
	VOwNHHU+T70oyq19N/nZzVSfs5vWNCqujdcZ4oaIVlqgjZxujgjExjRDEYyYlnnHZMbsd4MvUjR
	dgrxYuT2uvMMH9BdgOmsfhZx+LDWEz68suD2e4b/sEUUJNzDSP1N0uegdRNtJOWo7zIDPj2yd31
	wahzmZgMkthKbsiCD3yFeZ9lFposBX0K4jgwzbZR+g1gDKSaPFKb4WeKQ0XQE2RdRgzRwh/QrJm
	WQ9Z+Tu+vhR++GbEcRuBj4Yc=
X-Received: by 2002:a17:90b:5906:b0:3b0:d0be:f02c with SMTP id 98e67ed59e1d1-3b1b0b4ffffmr8198704a91.6.1794660677105;
        Sat, 14 Nov 2026 04:51:17 -0800 (PST)
Received: from kenhou-claw.tailf09bb7.ts.net (p1571063-ipxg05601hiraide.tochigi.ocn.ne.jp. [153.185.50.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aed76f95sm8462114a91.17.2026.11.14.04.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 04:51:16 -0800 (PST)
From: Kenhou Iijima <kenhou@kenhou.net>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Denis Benato <denis.benato@linux.dev>,
	Zhouwang Huang <honjow311@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kenhou Iijima <kenhou@kenhou.net>
Subject: [PATCH v2] HID: hid-msi: Drain orphan MCU ACKs by issuing a query
Date: Sat, 14 Nov 2026 21:50:59 +0900
Message-ID: <20261114125059.17772-1-kenhou@kenhou.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114101045.21986-1-kenhou@kenhou.net>
References: <20261114101045.21986-1-kenhou@kenhou.net>
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

On the MSI Claw 8 AI+ (0db0:1901, firmware 2.30), when a timeout-0
command such as SYNC_TO_ROM (0x22) or SWITCH_MODE (0x24) is issued
(either by the driver or from userspace via hidraw), the controller MCU
sends an asynchronous 0x06 ACK. Unlike regular command responses, the MCU
firmware keeps re-sending this 0x06 ACK approximately every 2 seconds
indefinitely until it receives another feature command (such as
READ_GAMEPAD_MODE).

When issued from userspace via hidraw while hid-msi is bound, the
driver never arms orphan_ack_pending, so every 0x06 ACK arrives with
waiting_cmd == CLAW_COMMAND_TYPE_NONE. When issued in-kernel with
timeout == 0, the initial ACK clears orphan_ack_pending if it arrives
within the 25 ms orphan_ack_complete window (whereas a SYNC_TO_ROM flash
commit ACK arrives ~560 ms later, after a subsequent command or its
timeout clears orphan_ack_pending), and all subsequent 2-second retries
likewise arrive with waiting_cmd != CLAW_COMMAND_TYPE_WRITE_PROFILE_DATA.
Because nothing sends a follow-up command when the device is otherwise
idle, the MCU stays stuck in its ACK-retry state:

1. An endless stream of 0x06 packets is delivered over the USB interrupt
   IN endpoint every 2 seconds until the next command is sent.
2. Only WRITE_PROFILE_DATA (0x21) expects a generic 0x06 ACK; read
   commands wait for their own ACK command types. Without guarding
   CLAW_COMMAND_TYPE_ACK against other waiting commands, a stray or
   delayed 0x06 ACK arriving while READ_PROFILE or READ_GAMEPAD_MODE is
   in flight completes send_cmd_complete early with an empty response
   buffer, corrupting the read result.

Fix this by:
- Scheduling a work item (orphan_ack_work) that issues a harmless
  CLAW_COMMAND_TYPE_READ_GAMEPAD_MODE query whenever an unhandled 0x06
  ACK arrives (whether caught by orphan_ack_pending or when waiting_cmd
  is not CLAW_COMMAND_TYPE_WRITE_PROFILE_DATA), which clears the MCU's
  pending ACK state so it stops re-transmitting 0x06 every 2 seconds.
- Completing send_cmd_complete on CLAW_COMMAND_TYPE_ACK only when
  waiting_cmd is CLAW_COMMAND_TYPE_WRITE_PROFILE_DATA, and draining any
  other 0x06 ACK via orphan_ack_work instead.
- Cancelling orphan_ack_work via disable_work_sync() in claw_remove()
  and msi_suspend(), and re-enabling it via enable_work() in
  msi_resume(). Set .reset_resume = pm_ptr(msi_resume) as well, because
  usbhid defines .reset_resume without falling back to
  hdev->driver->resume in hid_driver_reset_resume(), so reset-resume
  paths also need msi_resume() to re-enable orphan_ack_work.

Fixes: a9517958e828 ("HID: hid-msi: Add MSI Claw configuration driver")
Signed-off-by: Kenhou Iijima <kenhou@kenhou.net>
---
Changes in v2:
- Guard CLAW_COMMAND_TYPE_ACK so send_cmd_complete is only completed
  when waiting_cmd == CLAW_COMMAND_TYPE_WRITE_PROFILE_DATA, avoiding
  early completion of in-flight reads; schedule orphan_ack_work (with a
  dev_dbg log) for any other 0x06 ACK (whether caught by
  orphan_ack_pending or arriving later) instead of waiting for a 2 s
  retry.
- Use disable_work_sync() in claw_remove() and claw_suspend() paired
  with enable_work() in claw_resume(), and wire .reset_resume to
  msi_resume so urbin interrupts cannot re-queue work across suspend,
  reset-resume, or removal.
- Document why only WRITE_PROFILE_DATA expects 0x06 and why drain
  errors (e.g. during RESET_DEVICE or disconnect) are ignored.
- Link to v1: https://lore.kernel.org/linux-input/20261114101045.21986-1-kenhou@kenhou.net/

 drivers/hid/hid-msi.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
index 23d731f700..054babadda 100644
--- a/drivers/hid/hid-msi.c
+++ b/drivers/hid/hid-msi.c
@@ -332,6 +332,7 @@ struct claw_drvdata {
 	enum claw_profile_ack_pending profile_pending;
 	struct completion orphan_ack_complete;
 	struct completion send_cmd_complete;
+	struct work_struct orphan_ack_work;
 	struct delayed_work cfg_resume;
 	struct delayed_work cfg_setup;
 	spinlock_t registration_lock; /* Lock for registration read/write */
@@ -528,11 +529,20 @@ static int claw_raw_event(struct claw_drvdata *drvdata, struct hid_report *repor
 		if (drvdata->orphan_ack_pending) {
 			drvdata->orphan_ack_pending = false;
 			complete(&drvdata->orphan_ack_complete);
-			break;
 		}
 
-		if (drvdata->waiting_cmd == CLAW_COMMAND_TYPE_NONE) {
-			dev_warn(&drvdata->hdev->dev, "Got unexpected ACK from MCU, ignoring\n");
+		if (drvdata->waiting_cmd != CLAW_COMMAND_TYPE_WRITE_PROFILE_DATA) {
+			/*
+			 * Only WRITE_PROFILE_DATA waits for a generic 0x06 ACK;
+			 * reads wait for their own ACK command type. Any other
+			 * 0x06 ACK is an unhandled orphan ACK that the MCU will
+			 * re-send roughly every 2 s until it receives another
+			 * command, so schedule a harmless query to drain it.
+			 */
+			dev_dbg(&drvdata->hdev->dev,
+				"Draining orphan ACK (waiting CMD: %x)\n",
+				drvdata->waiting_cmd);
+			schedule_work(&drvdata->orphan_ack_work);
 			break;
 		}
 
@@ -653,6 +663,22 @@ static int claw_hw_output_report(struct hid_device *hdev, u8 index, u8 *data,
 	return __claw_hw_output_report(hdev, index, data, len, timeout);
 }
 
+static void claw_orphan_ack_drain(struct work_struct *work)
+{
+	struct claw_drvdata *drvdata = container_of(work, struct claw_drvdata,
+						    orphan_ack_work);
+
+	/*
+	 * A query is enough to make the MCU stop re-sending the pending ACK.
+	 * claw_hw_output_report() also waits for any orphan ACK before
+	 * sending, so this cannot interleave with a real command sequence.
+	 * Best-effort drain: errors (e.g. during RESET_DEVICE or disconnect)
+	 * are harmless and intentionally ignored.
+	 */
+	claw_hw_output_report(drvdata->hdev, CLAW_COMMAND_TYPE_READ_GAMEPAD_MODE,
+			      NULL, 0, 25);
+}
+
 static int claw_switch_mode(struct hid_device *hdev, enum claw_mode_field field, u8 val)
 {
 	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
@@ -1868,6 +1894,7 @@ static int claw_probe(struct hid_device *hdev, u8 ep)
 	spin_lock_init(&drvdata->rumble_lock);
 	init_completion(&drvdata->orphan_ack_complete);
 	init_completion(&drvdata->send_cmd_complete);
+	INIT_WORK(&drvdata->orphan_ack_work, &claw_orphan_ack_drain);
 	INIT_DELAYED_WORK(&drvdata->cfg_resume, &cfg_resume_fn);
 	INIT_DELAYED_WORK(&drvdata->cfg_setup, &cfg_setup_fn);
 	INIT_DELAYED_WORK(&drvdata->rgb_queue, &claw_rgb_queue_fn);
@@ -1954,6 +1981,7 @@ static void claw_remove(struct hid_device *hdev)
 		led_classdev_multicolor_unregister(&drvdata->led_mc);
 	}
 	cancel_delayed_work_sync(&drvdata->rgb_queue);
+	disable_work_sync(&drvdata->orphan_ack_work);
 
 	hid_hw_close(hdev);
 }
@@ -1983,6 +2011,8 @@ static int claw_resume(struct hid_device *hdev)
 	if (!drvdata)
 		return -ENODEV;
 
+	enable_work(&drvdata->orphan_ack_work);
+
 	/* MCU can take up to 500ms to be ready after resume */
 	schedule_delayed_work(&drvdata->cfg_resume, msecs_to_jiffies(500));
 	return 0;
@@ -2015,6 +2045,7 @@ static int claw_suspend(struct hid_device *hdev)
 	cancel_delayed_work_sync(&drvdata->cfg_resume);
 	cancel_delayed_work_sync(&drvdata->cfg_setup);
 	cancel_delayed_work_sync(&drvdata->rgb_queue);
+	disable_work_sync(&drvdata->orphan_ack_work);
 
 	return 0;
 }
@@ -2052,6 +2083,7 @@ static struct hid_driver msi_driver = {
 	.probe		= msi_probe,
 	.remove		= msi_remove,
 	.resume		= pm_ptr(msi_resume),
+	.reset_resume	= pm_ptr(msi_resume),
 	.suspend	= pm_ptr(msi_suspend),
 };
 module_hid_driver(msi_driver);
-- 
2.56.0

