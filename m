Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921902;
	b=Ae4BFLpDJGthfo5cAMPfqd6VeUALaihILaFHNV30Wsuh6ruOfsUgAZEeWc214n5nZIIK
	 yNlQUKIrvp4IyXHTJg1APiV5bOKw4z/G/9B27GABYjjwQqywFeNdKzyJyfuoTXZ5D3EDL
	 4frciz+MJtUdchevmluZtQwHo8Q17f3V41Oz0V/n9gqolP0U3rOV/S8TGSiHXbIVvnUJc
	 NwS3eFOGD+DD5/GqF0ITpdEXghAk8edzj3XdUJthQB8ObqNu/G57rfyeO1XCBQnHvEZLg
	 eirGnMoWbVFi6hzAKDuz8VihsTbcRnTA84pbfIo0MyJGBuI1c9ReqoXCEeDQuJQwNyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921902;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xYrnkQ5ALrFvyhMYjXa2KQK7bmShuxp4TgJGZ7gy57Q=;
	b=FEkjtC6+Xa55gIkKDNwzzs8IZx7pTMJ4T5/byJ6JegQsq3pesmXC9LukDVQ+7EVOjZNL
	 fTYUjeqpNkaDZZoYQUShc1gQmsjf9wLR+S3wXuLu8C9t5XH1gPooKkSRFPHLmJPEhpDSN
	 Z1kfwavVFH8d+4xzn/S5CkRMYxwRTZ5Ygy7aRUUkXJ7AWBA7dQYEJm6s/t/rQus4Zw+Uy
	 1CNLal6kyMdFTlJ80mpi6uxu8VAxJOkntfIExhePqG2LeFbAfGRK5qc558qDnahmpNfAC
	 LeloHstcqOwL4RvsNv4walP2GTM+fpYcFwO0EGPiF8Rm5dAUytmKvvEn14mrgTwzXtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=S4yAE0uH;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=umxxjhjg;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCC8606A32C
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 13:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBCC8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=S4yAE0uH;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=umxxjhjg
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E02471400151
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 08:25:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 17 Nov 2026 08:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1794921900; x=1795008300; bh=xYrnkQ5ALrFvyhMYjXa2K
	QK7bmShuxp4TgJGZ7gy57Q=; b=S4yAE0uHxaoeS1vhBT8m1aDfGpBVYgs7auVHZ
	pJemD0j5BP/T9JP2pDiu3b/iKUHdBT4mQRThpQLc7+pAippStFE67P5rJq9E+Pv2
	UbEx3bVfmY8Bu0CTV34YSVtyeE3YahWQ/37NPSGlpYcZRF0DIIX47urwwxMI6CcV
	MxTaOmMLC/dt049rZx1xt8AkAXrSGBh83973i50+SAGpj4FRFr+o/yI/J029ZlhG
	pifpwVzQxJLLKpU7PSTt7wnOjI4eHMl/fSQ49dJIqrq0laG4oKY9jarZfjMsIffq
	Oo+ZuFNyI7441irC4/jFuPeFI/gNGpZD5c+VecK3YbUzk+jKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794921900; x=1795008300; bh=xYrnkQ5ALrFvyhMYjXa2KQK7bmShuxp4TgJ
	GZ7gy57Q=; b=umxxjhjgBcm8vEaynSuspiU9q8SpZr2mlYlf2dYo7ZTjrXKb3zY
	qPmbqFJSQzoLfgRTN3N4a5GRp6rLP7u1Db739V1W95gCUTF+cIzyMqPqe1HZaNil
	Aj+vb1oiJ6tDPUqWlyYVzXamKThDa20aB8kOJic1IlfOujJhzlLEf/jomqTlip0g
	njYML6izxxK31cddOBDOGw0ufNzzv3XuGXUiFiOqXQEF8F7c6OwEtWtc/zP3St4B
	U0VZSi4dXAPuOZNXUMblY4im6bL7yWqMn4M3DNJaqPaOD9lXHhDjL5QGzh5BazzY
	GG33tTK1dJ1ed2CdRuXoNp6yeXc4x3VYuGw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794921900; d=fastmail.com;
	mf=PGdyZWVuLmtvYWxhMjk3OUBmYXN0bWFpbC5jb20+;
	rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
	s=fm3:rsa-sha256:d7ItH5fc+mzYBd0pbxBNOQVBFGyefGAMLL2BVZPQuRnwUER
	SaUKp16DH4+ebwmLV3orjycbHRPZNUYibUfsj6WWyhRzcMcHVT9paw3705jI95sW
	ai/M1Y5e83NUlSRpe4wm1RL2VlHgtvix81SaBpKAKVhkF3sVxWBv2Cgwlyd5bZhh
	C1RM16sy8UGmx0uPEYJ+Nw5tjfjfmcL2lwrQ+fmN7qAEDQv5i+VgOahOL6ezK8ql
	LNjo9Pl/xZLLXq5rN5KwokPO4zv1b7sGRo3iEZufFHi/N9yp7azH4o+OWAmfvYtA
	zMR73iniVTC2F07inj4foNUOrSNmvQ8s3R7w1ZQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:DGovqwJB8eH/S/Xjwtr3t8snuSo01C1Omi9Jfo50NAA=:yz3b2V+w6SsqHsT7xXEFa4wzlY6fP5s38O3tf4o0yk4=;
X-ME-Sender: <xms:rFX8armjVgp_4IUVVfFFa4iPy6vSaN2NRX_MNJgHPo1FbuiELB36dg>
    <xme:rFX8avm6_QDShbnD46vVj7LEipKGpgvi2ekFQuuxh2Si4y8_A4zE1O-mEQoUlu7oR
    4wb3vqsn4_uc3E-ObQHUg-ncqeqojStpeFR69krPohenZL0p3FY8pV3vw>
X-ME-Received: <xmr:rFX8atxwwDxzqnbd9TS3j94o5Ur2fa59uZnjUegOEBbxTKG9fPA8F7DNFG1KPN-sdnREeztrihMZBCoEOKoMAyXWzQZ9vgZ0ZNg_gycNxE85s4w>
X-ME-Proxy-Cause: dmFkZTEFXElo4H2OVJj6DhQewPfbgr7phfwrcHREpc8lzp2ePPfwAUqvDQneg1mWASWAR+
    RWo+S3iRh7AamqEd8Lx63jZZ9bC2sDECiLVjQT1aUCVJp60XU02aTwrxEt0lOFT5Qgfeq6
    YRm6b+9iCn7kl29KFGjQbiZTfV+Q8pS6GIZQpvPr1ZVemeDeV+0o6uGS+lGGQ5EDceyQSt
    tI6kEQzGTPh+gBRgwK7bG/CihJfOswct8mwa4EfI0ZF7gnEsQCq+cVUREvFexHk/kG9IHb
    dz15YOFiv0GEOcaGH5MUE5n/1ZBSiiGh1o+Fw/ljwE7I9oA43x7MliFAZIPkd9QjRrs/gN
    fvvpdub92WmDAzfe+p4PZ+iZoTbUsjtGMkE15afA2kmhcf3diqPHFXhd8k52dDjNaAQQR6
    ebr5+iFwm4tMlMbPyV+AQ1sf1cixaaQOuLdjWZwJK2KfDmzoxHNksESZGYNbuQVF3C/QRz
    At+eHgLupLxXGerqpcsEsGL7cS75iNZ0pr9MjCUq9n9xEjDBJLkoMbyz/LPrqNmC67dPhW
    VqkWnek+i6Ec1TP27/Hbk3Vx9EYfhfBEAbTNBUyvOKD3XGBwZYi8iE+3U8Tx8lu4tl+rhF
    X8necmWEqrkEZrAVBtjK1T4TwGkz3VLgykLDdcDTW7HKYlS/wR2EIm3+Xfxw
X-ME-Proxy: <xmx:rFX8akosLqTa4ptU4h0ak8lKT8YUJehlM5ZPnZGpPT5jVRApTvsQWQ>
    <xmx:rFX8as5beWIFQCz4WckrPTcZrShTfhWfUbYWSg2VvpWSfz8AdxkUxw>
    <xmx:rFX8arcGUyfflXZSzZj52vt97v4M0a72cPOIt_tVPjlKMJt96cSndA>
    <xmx:rFX8ah60xce5DQqnGBnkdKJUMPSNuyNKPjKGM-pUKBRKWlktQH7pvw>
    <xmx:rFX8auxXpFTQC6q-LYAxD0z83H4e2pZ_r-kjbdEdINgwjk9hKJPnTLpd>
Feedback-ID: ib51446d9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 08:24:59 -0500 (EST)
From: Ana Veto <green.koala2979@fastmail.com>
To: derekjohn.clark@gmail.com,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Ana Veto <green.koala2979@fastmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] HID: hid-msi: Send a uevent when the MCU changes the mode by itself
Date: Tue, 17 Nov 2026 13:24:48 +0000
Message-ID: <20261117132448.57489-1-green.koala2979@fastmail.com>
X-Mailer: git-send-email 2.56.1
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
controller stays in desktop mode or with M1/M2 disabled until the
controller is probed again.

Emit KOBJ_CHANGE from a work item whenever a report changes the stored
mode or M-key function. Store the new values after a successful
SWITCH_MODE write as well, so that the driver's own writes raise no
event. A report that comes in during the write was sent either before
the MCU applied the write or after the MCU changed the state again, so
neither the report nor the written values can be trusted: read the state
back and emit the event, so that userspace checks the state. Read the
state from the MCU before each SWITCH_MODE write as well, as the show
functions do, so that the field that is not written is sent with the
MCU's value even when such a read-back failed. A failed read fails the
write.

Tested on an MSI Claw 8 EX AI+ (0db0:1901) with a v7.3.3-based kernel
and InputPlumber's rules. The controller was switched to desktop mode by
a SWITCH_MODE report written to hidraw, bypassing the driver. A read of
gamepad_mode then returned desktop and raised a change uevent, and the
rule wrote xinput 66 ms later. After another such switch, View+LB made
the MCU report mode 4 by itself, and the rule wrote xinput within 0.3 s.
While View+LB was held in xinput mode, the MCU reported the M-keys
disabled once a second, and the M-key rule set macro again each time. In
a build without the read before each write, a mode report with the state
from before a SWITCH_MODE write was also made to arrive during the
write, by a query written to hidraw while the driver waited to send the
write: the driver read the state back and raised an event, and the next
change of the M-key function by the MCU raised one as well. With such a
report and a failed read-back forced in a test build, an M-key function
write and then a gamepad mode write left the written M-key function in
place; without the read before each write, the second write sent the old
M-key function back.

Fixes: a9517958e828 ("HID: hid-msi: Add MSI Claw configuration driver")
Signed-off-by: Ana Veto <green.koala2979@fastmail.com>
---

Notes:
    Based on hid.git for-next. This changes lines near "HID: hid-msi: Drain orphan MCU ACKs by issuing a query" (v2, posted 2026-11-14); the two patches apply in either order.
    
    v5: read the state from the MCU before each SWITCH_MODE write. In v4, when the read-back after a raced write failed, the stored state stayed the one from before the write, and the next write of the other field sent that old value back (CodeRabbit review of the OGC copy of v4: https://github.com/OpenGamingCollective/linux/pull/137#pullrequestreview-5931619122). Tested on the Claw with the race and a failed read-back forced in a test build: with v4, an M-key function write followed by a gamepad mode write set the old M-key function again; with v5, the written one stayed. The two longer comments are one line each now. The tool trailer of v4 is gone, as the current checkpatch rejects that tag; tool use is in the last paragraph.
    
    v4: if a GAMEPAD_MODE_ACK comes in during the SWITCH_MODE write, the driver now reads the state back and emits the uevent. In v3 such a report raised no event when it carried the state from before the write, and the stored state could stay wrong, so a later change by the MCU could go unreported as well (Sashiko review: https://lore.kernel.org/r/sashiko-outbox-215202@kernel.org). Tested on the Claw with the report forced into the write: with v3, no event in 2 of 2 runs; with v4, an event in 4 of 4.
    v4: https://lore.kernel.org/r/20261115142110.65521-1-green.koala2979@fastmail.com
    v3: https://lore.kernel.org/r/20261115032314.7094-1-green.koala2979@fastmail.com
    v2: https://lore.kernel.org/r/20261114221440.12580-1-green.koala2979@fastmail.com
    
    Claude Code (claude-opus-5-5, effort xhigh) wrote the code and the changelog and ran the tests on the Claw.

 drivers/hid/hid-msi.c | 61 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
index 3225d3b..b66d997 100644
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
@@ -387,19 +389,43 @@ static int get_endpoint_address(struct hid_device *hdev)
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
 
+	/* The MCU also changes the state by itself, e.g. on View+LB */
+	if (changed)
+		claw_queue_mode_event(drvdata);
+
 	return 0;
 }
 
@@ -656,11 +682,19 @@ static int claw_hw_output_report(struct hid_device *hdev, u8 index, u8 *data,
 static int claw_switch_mode(struct hid_device *hdev, enum claw_mode_field field, u8 val)
 {
 	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	unsigned int reports;
+	bool raced;
 	u8 data[2];
+	int ret;
 
 	guard(mutex)(&drvdata->cfg_mutex);
 
+	ret = __claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_GAMEPAD_MODE, NULL, 0, 25);
+	if (ret)
+		return ret;
+
 	scoped_guard(spinlock_irqsave, &drvdata->mode_lock) {
+		reports = drvdata->mode_reports;
 		switch (field) {
 		case CLAW_FIELD_GAMEPAD_MODE:
 			data[0] = val;
@@ -673,8 +707,27 @@ static int claw_switch_mode(struct hid_device *hdev, enum claw_mode_field field,
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
+	/* A report during the transfer can be older or newer than the write */
+	if (raced) {
+		__claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_GAMEPAD_MODE, NULL, 0, 25);
+		claw_queue_mode_event(drvdata);
+	}
+
+	return 0;
 }
 
 static ssize_t gamepad_mode_store(struct device *dev, struct device_attribute *attr,
@@ -1871,6 +1924,7 @@ static int claw_probe(struct hid_device *hdev, u8 ep)
 	INIT_DELAYED_WORK(&drvdata->cfg_resume, &cfg_resume_fn);
 	INIT_DELAYED_WORK(&drvdata->cfg_setup, &cfg_setup_fn);
 	INIT_DELAYED_WORK(&drvdata->rgb_queue, &claw_rgb_queue_fn);
+	INIT_WORK(&drvdata->mode_event, &claw_mode_event_fn);
 
 	/* For control interface: open the HID transport for sending commands. */
 	ret = hid_hw_open(hdev);
@@ -1946,6 +2000,9 @@ static void claw_remove(struct hid_device *hdev)
 		smp_store_release(&drvdata->rgb_registered, false);
 	}
 
+	/* gp_registered is false now, so no new mode event can be queued */
+	cancel_work_sync(&drvdata->mode_event);
+
 	if (gp_registered)
 		device_remove_group(&hdev->dev, &claw_gamepad_attr_group);
 
-- 
2.56.1

