Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB21941A4E1;
	Wed,  5 Aug 2026 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923806; cv=none; b=IiqRwE6lqvOOimG9v0WsoGit8dgJI/Xa2zo+bxWz4wH4DhB9IDir1lAt4L6/W+EflwiEdmE7qyAivL9Ju55dyNp/LxPiojDQ3xRbWqoxLENaYh1P80wvcx/YNs19nIFgJZYASwLZby9+Ks9vx77drBxIiZyMH3Ja4xKnGOQk3fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923806; c=relaxed/simple;
	bh=ysulJ+qIdP9M03dX9q3uuIZsRi1KA0P5wAYKVrFTxkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r9ux3AjeWnuKFFZaIusbqhjXpXPXbtOB3/NEQmqAWHSV8GrsjwWVTXMakT37DqNo7e6GG0NyrpwjAX+oJppE+mpVoVZusVJ+mlhLNL6V0PEA46t47jGlFINeNqXOLovXUaf7yPEXFW5QBUc6N2KACF9V80+qSeWS7Ul0PvRn+60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=lEWTKV4c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aQK1Hooq; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="lEWTKV4c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aQK1Hooq"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id BCE031D0011F;
	Wed,  5 Aug 2026 05:56:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 05 Aug 2026 05:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785923803;
	 x=1786010203; bh=fC7lT3XFqTMVz0S9gEzMPr616r+hjTfz37jKvq6p+Zs=; b=
	lEWTKV4clADGaDUqYEyBURKNkpGKyfsXz2RYiKImgtKADKht5cexo9+qT6mFqQz+
	u6GX3U2K0K6XcmojEeLicQ5qfbN3QMLxXMk43tOP9YEJDAaZcU/hWi7SqHaK/O5L
	OECYYJBCEVsCSDjWGZNq6KakVd6rvR+xIVGvudt3zgi0G8zS60Zq+3niusmnf19a
	eqZJ1frEpr4RFqCHpBgc2Y3ZjIX6SVXhu/xPpit0fI9YsJ3BgL7y/QC0soG8YU7P
	GvQodOkr9JFv1fB2DsqcibziPFMSmVRRdiPyP7v1VSGfskmexprfhYBImjkbUBaP
	b71QLwPoMYRrxp/KY+CpGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785923803; x=
	1786010203; bh=fC7lT3XFqTMVz0S9gEzMPr616r+hjTfz37jKvq6p+Zs=; b=a
	QK1HooqnCCwug21fYZ/S+3J4/xsXk8zejDCic7UR7Esz29iHqtA1Zu4TqJKDG6D9
	8rJ7qqDL+EkXtCDZQ6zWJpkyz0G89cocnNjxoWvGv21UnLET76JvhmLyXbGTR9ZO
	Rfazex4zimNW3taiY2nsrwH1HzkOiWgskdxr9nSWXa5u2sAJVs74XWJDE8zN40VB
	W/1LbOeiBXmvTzTWoeoIfVrCNMbgo0XnM+HWIRANNZSeSix3A351xiQ887mhvq/C
	SxUtvSAnrNon3oVNg6MZSsnAEdj/g+xrnOqOvns+Buh8AM5RdDltOJ3kYW0lUPmi
	9SGjSpVZihgFBqsVbI15A==
X-ME-Sender: <xms:2whzav65vWtLi1DNZ7_TLizdFZ1obtbemydZeWSj_8nUQctHOQSTTQ>
    <xme:2whzaitzKuia03YVXlSvPUxR4wQ5KqiYPCw9ZOsr2hkh8lOmAIrQreiUz3JThhRvr
    Mdxxli8HBdlFXYjyx4WNA3AU1RHBP4QDV-YiLRk9pKt2B9jnTx6>
X-ME-Received: <xmr:2whzag7hcCDo7vF9HD1plQ-4ng5sonPDDAEYrs5pP5WL1ORWsIFI4eXMPw75a16IZWZyJF8s9Nts9KtJ9gGmFbWX7-tkCvktFZFzijTKbDHUUU5CagA>
X-ME-Proxy-Cause: dmFkZTGFmieYTi6XVSD9JS6fFv4Co7/tsx/JNRmS47kQ29d8pHJTrqV8y2YYcKvdOSEOsy
    amltvU1PihpoMPE9lypDUg/6+RcLmLeiRhVhdB2TRj4x7BXBh5Kqp/k0BTuFPaJJ0fGabH
    Di0slKmG24fGELEppYniAqsRVJURoRRgu2i2BK8GLrYmli4SKxSi3n55E3H/0a5xG+zG1s
    Lho5fEA7CE0KIIug9ZFYAnjcLRWNtDwaYdrQhrTZVUzMnumGGsz2QIwo6PhT3lSk7UFoc4
    O7RUy6ZFvCTjOQaAr24VYGuRnM5Zj4wDzO4ue4+btCjvpfrTYOjaj8Dibz9zfHzSqkJEF1
    zxzYjW7lnQC3C8tYsRWj7nQwR7H+vth3qonhl3P2zzqV1aA6r8XX1FWJ3Gl62iITS7QqLR
    K4wr7LL7RcYMaW7ir0rnH30OM6jV4wquOmbEA/3UnygoV1uAx4oIIV0tC+cJbP0u0XDZcB
    DqYtKJKtlidGlqeZQtMFINeidZCA5/rxZBf0YxPp3LumPRBvYmLBY3rYIeUZhAF674vhnV
    fYSujmwpTq/oHgqpcA6zUdNoEBeD9nV+t5Jx58q8GZsRVhj5LF0ixPutpbg2KoOspUuvcm
    860rCixJCu51OQHVz8H1eu0pRPXg9Kby45EbAIB5HVDkrfoMKasIYTwysRIA
X-ME-Proxy: <xmx:2whzatW0wCVUNj8pLIr6RGWZfIImqGnQwjug4yYl4uwz_tJquRD9cg>
    <xmx:2whzai9wyycxLfSq6-9i2uive5YOcnVAXqvh02s-eFWWDYQQ4p5J9g>
    <xmx:2whzapnk6QBZ9bsgPf_svz84E2KM72HbbVIlzzZspz8TLw8PO8Ev5Q>
    <xmx:2whzagVeFpVeolPVGSbwlhJhfWq5W17cVshGjjkj0eBYZWe_uUQZMg>
    <xmx:2whzauRESYDxzZ72Rx45IyOqLUdKliS7oIkT8gbTCi7WKKNqHQuINyRr>
Feedback-ID: i1d2843be:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 05:56:42 -0400 (EDT)
From: Griffin Kroah-Hartman <griffin@kroah.com>
Date: Wed, 05 Aug 2026 11:56:36 +0200
Subject: [PATCH v2 2/3] Input: xpad - add packet length check for
 xpad_process_packet()
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-xpadone_length_checks-v2-2-f3e925e0280b@kroah.com>
References: <20260805-xpadone_length_checks-v2-0-f3e925e0280b@kroah.com>
In-Reply-To: <20260805-xpadone_length_checks-v2-0-f3e925e0280b@kroah.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin@kroah.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785923798; l=1356;
 i=griffin@kroah.com; s=20260706; h=from:subject:message-id;
 bh=ysulJ+qIdP9M03dX9q3uuIZsRi1KA0P5wAYKVrFTxkU=;
 b=xb0D/E6AM+YrymkHhVmkKTrTzAFLbI2v25TrCC+sM2leFn6yRp4zXFOfOHZ7rZZun0UxFsnXH
 Ln2m2yetDYOCK1F77MIXnMe2B9Po6E/9/nrXqIGu5AffSBIS0VLq8b9
X-Developer-Key: i=griffin@kroah.com; a=ed25519;
 pk=Hy1TuVHERdQhLAWwjmxLFNtGj7eEEjaZWPXehAlic5M=

Add a check to ensure that the packet being processed is not less than
20 bytes, which would enable an OOB read if true.

Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
---
 drivers/input/joystick/xpad.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 9ce792503b3a..83bc361b15f7 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -795,10 +795,13 @@ static void xpad360w_poweroff_controller(struct usb_xpad *xpad);
  *	The used report descriptor was taken from ITO Takayuki's website:
  *	 http://euc.jp/periphs/xbox-controller.ja.html
  */
-static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
+static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data, u32 len)
 {
 	struct input_dev *dev = xpad->dev;
 
+	if (len < 20)
+		return;
+
 	if (!(xpad->mapping & MAP_STICKS_TO_NULL)) {
 		/* left stick */
 		input_report_abs(dev, ABS_X,
@@ -1259,7 +1262,7 @@ static void xpad_irq_in(struct urb *urb)
 		xpadone_process_packet(xpad, 0, xpad->idata, urb->actual_length);
 		break;
 	default:
-		xpad_process_packet(xpad, 0, xpad->idata);
+		xpad_process_packet(xpad, 0, xpad->idata, urb->actual_length);
 	}
 
 exit:

-- 
2.55.0

