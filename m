Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19373D0907;
	Fri,  3 Apr 2026 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232759; cv=none; b=Sf8UDaUul6aOskGu9MVFSdgpVA7STGVR0WHsjNiOjwO7zZtnMObJS48P9H744K45WkkNnBuDeL9P0WU1bn4aL+6oRVVlqYCZeWy+GeSvwgB0hPaY+BKqm1ZHfkgQR+7wv7iRj2Z0ySEP8GS/31rkfF1K2zE2AMeL27Bky9+drBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232759; c=relaxed/simple;
	bh=+NpVaNfUPwdm9/FI+Cp8m6hZN3QbrQIskvwSo6Dt4Oo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sDZaof+SGmhb9xO8EPXu4so6x5hoNnu6R4oFUummuZTfGwmFKpuCkE6VZA893RzETQdJtKpwj5ymdt+LmYeG7E5uRcP3qWojXQH24FGMpfpu3ZtLEhJE6+zxpbZSMhXfZMyeEyagvSk9pcnDYbgMkNZRTo7M6Hs4SQAjFl1iFq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NA3agHVo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NA3agHVo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14D2C4CEF7;
	Fri,  3 Apr 2026 16:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775232759;
	bh=+NpVaNfUPwdm9/FI+Cp8m6hZN3QbrQIskvwSo6Dt4Oo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NA3agHVoTcct5Dqe0rCzYkukjWesvZMpAgYQJ9gzSQYVp1K8EWfKi+Rqf/E2/Z4xG
	 nYpcYapjE2u8SGZpO6/m2uKYXQUb+8399yW7nBVh5Wdm6bbEVMq+xDZ4McbpFA/zvN
	 1WScEvYaILVZtAjdlzI8gC7ccnmFaDRuJazioTBdGHYOzuy50QXMG5dIWRoukCAhMT
	 csOI1zYejFPYwNZmtxBFLLtqawi0Nua8kGO4kkwvto9zKGPBbOSONNRxFLzGXp3UKa
	 /JvtcFwfpShzBobDvGjp23tGatdgh5DcVqC9fquXlIaPNG9GxFVDQjlB4TADv+NoJ/
	 TDHkXJNF95LqQ==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 03 Apr 2026 18:12:23 +0200
Subject: [PATCH 5/8] hid: bpf: hid_bpf_helpers: add helper for having
 read/write udev properties
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-wip-sync-udev-hid-bpf-2026-04-v1-5-978cedb9a074@kernel.org>
References: <20260403-wip-sync-udev-hid-bpf-2026-04-v1-0-978cedb9a074@kernel.org>
In-Reply-To: <20260403-wip-sync-udev-hid-bpf-2026-04-v1-0-978cedb9a074@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775232750; l=2985;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=+NpVaNfUPwdm9/FI+Cp8m6hZN3QbrQIskvwSo6Dt4Oo=;
 b=A/uLu157cIljepnWw/s3Ylg+TzQxoDh6m9niANlnpFNWtwjRu+CD+co6IJmtFPGiFDWXGU7A3
 apIGPiY7jOmC4tp1lXw0G6AyeG31j8odwsKdsDB6tdZr91FRUqkVLZL
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

We want udev-hid-bpf to be able to set udev properties by printing them
out after the BPF object has been loaded. This allows to make a query to
the device, and set a udev prop based on the answer.

Because the way udev works, the properties are cleared on bind/unbind,
and we need a way to store them. After several attempts to keep the
property alive without re-running the udev-hid-bpf tool to communicate
with the device, it came out that HID-BPF maps are pinned in the bpffs
and we can then query them.

So the following would export a UDEV property in the bpffs:
   EXPORT_UDEV_PROP(HID_FOO, 32);

   SEC("syscall")
   int probe(struct hid_bpf_probe_args *ctx)
   {
     const char *foo = "foo";
     UDEV_PROP_SPRINTF(HID_FOO, "%s", foo);

     return 0;
   }

Then, we can debug it with a simple cat:
   sudo cat /sys/fs/bpf/hid/.../UDEV_PROP_HID_FOO
0: {['f','o','o',],}

This way, the property is always accessible without talking to the
device

Link: https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_requests/220
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/progs/hid_bpf_helpers.h | 38 +++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/hid/bpf/progs/hid_bpf_helpers.h b/drivers/hid/bpf/progs/hid_bpf_helpers.h
index c67facdefff3..0fd8e7d90742 100644
--- a/drivers/hid/bpf/progs/hid_bpf_helpers.h
+++ b/drivers/hid/bpf/progs/hid_bpf_helpers.h
@@ -340,6 +340,44 @@ DEFINE_GUARD(bpf_spin, struct bpf_spin_lock, bpf_spin_lock, bpf_spin_unlock);
 #define hid_bpf_cpu_to_be32(x)	bpf_htonl(x)
 #define hid_bpf_cpu_to_be64(x)	bpf_cpu_to_be64(x)
 
+/*
+ * The following macros are helpers for exporting udev properties:
+ *
+ * EXPORT_UDEV_PROP(name, len) generates:
+ *  - a map with a single element UDEV_PROP_##name, of size len
+ *  - a const global declaration of that len: SIZEOF_##name
+ *
+ * udev_prop_ptr(name) retrieves the data pointer behind the map.
+ *
+ * UDEV_PROP_SPRINTF(name, fmt, ...) writes data into the udev property.
+ *
+ *  Can be used as such:
+ *  EXPORT_UDEV_PROP(HID_FOO, 32);
+ *
+ *  SEC("syscall")
+ *  int probe(struct hid_bpf_probe_args *ctx)
+ *  {
+ *    const char *foo = "foo";
+ *    UDEV_PROP_SPRINTF(HID_FOO, "%s", foo);
+ *
+ *    return 0;
+ *  }
+ */
+#define EXPORT_UDEV_PROP(name, len) \
+	const __u32 SIZEOF_##name = len; \
+	struct COMBINE(udev_prop, __LINE__) { \
+		__uint(type, BPF_MAP_TYPE_ARRAY); \
+		__uint(max_entries, 1); \
+		__type(key, __u32); \
+		__type(value, __u8[len]); \
+	} UDEV_PROP_##name SEC(".maps");
+
+#define udev_prop_ptr(name) \
+	bpf_map_lookup_elem(&UDEV_PROP_##name, &(__u32){0})
+
+#define UDEV_PROP_SPRINTF(name, fmt, ...) \
+	BPF_SNPRINTF(udev_prop_ptr(name), SIZEOF_##name, fmt, ##__VA_ARGS__)
+
 static inline __maybe_unused __u16 field_start_byte(struct hid_rdesc_field *field)
 {
 	return field->bits_start / 8;

-- 
2.53.0

