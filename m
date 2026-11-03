Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746769;
	b=CCEadayardwBdx3AxDaYLSjQwcFXp6hlnvYkpbe5cJ2H4A4doOyBLkfk8cJKWEDe9UgO
	 ZPTtZbwB0SPqnkuM98jaBWJd11x+58E0Flq2Lk55UoR8NBjvYKFPR2RX4xIXpwD0JTP6o
	 S34VoNvxvMDJ4Ei2UxIVemgxs0h+c+oN/BGCWDVAqQLxPvl+05CcjLjC5oQNIxZlpQcYF
	 PogcDMVd+tThj0co3Z4ADx7lMni7Q1QEwdn2K080qUP0h7Q+g3Ycfg8SN/gabCLOqaYiF
	 O8tjzUeVC3Gi6mBQwZ7VE3IZuWQgYv4+PGZMSq7YxlVGkaCRt/AaoNY4Qyg624faUIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=M4HWTp4evsaap0AfFKcKdMCCnVBz30GdJ6zIUdfmiDs=;
	b=qZh8+ghArJRF8k9AsoBHCUVot8cm9Wc7ai1bUkVQxJEse1Iup/o3whjo+g7i2NYTp+QG
	 Nlf7ru+Tq5KL42FW+U6JewVc8QHRU27PnDTkjuKlrTf8a33QWmO/tRCwHC0Fye0KAzw0f
	 WYlGefwW+gEv/JkisNfKjigE1FMnG0B3xNG0bbL9Crej/sw+0mtvp2DAoYmYZ7n8QolFt
	 fhsh78a3D3XmZ2u6UXpKl83pM4+zolP6ztnkmfsSiyjD3boL1f+KlfacFElUBnUl/vWXb
	 vju81ix0PukpFXrYRaCGipxt0+AHVTrBOhz7VtflPdifU1K/JJpnhBRXWqz+Zrtmjpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=weS3T+lu;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F17C606A32C
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 22:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F17C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=weS3T+lu
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3550c917fd3so87134eec.0
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 14:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746768; x=1794351568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M4HWTp4evsaap0AfFKcKdMCCnVBz30GdJ6zIUdfmiDs=;
        b=weS3T+lumGwZNXpPkdkHSE8Jo2JuhqQAzHhBPJmhkwd11KbkiRtZ5PdJSwY62ljLJR
         rtvR/GZ/aXISKffBOo+sYoXKMI0zQgHjDAcNKUhz8ys9lsqLaW5SBB0+atFrMcUqnAcp
         L9qEw6oNrHxrD5PyYRFmqHtQ43U5teRZ5R+WtH0W17l+njAFMJkK/O6YD3pKwdCaSnEM
         HI9jSQ/NbUtq5NMzldHrYtNPpv2O2Nwj/WO+mHtGI+e1Dn6rHF/MIYxj+TzKJ1M1ZzRm
         nSFJIQ3pV9w0X6PKyQzORfOrrvR4fn2t3qQrHYlKinGG3/pQf/FN6LTd7u7TLkkO/9Hn
         mzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746768; x=1794351568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M4HWTp4evsaap0AfFKcKdMCCnVBz30GdJ6zIUdfmiDs=;
        b=g4oEOwZuvTK//+m3P7Ac1tR7csB2omxPL1dz0PPGasohpzhY+LuPUJwYKnlufKT49Y
         dXi10S7UCUpxtUihiZYOLeWX4MFvTVPlV4tLxKDBXijeT17AbQceJfZcgxaryToSJt32
         L1S4E30sLRx7heW0uvUlaGLXBDx6wbQ/0BMSI4BBxJ8N1v1L54J7B2sDsUp2eEZYv4ot
         xkytjsx4Fgof3mtSdg2pFyLole86uXTKifR0MqZSZO+wn/X8RMYVdysULae5pM1PnrR0
         m3VwRaNQdAkYNg5wb8trKxi9LsWQw9l5PeCNqq8Hy8tpy2j0LUSclNY6FuQaaFfq/NT9
         ydqw==
X-Forwarded-Encrypted: i=1; AKwUvBy9YKTE/qqKzfT1xmAPTWFxl+pCdcJMWs374g9pqdiM2LC0x92jn5k3ar66cbhUlqybuX3UJz8syxJJlA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Kz46WXzH0klWyaAqRDOfaLvVSwtS/et+QYlhZzOJHKUQyKic3
	5UcIMP5FwfVDsECICD4xzFbUmYKlAICZYfyAjDd6EEs5Li9OUH7C9tNf
X-Gm-Gg: AYBFou2PG9QOik6iOwdTimYGjixbe89/lxvRK7D1ejfS6I4ZCfK+MuiqPVSk3HPbtRx
	Qme1Tp8VKdX3SxsKAsDnPIVBRpmziIGoqaWWycBKwwT6v5aLZF7+aa3GvlH6ZGRtRtbTLYr3laf
	EUGyxLcAjsRW7wJwKWYhVHydIyQMZCpayiMwBwaKQc0k+hhlDVk98MRd4nU8spouiB/WcyJFjWG
	ltuLvYe6w3FfSZi3wi3KPKb1QTbATsiBu5Zjk3uHf2L0J60g1Oja11ZGAgWsZfIApa8svI8RrpV
	JUm2MFlzX/OP+eF7wIUEfnKCscBh2jtHzq94eLW62mP8va5MsEN8PztTEatSk0gD1ybiWAxJ9WK
	fKWRMBy3kgrn9pIBWjrvsRt8jkSOJcS1oPXtap6RZn+FuwkOvEP7min/w3W1YX5QfUtXqbsUejM
	Sr+VL5srU6JLDY/xBVOwxeuQ7BJ0wL77JlavBLqxduyfOkoie4IOU/VRS5Szkor779uTg44lYA5
	fNiZczpcUJ3HBsymR5rBElMlf9jaRj0+IfdL9FmO8H+Aj50FrIRz5pjuQyti0ZOC+//Y/6KmCp2
	BVputI9ZpsFy8s3Zwy+olKlo/xx0WM30P8BNEExFv4LznYnjxKbV/LAyLzQ/NbJK4k45ijFTJs8
	3iXAL/Iv3Zf3A0I4I
X-Received: by 2002:a05:7301:6198:b0:36a:1e9e:ae61 with SMTP id 5a478bee46e88-36a42602aa1mr20317199eec.38.1793746767814;
        Tue, 03 Nov 2026 14:59:27 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a67edsm1187111eec.8.2026.11.03.14.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:59:27 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: David Heidelberg <david@ixit.cz>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Petr Hodina <petr.hodina@protonmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Input: stmfts - event parsing and coordinate reporting fixes
Date: Tue,  3 Nov 2026 14:58:40 -0800
Message-ID: <20261103225923.3892612-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
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

This series addresses a few issues in the stmfts touchscreen driver's
event handling and coordinate reporting for both FTS4 and FTS5
controllers.

First, it updates the FIFO event parsing loops so that non-touch events
(such as controller-ready, status, user-report, or debug events) do not
abort processing of subsequent touch events already read in the same
FIFO batch. Next, it validates the 4-bit slot ID extracted from event
payloads against STMFTS_MAX_FINGERS before calling input_mt_slot().
Finally, it switches contact and hover coordinate reporting to use
touchscreen_report_pos() so that axis inversion and swapping properties
parsed by touchscreen_parse_properties() are respected.

Dmitry Torokhov (3):
  Input: stmfts - do not abort event parsing on non-touch events
  Input: stmfts - validate slot ID in touch events
  Input: stmfts - use touchscreen_report_pos() for coordinates

 drivers/input/touchscreen/stmfts.c | 49 ++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 13 deletions(-)

-- 
2.56.0.385.gac671c819a-goog

