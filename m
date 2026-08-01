Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9EA38E11C
	for <linux-input@vger.kernel.org>; Sat,  1 Aug 2026 09:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785574869; cv=none; b=J4T25C6NEAF18g254AOriNSEyYA4E6jkL3iYCB5UmtAJWGos7TP6x370DR806dBrEvGIyH7TEGW/WmqjsGRKEuLB4gpF99Ih1w2pote+72M4ZFd0tXyt29FPXJVBN6634RLiruhvyDliLib7S5FGn2cmXj9/loZVssksebztyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785574869; c=relaxed/simple;
	bh=ASCMJWrFpviMulxYbxqhz2oAsml9SOnD/nYqETHec3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YSTXhvqWQKUw1cJZMIEEWWjNm4i3lBFFc9V4NQ4C3TRI87IBUgf/iQVwJuPs18OsRqrW0sf+LMXNPrNoYBvQxaeC9oNS/Mz8YWIahN67mxVeAHmFd5fqOaEkpFSgMjn8Xjfbx8Gm5CTnMbdaokZ+Zh5TXHzL1K0SPKk5UUt0MCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBrXwqbK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBrXwqbK"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49557167508so4766235e9.1
        for <linux-input@vger.kernel.org>; Sat, 01 Aug 2026 02:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785574864; x=1786179664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RLebyPNAQYMs2atXyqoEwp6i5xpU6rXMBJl7j5uTfe8=;
        b=FBrXwqbKuvYi9r3/bmlBMr9WWwG2lN8CxSRyB0NPYo76UUVUSJ2qzUKcLtLWvqhnz3
         di6Drwt4HTXeAnQKhGB3LtD8LNd8zq9sClh4vyedUzo5X2Wazo7KMT7BHIV2GyfHoeIH
         kOZf48LFv62Y9/Rph4qoVV2GQLXMlxgsedmpc1g+7TQeHhiBGHBPuybHuB/u6n3ikm1V
         EtPqata3jXg8daHDXbncF+OHCJfvPIHB9H7gzksiDdqcPD9V9dE7F4s2o+2rTS35aEfA
         JyKFjJETx9O2usxkd1208OgmjYLtLrRMIyKvZFdIbS7krJSQnTrtFfB0lwj7Y5U7IsvB
         nwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785574864; x=1786179664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RLebyPNAQYMs2atXyqoEwp6i5xpU6rXMBJl7j5uTfe8=;
        b=cxtjIxgYBfqjlBDkhl3NV7yOnJUAzkXWvSmAwj0SvtOzY81N+XHtZMQ+oD436cxNTs
         pi1j85FQmSyxcuF9FjrfVQYjY3Lv2Pna2DIPzsUQy+DLpOtSVYmZD7g8Y8tem2SIX34s
         MaDkQlrI/A7WnIER8T79H49rOAmoXmn3dVkDPKMksZdUJSvOqHU/dMF2lGehVoBqHUng
         EYm8XTxMHm4pf9XqeSn9lV7/AEJSGBVhuHiDBBb/gudWvunC7yZdJJD7uMPZnoT8jiNw
         6m7cNO1oT/9IubFDo2AKqYPb26++j8AClae7tRIxqnZG7xXQTNxhNLiIe0ke33qot6h7
         6PVw==
X-Forwarded-Encrypted: i=1; AHgh+RqQSWgCbTjOvVm/4DeDkKhGzeJEwzHrCwvJZ3ueygUMZD0LK/97ZzE4iD3b3DSgcFmtwYMy+NGnwQFHyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRNulo599kzkAkwr3mhC7wPUHEXpdlKZbukCCocnEWwKHU190T
	amU1FePkymDtkxfkQ1CTgxOtaSWajn981860iAQQ3+OuetRiyEZmZBeTZgMWJubIP51GvQ==
X-Gm-Gg: AR+sD10eVKZRs80euUIGT/Ew7ctiD4HSmYrVXuNY3ISG8h1EL7YxyPH7EQLyPjoKNHt
	j6SDJZN6bWE910doL2f7d0rGvrnKu3WwuzpuYns+yWlJRHrQNUJWJBZYDN0mOBb4mXW7UtK6c9T
	lro6QwMA2MZbBaSSxbcKs2ErlKf7BlXzJrvi9lIC+PN4DugsW+3YO5iBjN1YLGmN7x6d1LIVHf4
	BVjJuFb/3Wi4S1/R2IjpE6WyYx4uillZS5JNiRzu9G3t6PBh+26tU0bwHhFM2bODkLk4Pi/dxic
	BdPO9XF5tRHygD+1OudxevPznWzONigHdFC4z2Ot21zrkRr3RkUbQcNYz9aL9J8LQsrZa568Id3
	R3BnYIuHr16FmWawbz33Vb5egr7cJzzIT45Qvl8FHP+r0b+xph2gO/XFRjgXm1ygi64Qjp6FyBQ
	o/M1c3DRP9q/g5jxD/Dx9WJFmoQojhPSpKij7PxST1ZK0OXSL1eLs2X93siqBMtI4cJu25BgpJ7
	S6AF1VQHkzqFA8Jg2HxsI+O988B2Kw0
X-Received: by 2002:a05:600c:4e52:b0:496:bbce:fc with SMTP id 5b1f17b1804b1-4980c658ff3mr34073065e9.12.1785574864411;
        Sat, 01 Aug 2026 02:01:04 -0700 (PDT)
Received: from cyln000394.fritz.box ([79.132.233.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b86d66sm17257775e9.1.2026.08.01.02.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:01:03 -0700 (PDT)
From: Alexandre Derumier <aderumier@gmail.com>
To: "Daniel J . Ogorchock" <djogorchock@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Derumier <aderumier@gmail.com>
Subject: [PATCH] HID: nintendo: fix rumble starved by the input report cadence gate
Date: Sat,  1 Aug 2026 11:00:59 +0200
Message-ID: <20260801090059.1349535-1-aderumier@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rumble on third-party controllers speaking the Switch protocol is weak
and intermittent over bluetooth, and absent on some units.

Since commit d750d1480362 ("HID: nintendo: fix rumble rate limiter"),
joycon_enforce_subcmd_rate() requires JC_SUBCMD_VALID_DELTA_REQ (3)
consecutive input reports spaced 8-17ms apart before releasing a
subcommand. That window is the official Pro Controller's bluetooth
cadence, and controllers that do not report on it cannot pass the gate,
so their rumble is starved.

Measured over bluetooth on one host, reading the controller directly,
fraction of reports at which the requirement is met:

  official Pro Controller     95%
  Datafrog clone              46-52%
  8BitDo Pro 2                2.5-4%

The Pro 2 delivers reports in pairs, so 11-19% of its deltas are 0ms and
reset the counter. Affected controllers report Nintendo's USB IDs, and
the MAC is no better: the Datafrog clone reports an OUI registered to
Nintendo, so identifying them by vendor would misclassify it.

Instead, notice when the requirement cannot be met: after
JC_SUBCMD_RATE_MAX_FAILURES exhaustions of the limiter, fall back to the
pre-d750d1480362 throttle, which keeps the 25ms spacing and the
transmit-after-receive synchronisation from commit e93363f716a2 ("HID:
nintendo: ratelimit subcommands and rumble") and drops only the cadence
requirement. Exhaustions are counted cumulatively, as an affected
controller meets the requirement occasionally and a consecutive count
would never be reached.

Signed-off-by: Alexandre Derumier <aderumier@gmail.com>
---
 drivers/hid/hid-nintendo.c | 39 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 0000000..0000000 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -609,6 +609,8 @@ struct joycon_ctlr {
 	unsigned int last_input_report_msecs;
 	unsigned int last_subcmd_sent_msecs;
 	unsigned int consecutive_valid_report_deltas;
+	unsigned int subcmd_rate_exhaustions;
+	bool subcmd_rate_relaxed;
 
 	/* factory calibration data */
 	struct joycon_stick_cal left_stick_cal_x;
@@ -841,10 +843,11 @@ static void joycon_wait_for_input_report(struct joycon_ctlr *ctlr)
 #define JC_SUBCMD_TX_OFFSET_MS		4
 #define JC_SUBCMD_VALID_DELTA_REQ	3
 #define JC_SUBCMD_RATE_MAX_ATTEMPTS	25
+#define JC_SUBCMD_RATE_MAX_FAILURES	4
 #define JC_SUBCMD_RATE_LIMITER_USB_MS	20
 #define JC_SUBCMD_RATE_LIMITER_BT_MS	60
 #define JC_SUBCMD_RATE_LIMITER_MS(ctlr)	((ctlr)->hdev->bus == BUS_USB ? JC_SUBCMD_RATE_LIMITER_USB_MS : JC_SUBCMD_RATE_LIMITER_BT_MS)
-static void joycon_enforce_subcmd_rate(struct joycon_ctlr *ctlr)
+static void joycon_enforce_subcmd_rate_strict(struct joycon_ctlr *ctlr)
 {
 	unsigned int current_ms;
 	unsigned long subcmd_delta;
@@ -872,6 +875,14 @@ static void joycon_enforce_subcmd_rate(struct joycon_ctlr *ctlr)
 
 	if (attempts >= JC_SUBCMD_RATE_MAX_ATTEMPTS) {
 		hid_warn(ctlr->hdev, "%s: exceeded max attempts", __func__);
+
+		if (++ctlr->subcmd_rate_exhaustions == JC_SUBCMD_RATE_MAX_FAILURES) {
+			ctlr->subcmd_rate_relaxed = true;
+			hid_info(ctlr->hdev,
+				 "input report cadence does not fit the %d-%dms window; using the legacy subcommand throttle\n",
+				 JC_INPUT_REPORT_MIN_DELTA,
+				 JC_INPUT_REPORT_MAX_DELTA);
+		}
 		return;
 	}
 
@@ -886,6 +897,32 @@ static void joycon_enforce_subcmd_rate(struct joycon_ctlr *ctlr)
 	msleep(JC_SUBCMD_TX_OFFSET_MS);
 }
 
+/* The rate limiter as it was before commit d750d1480362, without the report
+ * cadence requirement.
+ */
+static void joycon_enforce_subcmd_rate_legacy(struct joycon_ctlr *ctlr)
+{
+	static const unsigned int max_subcmd_rate_ms = 25;
+	unsigned int current_ms = jiffies_to_msecs(jiffies);
+	unsigned int delta_ms = current_ms - ctlr->last_subcmd_sent_msecs;
+
+	while (delta_ms < max_subcmd_rate_ms &&
+	       ctlr->ctlr_state == JOYCON_CTLR_STATE_READ) {
+		joycon_wait_for_input_report(ctlr);
+		current_ms = jiffies_to_msecs(jiffies);
+		delta_ms = current_ms - ctlr->last_subcmd_sent_msecs;
+	}
+	ctlr->last_subcmd_sent_msecs = current_ms;
+}
+
+static void joycon_enforce_subcmd_rate(struct joycon_ctlr *ctlr)
+{
+	if (ctlr->subcmd_rate_relaxed)
+		joycon_enforce_subcmd_rate_legacy(ctlr);
+	else
+		joycon_enforce_subcmd_rate_strict(ctlr);
+}
+
 static int joycon_hid_send_sync(struct joycon_ctlr *ctlr, u8 *data, size_t len,
 				u32 timeout)
 {
base-commit: 0131b508c0e2489eac6e121135988f6eeb716f19
-- 
2.51.0

