Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.212.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567921;
	b=Ie1aEVJb1XWjqkv7Fao6ynETZLBrTuDKeN0fjFFrzmGn2fXwnuYCjpau+XCDbI/3ciGz
	 536QhI9pFbPXKm63bjz+7Pj5QxRJI9bSPXP09NJZIlxicMe6hcdhqmK7VN/yUSrmyHdEs
	 oIgG0TtkLHJP4L0eLPeH7LR8FG1MkoYh8OMsIreBQzwM6t49nHTpMzkh/DnQjo2pXuoKw
	 3ubueMXafGYpO0ZMZ3QJwWdrO+yYget5HyngLbWsWdq8CBdBlCW5YTsGcn/lsKn363qTh
	 PLE7vw+8aSP4OscZ9tFar4JwwfPwaPLy+mB5sC52P88RgxTvnen9atZHBe0wv8kgqqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567921;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Print-Chief:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:X-Hostinger-Mail-Ref:
	 X-Hostinger-Mail-Id:Received:DKIM-Signature:X-CM-Envelope:
	 X-CM-Analysis:Received:Cc:Content-Transfer-Encoding:Content-Type:From:
	 Message-Id:Mime-Version:Subject:To:Date;
	bh=TwtuMkGpp8gG7z+4w4hXHL+pU2MlTBevI9Xf+7Kv6oM=;
	b=LZlJfq788sEVGR+Xp0wObUwLR84aRraV2V3946MRLyJeKVKQscgOtcVv3e4li/HQXqIY
	 +BYOzV0/edpI8zx8Jow3+0uZWriAiLQafa5FUmlBPtA9rqNcz8xv7H8VHLr3WGbOvqonh
	 EMSyWCelaDfZuo4W8UcxyQBXV40gE8YCC6XPOERQsdYD6/QQwu0Liz8XLp/oOyVwHSTnd
	 5vWBbnciG6hk86WJrCqXg2PdAp5sibQR5zIXxjeOAQzt3GfaglBv3CrujqtwB4UBD7+lw
	 CFN4jQO+f/6FuCrgIwArBspEhE1wXkl3AYT9TUkxSdBiBrW8XGxkW1x2WZ24KtzDWxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=erencakar.com;
	spf=pass smtp.mailfrom=erencakar.com;
	dkim=pass header.d=erencakar.com header.i=@erencakar.com header.a=rsa-sha256 header.s=hostingermail-a header.b=Af23O9CT;
	arc=none smtp.remote-ip=23.83.212.14
Received: from bee.elm.relay.mailchannels.net (bee.elm.relay.mailchannels.net [23.83.212.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AB5606A8AA
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 11:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8AB5606A8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=erencakar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=erencakar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=erencakar.com header.i=@erencakar.com header.a=rsa-sha256 header.s=hostingermail-a header.b=Af23O9CT
X-Sender-Id: _forwarded-from|131.222.230.172
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id DB2E038A50A
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 11:05:13 +0000 (UTC)
Received: from fir5.relay.mail.hostinger.com (100-99-192-228.trex-nlb.outbound.svc.cluster.local [100.99.192.228])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 714E238A4E2
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 11:05:13 +0000 (UTC)
X-Sender-Id: _forwarded-from|131.222.230.172
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|131.222.230.172
X-MailChannels-Auth-Id: hostingeremail
X-Print-Chief: 6067d55834d484a4_1794567913810_679388457
X-MC-Loop-Signature: 1794567913810:112692082
X-MC-Ingress-Time: 1794567913810
Received: from fir5.relay.mail.hostinger.com (fir5.relay.mail.hostinger.com
 [148.222.54.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.192.228 (trex/8.0.2);
	Fri, 13 Nov 2026 11:05:13 +0000
X-Hostinger-Mail-Ref: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoibGludXgtaW5wdXRAdmdlci5rZXJuZWwub3JnIiw
	idGVuYW50IjoiaGV5PWVyZW5jYWthci5jb20iLCJ4X2N1c3RvbWVyIjoiaGV5QGVyZW5jYWthci
	5jb20ifQ==
X-Hostinger-Mail-Id: 182dcd5adf5211f190a3bc2411239de6
Received: from smtp.hostinger.com (131.222.230.172)
  by smtp.hostinger.com (KumoMTA ::ffff:127.0.0.1) 
  with ESMTPSA (TLSv1_3:TLS13_AES_256_GCM_SHA384)  id 182dcd5adf5211f190a3bc2411239de6 for <linux-input@vger.kernel.org>;
  Fri, 13 Nov 2026 11:05:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=erencakar.com;
	s=hostingermail-a; t=1794567910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TwtuMkGpp8gG7z+4w4hXHL+pU2MlTBevI9Xf+7Kv6oM=;
	b=Af23O9CTwuNi353djlKaqTdC5mKecrJjFB055nMv8Z1zTQuE4P5JLldnRBe9QPF72HHm5R
	YlQFzJ9wdzCZVhqrCcMvi4o0j5MOeW6UGsjIk34GAeXTF0DezOJIp4gbSGD9wqSOFoMruV
	2chFuvzXr66eGSDzCWGWTRolyyQ2oo6/Pneln0YpraUnSTRjkiMUm3JeXsc7gIFJ1CvBej
	F8b2nA0EGhYD4HgLUp+on/jT5j2/OuTLfne2xMt4h63SoUlE6Wz7oxojz3SomIuzwk3D96
	tO1zpb+1FZwxy/fCE0pHIScAqfu0Go7lwQysjCZ5D3y7TMxlAghLu4m5gRqcVQ==
X-CM-Envelope: MS4xfBZMdDD4xKXfa5RO6SHrIu1Y3FAwa3ASXqy+Sklnop5+cGCm1rGPFKIM+AyXoSR42OMuAZLiLD0d9xMoGjbhrYbdk7z9WJGfG12PMSO3Hf3h+by+Y7Jd XgkZv8L+cY2xUvzZFMJZE7fz4E8gID0rzsbEuAv6TpGmg/v2NshTH3/nN1NRAIxOo7o8/bFwLRASpViVesfW1o2g1tspqF3SbK4=
X-CM-Analysis: v=2.4 cv=UdEDS7SN c=1 sm=1 tr=0 ts=6af6eee6 a=prERNx796fc2PsiqrbVh+A==:117 a=prERNx796fc2PsiqrbVh+A==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=l0x-iJ_UAAAA:8 a=5WDK1-o_Z0DR0BEWtb0A:9 a=QEXdDO2ut3YA:10 a=dwddIJbocq3ZAqzMCJTT:22
Received: from localhost ([131.222.230.172])
	by smtp.hostinger.com with ESMTPSA
	id MHSRFebu9moNnxgAeimIyQ
	(envelope-from <hey@erencakar.com>)
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 11:05:10 +0000
Cc: <hansg@kernel.org>, <linux-input@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8
From: =?utf-8?q?Eren_=C3=87akar?= <hey@erencakar.com>
Message-Id: <1794567868877069470.1794567868@erencakar.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Subject: [PATCH] HID: letsketch: skip string descriptors the firmware does
 not implement
To: <jikos@kernel.org>, <bentiss@kernel.org>
Date: Fri, 13 Nov 2026 11:05:10 +0000

The Starcom GC-422 is a rebranded LetSketch WP9620C with the same USB
ID (6161:4d15), so it binds to this driver. Its firmware
("Vision_V201_180530") does not implement every string descriptor index
that the raw mode handshake reads. For those indices usb_string() keeps
returning an empty string or -EPIPE, letsketch_get_string() gives up
after its retries, and the probe fails:

  letsketch ...: probe with driver letsketch failed with error -5

The tablet then does not work at all.

The handshake only needs the reads to happen, not their contents. Once
the retries are used up, report an index that still reads as empty or
STALLs as missing with -ENOENT, and let the probe skip it. Other errors
still fail the probe as before, and the retries stay in place, so
firmware that only fails a read now and then behaves as it did.

With this change the GC-422 completes the handshake, switches to raw
mode and reports pen position, pressure and the five pad buttons.

The change and this message were written with the help of an AI coding
assistant (Claude Code); I reviewed them and tested the result on the
hardware.

Fixes: 33a5c2793451 ("HID: Add new Letsketch tablet driver")
Signed-off-by: Eren =C3=87akar <hey@erencakar.com>
---
 drivers/hid/hid-letsketch.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-letsketch.c b/drivers/hid/hid-letsketch.c
index b52e93a..6a93245 100644
--- a/drivers/hid/hid-letsketch.c
+++ b/drivers/hid/hid-letsketch.c
@@ -213,6 +213,12 @@ static int letsketch_raw_event(struct hid_device *hdev=
,
  * string descriptors. But the firmware is buggy and does not like it if
  * we do this too fast. Even if we go slow sometimes the usb_string() call
  * fails. Ignore errors and retry it a couple of times if necessary.
+ *
+ * Some firmware revisions (e.g. "Vision_V201_180530", sold as the Starcom
+ * GC-422) do not implement every string descriptor index the handshake
+ * reads. For those indices usb_string() keeps returning an empty string o=
r
+ * -EPIPE (STALL). Report such an index as missing with -ENOENT once the
+ * retries are used up, so that the caller can skip it.
  */
 static int letsketch_get_string(struct usb_device *udev, int index, char *=
buf, int size)
 {
@@ -225,9 +231,14 @@ static int letsketch_get_string(struct usb_device *ude=
v, int index, char *buf, i
 			return 0;
 	}
=20
+	if (ret =3D=3D 0 || ret =3D=3D -EPIPE) {
+		dev_dbg(&udev->dev, "String descriptor %d not implemented\n", index);
+		return -ENOENT;
+	}
+
 	dev_err(&udev->dev, "Max retries (%d) exceeded reading string descriptor =
%d\n",
 		LETSKETCH_GET_STRING_RETRIES, index);
-	return ret ? ret : -EIO;
+	return ret;
 }
=20
 static int letsketch_probe(struct hid_device *hdev, const struct hid_devic=
e_id *id)
@@ -256,6 +267,8 @@ static int letsketch_probe(struct hid_device *hdev, con=
st struct hid_device_id *
 	 */
 	for (i =3D LETSKETCH_INFO_STR_IDX_BEGIN; i <=3D LETSKETCH_INFO_STR_IDX_EN=
D; i++) {
 		ret =3D letsketch_get_string(udev, i, buf, sizeof(buf));
+		if (ret =3D=3D -ENOENT)
+			continue;
 		if (ret)
 			return ret;
=20
@@ -264,16 +277,16 @@ static int letsketch_probe(struct hid_device *hdev, c=
onst struct hid_device_id *
=20
 	for (i =3D 1; i <=3D 250; i++) {
 		ret =3D letsketch_get_string(udev, i, buf, sizeof(buf));
-		if (ret)
+		if (ret && ret !=3D -ENOENT)
 			return ret;
 	}
=20
 	ret =3D letsketch_get_string(udev, 0x64, buf, sizeof(buf));
-	if (ret)
+	if (ret && ret !=3D -ENOENT)
 		return ret;
=20
 	ret =3D letsketch_get_string(udev, LETSKETCH_INFO_STR_IDX_BEGIN, buf, siz=
eof(buf));
-	if (ret)
+	if (ret && ret !=3D -ENOENT)
 		return ret;
=20
 	/*
--=20
2.56.1
