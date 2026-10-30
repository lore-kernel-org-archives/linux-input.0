Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336347;
	b=mFWVwLVgA3GNk/dkL44rsWvacfXR1zH+p0hPGAFxcqcUrNagtS9tQo1T6PEBdNF4v1/U
	 8PU0OMUon7U4jznKfyG1jcm8Klw7Or1xveqF+ae+T1isuXENMN4RErm82xs5AeOYrffKQ
	 Ik9s4Tr/nbKtXoAot1Q3NdKB6ftKVeChuWfeXav027sAQrrP3nnyTdSFxzQ8wv4rZtOCC
	 Vpl6DgoNGnbqikGbK1L6b7XOkhQwr50BBRIILyICPiyY0P61tHtni+nTNgiWZiVs4voB5
	 KgQJeAK3dv9CQcN3IQdMhSPcBPK7AXR+ZaJJcQUqqDUnQsJVRxo3GuMZwBATWk5/aig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZG6bOylgszrN/sJI6CN0hf+3k0g0lKx6/Z4LrJV7mls=;
	b=pYvdSLxXcKvI3BK9X7OhrcdrPA1ckY5SUH/O/r6c49iT0FfvdMvRBNjkcpg0hmvYe825
	 GtxcHOwuCTDRBIxdClMM64lmV5M9pCIFYcsD/WPXTzFrz/8vWuWsxs2iU7zBg94gDwqUG
	 Ez60eh0ZXe95qZQEGcwX/BonVsJXE35UTZ7y5j7ZPek8DlvawEmNPkGIkNHO1BXCPBE55
	 bZTkmvWCQEwPT1jMMe8Ei3Cv6dXzYDbPYtSZ14USw2crtqm8Wwt5lsL5NxgigjtdQbK1T
	 150aaMZo/KvmHfLPygqxtjy8ADWhk32Vl+ar1dXHBz0Rhm5e8hryR7G9hP4Wo55ikSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=INJciFkO;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCE5606A32D
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 04:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FCE5606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=INJciFkO
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1846bc43c28so336353c88.0
        for <linux-input@vger.kernel.org>; Thu, 29 Oct 2026 21:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793336345; x=1793941145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZG6bOylgszrN/sJI6CN0hf+3k0g0lKx6/Z4LrJV7mls=;
        b=INJciFkO5H4hqxAW1C8mpRHp4hDDtq7RkjC5vXmOhsNlIuw+a0RMGZM9XGyipAUsTW
         ATnG2Dk1f2JsvFd8IP6t2cJCX/VhUr4nCzvtzk3wWcbY0Q+J4frKLqZ3+8iu/G0WmRKP
         1gcbVTuarCESI+T4zZc7MYR2T+0w7j5hKiOct8mP1/1iQ2O0hWsxt8oSm3RBIqkWq/bZ
         LdSDAT0VOOA7KVckxMp97EGXiLoJimw7j2zFqbjkLBXHq1qTGPVLLZLQlIg4zL8ktsi3
         oD/m8exNW230TXd+83r6hGVK7UnSI47YxcgrucWrvX+MfhDvemFic6ll9P7et6/nQtNM
         gHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793336345; x=1793941145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZG6bOylgszrN/sJI6CN0hf+3k0g0lKx6/Z4LrJV7mls=;
        b=ir2iOfuaH8AHXpBcUrSy6evZoaWYttBeuN+xeS5P3RH0WAeqEvcNGT91LHrYCysTyT
         VV59q2BQvNv716SivY10XtL3nZd8oWiFkCaICQVFfo8UMsCBV1qIHVIrRkj8unfCIITr
         d5TwRs3dO39fNNA8Aib6LjHwO4QAGEBz3Z/3dSkq56boMgZqbtYFNmcxKxPZPmDK8dGg
         IdhBxsTKF8NF7TtYRuLSKx5Tq2CZjZces9yc7PGS3UJAW9bxeQx5C/w2EQkT/zFLFxSo
         IU3OODBEIk7MnXwrVsznaUBbcDvqBc1KbCewBPd96KkQtHm/nOusVcKGZGy6M5lsMMcl
         m8Sg==
X-Forwarded-Encrypted: i=1; AKwUvBxZ5+hsXx4ecjVrjJfDAGIwZzMZv1LtZFYrgP6MpNYmdY6vCfjX223Wzu6LZ6L6QsQ5BCmoxB2EJNhAzQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLm1GrZ8tSMNi2p0j9O3dF575rh12u8i6fKsFcGumQ/s1h9omNA
	X6VsrcQKcb1rYFuQWDrDMrTDEzurZKd1ZZ/1Dx3IM1/NLmWSTeic3giJ
X-Gm-Gg: AYBFou2MM1Zfoqc3dGQklpIvFlYa+3Y7A3QgKPuWdGqr6TZEsbPbEjhdo8lvcnp4RZi
	aLjkJI40t1MH6cMaTsxe3wFqWvuQCxNmZJQSQrgnZMFlnqfd1IpJ1emudCVdKnNS6WVRGF9O9Zd
	URcVcpD/V3VAVu+UsytgXH1/eQteNzTDgo95pmwkxCyGz1Ap522m75eSPYhlAvD2ogkpl55EzLM
	KMPfwrNmQBHFP7k0aG9nYiuWDRvXAtIWnhWTvDh7GjoBdtpActpCDk5ecFsbvPBad0LgbpbxiDW
	S6hmuCAkGwWQp6OATDzhUEvOkJNd7z/C0oaPMeHQjDYUia31f764s3FmD8dNamb0N2xhh72rQyi
	Ja+YCtQGGZws/4w+lcKxWLh3dZPdoPGD4WvCQC8iPLgmppLaEyFsMjMTLS10VPglmwG1/7u5FFN
	l7SKcGCPtfXvYKAPraBQ+3I89Mf08xJpcQc3jmifs7VkIEswPe0ZZ2FW900qf0jCvCUw/WjqxL0
	33P1PatL6MJwVZ45EzAFjboN2o93QtyT8UgrT2AMDqOavd93IopWdSBQUwSMz4y8LFYhbUdL94e
	6XTvtN2Lfzmj+Wp8hvm0UZSinlFXFegfjAcEwtjBmWsCPg==
X-Received: by 2002:a05:7022:ef12:b0:14d:ef19:246f with SMTP id a92af1059eb24-1ac5f36d5cbmr1974923c88.45.1793336345453;
        Thu, 29 Oct 2026 21:59:05 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm3433152c88.8.2026.10.29.21.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:59:04 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: dmitry.torokhov@gmail.com,
	mathieu.poirier@linaro.org,
	linux-serial@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: [PATCH v4 2/2] tty: sysrq: reset the per-device key state when reparsing reset_seq
Date: Fri, 30 Oct 2026 12:58:54 +0800
Message-ID: <20261030045854.153556-3-zhanxusheng1024@gmail.com>
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

sysrq_parse_reset_sequence() clears reset_seq_cnt, but reset_keybit is
only ever __set_bit() and reset_seq_len only ever incremented.  struct
sysrq_state is allocated once per input device in sysrq_connect() and
lives until the device goes away, so both accumulate every time the
sequence is reparsed, which happens whenever the mode 0644 reset_seq
parameter is written.

After writing 56,29,111 and then 59,60 a device keeps all five keys in
reset_keybit with reset_seq_len 5, so the effective combination is the
union of the old and the new sequence: holding just 59 and 60 counts two
of five and does nothing.  Releasing one of the three stale keys takes the
key-release path, because the key still tests positive in reset_keybit, so
reset_seq_cnt is decremented for a key that was never counted and goes
negative.  From there ++reset_seq_cnt has to climb back through zero
before it can match reset_seq_len, so the emergency reset cannot be
triggered until reset_seq is written again or the device reconnects.

Rebuild both from the sequence that was just read.  Also delete
keyreset_timer: with sysrq_downtime_ms set, holding a full sequence arms
it, and it is only deleted on a press outside the sequence or a release
inside it.  Dropping the old keys from reset_keybit removes both of those
cancellations, so an already armed reset would otherwise survive into
orderly_reboot().

This depends on the previous patch.  Clearing reset_seq_len turns what
used to be a stale superset of the old and the new keys into a real
truncation, so without the sequence being published in one step the
single-keypress reboot described there would reach every device rather
than only those that have never parsed a sequence.

Fixes: 154b7a489a5b ("Input: sysrq - allow specifying alternate reset sequence")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 drivers/tty/sysrq.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index f9d63b45f859..00cea2f315c3 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -724,11 +724,18 @@ static void sysrq_parse_reset_sequence(struct sysrq_state *state)
 	if (read_seqcount_retry(&sysrq_reset_seq_lock.seqcount, seq))
 		return;
 
+	/*
+	 * An armed reset belongs to the sequence being replaced: once the old
+	 * keys are gone from reset_keybit their release no longer cancels it.
+	 */
+	timer_delete(&state->keyreset_timer);
+
+	bitmap_zero(state->reset_keybit, KEY_CNT);
+	state->reset_seq_len = len;
 	state->reset_seq_cnt = 0;
 
 	for (i = 0; i < len; i++) {
 		__set_bit(keys[i], state->reset_keybit);
-		state->reset_seq_len++;
 
 		if (test_bit(keys[i], state->key_down))
 			state->reset_seq_cnt++;
-- 
2.43.0

