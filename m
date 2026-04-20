Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7776F345752;
	Mon, 20 Apr 2026 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701590; cv=none; b=XVcMQv+tjOkWP0IrMU9qIAHHTwuGPNXX1dd2eghrjx2NUq5zWiP06rcFJU2ZseuM5rpRz9zNEPqGQiqfy8oKjwKwqd6PhPGEUhG+JoAewvezw+uuFb3yF5kL+iuO+FAp9SJO3rCb2qZKo0eX2qp2vDcSRnNuHPtFkZH8YmkyCeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701590; c=relaxed/simple;
	bh=a9uTXcO3PsYxxt/OPq1p6TAxbS+fSZ0fDOPPGimJuyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pu2Y5s1vWQo+63lMa1Qx8+3r3zOy5ygd9qVHbMk7sblq7U+uXEs3aD5cdMA9p2uwD+EDML77loWrrbbcAHArNxn8W4kQjvMX/ekd5w09BOFBCLeLUTkqWLaJaWxXUP8mWLaq+0yKsUHrsQDGFSMuyIC95AQys1mIVsOPl1cvsgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SvbaM+eK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SvbaM+eK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A87C2BCB4;
	Mon, 20 Apr 2026 16:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776701590;
	bh=a9uTXcO3PsYxxt/OPq1p6TAxbS+fSZ0fDOPPGimJuyU=;
	h=From:To:Cc:Subject:Date:From;
	b=SvbaM+eK9v7Pem6paCQ6W+8gS1fsXFU48jbyAqOffBKD2iSkBjqwEsbo0SJiaATXn
	 K1ru5al4OtIEVSkFhPhIHe0pMExPOZWzgls/Uqr8hKpX5hEa6KNVCQ7JMMi9KY/kDF
	 4mFhcY/HoqqJx0pfJMG6JrptaS0IQI60MzxZXgOo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	stable <stable@kernel.org>
Subject: [PATCH] Input: usbtouchscreen - clamp NEXIO data_len/x_len to URB buffer size
Date: Mon, 20 Apr 2026 18:00:27 +0200
Message-ID: <2026042026-chlorine-epidermis-fd6d@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2134; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=a9uTXcO3PsYxxt/OPq1p6TAxbS+fSZ0fDOPPGimJuyU=; b=owGbwMvMwCRo6H6F97bub03G02pJDJnPfGettOiIO7Q+v6BX7UOXvc3Tlml8L1le55hwKpRP/ Cn7vs2/I5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACayK45hvgOP52bG9t/x9jYT 6iYsXLpyScACGYYFCz5MOB5g+dT8vchy272qZ2Olpe7vAQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

nexio_read_data() pulls data_len and x_len from a packed __be16 header
in the device's interrupt packet and then walks packet->data[0..x_len)
and packet->data[x_len..data_len) comparing each byte against a
threshold.

Both fields are 16-bit on the wire (max 65535).  The existing
adjustments shave at most 0x100 / 0x80 off, so the loop bound can still
reach roughly 0xfeff.  The URB transfer buffer for NEXIO is rept_size
(1024) bytes from usb_alloc_coherent(), with the first 7 occupied by the
packed header — so packet->data[] has 1017 valid bytes.  read_data()
callbacks are not given urb->actual_length, and nothing else bounds the
walk.

A device that lies about its length can get a ~64 KiB out-of-bounds read
past the coherent DMA allocation.  The first index whose byte exceeds
NEXIO_THRESHOLD lands in begin_x / begin_y and from there into the
reported touch coordinates, so adjacent kernel memory contents leak to
userspace as ABS_X / ABS_Y events.  Far enough out, the read can also
hit an unmapped page and fault.

Fix this all by clamping data_len to the buffer's data[] capacity and
x_len to data_len.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Fixes: 5197424cdccc ("Input: usbtouchscreen - add NEXIO (or iNexio) support")
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/touchscreen/usbtouchscreen.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 657555c8796c..866d4a7fbe42 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1070,6 +1070,11 @@ static int nexio_read_data(struct usbtouch_usb *usbtouch, unsigned char *pkt)
 	if (x_len > 0xff)
 		x_len -= 0x80;
 
+	if (data_len > usbtouch->data_size - sizeof(*packet))
+		data_len = usbtouch->data_size - sizeof(*packet);
+	if (x_len > data_len)
+		x_len = data_len;
+
 	/* send ACK */
 	ret = usb_submit_urb(priv->ack, GFP_ATOMIC);
 	if (ret)
-- 
2.53.0

