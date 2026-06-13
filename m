Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E4D2FFF8D;
	Sat, 13 Jun 2026 04:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781324475; cv=none; b=JfW+Ggq28Cf4XHDzYsypcGsa2jv60WgKAXxHsQ9XP+yPf8BXc2z5HKC4tdg8nkovVpvnwlnVjFVb18KKK/tIw+bdVNEKsZ0TpiVRmm+X3DHCV6JbpCeOF6DL4TQVM/m90SuASwkintghq6g+asiOMk7mTMfACmLdCERhbjmEG1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781324475; c=relaxed/simple;
	bh=bYolUeNJ6TssqwqSii2cfEs0z5RJIkMcXv/1SDOe6Bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NwEA5PSw/RU1uE6xriwTlXaCCsl5cX9Kg+FefvgMQZ9B/F+8OwlQme2n/wtZpASUkBejyNdXNzKWMvUOIDrUDfg9IlLc4zglX3j0OWYBkrRqx6JPLsHQAGqLXvqIWesub2B8EXKnwOdSl72rTrXDaSk87VsCRNdusxXOqCLQvhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vt1T9r1s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vt1T9r1s"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03A60C19425;
	Sat, 13 Jun 2026 04:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781324475;
	bh=bYolUeNJ6TssqwqSii2cfEs0z5RJIkMcXv/1SDOe6Bo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Vt1T9r1s7QNB6mr2zdjpoPbKlgGBR5hQEmXUs5nrYRQTUqYYWQIc+asXtbGo2FXgr
	 m4nHWrUxQvgu+hF3jg9RfAdNfdL9IDc56ZQIKFU9FuP3i5/ssyRBMNtqulX5MynSif
	 +u7MiI7+NnBYajJtwgYgANssywycxi+4VLMOl8+YDiJiq76NkpA7qzgcFLXYzWB7/G
	 xjHNJwPeTtyWQbCmeTIwYIQkw8lBTHfYWDFnPkQmC34rhvzQXDlmlkiqnmtmOdP+06
	 RWClJ3ZXtGd9wvYihCBWtM6C2RoGKVdifsLQR746Vi+IIJx9jiH4E9r/HX1CJS7FJX
	 CN2bng/mjeJAA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC55CD98CF;
	Sat, 13 Jun 2026 04:21:14 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Fri, 12 Jun 2026 23:21:14 -0500
Subject: [PATCH] Input: mms114 - reject an oversized device packet size
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-b4-disp-dc4b8dc4-v1-1-d7cb0a828d92@proton.me>
X-B4-Tracking: v=1; b=H4sIALnaLGoC/x2MQQqAIBAAvxJ7bkFNzPpKdEjdai8lChGIf0+6D
 MxhpkCmxJRh7gokejjzfTWRfQf+3K6DkENzUEIZYaRCpzFwjhi8drYBLQ2Tm4LRSo/Qspho5/d
 fLmutH/8VYphiAAAA
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 Joonyoung Shim <jy0922.shim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781324473; l=2369;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=6WV4KDtYyMuVstt+ID8Kq5NDhRv4I0YIkiOyhsfbDHc=;
 b=3EG4JelF3w7WLIYr8LmpS+FPVdyNbSggirjrZTZijCyqetaboJgZpK9v1VlMmNnFvJEY4N3ip
 dgKrM21hmn2AJEQumkdvOnK41RrNK8McqHtg3O6aBOsFs/4zPPD46Uo
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

mms114_interrupt() reads a packet of touch data from the device into a
fixed-size on-stack buffer

	struct mms114_touch touch[MMS114_MAX_TOUCH];

which holds MMS114_MAX_TOUCH (10) events of MMS114_EVENT_SIZE (8) bytes,
i.e. 80 bytes. The length of the I2C read into it is taken verbatim from
the device:

	packet_size = mms114_read_reg(data, MMS114_PACKET_SIZE);
	if (packet_size <= 0)
		goto out;
	...
	error = __mms114_read_reg(data, MMS114_INFORMATION, packet_size,
			(u8 *)touch);

packet_size is a single device register byte (0x0F) and the only check
is the lower bound packet_size <= 0; it is never bounded against the
size of touch[]. A malfunctioning, malicious or counterfeit controller
(or an attacker tampering with the I2C bus) can report a packet_size of
up to 255, so __mms114_read_reg() writes up to 175 bytes past the end of
touch[] on the IRQ-thread stack: a stack out-of-bounds write that can
overwrite the stack canary, saved registers and the return address.

A well-formed device never reports more than the buffer holds, so reject
an oversized packet and drop the report, consistent with the handler's
other error paths, rather than reading past the buffer.

Fixes: 07b8481d4aff ("Input: add MELFAS mms114 touchscreen driver")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 drivers/input/touchscreen/mms114.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index af462086a65c..4c75f16c503d 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -226,6 +226,13 @@ static irqreturn_t mms114_interrupt(int irq, void *dev_id)
 	if (packet_size <= 0)
 		goto out;
 
+	/* the device controls packet_size; reject anything too big for touch[] */
+	if (packet_size > (int)sizeof(touch)) {
+		dev_err(&client->dev, "Invalid packet size %d (max %zu)\n",
+			packet_size, sizeof(touch));
+		goto out;
+	}
+
 	/* MMS136 has slightly different event size */
 	if (data->type == TYPE_MMS134S || data->type == TYPE_MMS136)
 		touch_size = packet_size / MMS136_EVENT_SIZE;

---
base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
change-id: 20260612-b4-disp-dc4b8dc4-8e39b9d64247

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>


