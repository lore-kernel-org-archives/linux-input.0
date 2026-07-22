Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8A51F4CB3
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784720934; cv=none; b=TMFPfvqid+xgGNXWbRKew0dcsimmD5E4NC2x41OPFIRZlAwmylfjJA1+IoTsaZDlVQZBvfTVsxvamrfRZP3LcWbV+AJTN9Di99WttrcaFhL6AwHauOZ6pePjTM+TjakfdA+fw/V3RR9isBB0VTQZt+jov+m+bZHZw4X9+h0LZzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784720934; c=relaxed/simple;
	bh=JpQfc1nczgcXGgnDLREsW/nZxzFA+RAgRFf318nS3co=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yu0OnLSrAr1I0EEbfgjB6u+LLn6GYZGT4d7Ou+05LhLRqKOP5jcz+ssm83UWGYv7m49he5MkaBv5vFED5RcRi5kYvIlXaQD98KVXTuwurKAfiVIDP7wElI9R6KQNJC3K9N5hoaH10lB9q3crS4mKpNIfwJwrzK0VNgacOv62aMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDOkRy1z; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDOkRy1z"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so114715045ad.1
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 04:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784720932; x=1785325732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=18jGiFPlhf1Ds42/v0n+tmKyfW0Mfrf15/7SgN0vMA0=;
        b=gDOkRy1zG7GyVpvBSdTu8+C0xcI/BfIkwvMlp9LtaExjS8IdSU/cbHh8do+0FxF7sw
         3iENIwsvZ7Mm6j/A+jXdPc+q8B+Y8yrviRSPZDd1TAnigtpw8zFnkwii64lnSfDH1YzK
         pHUUSmQ7120vJZBMRbBnOWZq1vxUuGlMUxsoa9dgHH8HS0rvLcZ9potkrO0GU8Kw/wwP
         dUTojhHJ/nyQvX8noLq6J8k8BDUpxm6i/PeL10CaFOO/DfDtUtoCIn45QDvUxShqaJKK
         Adybtj3CxxMf1Nsce8/8pZe7djT6yrXcAkFxpESTSaeKlUb81YXpul6+q+4guDMQrbOF
         YhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784720932; x=1785325732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=18jGiFPlhf1Ds42/v0n+tmKyfW0Mfrf15/7SgN0vMA0=;
        b=rvRpD0DKwbsxsSrw2LDf1J52WkbzHLplxhCDXtfcQADRa6rRWphvOENbg+gYwyN+Zk
         rWw+3Ac9lYyZma5h6Or+SG2431S0i8zEoSHSZLtdw93X0GEMVFYk8OQ3Mg0F7gIziE5T
         csDTcO0SdmZfkiCXxgDdTUFULeGB+BHY0zDMtNhHIpKlA8FJKKIWaJHYSqABbP8TvbCx
         VXu6KS3onEHs9UjP0uU8OA96ku9SVPUIFGYvsDF+GyN6UEp57wio94w6b+zj9KfpzyKA
         enoOO31QpCtMj+0efSUPbxUcFGm/Q584rfzORal0yQYTx6anvcIg7g5IGsdW2YXgzOPf
         OtmQ==
X-Gm-Message-State: AOJu0YzOfqDkEh8eSTSh3hb4S5dJaO+GnkPeRdVFD8D0JWFN1Mnz43GW
	0TvdG9pf3mSPUNansPj3OVYPgRHlCiKGJv9fFiEi/5A6dJ57Nf7PFOz4
X-Gm-Gg: AR+sD10HQrkJSXmg2T8Pr/rd6pwBzs0oj38YhQ0ANgx62hY06G/6a1JE0ORRJo3wKU1
	iE3llhh+zRGFoQ67F4Mma5JKyksWRw3I4j+33q0i+Q23ga+/2TG78WDRSjPVcwVp/TwP+tkeXeb
	UYeWtH8aie2MHUlbAm3la/5pLVcAgfNQJBUgQ0hFCuIdDSrFq5qQX8Q7eduD5PIR842+yrbL2Xy
	O6WjXRXgon973Dsn+Tjay3e2lCAmTqDgLxwCTShmFyd1Q0g0BU7UMvvw+YmwgKjOZUIRU0GLNFs
	OM9gA9JkF3n21UBiz9r3hY+mYBq54wxlQ1j8pciWjCZOF5qBXy/UNY7twT8UBf9LTiQV7ggnKSf
	6rUI2VRCLzwvtK2P+bJLM3kXakkTR0Z1glboyXTiaBEXL1ajqoKKsKUVLWM0dMu5cY+QRnJjuIO
	mJtJ+FUx7KrxzDLvrFYW4daG7rwdIS5YPK7/ZzhVtgyP65S8t2sgWBhFvwh2zhKUBfxb4fqxKp8
	/JYTLwBRpuyGGyy/h2sxQc5/hdI5Yds
X-Received: by 2002:a05:6a20:918f:b0:3bf:6c08:fba2 with SMTP id adf61e73a8af0-3c3ad97433dmr24766720637.54.1784720931773;
        Wed, 22 Jul 2026 04:48:51 -0700 (PDT)
Received: from arch.localdomain ([2401:4900:aa0a:a19b:cc5:dff3:7624:9d93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc1b99esm9030939eec.3.2026.07.22.04.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 04:48:51 -0700 (PDT)
From: Krish Gulati <krishgulati7@gmail.com>
To: bentiss@kernel.org,
	jikos@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	krishgulati7@gmail.com
Subject: [PATCH RFC v2 RESEND] HID: BPF: add keyboard behavioral anomaly detection
Date: Wed, 22 Jul 2026 17:18:43 +0530
Message-ID: <20260722114845.156183-1-krishgulati7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch implements a HID-BPF struct_ops program that detects automated
HID injection attacks. It does this by measuring post-enumeration delay
and tracking inter-keystroke timing using Welford's online variance algorithm.
State is stored in a hash map keyed by the HID ID.

Detection results are currently surfaced via bpf_printk(). A
BPF_MAP_TYPE_RINGBUF interface with configurable userspace daemon
is planned; deferred pending validation of detection heuristics.

Signal design is grounded in: Neuner et al., "USBlock: Blocking
USB-based Keylogger Attacks", DBSec 2018.

Link: https://lore.kernel.org/linux-input/adSxXidgeWF0-Ewn@beelink/

Signed-off-by: Krish Gulati <krishgulati7@gmail.com>
Suggested-by: Sashiko-bot <sashiko-bot@kernel.org>
---
Changes since v1:
- Added bpf_spin_lock/unlock around the Welford compound update in
  kbd_hook() to close a data race on concurrent execution (was
  lockless read-modify-write).
- Switched dev_details from LRU_HASH to plain HASH so eviction
  under map pressure fails the insert instead of silently
  displacing an existing tracked device.
- Store report_id in dev_info and gate kbd_hook() on it, so
  composite devices no longer misattribute other report types'
  bytes as keystrokes.
- Zero dev_info with __builtin_memset before populating in probe()
  to satisfy the verifier's stack-init tracking (was relying on a
  partial designated initializer).
- Replaced active-byte-count heuristic with bytewise diff/mask
  (standard_boot_keypress/nkro_keypress) so consecutive keystrokes
  without an intervening empty report are still detected.
- Verified bucket-size rounding (8/16/32/64) does not drop events
  or read out-of-bounds, tested via hid-replay with synthetic
  report sizes (9, 14 bytes, etc.).

Known limitations, not addressed in this version:
- No cleanup on device disconnect: hid_bpf_ops has no disconnect
  hook, so dev_details entries persist until the map fills.
  Deferred pending maintainer guidance on the right approach.
- find_keyboard_field() returns on the first Keyboard-typed
  (GenericDesktop/Keyboard) Application Collection found; a device
  with multiple such collections within a single report descriptor
  (as opposed to multiple HID interfaces, which are already handled
  correctly and verified on real composite hardware) will only have
  the first one tracked. Untested; the only hardware available for
  testing exhibits the multiple-interface pattern rather than the
  single-descriptor multi-collection pattern, so this path has not
  been exercised.

Resending as a top-level thread (v2 was sent as a reply to v1 on July 9).
Original thread: https://lore.kernel.org/linux-input/20260709104958.38303-1-krishgulati7@gmail.com

 src/bpf/testing/0010-Generic__keyboard.bpf.c | 311 +++++++++++++------
 src/bpf/testing/meson.build                  |   1 +
 2 files changed, 217 insertions(+), 95 deletions(-)

diff --git a/src/bpf/testing/0010-Generic__keyboard.bpf.c b/src/bpf/testing/0010-Generic__keyboard.bpf.c
index 9114587..c3f2364 100644
--- a/src/bpf/testing/0010-Generic__keyboard.bpf.c
+++ b/src/bpf/testing/0010-Generic__keyboard.bpf.c
@@ -24,11 +24,11 @@
 #define HID_GUARD_PED_SUSPICIOUS_THRESH (50 * HID_GUARD_NSEC_PER_MSEC)
 #define HID_GUARD_PED_WARNING_THRESH (300 * HID_GUARD_NSEC_PER_MSEC)

-/*not derived from real typing data yet*/
+/*not derived from real typing raw_buffer yet*/
 #define HID_GUARD_MIN_SAMPLES 5

 /*
- * Variance is "too metronomic
+ * Variance is "too metronomic"
  * to be a human," expressed in ms^2 so we never need sqrt().
  */
 #define HID_GUARD_VARIANCE_THRESH_MS2 (40ULL * 40ULL)
@@ -57,9 +57,17 @@ enum hid_guard_ped_flag {
 };

 struct dev_info {
-	__u64 connection_time;
+	struct bpf_spin_lock lock;
+	__u8 report_id;
+	__u8 field_type;
+	__u8 prev_report[64];
+	__u16 bits_start;
+	__u16 bits_end;
+	__u16 usage_id;
 	__u32 report_size;
-	__u64 prev_report[32];
+	__u32 keyboard_offset;
+	__u64 connection_time;
+	__u64 raw_buffer_length;
 	/*welford's variables*/
 	__u64 prev_keydown_ts;
 	__u64 count;
@@ -71,22 +79,8 @@ struct dev_info {
 	 */
 };

-/*
- * BPF_MAP_TYPE_LRU_HASH:
- * Using an LRU map automatically prevents exhaustion by silently evicting
- * the oldest idle devices. It requires no syntax changes to the rest of the
- * code (lookup/update helpers work identically), but introduces behavioral
- * trade-offs:
- *
- * 1. Eviction wipes Welford variance history. An attacker
- *    could theoretically flood the map to flush their device and reset their
- *    score.
- * 2. PED Blindspot: Eviction deletes the 'connection_time' set during probe().
- *    If an evicted device wakes up, it will bypass post-enumeration delay
- *    checks.
- */
 struct {
-	__uint(type, BPF_MAP_TYPE_LRU_HASH);
+	__uint(type, BPF_MAP_TYPE_HASH);
 	__type(key, __u32);
 	__type(value, struct dev_info);
 	__uint(max_entries, 128);
@@ -138,11 +132,29 @@ static __always_inline void welford(struct dev_info *dev_state,
 	delta2 = x - dev_state->mean;

 	dev_state->M2 += (__u64)(delta * delta2);
+}

-	bpf_printk("W[Count:%llu] Int:%llu ms, scaled_x:%lld\n",
-		   dev_state->count, interval_ms, x);
-	bpf_printk("  -> delta1:%lld, mean:%lld\n", delta, dev_state->mean);
-	bpf_printk("  -> delta2:%lld, M2:%llu\n", delta2, dev_state->M2);
+static __always_inline bool standard_boot_keypress(__u8 *current_report,
+						   __u8 *prev_report)
+{
+	for (int i = 2; i < 8; i++) {
+		if (current_report[i] != prev_report[i])
+			return 1;
+	}
+	return 0;
+}
+
+static __always_inline bool
+nkro_keypress(__u8 *current_report, __u8 *prev_report, __u64 buffer_length)
+{
+	for (int i = 0; i < 64; i++) {
+		if (i >= buffer_length)
+			break;
+
+		if (current_report[i] & ~prev_report[i])
+			return 1;
+	}
+	return 0;
 }

 HID_BPF_CONFIG(HID_DEVICE(BUS_USB, HID_GROUP_ANY, HID_VID_ANY, HID_PID_ANY),
@@ -150,7 +162,7 @@ HID_BPF_CONFIG(HID_DEVICE(BUS_USB, HID_GROUP_ANY, HID_VID_ANY, HID_PID_ANY),
 			  HID_PID_ANY));

 SEC(HID_BPF_DEVICE_EVENT)
-int BPF_PROG(kdb_hook, struct hid_bpf_ctx *hctx)
+int BPF_PROG(kbd_hook, struct hid_bpf_ctx *hctx)
 {
 	__u32 hid_id = hctx->hid->id;

@@ -161,124 +173,233 @@ int BPF_PROG(kdb_hook, struct hid_bpf_ctx *hctx)
 	if (!info)
 		return 0;

-	__u32 size = info->report_size;
-	__u32 fetch_size;
-	__u8 *data;
+	__u8 *raw_buffer;

-	if (size <= 8)
-		fetch_size = 8;
-	else if (size <= 16)
-		fetch_size = 16;
-	else
-		fetch_size = 32;
+	__u8 *report_id_data = hid_bpf_get_data(hctx, 0, 1);

-	data = hid_bpf_get_data(hctx, 0, fetch_size);
+	if (!report_id_data)
+		return 0;

-	if (!data)
+	if (info->report_id != 0 && report_id_data[0] != info->report_id)
 		return 0;
-	int now_active_ks = 0, was_active_ks = 0;
-#pragma unroll
-	for (int i = 0; i < 32; i++) {
-		if (i >= fetch_size)
-			break;
-		now_active_ks += ((__u8)data[i] + 255) >> 8;
-		was_active_ks += ((__u8)info->prev_report[i] + 255) >> 8;

-		info->prev_report[i] = data[i];
+	__u32 offset = info->keyboard_offset + (info->report_id != 0 ? 1 : 0);
+
+	__u64 buffer_length = info->raw_buffer_length;
+
+	if (buffer_length <= 8)
+		raw_buffer = hid_bpf_get_data(hctx, offset, 8);
+	else if (buffer_length <= 16)
+		raw_buffer = hid_bpf_get_data(hctx, offset, 16);
+	else if (buffer_length <= 32)
+		raw_buffer = hid_bpf_get_data(hctx, offset, 32);
+	else
+		raw_buffer = hid_bpf_get_data(hctx, offset, 64);
+
+	if (!raw_buffer)
+		return 0;
+
+	bool new_key_pressed = false;
+
+	if (info->report_id == 0) {
+		new_key_pressed =
+			standard_boot_keypress(raw_buffer, info->prev_report);
+	} else {
+		new_key_pressed = nkro_keypress(raw_buffer, info->prev_report,
+						buffer_length);
 	}

-	__u64 current_ms = bpf_ktime_get_ns() / HID_GUARD_NSEC_PER_MSEC;
+	__u64 now = bpf_ktime_get_ns();

-	if (now_active_ks > was_active_ks) {
+	__u64 interval_ms = 0;
+	__u64 variance_m2 = 0;
+	bool is_idle_gap = false;
+	bool is_suspicious = false;
+	enum hid_guard_ped_flag ped_flag = HID_GUARD_PED_NO_ENTRY;
+	bool run_ped = false;
+
+	bpf_spin_lock(&info->lock);
+
+	if (new_key_pressed) {
 		if (info->prev_keydown_ts != 0) {
-			__u64 interval_ms = current_ms - info->prev_keydown_ts;
+			interval_ms = (now - info->prev_keydown_ts) /
+				      HID_GUARD_NSEC_PER_MSEC;

-			if (interval_ms < HID_GUARD_IDLE_GAP_THRESH_MS) {
+			if (interval_ms < HID_GUARD_IDLE_GAP_THRESH_MS)
 				welford(info, interval_ms);
-			} else {
-				bpf_printk(
-					"hid %d: idle gap %llu ms excluded from sample\n",
-					hid_id, interval_ms);
-			}
+			else
+				is_idle_gap = true;
 		}

+		/*
+		 * Variance check runs after welford() so the current
+		 * sample is already folded in before we decide.
+		 * Guard on MIN_SAMPLES: Welford's unbiased estimator
+		 * (M2 / (count - 1)) is undefined for count < 2, and
+		 * unreliable until a few samples have accumulated.
+		 */
 		if (info->count >= HID_GUARD_MIN_SAMPLES) {
-			__u64 variance_m2 =
+			variance_m2 =
 				info->M2 /
 				((__u64)HID_GUARD_WELFORD_SCALE *
 				 HID_GUARD_WELFORD_SCALE * (info->count - 1));
-			/*
-			 * the initial interval x was multiplied by HID_GUARD_WELFORD_SCALE, both
-			 * delta and delta2 are also scaled by that factor,
-			 * thus scale^2 in the denominator
-			 */
-			if (variance_m2 < HID_GUARD_VARIANCE_THRESH_MS2) {
-				bpf_printk(
-					"hid %d: Suspeciously regular typing, variance=%llu ms^2\n",
-					hid_id, variance_m2);
-			}
+			if (variance_m2 < HID_GUARD_VARIANCE_THRESH_MS2)
+				is_suspicious = true;
 		}

-		info->prev_keydown_ts = current_ms;
+		info->prev_keydown_ts = now;
 	}

-	if (info->connection_time != 0) {
-		enum hid_guard_ped_flag ped_flag =
-			post_enumeration_delay(info, bpf_ktime_get_ns());
-
-		bpf_printk("PED flag for hid %d: %d\n", hid_id, ped_flag);
+	for (int i = 0; i < 64; i++) {
+		if (i >= buffer_length)
+			break;
+		info->prev_report[i] = raw_buffer[i];
+	}

-		/*
-		 * Prevent re-evaluation on subsequent packets for this device
-		 */
+	/*
+	 * PED: fires exactly once per device lifetime. connection_time
+	 * is set at probe() time; we clear it here so subsequent events
+	 * skip this branch entirely.
+	 */
+	if (info->connection_time != 0) {
+		ped_flag = post_enumeration_delay(info, now);
 		info->connection_time = 0;
+		run_ped = true;
 	}
+
+	bpf_spin_unlock(&info->lock);
+
+	if (new_key_pressed) {
+		if (is_idle_gap)
+			bpf_printk(
+				"hid %d: idle gap %llu ms excluded from sample\n",
+				hid_id, interval_ms);
+		if (is_suspicious)
+			bpf_printk(
+				"hid %d: suspiciously regular typing, variance=%llu ms^2\n",
+				hid_id, variance_m2);
+	}
+
+	if (run_ped)
+		bpf_printk("hid %d: PED flag=%d\n", hid_id, ped_flag);
+
 	return 0;
 }

 HID_BPF_OPS(hook_keyboard) = {
-	.hid_device_event = (void *)kdb_hook,
+	.hid_device_event = (void *)kbd_hook,
 };

 struct hid_rdesc_descriptor HID_REPORT_DESCRIPTOR;

-SEC("syscall")
-int probe(struct hid_bpf_probe_args *ctx)
+static __always_inline bool find_keyboard_field(__u16 *bits_start,
+						__u16 *bits_end,
+						__u8 *report_id,
+						__u32 *size_in_bytes)
 {
 	struct hid_rdesc_report *input;
 	struct hid_rdesc_field *field;
 	struct hid_rdesc_collection *col;

 	hid_bpf_for_each_input_report(&HID_REPORT_DESCRIPTOR, input) {
-		__u32 size_in_bytes = (input->size_in_bits + 7) / 8;
-
-		bpf_printk("Report size: %d\n", size_in_bytes);
-		if (input->report_id != 0)
-			size_in_bytes += 1;
-
-		bpf_printk("Report size after report_id: %d\n", size_in_bytes);
-
 		hid_bpf_for_each_field(input, field) {
 			hid_bpf_for_each_collection(field, col) {
 				if (col->usage_page ==
 					    HidUsagePage_GenericDesktop &&
 				    col->usage_id == HidUsage_GD_Keyboard) {
-					__u32 key = ctx->hid;
-					struct dev_info info = {
-						.connection_time =
-							bpf_ktime_get_ns(),
-						.count = 0,
-						.report_size = size_in_bytes
-					};
-					bpf_map_update_elem(&dev_details, &key,
-							    &info, BPF_ANY);
-					ctx->retval = 0;
-					return 0;
+					*size_in_bytes =
+						input->size_in_bits / 8;
+
+					if (input->report_id != 0)
+						*size_in_bytes += 1;
+
+					*bits_start = field->bits_start;
+					*bits_end = field->bits_end;
+					*report_id = input->report_id;
+					return true;
 				}
 			}
 		}
 	}
-	ctx->retval = -EINVAL;
+	return false;
+}
+
+SEC("syscall")
+int probe(struct hid_bpf_probe_args *ctx)
+{
+	__u8 report_id;
+	__u16 bits_start, bits_end;
+	__u32 size_in_bytes;
+	__u32 hid_id = ctx->hid;
+
+	struct dev_info *existing_info =
+		bpf_map_lookup_elem(&dev_details, &hid_id);
+
+	struct dev_info info;
+
+	__builtin_memset(&info, 0, sizeof(info));
+
+	if (!find_keyboard_field(&bits_start, &bits_end, &report_id,
+				 &size_in_bytes)) {
+		ctx->retval = -EINVAL;
+		return 0;
+	}
+
+	if (existing_info != NULL) {
+		__u64 now = bpf_ktime_get_ns();
+
+		bpf_spin_lock(&existing_info->lock);
+
+		existing_info->connection_time = now;
+
+		existing_info->bits_start = bits_start;
+		existing_info->bits_end = bits_end;
+		existing_info->keyboard_offset = bits_start / 8;
+		existing_info->report_size = size_in_bytes;
+
+		if (existing_info->keyboard_offset >
+		    existing_info->report_size) {
+			bpf_spin_unlock(&existing_info->lock);
+			ctx->retval = -EINVAL;
+			return 0;
+		}
+
+		existing_info->report_id = report_id;
+		existing_info->raw_buffer_length =
+			existing_info->report_size -
+			(existing_info->keyboard_offset -
+			 (report_id != 0 ? 1 : 0));
+
+		existing_info->count = 0;
+		existing_info->mean = 0;
+		existing_info->M2 = 0;
+		existing_info->prev_keydown_ts = 0;
+
+		__builtin_memset(existing_info->prev_report, 0,
+				 sizeof(existing_info->prev_report));
+
+		bpf_spin_unlock(&existing_info->lock);
+		ctx->retval = 0;
+		return 0;
+	}
+
+	info.connection_time = bpf_ktime_get_ns();
+	info.bits_start = bits_start;
+	info.bits_end = bits_end;
+	info.keyboard_offset = bits_start / 8;
+	info.report_size = size_in_bytes;
+
+	if (info.keyboard_offset > info.report_size) {
+		ctx->retval = -EINVAL;
+		return 0;
+	}
+
+	info.report_id = report_id;
+	info.raw_buffer_length = info.report_size - (info.keyboard_offset -
+						     (report_id != 0 ? 1 : 0));
+
+	bpf_map_update_elem(&dev_details, &hid_id, &info, BPF_NOEXIST);
+	ctx->retval = 0;
 	return 0;
 }

diff --git a/src/bpf/testing/meson.build b/src/bpf/testing/meson.build
index 9d1b5d3..2586aea 100644
--- a/src/bpf/testing/meson.build
+++ b/src/bpf/testing/meson.build
@@ -11,6 +11,7 @@ tracing_sources = [
 # 'sources' are BPF programs only compatible with
 # struct_ops (kernel v6.11+)
 sources = [
+    '0010-Generic__keyboard.bpf.c',
 ]

 foreach bpf: tracing_sources
--
2.55.0

