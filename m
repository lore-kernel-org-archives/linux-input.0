Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794713017;
	b=bjqKzVWjFOEHqkQmEGUC2hcK0+nB7XtyErPyNlx1xzG6Q9vh9lf7vs7SQ3SeAqP8Ej84
	 xPpb2NPVAnd27eo+ozrHkgMfvs4Bb9HRJwmitffVjcbIy+RlnNFHGNX5sppiJOkF/eBbN
	 O3Q2/IEgq2F9s7tyvcwUctWTrsc663pX5G4VOL/NjqKK2OHGKnVF0lgPQC7M/g5BcbTMy
	 bY5qQI1M7y/SZdvoEgd5DCBMa49Wzp5ni0EItnG5M1ZsoQQw7ebksgpxtEZ5NeG8eA78C
	 JJnUPfnhQA65P1cyD8idUiscCYN50pgwkyI5006vmDTgWi+/k78en/R7hgGqO3krtbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794713017;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=kl79L3c9rNpYrweCRtWHwKdmqJ86B/vjP/tYTMzC8GY=;
	b=DTiblmSSFCBY8qRYaOpqx8UuAFuNPswNsZEHhcUb3e/iOjyfjl1o7QqpcJG5oY4Gj+wu
	 vldC5MRexjMvV7pXpaEwvR5E0+47P5BzxnZmCMFX/ldXggLJuPZRGGdczGHOKYYmDdotH
	 qKshGOvdG/QEOIkRtpq3PisTPhcK8PwmrT7AE7R9/iqy+si1Hz26yz5mDuCcqQigldyuA
	 aaUuTgwZLmqxcBZiQN2KD8jwBZZeLqzNuQYcgWLIVBVdhg7uENjyoiwcbmcZpK6/Xs2B1
	 Uvfqel1HVJKsfNxagOfdQykwWIKGS9VXurYRmbd0sfjIM20npsWzuMvG+KirNsmkYbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=XxL9Nu7G;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FNJ6DBUo;
	arc=none smtp.remote-ip=103.168.172.139
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AF7606A323
	for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 03:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2AF7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=XxL9Nu7G;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FNJ6DBUo
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id 225B21381DBF
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 22:23:36 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sat, 14 Nov 2026 22:23:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1794713016; x=
	1794720216; bh=kl79L3c9rNpYrweCRtWHwKdmqJ86B/vjP/tYTMzC8GY=; b=X
	xL9Nu7GB6+Cwz8lcw+649TLD8kh06GJD7XSVqJszq7DUZScURiyN3E29Ykq3XWSf
	KKukg0d0sPq4Q4DfZbWk/Br9/IMYZ5r+ECb9sTalID3F1KAh5kMuqpm3orLfNfn+
	rpeDOsp9Xztf1sI9O9HcZ8jQre+hOcgJ5kRwoKl8Rpi1/qc5YutDr2uDVXIdXLrK
	TRCK3aD16QKw/MO8lkmun/1q0mMiNil4zKYpKMwN4MVkSL14pr62Kvb0UEDe5JoW
	IdZLalQZpAcsK0a+mZaPCOZ9IxWbuudFP/pPmIT3VRXRSAIoAKk5HWzs7Wn1Zlle
	OqYo6z60ILcWdNmZBU2dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794713016; x=1794720216; bh=k
	l79L3c9rNpYrweCRtWHwKdmqJ86B/vjP/tYTMzC8GY=; b=FNJ6DBUoOpTZ1aJkv
	TePq/UO0fXrv+Apxp67YGRdkhHq24jyKESvawKOJQ6/2JiaYH+/7ax4SNYNyPuqb
	dgeEHOc7v0KZrna1mV8hW1JLibrw2HtV9OBTtJXE615FgSb8m/Gcsc7nUEZWwwIo
	Q8x3O0g7eeNUUOBvoq40FV8KfX0pSWtT3PBPTSr1z6pbpm5RSbouUVulXaBUC4jr
	BhNBInCHMezo25W4h/Z8THbp6ndo7I4G/gBJeF85cfjCPT8yXHE4pLRj7wWmTfZ8
	j7BB8x6VSUiorS1eCk0ruO/QvXIr1zxJU0P2hGrjG83cOrjTB2tcqFgxGnwESiYL
	V74vg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794713016; d=fastmail.com;
	mf=PGdyZWVuLmtvYWxhMjk3OUBmYXN0bWFpbC5jb20+;
	rt=PGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZz4=;
	s=fm3:rsa-sha256:gwo5o3dy4g4W4Y3QBeEGZ36cfVjYpm2xMI/CdT7if3Cj67y
	oTggRciH+uuO3N3Oezay6mQk4Gwc0dwb9hm9Wia4OV1/9f5/VWocnAdmActwj0sK
	JNbWKd7fISUaGjOBCprLiiTuA7IoyZ7IyeMOfL1MxGYwGiHM+DPxql8ubKKPPaHo
	oOtRJ4fgEBA2PCf4eaYIUHUNSig86vYoMm6HM4IzxIPa1J3trExrwHEbIiHBtRV7
	lLIqVWKYDTIw/EIzOXqhtVCtZ7Y4CYFyCFytoE0R0ZRIxE0WjqT7NstxNnRCP7ZX
	mkie+Ga8eQKuis7bX5JAk6wUDLALe+DSjXq2iSw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:JDpOq7XsTkL1ppG+bzM/oDLmCYvlXRCEO1jFnbfWZXA=:cswWuoCL1+p6v9Q7lgHE4XIDrdHHjiSMQaUzcNNvjTU=;
X-ME-Sender: <xms:tyX5asV5uwUe5-At_oc067L34AnFI3Kb-NHISR6JdVquN-cYBGRcLg>
    <xme:tyX5ap5Gw9sfA8NUgVZa45jd44YHJBjOD3KWdtGgh3YOpB1RIDIUIbI6F92i-X5l1
    P5UGviunJYbeoLhNPjWoxKeANEyrTdsR97gzaa8_tz9uqhG4cfmPewy>
X-ME-Received: <xmr:tyX5anrUtIe3A0ARx3wLIPrHN8yH0IPJ2KkKJcBj4Y13CAeqTwRbVaDQuxo27TANdtyeZ5Hpnb1VjaffZiSc9CHkhJRQ__hEFS-fd345c1fneq8>
X-ME-Proxy-Cause: dmFkZTGYamLCE26H9dh/TW+9QFJBmNBXpcW+/bioom/h3o8y6x6Xc8Q81U1oCKWPRybk5s
    5B2Hw243lz5JYaGMm8nX7m1VREuShWzNSWhKbLhN71ArlIG/Yl8/R1ORlL5ga3f9yxR0Ic
    mDp2Xq7OPLAPADwhWrExV+NVD56tUQvakz3N6LqZmA+fB7t0wjqPLTLbu7GV9ZWyuvF47E
    o3ffz/g7X6FKZntGNvI4MIQ14++APaN/kKvrika04leUqM1c8zelc6ptRjqU/a6v2Uloe0
    xnxaGIQ/U2dfwmqiYBW1Kw89zdWZxHe+jWvCmy08MqWoPJdthKKvd/tMCJSxnlcUfmGKQy
    2quMhRKkCNIpsa9+eRzMsYD0YUDQQyV1Rcs8tJ7XQzlUIYlbs9rgLvqeTNiRkC0lB2vi4i
    g1L2RVQ2bxq+H5mI5DEU0AFA5uuXIp/Eo/VNLZHge/Cyshi7udy4oiNKMqpz53zAv6gQzq
    hv+ZF1B77bA0JxzSefNuEb1fWo1kTuQkEWRNewwntjUPSgZMkPvR5tw0GeOlJx8CZ7LCPM
    KFSYNPb88Q7PkLOtUbE/38AZrLdEomfC4vXy6ALDeZu1n2nscMG79WIyuDIv0sllC/VPcy
    pcVMuR+DGxf2e5jU7WNy8cHxpaYQIAemV6kydMm4FcXuYcTYyfzZFcfZsGJg
X-ME-Proxy: <xmx:tyX5askyjHr1CvQ75jNS5sk0SoF5Uh9fFhzg0_AzG9BHMxAdDhd8SA>
    <xmx:uCX5ajOsplCkyeAwqNV7v-zx4aH1cmYILJviaQSWZzQSG3F7DQEiRg>
    <xmx:uCX5agMofw3zpDkLtMxJstZjBdu93rTnU5mmhBJNxGYMoM-LC_Mw5g>
    <xmx:uCX5akiXHmXydsNzprrxX3mZhJ4UfSqTilxTPhezBCD8F4p9--tMqw>
    <xmx:uCX5aiYQgGFYhV83I9YRwuTczgDp0qCpXKOSLhhilIvAALdbd3t0opI->
Feedback-ID: ib51446d9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Nov 2026 22:23:34 -0500 (EST)
From: Ana Veto <green.koala2979@fastmail.com>
To: derekjohn.clark@gmail.com,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Ana Veto <green.koala2979@fastmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] HID: hid-msi: Send a uevent when the MCU changes the mode by itself
Date: Sun, 15 Nov 2026 03:23:14 +0000
Message-ID: <20261115032314.7094-1-green.koala2979@fastmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114221440.12580-1-green.koala2979@fastmail.com>
References: <20261114221440.12580-1-green.koala2979@fastmail.com>
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
event, unless a report came in during the write: that report may
already show a newer state, so it stays.

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
    
    v3: a GAMEPAD_MODE_ACK that arrives during the SWITCH_MODE write is no longer overwritten by the values the driver sent (claw_switch_mode now stores them only if no report was stored meanwhile).
    v2: https://lore.kernel.org/r/20261114221440.12580-1-green.koala2979@fastmail.com

 drivers/hid/hid-msi.c | 51 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
index 3225d3b..6404de8 100644
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
@@ -387,17 +389,40 @@ static int get_endpoint_address(struct hid_device *hdev)
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
+		drvdata->mode_reports++;
+	}
+
+	/*
+	 * The MCU changes the mode or M-key function by itself, e.g. while
+	 * View+LB is held. Userspace learns of changes only through uevents.
+	 */
+	if (changed) {
+		guard(spinlock_irqsave)(&drvdata->registration_lock);
+		/* Pairs with smp_store_release from cfg_setup_fn and claw_remove */
+		if (smp_load_acquire(&drvdata->gp_registered))
+			schedule_work(&drvdata->mode_event);
 	}
 
 	return 0;
@@ -656,11 +681,14 @@ static int claw_hw_output_report(struct hid_device *hdev, u8 index, u8 *data,
 static int claw_switch_mode(struct hid_device *hdev, enum claw_mode_field field, u8 val)
 {
 	struct claw_drvdata *drvdata = hid_get_drvdata(hdev);
+	unsigned int reports;
 	u8 data[2];
+	int ret;
 
 	guard(mutex)(&drvdata->cfg_mutex);
 
 	scoped_guard(spinlock_irqsave, &drvdata->mode_lock) {
+		reports = drvdata->mode_reports;
 		switch (field) {
 		case CLAW_FIELD_GAMEPAD_MODE:
 			data[0] = val;
@@ -673,8 +701,23 @@ static int claw_switch_mode(struct hid_device *hdev, enum claw_mode_field field,
 		}
 	}
 
-	return __claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SWITCH_MODE, data,
-				       ARRAY_SIZE(data), 0);
+	ret = __claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SWITCH_MODE, data,
+				      ARRAY_SIZE(data), 0);
+	if (ret)
+		return ret;
+
+	/*
+	 * The driver's own change is no change to report. A report that came
+	 * in during the transfer may already show a newer state; keep it.
+	 */
+	scoped_guard(spinlock_irqsave, &drvdata->mode_lock) {
+		if (drvdata->mode_reports == reports) {
+			drvdata->gamepad_mode = data[0];
+			drvdata->mkeys_function = data[1];
+		}
+	}
+
+	return 0;
 }
 
 static ssize_t gamepad_mode_store(struct device *dev, struct device_attribute *attr,
@@ -1871,6 +1914,7 @@ static int claw_probe(struct hid_device *hdev, u8 ep)
 	INIT_DELAYED_WORK(&drvdata->cfg_resume, &cfg_resume_fn);
 	INIT_DELAYED_WORK(&drvdata->cfg_setup, &cfg_setup_fn);
 	INIT_DELAYED_WORK(&drvdata->rgb_queue, &claw_rgb_queue_fn);
+	INIT_WORK(&drvdata->mode_event, &claw_mode_event_fn);
 
 	/* For control interface: open the HID transport for sending commands. */
 	ret = hid_hw_open(hdev);
@@ -1946,6 +1990,9 @@ static void claw_remove(struct hid_device *hdev)
 		smp_store_release(&drvdata->rgb_registered, false);
 	}
 
+	/* gp_registered is false now, so no new mode event can be queued */
+	cancel_work_sync(&drvdata->mode_event);
+
 	if (gp_registered)
 		device_remove_group(&hdev->dev, &claw_gamepad_attr_group);
 
-- 
2.56.0

