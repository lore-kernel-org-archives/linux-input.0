Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FA530D3F2;
	Mon, 15 Jun 2026 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547652; cv=none; b=TkjBpQmc9ztY8T1mNp5gM6Wwd9pPihltzA04qy5+Ju8aB9LFpbzlfcXp8Y4DD9OUWl+iPq6GfAT2FykNSVHU7t+sMf1q5jrqC2uYW6kK1tu3HyWLq99u2g+7olRjlVZBYmKLWwy/EOg33ADw2wLxin/L92Z4TFTbe7tkBI4iWt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547652; c=relaxed/simple;
	bh=OJLU90wf5xnUhMrI5z0nkDvgMEZU1IESbgO4SOzbSmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XnOK9aiXKg4NKUXmN675oZ3jB0tP1DtZOKw7az1dPZgMDGqMC0n2vUJHOHIcDZ5U8m+CItv/E8hiVwjHxpzm2odZdEyaASey8VDJEwqAx6hR64l3WSTt9VWBT1kJ+lxe3z8wJTnVpkNbEU6q7PVcZdyyblLkmfBsK/LY0y6cvd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LThuW04R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LThuW04R"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90E13C4AF0D;
	Mon, 15 Jun 2026 18:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781547652;
	bh=OJLU90wf5xnUhMrI5z0nkDvgMEZU1IESbgO4SOzbSmE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LThuW04RQgxncBje76MsQlwBH9rqUYVr+3Jwg9z+wdHKwWP7mwR4cI2UJ3XtUkOf2
	 0PRsOC4m4NLuUpMb44yy1XiW69f+o42NlM54GTZBnTZn7iFqa5cJt6d8fVOiSn7dQH
	 SF85E8Z1p9EQX3Z/OoN7N3dtqTzn26l8QagSNIww9XA5y2BaLU2RRt2p3XufQMhnSd
	 3UGwo1jhry1qi+c3fkdr1BX5nv6cY2G2SrwWBecZbqeaccGgAJZqbUn3wcg22Mj3i4
	 HycYD11k3iLm7dhJZxHXl2jhUK6F4GLR9E06eCwK5LsUXUiAUdtO01frjQWdGentuO
	 lRHK0w9YR522Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F30DCD98DA;
	Mon, 15 Jun 2026 18:20:52 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Mon, 15 Jun 2026 13:20:51 -0500
Subject: [PATCH v3 1/2] Input: apple_z2 - bound the device-reported packet
 length
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-disp-05943ee1-v3-1-bbfe1b651613@proton.me>
References: <20260615-b4-disp-05943ee1-v3-0-bbfe1b651613@proton.me>
In-Reply-To: <20260615-b4-disp-05943ee1-v3-0-bbfe1b651613@proton.me>
To: Sasha Finkelstein <k@chaosmail.tech>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neal Gompa <neal@gompa.dev>, asahi@lists.linux.dev, 
 Sven Peter <sven@kernel.org>, linux-input@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781547650; l=2446;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=0disTE6FLcmJRgyM/FHjVXBLuUuCv501SYEb1c85Kas=;
 b=+f1rkqMagRllETr38DyiMSMBldd07Ev1yHnQc0RGV3vV+DweLYAlWjnOCARVzGzjvvuTw9pN3
 mOQVdD2hyLdB1jKC8zLiX+HQFNHszsBUBn3QlmHzK5Lvv/MbnOYmdd1
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

apple_z2_read_packet() takes a 16-bit length from the touch controller's
interrupt-data reply (rx_buf[1..2]) and, only rounded down to a multiple of
four, uses it as the size of the second SPI transfer into the fixed-size
rx_buf:

	pkt_len = (get_unaligned_le16(z2->rx_buf + 1) + 8) & 0xfffffffc;
	error = spi_read(z2->spidev, z2->rx_buf, pkt_len);

rx_buf is a fixed 4000-byte buffer, but pkt_len is fully controlled by the
device and is never checked against it, so a malicious, malfunctioning or
counterfeit controller (or an interposer on the SPI bus) that reports a
large length makes spi_read() write up to 65540 device-supplied bytes into
the 4000-byte buffer -- a controller-driven heap out-of-bounds write of up
to about 61 KiB.  The recently added reply-type check only validates
rx_buf[0], not the length.

Reject any packet whose length exceeds the receive buffer.

Fixes: 471a92f8a21a ("Input: apple_z2 - add a driver for Apple Z2 touchscreens")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Reviewed-by: Sasha Finkelstein <k@chaosmail.tech>
---
 drivers/input/touchscreen/apple_z2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/apple_z2.c b/drivers/input/touchscreen/apple_z2.c
index 271ababf0ad5..ff9ff97be185 100644
--- a/drivers/input/touchscreen/apple_z2.c
+++ b/drivers/input/touchscreen/apple_z2.c
@@ -22,6 +22,7 @@
 #define APPLE_Z2_TOUCH_MOVED             4
 #define APPLE_Z2_CMD_READ_INTERRUPT_DATA 0xEB
 #define APPLE_Z2_REPLY_INTERRUPT_DATA    0xE1
+#define APPLE_Z2_MAX_PACKET              4000
 #define APPLE_Z2_HBPP_CMD_BLOB           0x3001
 #define APPLE_Z2_FW_MAGIC                0x5746325A
 #define LOAD_COMMAND_INIT_PAYLOAD        0
@@ -147,6 +148,8 @@ static int apple_z2_read_packet(struct apple_z2 *z2)
 		return 0;
 
 	pkt_len = (get_unaligned_le16(z2->rx_buf + 1) + 8) & 0xfffffffc;
+	if (pkt_len > APPLE_Z2_MAX_PACKET)
+		return -EMSGSIZE;
 
 	error = spi_read(z2->spidev, z2->rx_buf, pkt_len);
 	if (error)
@@ -363,7 +366,7 @@ static int apple_z2_probe(struct spi_device *spi)
 	if (!z2->tx_buf)
 		return -ENOMEM;
 	/* 4096 will end up being rounded up to 8192 due to devres header */
-	z2->rx_buf = devm_kzalloc(dev, 4000, GFP_KERNEL);
+	z2->rx_buf = devm_kzalloc(dev, APPLE_Z2_MAX_PACKET, GFP_KERNEL);
 	if (!z2->rx_buf)
 		return -ENOMEM;
 

-- 
2.43.0


