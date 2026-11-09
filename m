Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217484;
	b=eEXurxizwERtl9PuCPXBfytS05+84liEbsg4pASHcAMmbEf7wRXP32X265F3ju/haPGh
	 vwt3OaIAUmk1yCE20FbpplenE9q1FNiTkrSKAli4ICuXkds+ufE5CQqaz4hDKyNJWICNO
	 1akCXYU/OyBSYBboxUVpad6EdtpQQ5cYM4C1dz2O1vpDDbcRbZRY3mo9qaRKO3IPO/c5j
	 ertPgbmbrh+K/ubV/jT+ujl47IbaefzPzRFe+4xTZ/Imm0oawgy2mb2abpdvqc0GfOEJJ
	 ylcdJtN20sEBpGcY03FZ9lRwvr9r8qvNBwICwVUKbkAfgCplGYh1b3cabNbUYgF5K4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=+YUTUU/Oh61z8CN0ior4Fb72s+3vtuOG9EHYvb714Q0=;
	b=jO17bADC+5PmrQYKKivL929dvof0v9uodQuRFZiXCu9snTPBwCBXOQVmTLJ4uNUy73YW
	 tfcOt2iDHxnuwe6lbHX27jUKKiVXONtxu83LcGdg6cuwqOS7Qwhwfcc7YlNBQXKuL2O0f
	 UpWBJWQBvz8tw6CLbkKd469q2Yaq6UA47rBLe450MA6ihO/y0SZJ54DXrNKZji7xcbiIz
	 +KM6AwLrgIgSV6meBHfIPcM59xXcMbCs4f2GPI9Zn5Wk8F3JvH14shmiDB4GHF0T/wZ6f
	 XcF7WrK8g3U45J0D2NVRwr6lwJLLcpSucOXHD7AnCLg+tF+gYaCqRsMjZbKbYmzCfow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tV8PhDd3;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72AD606D821
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 09:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A72AD606D821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tV8PhDd3
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c49b431f022so105169066b.1
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 01:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794217482; x=1794822282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+YUTUU/Oh61z8CN0ior4Fb72s+3vtuOG9EHYvb714Q0=;
        b=tV8PhDd355+0kQCWxNYoKmw9zjYChsQn8E5NpzD3e0HdlpOQQnFJGabjr4qby7kFWB
         eT5U/0nx3savniE82cVkgUH+wYsoI+l38aTM8FulKR45ZT8K9SMmp95F+Pztmvbhvdz2
         rJUhMZgn1TWiL6aqyuF2vJDuRrTaDnzo0gT+IvksjLBUj+9TG5o+ztGmpg6lm4SzaGH2
         DBysk7/W2i7ET2Y43CmxrJW69yzQIr0qKEU8J006uJgRwukg4SB3Aqv/svoWp29/fTiJ
         xAarqYr9v8ggJE0bH1R5JarZwDyJyzHG6Cqk8r4+m4iEl66dq4Q/uFVXCaQw8zr/HqYS
         fyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794217482; x=1794822282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+YUTUU/Oh61z8CN0ior4Fb72s+3vtuOG9EHYvb714Q0=;
        b=lK6MC/ZipQyDmvQx2Oxb0+Bm5Ib6pw9UpiQ68g/2zZ7sdO0CsZno8GBnx8KtBlKMPO
         RKItpCw6BbdtnKaQ/3MRqDtSzGABRbY78AfKLw+VjtGr/rT2cpTaW7r02BEcwxSNZOl/
         eSTy3tN5EahwCdQ6vQVBehQXL9+ofy/r+Y4PNSa1/uF+ks0LbOuMYawdaQ4PRlYbCTy6
         Gvj+mJQbOi5rd+rAYufZQsXgm984akC0Jp6Si05/mnYs8QZgCHheGjETJ6rXN7ah+CEx
         FLF3RZLGiuDPQhwj08hQnUh8Ix8CvQrth/j5VcjN83US2G+Z7iTzFXzwazP5n6/UlryX
         DG5A==
X-Forwarded-Encrypted: i=1; AL+hErErDqX9BP6WSlbHcfuWgLOj2ANSCYfk2EyRk4QHiztpUxXOwxnVvYyGkpLAAOWXIg+r9wrjiB3AeI/LPQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9/Msk5RIgvoVar3qVzjhhU+26m4qdN6I9ZLVU3mJO7yq0dO2r9
	fcfycTkFSR8TqnLS6HhNbGRRc/ye4BYcO9jiLALWMuwDi+my5jR6TRbt
X-Gm-Gg: AYBFou0sLFUqA9JcuICG6XHR4MObE8dgJHArrmeVpNTLuzOJepL6+UoOfXO6c2BB3Hz
	QTYgGZXZxpPUZ2se7rbzwbiD5k8Ztqo9JYszye1F1oLpFB0ecxBi5DLhCkv/QvAi2gLxuRSocUP
	NQu0ncGA7x6FYn5R+JrOgou2dmN6BFzCFJ5OWUOQ6oAuUaR6r5+uw6FrJINfbOA/q1y0YiucTjK
	ZiGzLRCB4BtAvo7UCvwendjVhVexR8ug6yKl/Qpnp+BkQTWaM/MRmvz0nFBfQbA6gXY/CK4CyHU
	enmFvugROL4aw7qHUtY5QhWSd2XskMnIET7VZpG2gyy9kBsg3wSZIaIaKBuzulbgCN2/Btux/Fj
	LtS50zFklFeBnJzkC4YYDWGJfhyNBjnXOZ4M/vqu7cLSUbzZKsVkuMlbUXsIsO3KAUcUNtRduA4
	HGdXark222Cl03/NVU0jlomEjluOxkK/lBMOuRXIpI2nPvp0FvOHBpIb3cPf1mlFBWFH7XYK8OS
	bbitzz+oY0fukJaMcuN4elPwuX8Bk9jitLN+ihXQDpK2tXmZ6gvpXvNk6qUhiJLES7yOfoJsG1U
	4cF7OtUCELPrGCX04qLx6jj+ZHitdiTRhCEODBam8MKiM9XSeAp9bJMQrQ==
X-Received: by 2002:a17:907:9622:b0:c4d:31cd:9dec with SMTP id a640c23a62f3a-c4d6d7c3deemr218179666b.30.1794217481952;
        Mon, 09 Nov 2026 01:44:41 -0800 (PST)
Received: from torstein-desktop.internal ([2a01:799:3a1:9700:6e3a:d704:53e2:f00e])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c4d6a4753aasm137786866b.45.2026.11.09.01.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:44:41 -0800 (PST)
Sender: Torstein Eide <torsteine@gmail.com>
From: Torstein Eide <torsteine+linux@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] HID: lg-g15: cancel LED work only after stopping the hardware
Date: Mon,  9 Nov 2026 10:44:26 +0100
Message-ID: <20261109094426.1432465-5-torsteine+linux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109094426.1432465-1-torsteine+linux@gmail.com>
References: <20261109094426.1432465-1-torsteine+linux@gmail.com>
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

lg_g15_remove() cancels g15->work before calling hid_hw_stop(). In
between, a backlight or game-mode key press makes raw_event call
schedule_work() again. The work then runs after remove() has returned
and devm has freed g15, which is a use-after-free in
lg_g15_leds_changed_work().

Cancel the work after hid_hw_stop(), once no more raw events can arrive.

Fixes: 7705b4140d18 ("HID: lg-g15: cancel pending work on remove to fix a use-after-free")
Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
Assisted-by: Claude:claude-opus-5-5
---
 drivers/hid/hid-lg-g15.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
index 592c9747738e..a341b0aca249 100644
--- a/drivers/hid/hid-lg-g15.c
+++ b/drivers/hid/hid-lg-g15.c
@@ -1927,18 +1927,19 @@ static void lg_g15_remove(struct hid_device *hdev)
 
 	g15 = hid_get_drvdata(hdev);
 
+	if (g15)
+		lg_g15_unregister_fb(g15);
+
+	hid_hw_stop(hdev);
+
 	/*
 	 * g15->work is only initialized for the models that schedule it
 	 * (G15, G15 v2, G510). The G13 and Z-10 leave it zeroed, so only
-	 * cancel it when it was set up.
+	 * cancel it when it was set up. Cancel it after hid_hw_stop(), as
+	 * until then raw_event can still schedule it again.
 	 */
 	if (g15 && g15->work.func)
 		cancel_work_sync(&g15->work);
-
-	if (g15)
-		lg_g15_unregister_fb(g15);
-
-	hid_hw_stop(hdev);
 }
 
 /*
-- 
2.53.0

