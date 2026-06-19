Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEC831F995
	for <linux-input@vger.kernel.org>; Fri, 19 Jun 2026 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854581; cv=none; b=D0Fl+oU2zm5iRfc8LNOuzpGvbhTTIGMhYEUBY0KBo5IJcaqhsgPdf0mXgN7j4B0LNUzV9eyC/upFvHXJ7HJMGL9p3uHVtu8ydXpbAv+IW1zXlndnAju1zOMpoSVCCBihGFMQRToSDibOjDKZ3fAym7hDelhFzMoaKsMUs//VmxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854581; c=relaxed/simple;
	bh=dMF7ubYW1j5n5hSg6RDtBXpRhjVstRU2yawJ/srD/+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQhJzRTvX+q5oaSqKGDE7pdleqyOKiCbYurUusDYgDQCC8/p+ERYgE4f1TW9WFyAQerWAhoNzX4icZp4REYJGYJ8H2TtCDbXtCcEAdzTGyB/E+3YWaFWRGpiZ5adVx060Ocnz2ZhB52mDHaQVDZcSAPA7wUuisGW7M7oCKUY/PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjaKm9W6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjaKm9W6"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c6c9e02e7dso11517425ad.2
        for <linux-input@vger.kernel.org>; Fri, 19 Jun 2026 00:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781854578; x=1782459378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTPHhG2ig7dh2UeaKPsPz6Mr0hMJ1emlUV2gSrdxNaI=;
        b=MjaKm9W6vfBoWN63FuXazGjeDTjMIb+WYXAkuDyRET+sMGZvp16uBxc3EbtRq9qv2P
         y0FtEgniwhLAgtGpvYBoIEZcaicE2FqLaKm53TmPWrYmPvWedbmj7iKPucUCKvc7Qvey
         LeCQZjUKkeQnEaaHfT8n0gU/hMzv50H4PqNA+LnVOJuELlfbciAeB/UkmnwZT8cP22hF
         hhDa/ar8qvq+jXz77fPrN3fi10mJ00mT7ME3idhnu95d7RnSU337wUtEmmKF5Qkj5DiI
         vmNwg1kPX/ZUr6+WBGZYoUOQ8ArE4iknLi0w3XgOjO6weyQT34RpEMgxKKLk3wSWon13
         KZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781854578; x=1782459378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wTPHhG2ig7dh2UeaKPsPz6Mr0hMJ1emlUV2gSrdxNaI=;
        b=QhFiszxSTiGXW2phPwoclsucTD1Tvj70KWLJJlIAbxAqpr0Vp4mHUaSUb2ZNsKSDxj
         N0ET+XDmNMpIp2lw3sVDmFwa7NGrVlmVRM0w0Pdd1LJP9jifHbH/zUrJ3lJ7FcJKuES4
         EbluHTYdMYNjEbm7CmSiKl59ueZSPwNd1rSu07+dP8s//f4R178CLueQRvcsv7VFKpEy
         kK+3PfyXfSLhjNchaSGrOP7ucocdVy8Gv+jKJtxnOM+wvi+mZ6Req29h6/FkOSjrNMXX
         FofoOXx04tzCcAomgLTIJsS6Lx/UrZi9Lrtrasfq8tEqK+7w/pxTKWBZj3ntlTNF7yfG
         EjqA==
X-Gm-Message-State: AOJu0YxPsxAWa/4pvYgZsHqdTjiHUpKAr0no+3x++KojT2FGiOpbdHlA
	/ktATrikAHBXE0g2sVKH28pfcjku6CwV6KTEdkGdt8lIM+nzqEUMxapw
X-Gm-Gg: AfdE7cnVePnmwXVtlW+Rvzvv1DQa1zMNnCrvloLY72xnWTT4H82bNeSoX2E2qYs51ot
	rOsU7ZyNvmA3Z3PGY8rzrNILuMJLzyCZdKJwBlbtvm7jG46oxixDh3pXlLlJC4WWYmNN+kpXsJe
	6VyGdNUtpT5+jSojSIbXwnD1RyyWr1KD/UTCluUKS90J4N8ipfUSyI/3bKjTitBl6D7FpV/nDxl
	44Yg7nSHsqaJvEKgBZZ/0UqTVXZedPQaBSHOk8LwblimiorX1d4FLZp3XaGOJ4+thntjWvFlPhe
	rtzTjcIaL1IaXTQIS/TBveU8cqfrmEZPrxHuP7v4AaG6z2+BRErZBZ8AgQAkYZZtKZ92g2abRs+
	n7/mpSw8del+MQHNejs7a8EVgJKMZWfCQv4gjYJUwVy7dfJe0OX+fUiTk+RUf6sSlgSyMaCZfv8
	rjncXGHjyD9Y2lQy4/FxF9wyJIpMHRpUvluiwSF+3KwVLLJY4sU9ZhGoSqE9mg5Uw+SODms+m58
	o2X9lIeDpjbjlHjQ/SibJ4geq7NPfa4lyNYk+JD2Y4=
X-Received: by 2002:a17:902:d4ca:b0:2b7:abc0:3bd7 with SMTP id d9443c01a7336-2c718c9b912mr32184005ad.9.1781854577620;
        Fri, 19 Jun 2026 00:36:17 -0700 (PDT)
Received: from arch.localdomain ([2401:4900:1c08:3723:80ea:2614:6e13:5570])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7208e2a45sm13692105ad.32.2026.06.19.00.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 00:36:17 -0700 (PDT)
From: krishgulati7@gmail.com
To: bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jikos@kernel.org,
	Krish Gulati <krishgulati7@gmail.com>
Subject: [RFC PATCH] HID: BPF: add keyboard behavioral anomaly detection
Date: Fri, 19 Jun 2026 13:06:03 +0530
Message-ID: <20260619073607.393248-1-krishgulati7@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <adSxXidgeWF0-Ewn@beelink>
References: <adSxXidgeWF0-Ewn@beelink>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Krish Gulati <krishgulati7@gmail.com>

Implements a HID-BPF struct_ops program that detects behaviorally
anomalous keyboard input consistent with automated HID injection
attacks (USB Rubber Ducky and similar).

This is a direct response to Benjamin Tissoires's recommendation in
the hid-omg-detect review thread [1], where a kernel driver approach
was rejected on the grounds that a HID driver can only bind exclusively
to a device, racing with and displacing the legitimate driver. The
HID-BPF struct_ops approach resolves this: the program attaches
alongside the existing driver, receives the raw event stream before
kernel processing, and never takes exclusive ownership of the device.

Two independent detection signals are implemented:

Post-Enumeration Delay (PED):
  Measures the delta between device connection (recorded at probe()
  time via bpf_ktime_get_ns()) and the first input packet. Legitimate
  users take hundreds of milliseconds to react after plugging in a
  device; injection tools begin transmitting within 25-100ms. Events
  are classified into three bands: SUSPICIOUS (<50ms), WARNING
  (<300ms), and NORMAL (>=300ms). Thresholds are placeholder values
  and MUST be empirically calibrated before production use.

Welford online variance (inter-keystroke timing):
  Tracks keydown-to-keydown intervals per device using Welford's
  single-pass online algorithm. BPF forbids floating-point, so the
  running mean is maintained in fixed-point (scaled by 1024) to
  prevent integer truncation at small counts. Intervals exceeding
  10 seconds are treated as typing-session breaks and excluded from
  the variance calculation. Detection fires after
  HID_GUARD_MIN_SAMPLES (5) samples when variance falls below
  HID_GUARD_VARIANCE_THRESH_MS2 (1600 ms^2), flagging suspiciously
  metronomic timing inconsistent with human input.

Per-device state (Welford accumulators, PED timestamp, report size)
is maintained in a BPF_MAP_TYPE_LRU_HASH keyed by hid->id. The LRU
eviction policy prevents map exhaustion at the cost of two documented
trade-offs: eviction can silently reset Welford history (potential
map-flood attack) and may clear connection_time (PED blindspot on
device re-wake after eviction).

Detection results are currently surfaced via bpf_printk(). A
BPF_MAP_TYPE_RINGBUF interface with configurable userspace daemon
is planned; deferred pending validation of detection heuristics.

Signal design is grounded in: Neuner et al., "USBlock: Blocking
USB-based Keylogger Attacks", DBSec 2018.

[1] https://lore.kernel.org/linux-input/adSxXidgeWF0-Ewn@beelink/

Link: https://lore.kernel.org/linux-input/adSxXidgeWF0-Ewn@beelink/

Signed-off-by: Krish Gulati <krishgulati7@gmail.com>
---
 src/bpf/testing/0010-Generic__keyboard.bpf.c | 285 +++++++++++++++++++
 1 file changed, 285 insertions(+)
 create mode 100644 src/bpf/testing/0010-Generic__keyboard.bpf.c

diff --git a/src/bpf/testing/0010-Generic__keyboard.bpf.c b/src/bpf/testing/0010-Generic__keyboard.bpf.c
new file mode 100644
index 0000000..9114587
--- /dev/null
+++ b/src/bpf/testing/0010-Generic__keyboard.bpf.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "hid_bpf.h"
+#include "hid_bpf_helpers.h"
+#include "hid_report_helpers.h"
+#include "hid_usages.h"
+#include "vmlinux.h"
+#include <bpf/bpf_tracing.h>
+
+#define HID_GUARD_NSEC_PER_MSEC 1000000ULL
+/*
+ * Post-enumeration delay thresholds (raw nanoseconds, matching
+ * connection_time and first_packet_time which are both __u64
+ * bpf_ktime_get_ns() values).
+ *
+ * LIMITATIONS: placeholder values based on rough figures from USB
+ * Rubber Ducky DETECT_READY research (modern hosts HID-ready in
+ * ~25-100ms) versus typical human reaction time after device
+ * connection (hundreds of ms to low seconds). NOT derived from a
+ * controlled study of this specific signal and MUST be empirically
+ * calibrated against real device/host combinations before any
+ * production use. Treat as a tunable, not a validated security
+ * boundary.
+ */
+#define HID_GUARD_PED_SUSPICIOUS_THRESH (50 * HID_GUARD_NSEC_PER_MSEC)
+#define HID_GUARD_PED_WARNING_THRESH (300 * HID_GUARD_NSEC_PER_MSEC)
+
+/*not derived from real typing data yet*/
+#define HID_GUARD_MIN_SAMPLES 5
+
+/*
+ * Variance is "too metronomic
+ * to be a human," expressed in ms^2 so we never need sqrt().
+ */
+#define HID_GUARD_VARIANCE_THRESH_MS2 (40ULL * 40ULL)
+
+/*
+ * Idle gaps this large are treated as a break in the typing session,
+ * not a sample — interval excluded from Welford, timer rebased.
+ * Borrowed threshold from hid-omg-detect (10s); not independently
+ * validated for this signal.
+ */
+#define HID_GUARD_IDLE_GAP_THRESH_MS (10ULL * 1000ULL)
+
+/*
+ * fixed-point factor: BPF has no floating values, so mean is stored as
+ * real_mean * HID_GUARD_WELFORD_SCALE.
+ * Without this, delta/count truncates to 0
+ * as soon as count exceeds the typical delta (in millisecond)
+ */
+#define HID_GUARD_WELFORD_SCALE 1024
+
+enum hid_guard_ped_flag {
+	HID_GUARD_PED_NO_ENTRY = 0,
+	HID_GUARD_PED_SUSPICIOUS = 1,
+	HID_GUARD_PED_WARNING = 2,
+	HID_GUARD_PED_NORMAL = 3,
+};
+
+struct dev_info {
+	__u64 connection_time;
+	__u32 report_size;
+	__u64 prev_report[32];
+	/*welford's variables*/
+	__u64 prev_keydown_ts;
+	__u64 count;
+	__s64 mean;
+	__u64 M2;
+	/*
+	 * unsigned as delta * delta2 is always >= 0
+	 * (as delta2 is delta scaled by the same sign)
+	 */
+};
+
+/*
+ * BPF_MAP_TYPE_LRU_HASH:
+ * Using an LRU map automatically prevents exhaustion by silently evicting
+ * the oldest idle devices. It requires no syntax changes to the rest of the
+ * code (lookup/update helpers work identically), but introduces behavioral
+ * trade-offs:
+ *
+ * 1. Eviction wipes Welford variance history. An attacker
+ *    could theoretically flood the map to flush their device and reset their
+ *    score.
+ * 2. PED Blindspot: Eviction deletes the 'connection_time' set during probe().
+ *    If an evicted device wakes up, it will bypass post-enumeration delay
+ *    checks.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_LRU_HASH);
+	__type(key, __u32);
+	__type(value, struct dev_info);
+	__uint(max_entries, 128);
+} dev_details SEC(".maps");
+
+/*
+ * POST ENUMERATION DELAY
+ *
+ * Computes the delta between the first input packet timestamp and
+ * connection_time (set at probe() time), both raw __u64 nanoseconds
+ * from bpf_ktime_get_ns(). Called once per device, the caller gates
+ * this on connection_time != 0, and this function clears it to 0
+ * afterward so it never runs twice for the same device.
+ *
+ * Returns a hid_guard_ped_flag classifying the delay.
+ */
+static __always_inline enum hid_guard_ped_flag
+post_enumeration_delay(struct dev_info *info, __u64 first_packet_time)
+{
+	__u64 delta;
+
+	if (first_packet_time < info->connection_time)
+		return HID_GUARD_PED_NO_ENTRY;
+
+	delta = first_packet_time - info->connection_time;
+
+	if (delta < HID_GUARD_PED_SUSPICIOUS_THRESH)
+		return HID_GUARD_PED_SUSPICIOUS;
+	if (delta < HID_GUARD_PED_WARNING_THRESH)
+		return HID_GUARD_PED_WARNING;
+
+	return HID_GUARD_PED_NORMAL;
+}
+
+static __always_inline void welford(struct dev_info *dev_state,
+				    __u64 interval_ms)
+{
+	__s64 x = (__s64)interval_ms * HID_GUARD_WELFORD_SCALE;
+	__s64 delta, delta2, delta_abs, signed_div_res;
+	__u64 div_res;
+
+	dev_state->count++;
+	delta = x - dev_state->mean;
+	delta_abs = delta < 0 ? -delta : delta;
+	div_res = (__u64)delta_abs / (__u64)dev_state->count;
+	signed_div_res = delta < 0 ? -(__s64)div_res : (__s64)div_res;
+
+	dev_state->mean += signed_div_res;
+	delta2 = x - dev_state->mean;
+
+	dev_state->M2 += (__u64)(delta * delta2);
+
+	bpf_printk("W[Count:%llu] Int:%llu ms, scaled_x:%lld\n",
+		   dev_state->count, interval_ms, x);
+	bpf_printk("  -> delta1:%lld, mean:%lld\n", delta, dev_state->mean);
+	bpf_printk("  -> delta2:%lld, M2:%llu\n", delta2, dev_state->M2);
+}
+
+HID_BPF_CONFIG(HID_DEVICE(BUS_USB, HID_GROUP_ANY, HID_VID_ANY, HID_PID_ANY),
+	       HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_ANY, HID_VID_ANY,
+			  HID_PID_ANY));
+
+SEC(HID_BPF_DEVICE_EVENT)
+int BPF_PROG(kdb_hook, struct hid_bpf_ctx *hctx)
+{
+	__u32 hid_id = hctx->hid->id;
+
+	struct dev_info *info;
+
+	info = bpf_map_lookup_elem(&dev_details, &hid_id);
+
+	if (!info)
+		return 0;
+
+	__u32 size = info->report_size;
+	__u32 fetch_size;
+	__u8 *data;
+
+	if (size <= 8)
+		fetch_size = 8;
+	else if (size <= 16)
+		fetch_size = 16;
+	else
+		fetch_size = 32;
+
+	data = hid_bpf_get_data(hctx, 0, fetch_size);
+
+	if (!data)
+		return 0;
+	int now_active_ks = 0, was_active_ks = 0;
+#pragma unroll
+	for (int i = 0; i < 32; i++) {
+		if (i >= fetch_size)
+			break;
+		now_active_ks += ((__u8)data[i] + 255) >> 8;
+		was_active_ks += ((__u8)info->prev_report[i] + 255) >> 8;
+
+		info->prev_report[i] = data[i];
+	}
+
+	__u64 current_ms = bpf_ktime_get_ns() / HID_GUARD_NSEC_PER_MSEC;
+
+	if (now_active_ks > was_active_ks) {
+		if (info->prev_keydown_ts != 0) {
+			__u64 interval_ms = current_ms - info->prev_keydown_ts;
+
+			if (interval_ms < HID_GUARD_IDLE_GAP_THRESH_MS) {
+				welford(info, interval_ms);
+			} else {
+				bpf_printk(
+					"hid %d: idle gap %llu ms excluded from sample\n",
+					hid_id, interval_ms);
+			}
+		}
+
+		if (info->count >= HID_GUARD_MIN_SAMPLES) {
+			__u64 variance_m2 =
+				info->M2 /
+				((__u64)HID_GUARD_WELFORD_SCALE *
+				 HID_GUARD_WELFORD_SCALE * (info->count - 1));
+			/*
+			 * the initial interval x was multiplied by HID_GUARD_WELFORD_SCALE, both
+			 * delta and delta2 are also scaled by that factor,
+			 * thus scale^2 in the denominator
+			 */
+			if (variance_m2 < HID_GUARD_VARIANCE_THRESH_MS2) {
+				bpf_printk(
+					"hid %d: Suspeciously regular typing, variance=%llu ms^2\n",
+					hid_id, variance_m2);
+			}
+		}
+
+		info->prev_keydown_ts = current_ms;
+	}
+
+	if (info->connection_time != 0) {
+		enum hid_guard_ped_flag ped_flag =
+			post_enumeration_delay(info, bpf_ktime_get_ns());
+
+		bpf_printk("PED flag for hid %d: %d\n", hid_id, ped_flag);
+
+		/*
+		 * Prevent re-evaluation on subsequent packets for this device
+		 */
+		info->connection_time = 0;
+	}
+	return 0;
+}
+
+HID_BPF_OPS(hook_keyboard) = {
+	.hid_device_event = (void *)kdb_hook,
+};
+
+struct hid_rdesc_descriptor HID_REPORT_DESCRIPTOR;
+
+SEC("syscall")
+int probe(struct hid_bpf_probe_args *ctx)
+{
+	struct hid_rdesc_report *input;
+	struct hid_rdesc_field *field;
+	struct hid_rdesc_collection *col;
+
+	hid_bpf_for_each_input_report(&HID_REPORT_DESCRIPTOR, input) {
+		__u32 size_in_bytes = (input->size_in_bits + 7) / 8;
+
+		bpf_printk("Report size: %d\n", size_in_bytes);
+		if (input->report_id != 0)
+			size_in_bytes += 1;
+
+		bpf_printk("Report size after report_id: %d\n", size_in_bytes);
+
+		hid_bpf_for_each_field(input, field) {
+			hid_bpf_for_each_collection(field, col) {
+				if (col->usage_page ==
+					    HidUsagePage_GenericDesktop &&
+				    col->usage_id == HidUsage_GD_Keyboard) {
+					__u32 key = ctx->hid;
+					struct dev_info info = {
+						.connection_time =
+							bpf_ktime_get_ns(),
+						.count = 0,
+						.report_size = size_in_bytes
+					};
+					bpf_map_update_elem(&dev_details, &key,
+							    &info, BPF_ANY);
+					ctx->retval = 0;
+					return 0;
+				}
+			}
+		}
+	}
+	ctx->retval = -EINVAL;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
--
2.54.0

