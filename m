Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363807;
	b=IyLXzicZM2x1q0cclVL952buLUVbRzy8pPtxFeTiUoCYTAsHUinzxvmn3XmyfHOPvbfk
	 CG78aN/vajuq19wK1ayHz7dUDKCcgzmGZvcjzp1IbLmvFc1qGN3FvZPjyi+idMCWtiIHx
	 6Eknh+WyJJioBTRW4bH7I0XtbMPuihtuBCSfmuSVUAwWZVIrE+bX/5BmbTFUv4xuqMpkQ
	 zQPE0OyekmJ8URtGMtDIf2UDzlvJXgHe+kzvJyJWivJtv6eexJmK7Qrpveu9xlQtfY3a+
	 bYt9/O71IXg5QWi/BYPhshM5MI0E5ZTl9CehZ80vFwHWKmJBqpQm70Yj+UujRHUqdcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pQElCk2k12jaC6kpnqjAIZ7YfARLoAsxq+ZYdTzaT7U=;
	b=1es5oMXEFB62K1e/20jfhZLDoUF5IjsDJMQkJNkb+ZbQ52M0kn41vzwBcF4dWWMv8MNI
	 ItfpwGPtA8MLGfo50ct0baJ4U3vwNu1KM+BMAHwdpIMIosYoDskhEhekZEpTSHNFQbHbQ
	 tic1uVzW14Dw/3EO/M6VanHLpgBvOdqye04dSugVHy/fG1Imj5i2AGlfreAcY8uF5glu8
	 6mKfOWoCpjGGWw1Bdi/LtxbdU2gEBue6xTLt67I/PpwrZfrKT5+RSeiD6KQXrFdifYR3Y
	 8u4weS+4MVWHFsntrUNIRCqzEET6J1jC7dX6e0mXx1CZL879YMELecZ0+OEkM7LzaFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fj3ZP9Cf;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE32606A31E
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 12:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BE32606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fj3ZP9Cf
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36a18fc7a38so1702810eec.1
        for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 05:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793363806; x=1793968606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pQElCk2k12jaC6kpnqjAIZ7YfARLoAsxq+ZYdTzaT7U=;
        b=fj3ZP9Cf5Y+e7SRaimUSFagvNtkpeoPKFhmaUN/TOWxv6iWzE/oJaP4Li4NwNzjOSF
         YwditmzupbjQkaHhRBJK9P642j5o13rhvL2p2Xmh/RysNjrrSRaHtVDudU528cNZNRzm
         ndAZVJ9IrDhDAlLg07xslGNbl/1VLsnxzZ/jlRAKdsFsth8qhq0p8IZq+vACSXKox5oZ
         blxBPKgiWHn/p0w5vxI+udQejA6fBo6JKV7jdXSromfqxshAuHWOZB20pnGBOowFX1lT
         YFSb1tsVgw/XP/alZzIfMOkIetsIXRWL2AO6Ob3Aemg3ByvLsDjGHUKqICWJB5JF1me/
         AkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793363806; x=1793968606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pQElCk2k12jaC6kpnqjAIZ7YfARLoAsxq+ZYdTzaT7U=;
        b=lCzRdDj6+E3vjJsW2RdHuuut30RjX2Ak1b2UJC8/vF+s4wnwZEJM6USHp3kxi5Q6VP
         9fS5Own7PELilV3x/Yq4NPBsQd6NmE9XIGqEVWHC3NXVh50lyHj2Q1g+G1IpLKrFsCiw
         jTjmseYt4VgTkPXcyGM4t/day/LBtPwGtFEpoHNIdmaDpmRrPNYZrbI9ICJeXWdUeveV
         w1yQFDYF4UQaPnCJuNaZgstMfA/PU70jxQFavEY8CGOwBXGUCwSDDIv9aKuFbQJyxgOD
         n2KR44rJrydmfSTO7lvhoOUWKxZrmWQLOrJsIQKqJFJP9Z7jOhqIn8dQMejuMbHehBbt
         eHVg==
X-Forwarded-Encrypted: i=1; AKwUvBzqQAWAZRWMXz/DsTGfkKHHW6C5bF6rpJVNE9imeGHUFrSZTN/S3VqTITCTpPgKZxevsJYSXDn5xRu83A==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0T/J9gLxDnJmoGYIOJMF3UTgwMQNcjcwjruhxV7v9DsTHncP4
	HGlTUqbXTUBuoSr0OJguV9ijqujW8FnqlPDSOJKqr26bevbz+ZrLocuuwBQF6qx+
X-Gm-Gg: AYBFou0WYdYN/LAOvWU0rasc+Zl7rfQ+Dxnhb+7B2zBIvOcu9DGBbYfNPjxHoikfyI9
	Z7pmN90CyeuF0AD8Rj8TIeKInPdxMLNasrA6rJ2i/QCzwulhNnar3g6/kMFHUMpwOVgG3Vtwv4b
	Au3r2poql1KeVRONfeLExU+Npq8SgESkbo3zWkCmxfwi8rEjpZPvko9RwR/Qngdd9j15HhKBNDp
	+Y9YOdHZDlUvTsTSH3QUUbnqzMz4a9S9AjVr6YR9CPxSXBMeqSJZox3un15VRCilcy3Ioui7Eb+
	nlgzrBIWhEzYW8BfKh2UX6+LwRApN9jCT0noloWyltgipoEpQyJ3DvefLqUbUJG+9/vPvfj3DhB
	or8HmT/eTJXDJEeGjHTinDTEaQ1pLvxB8mxAAPhH1Jolb6chrFOz1npcwH+bijnF65/UV7pMcTK
	SezTz/3HoZQtEEV8/xbUZzDfJDOhNjAubtV+FYqfAKf3Sx2lZ9DP8EF8WSvKey4gOC5dUA40Fdn
	Wi/hUA+YYhItcgCGx31kNuBC6KBWnVnqCoXipZc4Ldc8t93SsCQ0KjN/s7olxIIqysD4IOPUDtx
	+rgtqH9vAIgMHdtgzsNAa/w5PbZcCZbR8hEIxoLA5/sP8v+4fL7WXyor1v8+06wLXtw=
X-Received: by 2002:a05:693c:6092:b0:361:7ab9:479d with SMTP id 5a478bee46e88-36a423ee70bmr4018459eec.27.1793363806237;
        Fri, 30 Oct 2026 05:36:46 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af4e6sm6382373eec.4.2026.10.30.05.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:36:45 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: dmitry.torokhov@gmail.com,
	mathieu.poirier@linaro.org,
	linux-serial@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: [PATCH v5] tty: sysrq: clear the old reset sequence when reset_seq changes
Date: Fri, 30 Oct 2026 20:36:40 +0800
Message-ID: <20261030123640.263164-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Changing reset_seq at runtime does not work on a keyboard that already
used the old value, because each keyboard adds the new keys to its own
copy instead of replacing it:

  echo 56,29,111 > /sys/module/sysrq/parameters/reset_seq # Alt+Ctrl+Del
  (press any key)
  echo 59,60 > /sys/module/sysrq/parameters/reset_seq     # F1+F2

F1+F2 then does nothing; only all five keys together reset.

Clear the old keys when the copy is rebuilt.  If sysrq_downtime_ms is
set, also stop a reset the old keys already started, since releasing
them no longer cancels it.

A key pressed while reset_seq is being written can see a partial
sequence.  With this change that can happen on any keyboard, not only
on ones that never used a sequence, but the window is a few
microseconds and not worth closing.

Fixes: 154b7a489a5b ("Input: sysrq - allow specifying alternate reset sequence")
Cc: stable@vger.kernel.org
Assisted-by: Kiro:claude-opus-5.5
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
v5: Dropped v4 1/2 and rewrote the changelog.  Tested in QEMU with a
uinput keyboard: the new sequence resets, while the old one and a reset
armed before the rewrite do not.

v4: https://lore.kernel.org/all/20261030045854.153556-1-zhanxusheng1024@gmail.com/

 drivers/tty/sysrq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index f4571d05b496..a90e97a6d7aa 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -689,6 +689,11 @@ static void sysrq_parse_reset_sequence(struct sysrq_state *state)
 	int i;
 	unsigned short key;
 
+	/* A reset armed by the old sequence must not outlive it */
+	timer_delete(&state->keyreset_timer);
+
+	bitmap_zero(state->reset_keybit, KEY_CNT);
+	state->reset_seq_len = 0;
 	state->reset_seq_cnt = 0;
 
 	for (i = 0; i < sysrq_reset_seq_len; i++) {

base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.43.0

