Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794651135;
	b=usBh0mckK31QBuhVlHce07a5Ai1yv83VZd3A28nk3IOl1OMhlES8q1g7NBdFHPd8Ubcj
	 yaJ+kv88LIggF/xk2aBDiD6FfHZyDJ3MiUNnD9hjga1d9Qjf7NmK8wzYL2bz1ssTMZdr7
	 DKX8yZFM3ZimsjTJTw7giDKV60jnGhW6vGRgE848QkxGhnIbA89FC9AWobreo0HOOPIDd
	 HM4QPO2JJm75PDxkp5Rcdbf01gotj0BR0xLMD6PfEoqiIz4I11PP6bzVAC+JEjlWZXkMX
	 R8KYdAfFO8V7clZbPnRsjoZFwlbNJv/OTPeai6/KewLyYEif1Xi/Jh6JIwne8otD3Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794651135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lQt1j0RzsOrMUs+ezkU5e16z6y2hdKRE1AH6Wd6E6Fs=;
	b=B7WEyguMosav6WfhGzbFW+ovLF3Bv2klgHfaN/crID96wzopjI46hi7MMBtx5f/nmJ5B
	 oOn8FkvS3MqVQk++o59CWieFmx5pm4d1zQVsWlqBeAU5N6aSg9OwWxJwWm4rI2lMk62dS
	 XfXLI4280G7hbkE/WU8QcLSGMtYyKxXo7o0XuPgjQ70Xun84O2jyYVeDNp87C+uRRgz3Q
	 Q5Sf/l/V6JweOZWCSWRFqkq7ry5gKxPFODFuYGPSNCZORsRteRIeO/SWh6+KIlfMdO+yb
	 YYnTn90IqHm5PCfwypBFeGHxEN4wBNkk8va/cB/KdNnRjv2BJSM+Ce/hljmsLsQpdpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kenhou.net;
	spf=none smtp.mailfrom=kenhou.net;
	dkim=pass header.d=kenhou-net.20260707.gappssmtp.com header.i=@kenhou-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pHo5s6it;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC7B606A323
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 10:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BC7B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kenhou.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kenhou.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kenhou-net.20260707.gappssmtp.com header.i=@kenhou-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pHo5s6it
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b18bae2d56so294066a91.1
        for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 02:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kenhou-net.20260707.gappssmtp.com; s=20260707; t=1794651133; x=1795255933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lQt1j0RzsOrMUs+ezkU5e16z6y2hdKRE1AH6Wd6E6Fs=;
        b=pHo5s6itd3olfR7NaG4QNASWSQSctFgaaTOX6BuF2JvOsb5+P/6IXPo0qMuZVNsXfc
         q3paQHeIPgHyHpBKKabaNQh7BLWS5b1PSzl/DssUbQGvujKy+pAsUc7bcpU1Ot/k1LrC
         bOLbKkmtlQ2a5ciS/+KgY8R5C2exS45WVlmYmOgq+KhCuOOeDHdIpAQ9Djw85AV/xRSO
         ugBuGWO9V2wDV1qsiWYWvcs+4tx6wDUehVYKGwYSTX3q3BzrzeCZbuveBAXDpoAP7wUv
         XL/xOdP/58W04HkTHJBwAuxQ8lnHpTp4oouZ3wFBJNJovqfWR+B/1Jn99uEEBKnkHTGc
         mpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794651133; x=1795255933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lQt1j0RzsOrMUs+ezkU5e16z6y2hdKRE1AH6Wd6E6Fs=;
        b=oPZpSefgDaqT1c8W1eDAAzM0bAUr0lXiZPxpzlO4FsDReXoRP/lZvACLmftMNG0Cn9
         LHDgLu9At9rdvZSWydWkEkiItYrrzpLwMHhU63oeeAJXEAN/WcRmOAYjCzzHjQwbYmIS
         nAFxT76vhF53pykXS0QFhr0Z+z8vsITakJztbji7N2wNIlucmJoMaAF49WtYXHJHq3on
         z+DgZFiVgENt8G5n3Vc61EHlvgdCLFiXQFqBgvFJA6l63mjFim5B+FjdzPmXyfRZrKiU
         U8NkhbdudLHtHlerjoAFdXtsJHRZg7gkuvTmeHomm17G90cKbISfZXJTEAOgeGDXBBz7
         gpmA==
X-Forwarded-Encrypted: i=1; AL+hErFje+rCLS9TomcpuyfSQmeVDKC3kpYGk4KAh1X5lTBwTg52IbtQQge0ifBfwxQgXYzju28/j/ITV/KRNw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+06JcX9wneDTuZEPMZq63mB3geMxSnP+2dGh8hiRkZOppOi8OY
	MWi/jwoLCF24QHp0VWx4GIEzyt06MYSq7jVBv8Mcz9B5ypaCS4zu5VTF1vHR/UteG2Q=
X-Gm-Gg: AYBFou0Q2hjrSOiZyIIz7VYn3Sjr9kUB84Rl++XZ0udSqSEpyToSvdOp76kWkwjiPeo
	dehVlc+gShRLlX8KZd2MrvKxvORUmNCHPBvXS1e1R97yY5Aw4Sdo3m5Ps2UrHwtH7/eZHlwT4BW
	P4VdQh8kc0ttrP+m407MVCvLLrj+g457Ppn4xoyXqcAPYEYu88KEGpFSLcbaHCnZ8QRDJBmR6LQ
	9PToHHu2Wug7mJ6BM6Tf0hvvEu7HYLhhZxxwykGNyfOuFKS2ErRB7DsNE5l8YRtiJe7cir/sMhn
	MPjeLjMDDf1mASN0v1kayn3q1BbRGeE+q05DFHxiqsUFUJ8qKilwfZU3/rWW3Z0GstBRRgT4zTs
	ok6TG776S673ecah8/YO/noyymxAvkOMybI7ifVK/wA+TujPEccrUy2TuD0ZSMlYTpw2dRXJXty
	vz63n6IcSbeJVkCMdsNFCt7ufRV0YboDmHKrXdMWt6093JueWEltkhvn0ExKIFUFb2GC+49BRcv
	+gJy2ADEVBPXS1PZ+NCG6+0nzjb8ppc2qQMlwhsJ7jwoBt9Qv2vHEzwRanuui6OKqvvH0s519bt
	QpuH/9q2ewYhjuAJbF/aI42izC6UW3oNcPyUSHsAIzx2xBtD99SYhi7RrjVHJF/MwWxSkDc9pYD
	HwPAZe8YT4GKzU8bnS/hi/g==
X-Received: by 2002:a17:90b:2f46:b0:3ab:a188:b898 with SMTP id 98e67ed59e1d1-3b1b0853790mr7855496a91.2.1794651133412;
        Sat, 14 Nov 2026 02:12:13 -0800 (PST)
Received: from kenhou-claw.tailf09bb7.ts.net (p1571063-ipxg05601hiraide.tochigi.ocn.ne.jp. [153.185.50.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d282fdsm13654845a91.14.2026.11.14.02.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 02:12:12 -0800 (PST)
From: Kenhou Iijima <kenhou@kenhou.net>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Denis Benato <denis.benato@linux.dev>,
	Zhouwang Huang <honjow311@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kenhou Iijima <kenhou@kenhou.net>
Subject: [PATCH] HID: hid-msi: Drain orphan MCU ACKs by issuing a query
Date: Sat, 14 Nov 2026 19:10:45 +0900
Message-ID: <20261114101045.21986-1-kenhou@kenhou.net>
X-Mailer: git-send-email 2.56.0
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

The Claw MCU re-sends an unhandled ACK roughly every 2 seconds until it
receives another command. When an ACK arrives with waiting_cmd set to
CLAW_COMMAND_TYPE_NONE, such as after a command is written through
hidraw or once orphan_ack_pending has been cleared without a subsequent
command, the driver currently logs "Got unexpected ACK from MCU,
ignoring" on every re-transmission and never clears the MCU's pending
ACK state.

Schedule a work item that issues a harmless READ_GAMEPAD_MODE query when
an unexpected ACK arrives. Receiving any command causes the MCU to stop
re-sending the pending ACK, eliminating the repeated events and log
spam.

Fixes: a9517958e828 ("HID: hid-msi: Add MSI Claw configuration driver")
Signed-off-by: Kenhou Iijima <kenhou@kenhou.net>
---
Tested on an MSI Claw 8 AI+ A2VM (0db0:1901, bcdDevice 2.30).

 drivers/hid/hid-msi.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
index 23d731f700..e52923fcc8 100644
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
@@ -532,7 +533,12 @@ static int claw_raw_event(struct claw_drvdata *drvdata, struct hid_report *repor
 		}
 
 		if (drvdata->waiting_cmd == CLAW_COMMAND_TYPE_NONE) {
-			dev_warn(&drvdata->hdev->dev, "Got unexpected ACK from MCU, ignoring\n");
+			/*
+			 * The MCU re-sends an unhandled ACK roughly every 2 s
+			 * until it receives another command. Drain it by
+			 * scheduling a harmless query so the ACK storm stops.
+			 */
+			schedule_work(&drvdata->orphan_ack_work);
 			break;
 		}
 
@@ -653,6 +659,20 @@ static int claw_hw_output_report(struct hid_device *hdev, u8 index, u8 *data,
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
+	 */
+	claw_hw_output_report(drvdata->hdev, CLAW_COMMAND_TYPE_READ_GAMEPAD_MODE,
+			      NULL, 0, 25);
+}
+
 static int claw_switch_mode(struct hid_device *hdev, enum claw_mode_field field, u8 val)
 {
 	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
@@ -1868,6 +1888,7 @@ static int claw_probe(struct hid_device *hdev, u8 ep)
 	spin_lock_init(&drvdata->rumble_lock);
 	init_completion(&drvdata->orphan_ack_complete);
 	init_completion(&drvdata->send_cmd_complete);
+	INIT_WORK(&drvdata->orphan_ack_work, &claw_orphan_ack_drain);
 	INIT_DELAYED_WORK(&drvdata->cfg_resume, &cfg_resume_fn);
 	INIT_DELAYED_WORK(&drvdata->cfg_setup, &cfg_setup_fn);
 	INIT_DELAYED_WORK(&drvdata->rgb_queue, &claw_rgb_queue_fn);
@@ -1934,6 +1955,7 @@ static void claw_remove(struct hid_device *hdev)
 
 	cancel_delayed_work_sync(&drvdata->cfg_resume);
 	cancel_delayed_work_sync(&drvdata->cfg_setup);
+	cancel_work_sync(&drvdata->orphan_ack_work);
 
 	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
 		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context */
@@ -2014,6 +2036,7 @@ static int claw_suspend(struct hid_device *hdev)
 
 	cancel_delayed_work_sync(&drvdata->cfg_resume);
 	cancel_delayed_work_sync(&drvdata->cfg_setup);
+	cancel_work_sync(&drvdata->orphan_ack_work);
 	cancel_delayed_work_sync(&drvdata->rgb_queue);
 
 	return 0;
-- 
2.56.0

