Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408323CFF4A;
	Fri,  3 Apr 2026 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232755; cv=none; b=rxXvk5YH4a3caiwk63xmqR6T/lF2pGbp1Fa4aLqsQGPpM09CKy2pr6lptvwRjwGP5cEhjIlqtU+R2ao3zmtIIvdVoRqCpjekz+yi4gwVB97MM1QARgxBCzbtGBEuFFNcKCVJj2FrbAx0tnCUOqVUXs9xbXYHrxsfv1QMSGxjHyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232755; c=relaxed/simple;
	bh=nwtt+FcuK5HLjwtaSmiikbjw3Qdf1NxzJRbkXYYA6GM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DfbLvdJlffdnsPOWjE3AW4Un1YWhu00l84ua1rgc8JLxnCBOACsfR1mNWFsy3MIcYIzs51Il0kZ574R88Y9fmqC6vB4Mk6XZrGjcLvkTuXcaZzHTFYmroYayco7T/rJ5M1iMYapQbC5slvI2lg8MoY6KeHobRQjmM1rGfCj7Gu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iD6wOeMY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD6wOeMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 437D5C2BCB0;
	Fri,  3 Apr 2026 16:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775232755;
	bh=nwtt+FcuK5HLjwtaSmiikbjw3Qdf1NxzJRbkXYYA6GM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iD6wOeMYC1bg4sz6kLyGmRYfAPTJDhGo5JWUeesXn6/2siBpvWwDd7lsRFAVE7lYk
	 0L1TihpPfNQBmkhrVHPvZTj9mkMyyLZROXMn9Xsph5zh5X0aTYYm1SRsFzDmInJCaN
	 CD13dZ+RbJVkEbMN2auBIUrgrG4axGzqTR3B0LACTXitII7A8zeRgTYtHQ+LcMocJs
	 3ZyiqAjMD42QepMaoVHJldFld6DH0TBzHd4y4z09Zr2+xrmaFkJiQbjMAjoE/CdFZX
	 EDTAO26Hoy3w3rnOhlhaVZXxe6njXBWXYrPGjGLolj+zbytmWcCy5NHzrWM6E2Fhme
	 VNLmtuqWbqctA==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Fri, 03 Apr 2026 18:12:20 +0200
Subject: [PATCH 2/8] HID: bpf: hid_bpf_helpers: provide a cleanup functions
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-wip-sync-udev-hid-bpf-2026-04-v1-2-978cedb9a074@kernel.org>
References: <20260403-wip-sync-udev-hid-bpf-2026-04-v1-0-978cedb9a074@kernel.org>
In-Reply-To: <20260403-wip-sync-udev-hid-bpf-2026-04-v1-0-978cedb9a074@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775232750; l=5515;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=nwtt+FcuK5HLjwtaSmiikbjw3Qdf1NxzJRbkXYYA6GM=;
 b=b+305jvTJQE6dXGa3nTOwrv0ebGBGLXW67YF/pdV+4IABbwLtSm5Q14/jr/MHnVzq/i4O0t6D
 i9PuJCmuLkKAwpC7Q4e+3Tz81rOIhavS3ZJrIF2n0lzbq9tQGU3K2UE
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

Combination of 2 udev-hid-bpf commits:
bpf: hid_bpf_helpers: provide a cleanup function for hid_bpf_release_context
bpf: helpers: add guard(bpf_spin) macro

Link: https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_requests/221
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/progs/hid_bpf_async.h   | 36 +++++++--------
 drivers/hid/bpf/progs/hid_bpf_helpers.h | 80 +++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/bpf/progs/hid_bpf_async.h b/drivers/hid/bpf/progs/hid_bpf_async.h
index 9ab585434239..877bb7e81f03 100644
--- a/drivers/hid/bpf/progs/hid_bpf_async.h
+++ b/drivers/hid/bpf/progs/hid_bpf_async.h
@@ -116,15 +116,14 @@ static int hid_bpf_async_find_empty_key(void)
 		if (!elem)
 			return -ENOMEM; /* should never happen */
 
-		bpf_spin_lock(&elem->lock);
+		{
+			guard(bpf_spin)(&elem->lock);
 
-		if (elem->state == HID_BPF_ASYNC_STATE_UNSET) {
-			elem->state = HID_BPF_ASYNC_STATE_INITIALIZING;
-			bpf_spin_unlock(&elem->lock);
-			return i;
+			if (elem->state == HID_BPF_ASYNC_STATE_UNSET) {
+				elem->state = HID_BPF_ASYNC_STATE_INITIALIZING;
+				return i;
+			}
 		}
-
-		bpf_spin_unlock(&elem->lock);
 	}
 
 	return -EINVAL;
@@ -175,18 +174,19 @@ static int hid_bpf_async_delayed_call(struct hid_bpf_ctx *hctx, u64 milliseconds
 	if (!elem)
 		return -EINVAL;
 
-	bpf_spin_lock(&elem->lock);
-	/* The wq must be:
-	 * - HID_BPF_ASYNC_STATE_INITIALIZED -> it's been initialized and ready to be called
-	 * - HID_BPF_ASYNC_STATE_RUNNING -> possible re-entry from the wq itself
-	 */
-	if (elem->state != HID_BPF_ASYNC_STATE_INITIALIZED &&
-	    elem->state != HID_BPF_ASYNC_STATE_RUNNING) {
-		bpf_spin_unlock(&elem->lock);
-		return -EINVAL;
+	{
+		guard(bpf_spin)(&elem->lock);
+
+		/* The wq must be:
+		 * - HID_BPF_ASYNC_STATE_INITIALIZED -> it's been initialized and ready to be called
+		 * - HID_BPF_ASYNC_STATE_RUNNING -> possible re-entry from the wq itself
+		 */
+		if (elem->state != HID_BPF_ASYNC_STATE_INITIALIZED &&
+		    elem->state != HID_BPF_ASYNC_STATE_RUNNING)
+			return -EINVAL;
+
+		elem->state = HID_BPF_ASYNC_STATE_STARTING;
 	}
-	elem->state = HID_BPF_ASYNC_STATE_STARTING;
-	bpf_spin_unlock(&elem->lock);
 
 	elem->hid = hctx->hid->id;
 
diff --git a/drivers/hid/bpf/progs/hid_bpf_helpers.h b/drivers/hid/bpf/progs/hid_bpf_helpers.h
index 228f8d787567..5e3ffca1ed7b 100644
--- a/drivers/hid/bpf/progs/hid_bpf_helpers.h
+++ b/drivers/hid/bpf/progs/hid_bpf_helpers.h
@@ -40,6 +40,86 @@ extern int bpf_wq_set_callback(struct bpf_wq *wq,
 #define HID_MAX_DESCRIPTOR_SIZE	4096
 #define HID_IGNORE_EVENT	-1
 
+/**
+ * Use: _cleanup_(somefunction) struct foo *bar;
+ */
+#define _cleanup_(_x) __attribute__((cleanup(_x)))
+
+/**
+ * Use: _release_(foo) *bar;
+ *
+ * This requires foo_releasep() to be present, use DEFINE_RELEASE_CLEANUP_FUNC.
+ */
+#define _release_(_type) struct _type __attribute__((cleanup(_type##_releasep)))
+
+/**
+ * Define a cleanup function for the struct type foo with a matching
+ * foo_release(). Use:
+ * DEFINE_RELEASE_CLEANUP_FUNC(foo)
+ * _unref_(foo) struct foo *bar;
+ */
+#define DEFINE_RELEASE_CLEANUP_FUNC(_type)				\
+	static inline void _type##_releasep(struct _type **_p) {	\
+		if (*_p)						\
+			_type##_release(*_p);				\
+	}								\
+	struct __useless_struct_to_allow_trailing_semicolon__
+
+/* for being able to have a cleanup function */
+#define hid_bpf_ctx_release hid_bpf_release_context
+DEFINE_RELEASE_CLEANUP_FUNC(hid_bpf_ctx);
+
+/*
+ * Kernel-style guard macros adapted for BPF
+ * Based on include/linux/cleanup.h from the Linux kernel
+ *
+ * These provide automatic lock/unlock using __attribute__((cleanup))
+ * similar to how _release_() works for contexts.
+ */
+
+/**
+ * DEFINE_GUARD(name, type, lock, unlock):
+ *	Define a guard for automatic lock/unlock using the same pattern as _release_()
+ *	@name: identifier for the guard (e.g., bpf_spin)
+ *	@type: lock variable type (e.g., struct bpf_spin_lock)
+ *	@lock: lock function name (e.g., bpf_spin_lock)
+ *	@unlock: unlock function name (e.g., bpf_spin_unlock)
+ *
+ * guard(name):
+ *	Declare and lock in one statement - lock held until end of scope
+ *
+ * Example:
+ *	DEFINE_GUARD(bpf_spin, struct bpf_spin_lock, bpf_spin_lock, bpf_spin_unlock)
+ *
+ *	void foo(struct bpf_spin_lock *lock) {
+ *		guard(bpf_spin)(lock);
+ *		// lock held until end of scope
+ *	}
+ */
+
+/* Guard helper struct - stores lock pointer for cleanup */
+#define DEFINE_GUARD(_name, _type, _lock, _unlock)			\
+struct _name##_guard {							\
+	_type *lock;							\
+};									\
+static inline void _name##_guard_cleanup(struct _name##_guard *g) {	\
+	if (g && g->lock) 						\
+		_unlock(g->lock);					\
+}									\
+static inline struct _name##_guard _name##_guard_init(_type *l) {	\
+	if (l)								\
+		_lock(l);						\
+	return (struct _name##_guard){.lock = l};			\
+}									\
+struct __useless_struct_to_allow_trailing_semicolon__
+
+#define guard(_name) \
+	struct _name##_guard COMBINE(guard, __LINE__) __attribute__((cleanup(_name##_guard_cleanup))) = \
+		_name##_guard_init
+
+/* Define BPF spinlock guard */
+DEFINE_GUARD(bpf_spin, struct bpf_spin_lock, bpf_spin_lock, bpf_spin_unlock);
+
 /* extracted from <linux/input.h> */
 #define BUS_ANY			0x00
 #define BUS_PCI			0x01

-- 
2.53.0

