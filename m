Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795407669;
	b=SrDgCTKNpZk4d5lp79WZ7HL6OJ7ecouEvl9zgbaCS/tEFugAFd2oEjdeX2SP+wNsjAWg
	 cvehWPVk4jOBmwU3zrwWtFK5/zSU3W+c6iBs1+0/ZSAj73mNAk51C/ag89Y9VngeXTDwu
	 H1IkNwDrCklVGNzPK+L9N33NOLN+uDS0P0C/AvzBycdJb9Ccmkvy8GGnQs4NlbRbv4n6P
	 NYRRHXbkJ8C1GvmukkSZKTyuHwo591dzuyO8JjOPkCJwzA6QVNoyDD6CkWyDMaJKZY3+D
	 afK0WdRGVjulFmemI0eCsnw1ChJ1prebPBqnWFvKAm6mcbFKCWsgD8oUehNLHMedydA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795407669;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mXOXzco4JXOw2bK4x0BEUYDwyxl2ZBiIH+SEBteFzuw=;
	b=w6D+0dt5qPXvIvIS4LfPs1H8r8dJXTf0HXFVr8CsrDTbTwv9oQg2ClWQfp8ujQgBeOc0
	 HToXKB/mJ9nGKn0wr5J6inue2yhZfvshq9MEjTY6pZEZfUyFZmJkg/yD1jHdgEqCSTnQc
	 XjJb2cX1zK/X8LHhnuedUYtM5tycPRndhXlKtR9I/ma11DcpmEIFOZ2ecR0zuHkynnn2c
	 7ZbIVPPxrFByg7yE3GG8DjSkoEUppDT4kUE3BtSEt7pQhzyfMiR4AmxFxrkhQMu72Dr5E
	 5KRrNKiNmKfB3AN0sJ/pkY2JmBzrpGz3pfkQ90xkssAbq8JmpfWkHkEqTNjutmHnCOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wgv4KHDp;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97710606A331
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 04:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97710606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wgv4KHDp
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-380c28f9e35so3921894eec.1
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 20:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795407668; x=1796012468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mXOXzco4JXOw2bK4x0BEUYDwyxl2ZBiIH+SEBteFzuw=;
        b=wgv4KHDp4LsqTvvDPqIPzN67HcYvGEiDwT6d6VtJatFbTtIttUMX8fbNDP+Y3ZurZr
         XWmwIO41/RSwajPzj5w+cuZ7FBvYDb+iZ8Mg2Lbu3+gUhW1emFIOVerbr90XmoLLul5j
         mjArwG6c+Z7NubYJ8aayXWGRxD84xC8sWTI07jbhog4MFCAPDOw83mPb84TUmw2oTLAI
         N4qv0hviGQZFUEpVr7JCr+9jtlz0D0CwpWmNZ8NZFt3TpJrMGxHB/u73UPC+rCQ8aQeS
         D4S9UDpu/iCO6xkK0dEBriBwuZwnIAPZDuUlcD+6PfyEq8R1KndOtuydrEr2RwhTg3UK
         UQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795407668; x=1796012468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mXOXzco4JXOw2bK4x0BEUYDwyxl2ZBiIH+SEBteFzuw=;
        b=aRGBkkcsXUF8gT9mHRNe43gXnCG3e04oIaZgVeP0yxYQds4k9XmqbCNf9lgA1mmG/y
         z3PhmIWzje5YA5kwGK0kZnXVdqu29IccBxOxJEyvaAT2IZ2EsP1YmMSKW9VFUFVKPokb
         K4cx4v5pdNUBOxojMdEwP5S9gLmchfRDgCk5YB5fSZLgn1NoX5zHjlA2JYeAsbbhnp3A
         cRx9tGaWne5PYz6S6/wTUSYvma239mb+VgqiY1PZGExcfRgk10SqjfM6duhUtBw8pzJt
         YSUTbJR42wAC4PYPJiFA7MozSzDM1p7k0f+zxTn8hU7lDdusLmJeRfqoLL6nEVhReVgV
         t8SQ==
X-Forwarded-Encrypted: i=1; AL+hErGo3xxouLAmYu3Ocd5KsrCm6NncxstKvC9MuZTnPci1SIz5JosTi7e6EiTeezncBXUbCuEUMbax2akhew==@vger.kernel.org
X-Gm-Message-State: APuU4Z+RAjpbyAfMW9r8F+LMWaKzz6OKMqU7IdzEuFDSTZzUbusLDA6G
	eiWhPcXc+MF5WRB5X/rk8q+ODmaOB8Xu0I9dhEyt7CR8OMC/uEUR9PrZ
X-Gm-Gg: AZFdTZc+/Z830dd8ExGnxuEpFK5PlsHl43Xay8caMi/ZH8vWZUl1iQaatjrc4nIh+Ig
	LJ5tlZBst4Iti5VXvGR4GPisk1Z7vvupcDG8/5zdQOJoWylT59a20FI3NUROcr8IedbaMtvN5L4
	9HNODWPPC6ZGS1ab798taS9ybhTrsJ9SUGtKyNLB6vzZf/vQuRgFHU7R70LBDd5X4CwRj4MImAR
	VRCgsGAeWLK1bQqiqhgxUGQrtsrBCSl7uwEPb/HkCRLOIwcllLRI6fTXgtyE/jtGDxj9veftud9
	emCR4sbaCLlQpgt3//EZustLQk/kTIKbi1k2JZXIwHskxXcKC5o2oMkh4PVbcrFJIo20j5Q34hR
	Q14ifuaIktTG2zChaKGTq/B/BQosTvwcUNOizwL+Jbjwe/bYFyDk869o6GduHBbgVrq/pxyPePY
	8nhu8wDVTkExYz6jA8mrSWn8JRdeCxU6WBwWW6fvTd6hq3a696idACyAHRvqpajGtYdCiz+ckdN
	nBEnCY/6AQ4sePJsRMhcWAoigAKvGj/atyusS0G/GPLGvGdxwGcNssLkC0hy7S6qyT6n6qVI8Dq
	SbLrxkUO+2TtW0BCU8x3NTaqPWvcHZJnjHlgiOI/qU19FwHp8Udltofj6oG3lBbD3ioT+uy6F4n
	F1Wl4SzHBKrilWZXwZ19FqaB7VpYu/nfZMJEKrEjKvzSgwD6OTWiU8nt9jwAD+4iwAX1R
X-Received: by 2002:a05:7300:d589:b0:386:9ff1:7f7d with SMTP id 5a478bee46e88-3869ff18213mr6674962eec.4.1795407667621;
        Sun, 22 Nov 2026 20:21:07 -0800 (PST)
Received: from spark-da2e.tail8e743c.ts.net ([211.105.22.106])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672c6f31sm30804737eec.15.2026.11.22.20.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 20:21:07 -0800 (PST)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>,
	"Claude Opus 4 . 6" <noreply@anthropic.com>
Subject: [PATCH v5 4/6] HID: wacom: add NULL input guards to wacom_intuos_bt_irq()
Date: Mon, 23 Nov 2026 04:20:13 +0000
Message-ID: <5a4b092537e60ab22faadb3e8fd516e43c62e1b5.1795405057.git.jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795405057.git.jinmo44.yang@gmail.com>
References: <cover.1795405057.git.jinmo44.yang@gmail.com>
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

wacom_intuos_bt_irq() dereferences wacom->pen_input in every switch
branch, both directly for dev_warn/dev_dbg and indirectly through
wacom_intuos_bt_process_data() which calls input_sync(pen_input).
pad_input is also used in wacom_intuos_bt_process_data().

Both can be NULL when the corresponding setup_*_input_capabilities()
returns -ENODEV during a successful probe. For INTUOS4WL, pen and pad
are always expected together, so guard both at function entry.

Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index b162f40397be..e2c2bdf91c5b 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1269,6 +1269,13 @@ static int wacom_intuos_bt_irq(struct wacom_wac *wacom, size_t len)
 	int i = 1;
 	unsigned power_raw, battery_capacity, bat_charging, ps_connected;
 
+	if (!wacom->pen_input || !wacom->pad_input) {
+		dev_warn_once(&container_of(wacom, struct wacom, wacom_wac)->hdev->dev,
+			      "%s: expected pen and pad input devices\n",
+			      __func__);
+		return 0;
+	}
+
 	switch (data[0]) {
 	case 0x04:
 		if (len < 32) {
-- 
2.43.0

