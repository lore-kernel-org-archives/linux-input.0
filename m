Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEF24C92
	for <linux-input@vger.kernel.org>; Sat,  4 Apr 2026 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775309885; cv=none; b=B/4NKk4BKFrAYMSYaxO4JWudTlmWmpw++yGzrHv8Lgl3ZBK22Mb0qRUJ+Wi0dPKosOWRjEbugrdVB/mI9JPUXGcvf0BOoabLuvBkZmuBaAktgo7NsMjPRoH2i8PDfguSNAUVBFj7u5gSMuiSi9n2xEu5pm0x9V5FaMF+qegc1Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775309885; c=relaxed/simple;
	bh=Tti5c4+Qtl6DRYr93C9At10Ouqx5Scst5JK/tLK4OHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=az5BZFMyLw2K3sKKJUIIGVRzDHKjqrdBvrSG+y8j3Tp6UdNLe4i4WG5t/z4kp2K8a9pMQh+ZxzqeV7hBPvFtQB4hCgfBdwVrsae6kYvSB9PMNRAbkTAalqIDkgiwQWwVD9YCWQz2Q3bAgMOKq3dJ6K3VcXOXtOtIak/9TVsQWFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeiZWcb/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeiZWcb/"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso2076945e9.3
        for <linux-input@vger.kernel.org>; Sat, 04 Apr 2026 06:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775309882; x=1775914682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCazqZ+Sf1QzXooCov7jrt+jBsg4HlUtZCxwNCt2REA=;
        b=XeiZWcb/T54nBTuiyidH4auI5TeuRDrGC1z9KwLYyYhibi2pCb6Wv1El4RfQzquYMT
         1TxQpey+kCEUzfcitQaEZ1AyMth8B6/UUdfCu/mZaQ9GYEB9O7IXuqG2bUe1K77y5gmI
         LIa1Fa+FHEQdiTkKxeDY6WbKVk8DnEwakbQiQ86iXvHrvNEbQNIjtwAuTkf70QEEOvQ1
         /JoyS1pmfBup4hUrZRom2p07Wk1fxcLysi8QTm1x4r8QEICg4mzU48lEFMwdl8YyU6Zw
         h9WIWf6eBms3s34vNiWgyJYyb0kCXfqCBRSX6pop37fUfuvRh1rd2+xTPV6ra58N5erC
         p68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775309882; x=1775914682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sCazqZ+Sf1QzXooCov7jrt+jBsg4HlUtZCxwNCt2REA=;
        b=ibRo5ETJ0BZWStGS/efl/WB6Q9W2QzTF+H2VGA7cl1kNFIztt0GNE74gyPOLy8dPQ4
         /izLrprwwRq3OqcvGNWIil2qxWC4wQQ8Kn+pA4b6pASKSnsF8Md2l8/mwbJ0SiSCUAX9
         Sa/srg3xZKyjjTNBtUiez4ymJZSpaH5DdgD89Yy3tprcRpQubPhMw4he43BwCli90eQ+
         Ffy86o8XwVHkMc0GyBKFrbpaPRTRIV+PuFIWmsNOnNiz9Urbmag6+DgYVK792P6fZUPE
         QNgugdurqDgutuWI7lPouXeOr50FpGGmlcO7HcDEMnK4fCyNmAqMemu4houInVTeazgW
         2pFA==
X-Forwarded-Encrypted: i=1; AJvYcCUkjydKiQ8znJJNSBHZ6xsU31192meiHIc0yupDSEjgPIgmU8jxtBYrn31Ak7YPnedPVqk8RcI4N4YdWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyK7V6DsHtVlgeSmKOBQQ7T7l1zlUE5DrkU791FhxkR8VG/6dtT
	X447Xo9FjFm7Olg2ZNJZkyvrDvt5jj13JsbK4GcrcOnCK4p6uqU9/N8c
X-Gm-Gg: AeBDiet9j4AEk/WM/uLoGbLFDDU0o3pePR1JQNWf30noWkU7BR4EpEhUYBJlRYtuzSK
	CCe6RS11CucqJGWZkXajXWHoLEttHBsxJj4Wpihc9lV8gii7uKijPbwM95RkuieX26otLlL7a/w
	rwTuvjYd35kx6i1vWFWaZ/bpNc+isC+kGrone3fVuwLuKgEP0jMWOnOlucGNNAF36dD8i7j8D00
	6jXwqhfx4b4ayPdbWnDouCWaVZlsUM91k6wSj3so/7Tk0Fnh74r8FcjQxoyprOKyj1mjzPPpAUl
	QE9ZyJBXfToK2POsarQOnDiwrTT7c7iWrPjrUyMN8iOm2BcVo9NsflBuOGm3KOomM15sDgGQOFb
	C0dE0LcA+CGt/N0851jcLJ6HuMM9ohUQQNYYitFaR/qYq0P8CeUtLQhtkr1vvMT9+AFSovpv6rW
	R5tYq03VwUngXbNzlffawqRQ==
X-Received: by 2002:a05:600c:4593:b0:488:9696:488a with SMTP id 5b1f17b1804b1-488997e7dc7mr108719605e9.30.1775309881635;
        Sat, 04 Apr 2026 06:38:01 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6c7:268c::3d7:32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a706062sm239655955e9.9.2026.04.04.06.38.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 04 Apr 2026 06:38:01 -0700 (PDT)
From: Zubeyr Almaho <zybo1000@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Zubeyr Almaho <zybo1000@gmail.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: [PATCH v2 1/1] HID: add malicious HID device detection driver
Date: Sat,  4 Apr 2026 16:37:45 +0300
Message-ID: <20260404133746.80914-2-zybo1000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260404133746.80914-1-zybo1000@gmail.com>
References: <20260404133746.80914-1-zybo1000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a passive HID driver that computes a suspicion score for keyboard-like
USB devices based on:

- low keystroke timing entropy,
- immediate post-enumeration typing,
- known suspicious VID/PID and descriptor anomalies.

If the score exceeds a tunable threshold, the driver emits a warning and
suggests userspace blocking (e.g. usbguard). The module never blocks or
modifies HID events.

Signed-off-by: Zubeyr Almaho <zybo1000@gmail.com>
---
 drivers/hid/hid-omg-detect.c | 435 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 435 insertions(+)
 create mode 100644 drivers/hid/hid-omg-detect.c

diff --git a/drivers/hid/hid-omg-detect.c b/drivers/hid/hid-omg-detect.c
new file mode 100644
--- /dev/null
+++ b/drivers/hid/hid-omg-detect.c
@@ -0,0 +1,435 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * hid-omg-detect.c - Malicious HID Device Detection Kernel Module
+ *
+ * Detects O.MG Cable and similar BadUSB devices by combining:
+ *   1. Keystroke timing entropy analysis (human vs machine rhythm)
+ *   2. Plug-and-type detection (typing immediately after connect)
+ *   3. USB descriptor fingerprinting (known bad VID/PIDs + anomalies)
+ *
+ * When suspicion score >= threshold, logs a kernel warning and suggests
+ * blocking the device with usbguard.
+ *
+ * The driver is purely passive — it does not drop, modify, or delay any
+ * HID events.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/hid.h>
+#include <linux/usb.h>
+#include <linux/ktime.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/math64.h>
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Zübeyr Almaho <zybo1000@gmail.com>");
+MODULE_DESCRIPTION("O.MG Cable / Malicious HID Device Detector");
+
+/* ============================================================
+ * Tuneable parameters (pass as insmod args)
+ * ============================================================ */
+static int score_threshold = 70;
+module_param(score_threshold, int, 0644);
+MODULE_PARM_DESC(score_threshold,
+	"Suspicion score (0-100) to trigger alert (default: 70)");
+
+static int plug_type_ms = 500;
+module_param(plug_type_ms, int, 0644);
+MODULE_PARM_DESC(plug_type_ms,
+	"Max ms after connect before first key = plug-and-type (default: 500)");
+
+static int entropy_variance_low = 500;
+module_param(entropy_variance_low, int, 0644);
+MODULE_PARM_DESC(entropy_variance_low,
+	"Variance (us^2) below which typing is machine-like (default: 500)");
+
+/* ============================================================
+ * Constants
+ * ============================================================ */
+#define DRIVER_NAME		"hid_omg_detect"
+#define MAX_TIMING_SAMPLES	64
+#define MIN_SAMPLES		10
+
+/* ============================================================
+ * Known suspicious VID/PID pairs (O.MG Cable, Rubber Ducky, etc.)
+ * ============================================================ */
+static const struct {
+	u16 vid;
+	u16 pid;
+	const char *name;
+} suspicious_ids[] = {
+	{ 0x16c0, 0x27db, "O.MG Cable (classic)" },
+	{ 0x1209, 0xa000, "O.MG Cable (Elite)" },
+	{ 0x16c0, 0x27dc, "USB Rubber Ducky" },
+	{ 0x1b4f, 0x9208, "LilyPad Arduino BadUSB" },
+};
+
+/* ============================================================
+ * Per-device state (allocated on probe, freed on remove)
+ * ============================================================ */
+struct omg_device_state {
+	struct hid_device  *hdev;
+
+	/* --- connection timing --- */
+	ktime_t		connect_time;
+	ktime_t		first_key_time;
+	bool		first_key_seen;
+
+	/* --- keystroke interval circular buffer --- */
+	ktime_t		last_key_time;
+	s64		intervals_us[MAX_TIMING_SAMPLES];
+	unsigned int	sample_count;
+	unsigned int	sample_head;
+
+	/* --- USB info (immutable after probe) --- */
+	u16		vid;
+	u16		pid;
+	const char	*vid_pid_match_name;	/* non-NULL if VID/PID matched */
+	bool		descriptor_anomaly;
+
+	/* --- verdict --- */
+	int		score;
+	bool		alerted;
+
+	spinlock_t	lock;
+};
+
+/* ============================================================
+ * Math helpers
+ * ============================================================ */
+static void timing_stats(struct omg_device_state *s, s64 *mean, s64 *variance)
+{
+	unsigned int i, n;
+	s64 sum = 0, sq = 0, m;
+
+	n = min(s->sample_count, (unsigned int)MAX_TIMING_SAMPLES);
+
+	if (n < 2) {
+		*mean = 0;
+		*variance = 0;
+		return;
+	}
+
+	for (i = 0; i < n; i++)
+		sum += s->intervals_us[i];
+	m = div_s64(sum, n);
+
+	for (i = 0; i < n; i++) {
+		s64 d = s->intervals_us[i] - m;
+
+		sq += d * d;
+	}
+
+	*mean     = m;
+	*variance = div_s64(sq, n);
+}
+
+/* ============================================================
+ * Signal 1: Timing entropy
+ *
+ * Humans: high variance (pauses, rhythm changes)
+ * Machines: low variance (constant clock)
+ *
+ * Also penalises extremely fast consistent typing (mean < 15 ms).
+ * ============================================================ */
+static int score_entropy(struct omg_device_state *s)
+{
+	s64 mean, var;
+	int pts = 0;
+
+	if (s->sample_count < MIN_SAMPLES)
+		return 0;
+
+	timing_stats(s, &mean, &var);
+
+	if (var < (s64)entropy_variance_low)
+		pts += 35;
+	else if (var < (s64)entropy_variance_low * 10)
+		pts += 20;
+	else if (var < (s64)entropy_variance_low * 40)
+		pts += 8;
+
+	if (mean > 0 && mean < 5000)
+		pts += 25;
+	else if (mean > 0 && mean < 15000)
+		pts += 10;
+
+	return min(pts, 60);
+}
+
+/* ============================================================
+ * Signal 2: Plug-and-type
+ *
+ * A legitimate keyboard sits idle for a while after connect.
+ * A script device starts injecting within milliseconds.
+ * ============================================================ */
+static int score_plug_type(struct omg_device_state *s)
+{
+	s64 delta_ms;
+
+	if (!s->first_key_seen)
+		return 0;
+
+	delta_ms = ktime_to_ms(ktime_sub(s->first_key_time, s->connect_time));
+
+	if (delta_ms < 100)
+		return 30;
+	if (delta_ms < (s64)plug_type_ms)
+		return 15;
+	if (delta_ms < 2000)
+		return 5;
+
+	return 0;
+}
+
+/* ============================================================
+ * Signal 3: USB descriptor fingerprint
+ * ============================================================ */
+static int score_descriptor(struct omg_device_state *s)
+{
+	int pts = 0;
+
+	if (s->vid_pid_match_name)
+		pts += 50;
+
+	if (s->descriptor_anomaly)
+		pts += 20;
+
+	return min(pts, 50);
+}
+
+/* ============================================================
+ * Combine all signals and return per-signal breakdown.
+ * Caller is responsible for alerting outside any lock.
+ * ============================================================ */
+struct omg_score_result {
+	int entropy;
+	int plug_type;
+	int descriptor;
+	int total;
+	bool newly_alerted;
+};
+
+static void compute_score(struct omg_device_state *s,
+			   struct omg_score_result *res)
+{
+	res->entropy   = score_entropy(s);
+	res->plug_type = score_plug_type(s);
+	res->descriptor = score_descriptor(s);
+	res->total     = min(res->entropy + res->plug_type + res->descriptor,
+			     100);
+
+	s->score = res->total;
+	res->newly_alerted = false;
+
+	if (res->total >= score_threshold && !s->alerted) {
+		s->alerted = true;
+		res->newly_alerted = true;
+	}
+}
+
+/* Emit alert outside of spinlock */
+static void emit_alert(struct hid_device *hdev,
+		       struct omg_device_state *s,
+		       const struct omg_score_result *res)
+{
+	hid_warn(hdev, "=============================================\n");
+	hid_warn(hdev, "!! SUSPICIOUS HID DEVICE DETECTED !!\n");
+	hid_warn(hdev, "Device : %s\n", hdev->name);
+	hid_warn(hdev, "VID/PID: %04x:%04x\n", s->vid, s->pid);
+	if (s->vid_pid_match_name)
+		hid_warn(hdev, "Match  : %s\n", s->vid_pid_match_name);
+	hid_warn(hdev, "Score  : %d/100  (threshold=%d)\n",
+		 res->total, score_threshold);
+	hid_warn(hdev, "  Entropy      : %d pts\n", res->entropy);
+	hid_warn(hdev, "  Plug-and-type: %d pts\n", res->plug_type);
+	hid_warn(hdev, "  Descriptor   : %d pts\n", res->descriptor);
+	hid_warn(hdev, "Action : sudo usbguard block-device <id>\n");
+	hid_warn(hdev, "=============================================\n");
+}
+
+/* ============================================================
+ * HID raw_event hook — called for every incoming HID report
+ *
+ * This runs in softirq/BH context — no sleeping locks allowed.
+ * ============================================================ */
+static int omg_raw_event(struct hid_device *hdev,
+			 struct hid_report *report,
+			 u8 *data, int size)
+{
+	struct omg_device_state *s = hid_get_drvdata(hdev);
+	struct omg_score_result res;
+	ktime_t now;
+	unsigned long flags;
+	bool keystroke = false;
+	int i;
+
+	if (!s)
+		return 0;
+
+	if (report->type != HID_INPUT_REPORT)
+		return 0;
+
+	/* Byte 0 = modifier, byte 1 = reserved, bytes 2-7 = keycodes */
+	for (i = 2; i < size && i < 8; i++) {
+		if (data[i] != 0) {
+			keystroke = true;
+			break;
+		}
+	}
+	if (size > 0 && data[0] != 0)
+		keystroke = true;
+
+	if (!keystroke)
+		return 0;
+
+	now = ktime_get();
+
+	spin_lock_irqsave(&s->lock, flags);
+
+	if (!s->first_key_seen) {
+		s->first_key_seen = true;
+		s->first_key_time = now;
+		s->last_key_time  = now;
+	} else {
+		s64 interval = ktime_to_us(ktime_sub(now, s->last_key_time));
+
+		/* ignore idle gaps > 10 s */
+		if (interval < 10000000LL) {
+			s->intervals_us[s->sample_head] = interval;
+			s->sample_head =
+				(s->sample_head + 1) % MAX_TIMING_SAMPLES;
+			if (s->sample_count < MAX_TIMING_SAMPLES)
+				s->sample_count++;
+		}
+		s->last_key_time = now;
+	}
+
+	compute_score(s, &res);
+
+	spin_unlock_irqrestore(&s->lock, flags);
+
+	/* Alert outside the spinlock — hid_warn may sleep */
+	if (res.newly_alerted)
+		emit_alert(hdev, s, &res);
+
+	return 0;
+}
+
+/* ============================================================
+ * HID probe — device connected
+ * ============================================================ */
+static int omg_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	struct omg_device_state *s;
+	struct usb_interface *intf;
+	struct usb_device *udev;
+	struct omg_score_result res;
+	int ret, i;
+
+	if (hdev->bus != BUS_USB)
+		return -ENODEV;
+
+	s = kzalloc(sizeof(*s), GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	spin_lock_init(&s->lock);
+	s->hdev         = hdev;
+	s->connect_time = ktime_get();
+
+	/* Extract USB descriptor info */
+	intf = to_usb_interface(hdev->dev.parent);
+	udev = interface_to_usbdev(intf);
+	s->vid = le16_to_cpu(udev->descriptor.idVendor);
+	s->pid = le16_to_cpu(udev->descriptor.idProduct);
+
+	/* Check known bad VID/PID table (once, at probe time) */
+	for (i = 0; i < ARRAY_SIZE(suspicious_ids); i++) {
+		if (s->vid == suspicious_ids[i].vid &&
+		    s->pid == suspicious_ids[i].pid) {
+			s->vid_pid_match_name = suspicious_ids[i].name;
+			break;
+		}
+	}
+
+	/*
+	 * Anomaly: legitimate HID keyboards use bDeviceClass = 0x00
+	 * (class defined at interface level).  Any other value here
+	 * for a device presenting as a keyboard is suspicious.
+	 */
+	s->descriptor_anomaly =
+		(udev->descriptor.bDeviceClass != 0x00 &&
+		 udev->descriptor.bDeviceClass != 0x03);
+
+	hid_set_drvdata(hdev, s);
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "hid_parse failed: %d\n", ret);
+		goto err_free;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		hid_err(hdev, "hid_hw_start failed: %d\n", ret);
+		goto err_free;
+	}
+
+	hid_info(hdev, "Monitoring %s (VID=%04x PID=%04x%s%s)\n",
+		 hdev->name, s->vid, s->pid,
+		 s->vid_pid_match_name ? " KNOWN-BAD:" : "",
+		 s->vid_pid_match_name ? s->vid_pid_match_name : "");
+
+	if (s->descriptor_anomaly)
+		hid_warn(hdev, "Descriptor anomaly: bDeviceClass=0x%02x\n",
+			 udev->descriptor.bDeviceClass);
+
+	/* Run initial descriptor-only score */
+	compute_score(s, &res);
+	if (res.newly_alerted)
+		emit_alert(hdev, s, &res);
+
+	return 0;
+
+err_free:
+	hid_set_drvdata(hdev, NULL);
+	kfree(s);
+	return ret;
+}
+
+/* ============================================================
+ * HID remove — device disconnected
+ * ============================================================ */
+static void omg_remove(struct hid_device *hdev)
+{
+	struct omg_device_state *s = hid_get_drvdata(hdev);
+
+	hid_hw_stop(hdev);
+
+	if (s) {
+		hid_info(hdev, "Removed %s (final score: %d/100)\n",
+			 hdev->name, s->score);
+		hid_set_drvdata(hdev, NULL);
+		kfree(s);
+	}
+}
+
+/* Match all USB HID devices — we inspect and score them all */
+static const struct hid_device_id omg_table[] = {
+	{ HID_USB_DEVICE(HID_ANY_ID, HID_ANY_ID) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, omg_table);
+
+static struct hid_driver omg_driver = {
+	.name      = DRIVER_NAME,
+	.id_table  = omg_table,
+	.probe     = omg_probe,
+	.remove    = omg_remove,
+	.raw_event = omg_raw_event,
+};
+
+module_hid_driver(omg_driver);
