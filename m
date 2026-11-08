Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794126837;
	b=OwrFnUwdJQU5r6eiT6Xg910v6fS7bzD6LzTBSjN+W119BJo617GIubg4m5oKloB7uVeN
	 9GQANTAi/aNXTfq3ZyudIzr3usGo526BXel5EFJOVtYFJze9wlYGXPTZy7CfXDiBWjWaK
	 C5jjZRbYFpXtULOAQTPWftdjgpMC2JqdmuR5oHc+Q65zBT8d0YGJRsOQj8uoSbQvgW2w2
	 WYWgl01otcbbfD/w11FvsII97+tfRN/nXYJT70kl/1eR7OnNqZX8cG85Jg0FnWvUBALD0
	 fM5jvyyd8/wEGU6T+6pvUuMN0a5zCVMybOmweCcF00lAh1mk3Ztgf/45kDYTq8bZd4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794126837;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=l6RLTnHlfDijZ2OGcuwJQZfLo4/XS8Wt011NfZM0g+U=;
	b=c+MGkJshKcxxSlRPVaXetkil3jjXqbuLTSq3bndLaHYadgNBsWdH271SxkfMe3xzBa6u
	 shwbn9326BqTNVV56k51PvIs8v/G/QdCMTvO7AQlsLZGTA4e8LJvoQJJyvXTMckZTFdQs
	 xlroD3UAAMX7Rg/V4YEejHCuRvUkSpvnaGVGUDjXWSPms+X85wnCve3TGbPzTlwLNM/be
	 43i6CDDMoqW2N/SrwZ1kF22xTKWzQqK4E9+izBxb8LNcwNEetaw08u7fdwg1rn9VLWhEh
	 Kr2tFBVUe62UTXWhCUHhGi1drYG3AciZ6SiuM4bwWGJDvprudUdm/uRHsrNDDxuVq8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgAmNJ8O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E51606A321;
	Sun,  8 Nov 2026 08:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgAmNJ8O
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794126837;
	b=3CKneHghXUuQ+Xg12O9DQ63wajyF8apPJ9Yjyuo6RVDLhFvky4BNtJuwNxRCoAe/5Eqh
	 +AqFUHp84E/9IAhCK4zvjJ/MAKyDc8myTmprYb443lXtJHsDgMLVNx7R3X14xWNbgFrMo
	 h/M6DZNxPaSDwKOk3OmLiNucwVe2vfIKKYlR82bDzoyDNgPVm8DS6SP6xLU2xtnjJpBor
	 6MV7P1UKaFCIzK8y0SYazIuK1knY2zjcTlycWh648uYq+5GMVdV09F0Tzj7ydDtVS6Nag
	 LI32qXl/6sb3aNEXAT8JW4LBEQQvtPEoCqNOQsZQn2Pc0SJn1O+7ElmJduxZwgP7DeA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794126837;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=l6RLTnHlfDijZ2OGcuwJQZfLo4/XS8Wt011NfZM0g+U=;
	b=RnqsNBjhPMsRbB1JfyvFDnWu7p5+DEmxjKrFD9GWpsI1Qr+31yZsiGSqWGyoejWXwydP
	 6kwzRusHeb8SHbIJ1QPEZ0bU5FtZyfqMRaVEKbaCp4MHwBXd99P8A5Lq6jmS87EVAuyll
	 I18T8HqWafuBhVF9fNCBbzQooSxAuAHmA3UaFO07Ffd4jxbJS3UzS4M4Gio0UFJWZ+URM
	 KgaK9COYYLowVLcizRFmWbyV08N6gnaYFuL8suhcNq1SZKUohNxrNex5arChJOQRXTFmb
	 /z7G26q/BiqA+FdJvUQCMUYEG8RbjFQlhSVE+N4uIUVMFoRxZPNHBpiXQBQjXgUHNiA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 53BE21F008A2;
	Sun,  8 Nov 2026 08:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794126837;
	bh=l6RLTnHlfDijZ2OGcuwJQZfLo4/XS8Wt011NfZM0g+U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=LgAmNJ8OV/v3hqTurw45NUi35z380PROCWaBPVgjTprb0gLXTg/gVhotAI9SeMFPu
	 TZLVUNw/XBkIr9uCzuX9FDrB0ir3uIsazRhNRNBU9zPX9h/RONrzMn8/SQFWLTenJ8
	 UXvlhzMUZn/kTyIbzXA1pGz3z8TXXwZnurjZg8/gIxhvHb8zfxY/ygDGC4CiEI8vWs
	 YZV2QtvnvXVfwCMgD4sZAloWfGL37rZxOAkPIpfVF4Tg5ejyIRiq9cc+dSnfZ5vYR2
	 8csFoBvAZJcW+nOTIIIT2iBE3/sCrnN4+rWwNA+/+OSAg/HuZHfG+IYoWsH41vtkMd
	 Y8ecVqTxzeRVw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D041247E90;
	Sun,  8 Nov 2026 08:33:55 +0000 (UTC)
From: Nizat Mikayilli via B4 Relay <devnull+nacht.dxdmail.cc@kernel.org>
Date: Sun, 08 Nov 2026 09:33:54 +0100
Subject: [PATCH 2/5] Input: s6sy761 - check the multitouch axis ranges
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261108-b4-s6sy761-fts1ba90a-v1-2-999b3cfaf82d@dxdmail.cc>
References: <20261108-b4-s6sy761-fts1ba90a-v1-0-999b3cfaf82d@dxdmail.cc>
In-Reply-To: <20261108-b4-s6sy761-fts1ba90a-v1-0-999b3cfaf82d@dxdmail.cc>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Henrik Rydberg <rydberg@bitmath.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, David Heidelberg <david@ixit.cz>, 
 Nizat Mikayilli <nacht@dxdmail.cc>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794126835; l=1089;
 i=nacht@dxdmail.cc; s=20261004; h=from:subject:message-id;
 bh=a/pLroNBJtz3o9lo3KhseD8iBVAsH+uHttUxd7UDP/Y=;
 b=HDWPyass2lu1SrTdwK3bIsGL+a9szaSH9KZOW10verBpSAF0TUy8ldGdqh3EZOQbTQ7buF9Y3
 yNjZ9fmjPdRDH4ahPgNth/xO+BvbDIoFNbMjpetwRcXhx8sOQhMHtmy
X-Developer-Key: i=nacht@dxdmail.cc; a=ed25519;
 pk=Kay3P3pOJq5klUD+0/I8QX8JGOh0CeQXEwRVv7CMm4k=
X-Endpoint-Received: by B4 Relay for nacht@dxdmail.cc/20261004 with
 auth_id=1111
X-Original-From: Nizat Mikayilli <nacht@dxdmail.cc>
Reply-To: nacht@dxdmail.cc
Content-Transfer-Encoding: 7bit

From: Nizat Mikayilli <nacht@dxdmail.cc>

The axis check runs before input_mt_init_slots() copies the multitouch
ranges to ABS_X and ABS_Y, so it warns on every probe. Check
ABS_MT_POSITION_X and ABS_MT_POSITION_Y instead.

Fixes: 0145a7141e59 ("Input: add support for the Samsung S6SY761 touchscreen")
Signed-off-by: Nizat Mikayilli <nacht@dxdmail.cc>
---
 drivers/input/touchscreen/s6sy761.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscreen/s6sy761.c
index 967fd222f0d6..59166865d397 100644
--- a/drivers/input/touchscreen/s6sy761.c
+++ b/drivers/input/touchscreen/s6sy761.c
@@ -449,8 +449,8 @@ static int s6sy761_probe(struct i2c_client *client)
 
 	touchscreen_parse_properties(sdata->input, true, &sdata->prop);
 
-	if (!input_abs_get_max(sdata->input, ABS_X) ||
-	    !input_abs_get_max(sdata->input, ABS_Y)) {
+	if (!input_abs_get_max(sdata->input, ABS_MT_POSITION_X) ||
+	    !input_abs_get_max(sdata->input, ABS_MT_POSITION_Y)) {
 		dev_warn(&client->dev, "the axis have not been set\n");
 	}
 

-- 
2.56.0


