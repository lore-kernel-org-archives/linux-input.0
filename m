Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794694485;
	b=2Gu0k/U6iN1h4vlKAfqxcYARrkF669KJ8tZ1A4ooGNHkdhKXGs4svYka8zCDnG8PArhV
	 wM81bANRGLJrnsO/p+RqaeAkxH31P2IaCDc88S4KiNEhDxIgsYfM7rMgJ5Wtk0FMqDCeW
	 0OU6INcB9ucUjKV0UwTpTPRuYj0CnSRLTSuT4nGJ5uilRyeptX2CeTzx3ldz9ZO6jYMY6
	 xONww4+lSGu5g2nRgQOLJxfzY57DQpGGWZpsVNIAE88nVilckZKNpyXrL6pB/4uprE2ZL
	 9ucTfQiCYIHIpuX4TMTH2lxvbqpF0XaW4Hd5TX3AAN9VlWufSOwaem6RJLKnmBkWKAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794694485;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PdGGGPKBVweXPJhBi2Cqz/r9zlr/MqHJdtvjLMnaXks=;
	b=Yzo5mpRpqfr8dgVfKlmnDxKWfSppUf3xlMtYC+PNlJRBWwknY7DsAYq74hRhEjfeN872
	 HE/EcaQx9RiHKeQGfHztZuLri+3kwmIXbOpd37heGaG4mjMxZzCQeLTO2Qbo7IVQYBq7K
	 GNfEGRXcfGHbqUZWLXCNwAzuWHS4SEOzlINLkukNA8ZWcSoziRvM8MG92hsqhFoYMEGxx
	 LPE5+qK5COGTRXhJjAwQw9oNkc3gR6EM/fB4spDArpogEBhRW4GkrPWhqAO4pXQrJ4FLe
	 VCCXLg0qFdI+sN1TYEkKl3rq4+r8lDc1MjYaQ+wwUExskjdByJ3z0O5wQU/mQGJtMRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=YIN4wygU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KEVbe+9n;
	arc=none smtp.remote-ip=103.168.172.142
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567F8606A329
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 22:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 567F8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=YIN4wygU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KEVbe+9n
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 83E4A1381C37
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 17:14:44 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 14 Nov 2026 17:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1794694484; x=1794701684; bh=PdGGGPKBVweXPJhBi2Cqz
	/r9zlr/MqHJdtvjLMnaXks=; b=YIN4wygUJM7nYtanXxOhcNjF4lLS2/XohN0cx
	nrruI+vb03JTReiNhB/rSihmAKilWuxaugnOD65a3PbbkJn2jMbXUMHqwkF+GEYI
	6wDobQXCrBIOZvLqmv4O68fTNwlczg/VxWFoicm43oIgtZ35Ik4Z9XVWXfqBajv0
	pG48JKMPJUb3ZzdRDilkoXd5kHNsfkS+t3u9RQ5DsBZWB4CaodfEoJkkn0d64p9h
	lqVnJwBhEf7mRMgvnR1LuGrGLQUUPrK1hbJ1RmT+FQPJMabpNgYLmW6a6fGSrFAC
	BSVa6oJROaKO/jLt889kRq+swqxFW/DAcXz3UaapooSSMN7Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794694484; x=1794701684; bh=PdGGGPKBVweXPJhBi2Cqz/r9zlr/MqHJdtv
	jLMnaXks=; b=KEVbe+9n/l4j8vF44wNBiwZH5RliRcHSGE1zfwP/MZ4Pbac1j+g
	N2wqlxvnXQs4MQbnMIoKUghfExBcjuqTk2+sQ4/3bjRSfgCHEbgeOVyCEhl+fikW
	QYRunDqf/17tIn60J86jA5DB9Ywtb2jDHiT+CtVom64L3gzYg8ljewTyeejVeRei
	XiJFFJYHmZesigYE0hle+jUdQZbMu/Q8OAASNWqA/hhxpQ/5JdRF9Io6RyKFsRPX
	WRZE+0R6iWwsAyzbdiJFqoRsZ7ZcT73LwIROjU+nItjQn6AIWciI2rVedq5Sig5G
	1NVKWxQwfE3+GiAoojGht6N1AUUX54tzlwA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794694484; d=fastmail.com;
	mf=PGdyZWVuLmtvYWxhMjk3OUBmYXN0bWFpbC5jb20+;
	rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
	s=fm3:rsa-sha256:U6xBU9mp1NTTJgt3NwGWb4H0egMgRxlL6cr2S+CUgR1wq83
	7kncbt90/Z3S3nBwg1Ojg4nf/vgSprfQKLgGYczkuMO1zz2/4Iice+AG7GUDUS7X
	RLOtvWLYFDOJjyFYmJlt/ZiO/tA+VxR7hHKKPOc3HOs5SCxdz57U0SAtJduIrCeT
	ZG804YttPhLYuvrnxNit1SvK6NH9/bz7SMuWRyiecjtSNQa9/2UQLtuUxKlMV3s8
	3rkzF36J8+2FURv4IOwh7SYYQ5+onsH07ay1QNp+SLfE+wFzIFqX46gHquearjwE
	TqBGOyzXgRRNeKNRDOIHHW3p/xdZFo5VWmy/lWA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:nTEjR303d0FjaSw3RqcrN8q1hZW2khSG37yJcwyQx1A=:S4zICbouSGjAz/ioHEzYOAXGYdEJdG6dE08OwUpLYsQ=;
X-ME-Sender: <xms:VN34avzyqRZZr0sDPG2uqsca8JiY_rUdK6AJxIrR0a4mvpmV0SKoCg>
    <xme:VN34aglN6MKoZ2LSvYJs4ksIqK2nTBol9Pq-OyfDaPhMkWVeeHfA8CaTZO4sK55uN
    vp8Nj7nyuxYQbMfbm3MGTrv98CGBxC4L7owXoaVUAx-EHlR_z0zlOSl>
X-ME-Received: <xmr:VN34agmy4OrAD-0yHEAJ5aALdCucaoA2k-bXbzf16CVN9bX5ILMhUjFVX_wbkxaCg5V0EH1sgoy9wjLMB9UwBGM_49Q2hBkzCSuJtc1b4MamhWc>
X-ME-Proxy-Cause: dmFkZTGqlJFaF5zGcfLx5cvUG4JLHABA7Q+PiMXeNzxA+upxsZih52x2rypPlyXkSSVfuy
    3ohvNRsQiJewUE7oTVHP4sYsFOjnfb9U+Zjs1zxN/LWpxnHP6jzHQyp/G4/ib0gcziYpug
    R4KBokoZRpjltjzTgl6acBimji/dsjkLF+K+acvgnoGoxrpxxNf85Zblhdteiz6qrrzXlq
    m5IJ15ZU/Nqhnx0JeJ/4LbwRq15mRlYxi/TR6xR3FV3MwHeTIVTwyyh3YJCLj4xn+7xgTQ
    fWEyhzeToooNOcZLibnXzTSYFxOHYESK5r5xHqd6Bl/DD27UhkVqUjqBZ1oZWFApTceGFv
    YO5Am6AM5EIG1r4GeTpk7+l7jEJbZDrNrU+quFrZwYqkrXTDiuHsvcqDbHhJXhXKJOET0I
    EfOegRdP9WUlyMp/lwk9piWEuRyI0WcUn95p1NYCJXfiNx7a5oHCdqjUYdw0eA3mNpyOpM
    9zUJ85P9Qoa8Bo2L1qtiqbVdoeGolBZGZFh4kTm0VPYwvv2OHa/xNoRi+62Z7EklY2a5QD
    gNqhGBpXfPwJ06CnYjH2Spjo8Y2LIxW9BWGS+YNfY2fULHhDgxA+D48dZUIl7XeVIHLd7t
    zWNyJnG7A3+KNxzBUFtfmUvukZepzqhvbr8QHGu9RigCX4kPv2yLV9RxSBew
X-ME-Proxy: <xmx:VN34aqwCHF-4z3dqDrcBZ8TqNq2QDvcS2xZuqPCb1BV2ruptRusySg>
    <xmx:VN34atoh7FWAcPJshVxDzsOCRCAm2U8Q_VjOX50q83s-7flSrKY2Vw>
    <xmx:VN34ah5KuvumSgRWOliatTSku1xBob5LnCRDszXAJurBM4R-gt9DCg>
    <xmx:VN34asde1M9VSLC8JlnF5RPG0R9SD21ZexhXxgj2U7Fvfm9y3Ff1HQ>
    <xmx:VN34aglBMJGwLZ9XHDYojLheVUV7TXheG9zbn-cAeLipOo6crBITrSn->
Feedback-ID: ib51446d9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Nov 2026 17:14:43 -0500 (EST)
From: Ana Veto <green.koala2979@fastmail.com>
To: derekjohn.clark@gmail.com,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Ana Veto <green.koala2979@fastmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: hid-msi: Send a uevent when the MCU changes the mode by itself
Date: Sat, 14 Nov 2026 22:14:40 +0000
Message-ID: <20261114221440.12580-1-green.koala2979@fastmail.com>
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
event.

Tested on an MSI Claw 8 EX AI+ (0db0:1901) with a v7.3.3-based kernel and
InputPlumber's rules. The controller was switched to desktop mode by a
SWITCH_MODE report written to hidraw, bypassing the driver. A read of
gamepad_mode then returned desktop and raised a change uevent, and the
rule wrote xinput 66 ms later. After another such switch, View+LB made
the MCU report mode 4 by itself, and the rule wrote xinput within
0.3 s. While View+LB was held in xinput mode, the MCU reported the
M-keys disabled once a second, and the M-key rule set macro again each
time.

Fixes: a9517958e828 ("HID: hid-msi: Add MSI Claw configuration driver")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ana Veto <green.koala2979@fastmail.com>
---

Notes:
    Based on hid.git for-next. This changes lines near "HID: hid-msi: Drain orphan MCU ACKs by issuing a query" (v2, posted 2026-11-14); the two patches apply in either order.

 drivers/hid/hid-msi.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
index 3225d3b..e99f749 100644
--- a/drivers/hid/hid-msi.c
+++ b/drivers/hid/hid-msi.c
@@ -350,6 +350,7 @@ struct claw_drvdata {
 	/* Gamepad Variables */
 	enum claw_mkeys_function_index mkeys_function;
 	enum claw_gamepad_mode_index gamepad_mode;
+	struct work_struct mode_event; /* uevent when the MCU changes the mode */
 	u8 m1_codes[CLAW_KEYS_MAX];
 	u8 m2_codes[CLAW_KEYS_MAX];
 	u8 rumble_intensity_right;
@@ -387,19 +388,41 @@ static int get_endpoint_address(struct hid_device *hdev)
 	return -ENODEV;
 }
 
+static void claw_mode_event_fn(struct work_struct *work)
+{
+	struct claw_drvdata *drvdata = container_of(work, struct claw_drvdata, mode_event);
+
+	kobject_uevent(&drvdata->hdev->dev.kobj, KOBJ_CHANGE);
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
 	}
 
+	/*
+	 * The MCU changes the mode or M-key function by itself, e.g. while
+	 * View+LB is held. Userspace learns of changes only through uevents.
+	 */
+	if (changed) {
+		guard(spinlock_irqsave)(&drvdata->registration_lock);
+		/* Pairs with smp_store_release from cfg_setup_fn and claw_remove */
+		if (smp_load_acquire(&drvdata->gp_registered))
+			schedule_work(&drvdata->mode_event);
+	}
+
 	return 0;
 }
 
@@ -657,6 +680,7 @@ static int claw_switch_mode(struct hid_device *hdev, enum claw_mode_field field,
 {
 	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
 	u8 data[2];
+	int ret;
 
 	guard(mutex)(&drvdata->cfg_mutex);
 
@@ -673,8 +697,18 @@ static int claw_switch_mode(struct hid_device *hdev, enum claw_mode_field field,
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
+		drvdata->gamepad_mode = data[0];
+		drvdata->mkeys_function = data[1];
+	}
+
+	return 0;
 }
 
 static ssize_t gamepad_mode_store(struct device *dev, struct device_attribute *attr,
@@ -1871,6 +1905,7 @@ static int claw_probe(struct hid_device *hdev, u8 ep)
 	INIT_DELAYED_WORK(&drvdata->cfg_resume, &cfg_resume_fn);
 	INIT_DELAYED_WORK(&drvdata->cfg_setup, &cfg_setup_fn);
 	INIT_DELAYED_WORK(&drvdata->rgb_queue, &claw_rgb_queue_fn);
+	INIT_WORK(&drvdata->mode_event, &claw_mode_event_fn);
 
 	/* For control interface: open the HID transport for sending commands. */
 	ret = hid_hw_open(hdev);
@@ -1946,6 +1981,9 @@ static void claw_remove(struct hid_device *hdev)
 		smp_store_release(&drvdata->rgb_registered, false);
 	}
 
+	/* gp_registered is false now, so no new mode event can be queued */
+	cancel_work_sync(&drvdata->mode_event);
+
 	if (gp_registered)
 		device_remove_group(&hdev->dev, &claw_gamepad_attr_group);
 
-- 
2.56.0

