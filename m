Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6E0492E30
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 23:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788911018; cv=none; b=fY1cmyExK0PMjmShDruQbiNUZXpq6Plk7MZCCT8Ulz1lwVdHAR0i2XeNnIblc9LK6EoxeeHzgKICOf6u84cbBLcgJkOtLW1Bgun4gGvRlUvvfdR51lEGQ4gpZVUZyEty3otRLpnVLzOCGPVHo8RYDEpMyLd3J2qWEfzihgUYezo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788911018; c=relaxed/simple;
	bh=uwYgOWB6T85giMBSAkiXo5AXxkPNnz+4KKs0hupdbKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzIa+z1Nv4nOlqiV3YF2QqlmiYi53jtdgCv1aD3sczrzJ+LR/J+hsakIesbYnhs+AtN201lRy/XD4ElgUwl+L3wsNkk5XT9usuYDOK6CaGwcnKE6dqshIQGFtlh8jx0GKa5L4VwiTfRERdQk5ZB+vET1xlpK/wAUixO1gfEitfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk; spf=none smtp.mailfrom=fireburn.co.uk; dkim=pass (2048-bit key) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b=0ICz5k5K; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="0ICz5k5K"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6356257so731082f8f.0
        for <linux-input@vger.kernel.org>; Tue, 08 Sep 2026 16:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1788911015; x=1789515815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z21b6fsoY2E6Vzr2RDS21MTgNdKIrr6ZxRGvarq9zjQ=;
        b=0ICz5k5KkX7+Cgy32968AY4YtYGJQLMvrLXdkeXr+ZRALB8GqR66KuKGcHGdD7sFCd
         03qaoZzRGCZV+qvZ6ADriIZdWrRDhaOVNp5ak98iNOvafAZvCcqqPOaNGVFoq8S10ZPp
         ElbPIF2cMrIWLBxRSBpgZKAgWKW9uBUh8LcF2VWRRElckOCBv9isbKiOp+WoQOE9uAH2
         Az8JxYaPxc40aCcssDqgtQx4Xcsl5IuxCdpvu4NnUpd/1ccCgBaj0OFQ5DksTSzt0v/7
         bT9ziL7QYGfRghcVKp4EqLFR7mHggJaaWVDPX94Qef5wFo7bKC8z8rZ9BauGJvqPcDHq
         t48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788911015; x=1789515815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z21b6fsoY2E6Vzr2RDS21MTgNdKIrr6ZxRGvarq9zjQ=;
        b=VuayMhKZuIiudjIB21xT90xZVogwoPSOMFQqJ24fBgAIHffdZMr1Db9oWGKaZVpTuT
         o5okaAebsPAAJBFxidz6n0xmpyfVAjXb0WTiVbokmfPH1dc/CjeDeHjXuobkTtPIDlQX
         XUqHBUU5yzBP/oztmKDHDE4ChniLft7BtaSwaeiAncJw3g9dis/GKtbGvzSLWIcNYaFo
         ppEQugLOTWi1dn+rJr4dT/VxyFc7jl9wWV+BguG5wJvTDlucg3ScOoDxlJsP9bUTHv7L
         10sE2KC6jjFVMe5y8EL3bf09lnz+eoFDfEOpUkHiqC2BPCRdyeDpT8txky4qMPIHSXXv
         1ePA==
X-Forwarded-Encrypted: i=1; AKwUvBwTBBcRCPXeS65zXq5vVQVNw/SuUE2CY3qJMK/FPpvfviHRIeNhoWRSUnhMeaFAcVYJe5xDGoBIEoKz1g==@vger.kernel.org
X-Gm-Message-State: AFuF++m/zJZx4JPWgoP7sEsxB/yJv3+t0LrgZCbGcrKd+zwmpeLz/Riz
	hkPGWEMkpzOpIxX/nIwtwbKD8rnYilsIHVjKr8TwUIeFRNPOgBzS0CLO0HKxTdIO2g==
X-Gm-Gg: AYBFou2S68W28HUzXPFDXEmS2jPVXELZa/1G29ZrwKYtXcKQocciMbs7J8nIvGaL/RK
	TMY1ux8nXKEW+inWa1zmyCCH6On3Al0+vpfPH1QqQFzMWx/JzhBKmvsrDE+dycLoX2lsJVY8RzG
	qp9/PiIhE98KRl4kq4OrOKhq+e7UZnYIzwcMTDNebUIHIE3B+JzrQGiyJ0xNVqiLxaTFSs98vOE
	bZOv4OdOCLmDOKHBsfPcBiwRG5KdlGE22hIAwUpXS5jNLSNbt1RiSsTVzUsru59npYGfNC16FXR
	cF0X8q3NFeb91JjMkAFkntU/nPdqg3oFWi1rXjLkAN/ognJndFbzhddsb45buwdzdBJU1WBwFS1
	r3dZdUVTjrE+Y+XlaSNCz4/OEolwT018lELgAG9dU3va9CKUtznOIMdlJhj4+soA+akCmCYGXeV
	6zqVVi7XoeJAj1cwokPolXa7qh6FAGpdYmNtmzNxBoYXZz16OP449hHCvKddegF21+VLQZhaCU0
	501/31xjHu3MdbkWbS5wk6V+imf3ajveqKI
X-Received: by 2002:a05:600c:4455:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-49d1754fdf6mr107220985e9.6.1788911014994;
        Tue, 08 Sep 2026 16:43:34 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfbe5b252sm376047695e9.3.2026.09.08.16.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 16:43:34 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: "Daniel J . Ogorchock" <djogorchock@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Silvan Jegen <s.jegen@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mike Lothian <mike@fireburn.co.uk>
Subject: [PATCH v2] HID: nintendo: relax subcommand limiter until cadence is proven
Date: Wed,  9 Sep 2026 00:43:15 +0100
Message-ID: <20260908234315.117903-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908224532.114357-1-mike@fireburn.co.uk>
References: <20260908224532.114357-1-mike@fireburn.co.uk>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

joycon_config_rumble() queues a zero-rumble packet during probe. The
rumble worker sends it once ctlr_state becomes READ, and
joycon_handle_rumble_report() retries it a few more times. This is the
first subcommand sent on every connection and it goes out before any
input report has been seen, so consecutive_valid_report_deltas is still
0. joycon_enforce_subcmd_rate_strict() needs 3 consecutive reports in
the 8-17ms window before it releases a subcommand, so the send exhausts
all 25 attempts and warns on every connection.

Add a subcmd_rate_unproven flag, set until the cadence has been
observed, and use the legacy flat-delay throttle while it is set.
joycon_parse_report() clears it after JC_SUBCMD_VALID_DELTA_REQ
consecutive reports at a valid cadence. USB is excluded, as its
consecutive_valid_report_deltas is forced to the requirement anyway.

The flag is separate from subcmd_rate_relaxed so that the exhaustion
fallback added by commit 781f8e020a78 ("HID: nintendo: fix rumble
starved by the input report cadence gate") keeps its semantics.
subcmd_rate_relaxed is written from the subcommand worker under
output_mutex, subcmd_rate_unproven only from joycon_parse_report().

Found with btmon over Bluetooth on a MediaTek mt7921e: the three
JC_SUBCMD_RATE_MAX_ATTEMPTS warnings on connect match three
JC_OUTPUT_RUMBLE_ONLY (0x10) frames from the rumble worker's
zero-countdown retries. Tested on a Pro Controller, which now connects
reliably, where before it dropped within the first ~70 seconds of a
fresh connection about half the time.

Fixes: d750d1480362 ("HID: nintendo: fix rumble rate limiter")
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:Opus-5 [Claude Code]
---
v2:
- Use a separate subcmd_rate_unproven flag rather than reusing
  subcmd_rate_relaxed. In v1 joycon_parse_report() cleared
  subcmd_rate_relaxed from softirq under ctlr->lock, while
  joycon_enforce_subcmd_rate_strict() sets it from the subcommand
  worker under output_mutex. Clearing it after the exhaustion counter
  had passed JC_SUBCMD_RATE_MAX_FAILURES would stop the
  ++subcmd_rate_exhaustions == JC_SUBCMD_RATE_MAX_FAILURES test from
  ever matching again, permanently disabling the fallback added by
  781f8e020a78.
- Start USB controllers proven. consecutive_valid_report_deltas is
  forced to JC_SUBCMD_VALID_DELTA_REQ for USB at the end of
  joycon_parse_report(), so the v1 promotion could never run and USB
  would have been left on the legacy throttle.
- v1 was assisted by Claude Sonnet 5, v2 by Claude Opus 5.

Both issues in v1 were spotted by the Sashiko AI review:
https://lore.kernel.org/linux-input/20260908225815.952CE1F00A3A@smtp.kernel.org/

That review also flagged a pre-existing issue: that the probe error
path does not set ctlr_state to JOYCON_CTLR_STATE_REMOVED, so a queued
rumble worker could run against stopped hardware during
destroy_workqueue(). As far as I can tell that is not reachable. The
worker can only be queued from joycon_handle_rumble_report(), which
runs via joycon_ctlr_read_handler() and is gated on ctlr_state ==
JOYCON_CTLR_STATE_READ, and from joycon_play_effect(), which needs the
input device registered. input_register_device() is the last call in
joycon_input_create() that can fail, and ctlr_state is set to READ
immediately after it returns, so there is no window in which the worker
is queued and probe can still fail.

v1: https://lore.kernel.org/linux-input/20260908224532.114357-1-mike@fireburn.co.uk/

 drivers/hid/hid-nintendo.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 43e0f2aaea3b..5b3d97c0ad39 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -611,6 +611,7 @@ struct joycon_ctlr {
 	unsigned int consecutive_valid_report_deltas;
 	unsigned int subcmd_rate_exhaustions;
 	bool subcmd_rate_relaxed;
+	bool subcmd_rate_unproven;
 
 	/* factory calibration data */
 	struct joycon_stick_cal left_stick_cal_x;
@@ -917,7 +918,7 @@ static void joycon_enforce_subcmd_rate_legacy(struct joycon_ctlr *ctlr)
 
 static void joycon_enforce_subcmd_rate(struct joycon_ctlr *ctlr)
 {
-	if (ctlr->subcmd_rate_relaxed)
+	if (ctlr->subcmd_rate_relaxed || READ_ONCE(ctlr->subcmd_rate_unproven))
 		joycon_enforce_subcmd_rate_legacy(ctlr);
 	else
 		joycon_enforce_subcmd_rate_strict(ctlr);
@@ -1797,8 +1798,11 @@ static void joycon_parse_report(struct joycon_ctlr *ctlr,
 	 */
 	if (report_delta_ms >= JC_INPUT_REPORT_MIN_DELTA &&
 	    report_delta_ms <= JC_INPUT_REPORT_MAX_DELTA) {
-		if (ctlr->consecutive_valid_report_deltas < JC_SUBCMD_VALID_DELTA_REQ)
+		if (ctlr->consecutive_valid_report_deltas < JC_SUBCMD_VALID_DELTA_REQ) {
 			ctlr->consecutive_valid_report_deltas++;
+			if (ctlr->consecutive_valid_report_deltas == JC_SUBCMD_VALID_DELTA_REQ)
+				WRITE_ONCE(ctlr->subcmd_rate_unproven, false);
+		}
 	} else {
 		ctlr->consecutive_valid_report_deltas = 0;
 	}
@@ -2730,6 +2734,7 @@ static int nintendo_hid_probe(struct hid_device *hdev,
 
 	ctlr->hdev = hdev;
 	ctlr->ctlr_state = JOYCON_CTLR_STATE_INIT;
+	ctlr->subcmd_rate_unproven = hdev->bus != BUS_USB;
 	ctlr->rumble_queue_head = 0;
 	ctlr->rumble_queue_tail = 0;
 	hid_set_drvdata(hdev, ctlr);
-- 
2.55.0

