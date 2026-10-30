Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336343;
	b=GMgQAwuC5gJXqLJODgZdWHCRn6a26RP2F4F/Mh+uyyGQA8F+9OUOL5RjT3z/LBuL+UM1
	 B7VVwNI92d2DpS7/xJFjAqXuulPWiW2hytKLxb3KHB8aX9F+rrIylID+JN+MAvRfIL1/Z
	 uW+NIbxhrNlQdsykSf1osIbYUio68XxDF60MCA+ilhCz9RpuZTGV5JypZQW4Ze6EN4YZD
	 oq8+FtpINsq0U/1qtJyrke+SmSu1F03+DyFUng+hQqMzVrjubCcsyJMI6HKMRJ4x0TeLV
	 FpGxrwD4CIlSK8evC8TiwHhlbgfxJsUFIMIry1rJi5+QCYcH2R/1CM26WzB1anqUfEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UNGSjv4o0HBU90AGH4xcc6Zl05pH//0mf5MeXFB8Jaw=;
	b=fgr/x+lA1HyKeqzdFrjMy6w6LYY+nFltR0vryKps3L4fHLd8zUCjffIEjPBxy154XfuB
	 IMTXaoAcOUadjI1nAQFNASjTd42zjohd8i2ZAbPG+FnwsWGioBZbAZP/xns1iY2f0kxYi
	 DYnJyiv7vuRHZe3HzCPZ/0Lk6fJEBVNQHEaQIeVs4xmokKtHAycMF+0Bq8y0fjFv5CzB6
	 lDA/RAHunr63BBjxo5AyzKFjoYW9pAi8U/f1s12kjfTiPtLqQFZbmK37e1N5/zpRDsVx7
	 pPcjAA3uyzKhx6FesHVWFN+Tkb+WZsylm1rPlc3/ynz0fFrObo1WRUxBM1ZJZtptZRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xrAOp1qP;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F35606A324
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 04:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39F35606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xrAOp1qP
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1a8cc11ac42so228863c88.0
        for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 21:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793336342; x=1793941142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UNGSjv4o0HBU90AGH4xcc6Zl05pH//0mf5MeXFB8Jaw=;
        b=xrAOp1qPKlvoxGyQvxvlheyc6cfA4GHBcmhtRsZJFPhdacmU6ByarJ7Slxy/FTx4ml
         5rYXuUJWqoR7naE4UE94dZhfp5ue5fRa3MsZX9OqYvneQiXaAX74t5mVzON2v2awvGQ6
         wZbJA2ggXi/OHEiUpMldCt5bRaMvAlKUzkGB0W/7Z3QJLnbv3so3IPDizv3SpKBLSMBa
         XUxMi95iqvRNC7owPZngx7LprYHUJb0N0mM0m8WI0VWt5dyPOAZC+SzL5RnQMLiDTRD6
         ovJEdbCMSVKzOlY47EILQF/oBnDeFKlPfwEvhffHysK4Ij/DOBupcNfVLbbLpodGiWo0
         i9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793336342; x=1793941142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UNGSjv4o0HBU90AGH4xcc6Zl05pH//0mf5MeXFB8Jaw=;
        b=RQdxYVbCQRpxo0zpOiAY4q5tGjC/eZ9u+DUVuTDJpLBHsT+MFwO8aDSSWkV2MLC+c5
         A60JzkFVSmgVAPIBpxjVBzBssDt3y6vGX2dmv1ECucOrTCR3MsLdK72qvOrRL8sQ+IUe
         2lEE+xzf9XIw/BVKXOsWkpYl7TthKeqj97fLMWk85DXhMWxtQG49pYp0sTdMosL3VgcO
         IrW3Yk5XHDF0sFsbvH9zNfr41lT4oGCuTHV8bU2mG8orDBGzHIP2FwGqNzuMUmm70usJ
         Fuxopvwyv9ahbv2ghNvfmFg08p43WFXiJ20Tc1MjkwtLCUQoftOOaB/jVn/5Ff1V/zwL
         EeFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxXczZLAtVAAy148xXJbCMYOVy5c/QWGt+3HBLBkd2CnlipMu0meeSdSSlWggeezp8BUIyxzWEFjZyZ6A==@vger.kernel.org
X-Gm-Message-State: AFq9FYL4eFKDrbR2Py2pTGNWgl6eXhChDrj4NHYv6ytpN4C9iGp66OPy
	Dw9Rh8bLZDABSLKSNskof2xpfrV7ucVv0rhlMeNXHylHG1EI38mEeY7W
X-Gm-Gg: AYBFou0ODvZsIDzbjoFtNsDHy9hun7UFNAB/S/GDiCXVsxo/rC/zeaMdIovy9M6M82+
	oSSYZF74uS78I4FzfvHjeLGAvrrncM7SWoNusSwMYZCHTdbB4NEw4DnNM+wxLlm2tQsy1f+gDep
	g8XLkvnK5BqDSQGZLeBZw2KwuKtJ+kZ8nRY3HrS99BSGXyR5vdYANBl0odxXvU7Juto5gsOXy8Z
	njfgqfyIK+je6HRSVNrpFfBAf0QUWVR5Qx2jk1Gfjb0YaDvduP4fXmyfcVxojB7Fl3Ic9W4Y3H6
	R+supoyeTKI7eI3kqEVojBuXx4i7FtThFsQikkb4QZcOq9am8t7qZdkVeUQITMttqanc5GZvu3I
	yZTtTR7+BkrylASo944iXwwz/9U0amd6pw7ziapg0SVoawjTiV4IHppHIjHdeNZe+ck46qqSzFN
	cNvPuKoCfzxTyVR+7fAD/DBCHOu2nn0j72625fk9j0m1WXatgrd1/YikD9QG57rRiJm+DKSr2pO
	yzR2wxKxJhOs8x3yoKp8X9TCP+wPamP4XrEMJcolJeqLvbmjRrUu2kq1D1FghjibcG2gA8BQdN/
	qkK6YtTZfAJq+XiN9rISij/DGQ93D8M1F34dltSv8j1nKA==
X-Received: by 2002:a05:701b:4646:b0:157:cbf6:89c4 with SMTP id a92af1059eb24-1ac5eea3b63mr1661179c88.26.1793336342381;
        Thu, 29 Oct 2026 21:59:02 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm3433152c88.8.2026.10.29.21.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:59:02 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: dmitry.torokhov@gmail.com,
	mathieu.poirier@linaro.org,
	linux-serial@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: [PATCH v4 1/2] tty: sysrq: don't expose a partially written reset_seq
Date: Fri, 30 Oct 2026 12:58:53 +0800
Message-ID: <20261030045854.153556-2-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030045854.153556-1-zhanxusheng1024@gmail.com>
References: <20261030045854.153556-1-zhanxusheng1024@gmail.com>
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

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

reset_seq is a module_param_array, so param_array() builds it up one
element at a time: it resets the element count, then for each element
calls sysrq_reset_seq_param_set(), which stores the key and bumps
sysrq_reset_seq_version, and afterwards increments the count.  Every
intermediate step is a self-consistent sequence carrying a fresh version,
and sysrq_handle_keypress() reparses as soon as the version moves, so
writing 56,29,111 publishes a one-key sequence and then a two-key one
before the intended three-key one.

A key event that lands on the one-key state gives the device a one-key
sequence, and because the parse runs before set_bit(code, key_down) the
count is still 0 and reset_canceled is false.  The same event then reaches
sysrq_detect_reset_sequence(), where ++reset_seq_cnt matches reset_seq_len
and sysrq_handle_reset_request() runs; sysrq_reset_downtime_ms defaults to
0, so sysrq_do_reset() calls orderly_reboot() straight away.  Writing the
parameter needs root and the key has to be the first one of the new
sequence, but an administrator who presses that key while reconfiguring
the sequence reboots the machine.

Today this needs a device that has not parsed a sequence yet, because
reset_seq_len only ever grows.  The next patch resets it on every reparse,
which without this one would expose every device.

Parse the whole parameter in one callback and replace the sequence under
a seqlock.  The reader copies it out under raw_seqcount_try_begin(), as
it runs from the input event path with interrupts disabled, and keeps
its current sequence if a writer got in the way.  It is a seqlock rather
than a bare seqcount because writers were not serialised either:
sysrq_of_get_keyreset_config() stores the sequence from the kernel.sysrq
sysctl without the module parameter lock.

Behaviour changes:
 - A key of 0 is rejected instead of silently ending the sequence there.
 - A write that fails partway keeps the previous sequence.
 - An element longer than seven characters, such as a zero-padded hex
   value, is rejected.

Fixes: 154b7a489a5b ("Input: sysrq - allow specifying alternate reset sequence")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 drivers/tty/sysrq.c | 133 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 99 insertions(+), 34 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index f4571d05b496..f9d63b45f859 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -39,6 +39,7 @@
 #include <linux/writeback.h>
 #include <linux/swap.h>
 #include <linux/spinlock.h>
+#include <linux/seqlock.h>
 #include <linux/vt_kern.h>
 #include <linux/workqueue.h>
 #include <linux/hrtimer.h>
@@ -675,39 +676,68 @@ struct sysrq_state {
 	unsigned long reset_keybit[BITS_TO_LONGS(KEY_CNT)];
 	int reset_seq_len;
 	int reset_seq_cnt;
-	int reset_seq_version;
+	unsigned int reset_seq_version;
 	struct timer_list keyreset_timer;
 };
 
 #define SYSRQ_KEY_RESET_MAX	20 /* Should be plenty */
 static unsigned short sysrq_reset_seq[SYSRQ_KEY_RESET_MAX];
 static unsigned int sysrq_reset_seq_len;
-static unsigned int sysrq_reset_seq_version = 1;
+static DEFINE_SEQLOCK(sysrq_reset_seq_lock);
+
+/*
+ * Replace the sequence in one go.  The seqlock serialises writers against
+ * each other and lets sysrq_parse_reset_sequence() tell a complete
+ * sequence from one that is being replaced.
+ */
+static void sysrq_publish_reset_seq(const unsigned short *keys,
+				    unsigned int len)
+{
+	write_seqlock(&sysrq_reset_seq_lock);
+	memcpy(sysrq_reset_seq, keys, len * sizeof(*keys));
+	sysrq_reset_seq_len = len;
+	write_sequnlock(&sysrq_reset_seq_lock);
+}
 
 static void sysrq_parse_reset_sequence(struct sysrq_state *state)
 {
-	int i;
-	unsigned short key;
+	unsigned short keys[SYSRQ_KEY_RESET_MAX];
+	unsigned int seq, len, i;
 
-	state->reset_seq_cnt = 0;
+	/*
+	 * This runs from the input event path with interrupts disabled, so
+	 * it must not wait for a writer.  If one is active, or finishes
+	 * while the copy is being made, keep the sequence the device
+	 * already has and try again on the next key event.
+	 */
+	if (!raw_seqcount_try_begin(&sysrq_reset_seq_lock.seqcount, seq))
+		return;
 
-	for (i = 0; i < sysrq_reset_seq_len; i++) {
-		key = sysrq_reset_seq[i];
+	if (state->reset_seq_version == seq)
+		return;
 
-		if (key == KEY_RESERVED || key > KEY_MAX)
-			break;
+	len = sysrq_reset_seq_len;
+	if (len > SYSRQ_KEY_RESET_MAX)
+		return;
+	memcpy(keys, sysrq_reset_seq, len * sizeof(keys[0]));
 
-		__set_bit(key, state->reset_keybit);
+	if (read_seqcount_retry(&sysrq_reset_seq_lock.seqcount, seq))
+		return;
+
+	state->reset_seq_cnt = 0;
+
+	for (i = 0; i < len; i++) {
+		__set_bit(keys[i], state->reset_keybit);
 		state->reset_seq_len++;
 
-		if (test_bit(key, state->key_down))
+		if (test_bit(keys[i], state->key_down))
 			state->reset_seq_cnt++;
 	}
 
 	/* Disable reset until old keys are not released */
 	state->reset_canceled = state->reset_seq_cnt != 0;
 
-	state->reset_seq_version = sysrq_reset_seq_version;
+	state->reset_seq_version = seq;
 }
 
 static void sysrq_do_reset(struct timer_list *t)
@@ -768,6 +798,8 @@ static void sysrq_detect_reset_sequence(struct sysrq_state *state,
 #ifdef CONFIG_OF
 static void sysrq_of_get_keyreset_config(void)
 {
+	unsigned short keys[SYSRQ_KEY_RESET_MAX];
+	unsigned int len = 0;
 	u32 key;
 	struct device_node *np;
 
@@ -777,17 +809,16 @@ static void sysrq_of_get_keyreset_config(void)
 		return;
 	}
 
-	/* Reset in case a __weak definition was present */
-	sysrq_reset_seq_len = 0;
-
 	of_property_for_each_u32(np, "keyset", key) {
 		if (key == KEY_RESERVED || key > KEY_MAX ||
-		    sysrq_reset_seq_len == SYSRQ_KEY_RESET_MAX)
+		    len == SYSRQ_KEY_RESET_MAX)
 			break;
 
-		sysrq_reset_seq[sysrq_reset_seq_len++] = (unsigned short)key;
+		keys[len++] = (unsigned short)key;
 	}
 
+	sysrq_publish_reset_seq(keys, len);
+
 	/* Get reset timeout if any. */
 	of_property_read_u32(np, "timeout-ms", &sysrq_reset_downtime_ms);
 
@@ -903,8 +934,7 @@ static bool sysrq_handle_keypress(struct sysrq_state *sysrq,
 		/*
 		 * See if reset sequence has changed since the last time.
 		 */
-		if (sysrq->reset_seq_version != sysrq_reset_seq_version)
-			sysrq_parse_reset_sequence(sysrq);
+		sysrq_parse_reset_sequence(sysrq);
 
 		/*
 		 * If we are not suppressing key presses keep track of
@@ -1055,36 +1085,71 @@ static inline void sysrq_unregister_handler(void)
 static int sysrq_reset_seq_param_set(const char *buffer,
 				     const struct kernel_param *kp)
 {
-	unsigned long val;
-	int error;
+	unsigned short keys[SYSRQ_KEY_RESET_MAX];
+	unsigned int len = 0;
+	const char *pos = buffer;
+
+	for (;;) {
+		const char *end = strchrnul(pos, ',');
+		size_t n = end - pos;
+		char token[8];
+		u16 key;
 
-	error = kstrtoul(buffer, 0, &val);
-	if (error < 0)
-		return error;
+		if (len == SYSRQ_KEY_RESET_MAX || !n || n >= sizeof(token))
+			return -EINVAL;
 
-	if (val > KEY_MAX)
-		return -EINVAL;
+		memcpy(token, pos, n);
+		token[n] = '\0';
 
-	*((unsigned short *)kp->arg) = val;
-	sysrq_reset_seq_version++;
+		if (kstrtou16(token, 0, &key) || key == KEY_RESERVED ||
+		    key > KEY_MAX)
+			return -EINVAL;
+
+		keys[len++] = key;
+
+		if (!*end)
+			break;
+		pos = end + 1;
+	}
+
+	sysrq_publish_reset_seq(keys, len);
 
 	return 0;
 }
 
+static int sysrq_reset_seq_param_get(char *buffer,
+				     const struct kernel_param *kp)
+{
+	unsigned short keys[SYSRQ_KEY_RESET_MAX];
+	unsigned int seq, len, i;
+	int off = 0;
+
+	do {
+		seq = read_seqbegin(&sysrq_reset_seq_lock);
+		len = sysrq_reset_seq_len;
+		memcpy(keys, sysrq_reset_seq, len * sizeof(keys[0]));
+	} while (read_seqretry(&sysrq_reset_seq_lock, seq));
+
+	if (!len)
+		return 0;
+
+	for (i = 0; i < len; i++)
+		off += scnprintf(buffer + off, PAGE_SIZE - off, "%s%hu",
+				 i ? "," : "", keys[i]);
+
+	return off + scnprintf(buffer + off, PAGE_SIZE - off, "\n");
+}
+
 static const struct kernel_param_ops param_ops_sysrq_reset_seq = {
-	.get	= param_get_ushort,
+	.get	= sysrq_reset_seq_param_get,
 	.set	= sysrq_reset_seq_param_set,
 };
 
-#define param_check_sysrq_reset_seq(name, p)	\
-	__param_check(name, p, unsigned short)
-
 /*
  * not really modular, but the easiest way to keep compat with existing
  * bootargs behaviour is to continue using module_param here.
  */
-module_param_array_named(reset_seq, sysrq_reset_seq, sysrq_reset_seq,
-			 &sysrq_reset_seq_len, 0644);
+module_param_cb(reset_seq, &param_ops_sysrq_reset_seq, NULL, 0644);
 
 module_param_named(sysrq_downtime_ms, sysrq_reset_downtime_ms, int, 0644);
 
-- 
2.43.0

