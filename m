Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C5B41A516;
	Wed,  5 Aug 2026 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923807; cv=none; b=QjXqoMkJllMrMF7OAhu5vLyLK+hb1WH1gGML9t6ziy8hevUD6FHK1c9D+S3oy6tlRvdafgNwTb2QWdJRFzMzZsqCcgPanOODYVt68sftdvixIVh8LOz3YLmSLGNTw5QMrB0rOoey79t+hYiow8NcX5vsdpgIgULeS25occNklHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923807; c=relaxed/simple;
	bh=jNdWbaG1JTO4YVucHlz45Nf1w5WMDfgHYsy7ENTovIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D9Q8mhRcGfYImwLtL1jpoJ29NA92VZSFIN+59ToQyeMesJ6APq6sxAMYswyrpEoQhs4JjPHcX1XYhQMyXJwp0mZIZ7vIszERmWoXubLE6kiWBaGLP0LIvocR/ZYTZz9EIAdxB1I0z0b8EXR1QMy4bs9Uux8f1LlmmeceuDCuUtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=QxpGBPP6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jbKeg0Z0; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="QxpGBPP6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jbKeg0Z0"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5AAF37A0160;
	Wed,  5 Aug 2026 05:56:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 05 Aug 2026 05:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785923805;
	 x=1786010205; bh=9H7tqjmM41XGATvnizOzKXIiYIaR1C4nEL91sCrc0JE=; b=
	QxpGBPP6N4ifhSMb/hCdG3se1V73u4SqBPiTnrmo34TjOvVRpopKjMsYLxMD3+HX
	hwkdM1yIBxs2un1F55d6WoOsiethNw8cHADbKPxLNCDclXaL79AY7IgCa5gp+2SW
	UJG6sLDmnw5Inq5t4T4OMgtV92PcpNg0IVgc9ov8jyKhUOunl+iUDgGgaDpyxGVn
	CE9qWnBmTVU4qwZorvFeXSjFRM/cF7jIZ/jgjjUCtix+aEuVe+PKlshQ+uwO11wa
	l1jD+3TOrtU/JPHqEMuaM18elDvqNAzIGC2j4Ywe7Jf4N4ivUkJnmEleT/iADwXT
	PYW4mBsGyAYMk4Em+5hEHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785923805; x=
	1786010205; bh=9H7tqjmM41XGATvnizOzKXIiYIaR1C4nEL91sCrc0JE=; b=j
	bKeg0Z0gZsu2f2scOZlyLevjx6JWqa+6lLV9yXZov1MyrgTaKV8PjFZ1ug4rmkA+
	9Ddli3mvQcYdfdW9DgmLGxNlrV4QmFgWOK6GbzAFUqKfn2U2e1c4LUqwxF++EiwA
	cW9VqD2UhuvBTeAy35/aGg4SbBEDatWhoSl203R6ZHCHQE3NsLVMv9p9J3tHBmUB
	+EZr8uIreTvpzjYfDSvoEQ1fxI9/GVfAg3zqAp5va+Ku+I8Sdzn2eDOQZQtKnr8u
	DfnFHGA6iGUrXNH5eA75+viJFkYDwx23yBSLib3fnmvEomvnWhfbkORkEF9JrQ8M
	cZJZZ1Of//xid5F8rUnJQ==
X-ME-Sender: <xms:3QhzalV__ILHQ3Qfu-kHzZ08jK-U5XiBGKXP2eJavNMCp7vp8EHlTg>
    <xme:3QhzajajZJGKY7-QZ7aRrHP0xz2AqMGGQr-97O0LA_j4QMxcOYoBWSizyxr6_MRTT
    RHAzVBCOSmU7YZDtqr0qTJ-0gQXU8SwRzSP8iULVqdw2AVfi5Kz>
X-ME-Received: <xmr:3Qhzar03hUnXRFVIodj7mnuwRYXl8tVoFPlzJlaa6XhJ5LPOVyRFaWeCPPcw1SnYZ5YqWdWQdZpXQ8E4RGcwLlZGczCiPoiKpR3yoELRwLkAhwylO-A>
X-ME-Proxy-Cause: dmFkZTErfihmOAQGP1owjinQa15+b58ASSp2+EpXbMDCY18TakmGdDOd7kS8QlWJHK6Akk
    JmZvI11v1vDpWVeMy6GH/+8SXf4DfFC67MWfsrwTuOZlktEcNWSO67WhyknexN3hurM52E
    ADVRYD6u8JSJGsN3tC4tRthmsBlaFiKaSBh3tN/tFOt1dPnIBaUdvkvArJT1bKgqhDCslM
    Zy6lNXyqgUvtM8btJ7En0SOupr11+pqUULhGqHA5Xo7BkWIYuoihnYrmFQrckUAzC8jg0M
    bT+BTxqemc31+eHPm7BJ8b9lOgPt4Ddk9WdbOw0GYMtz+Xdu83vxH5m557vnBS97gkeCp0
    PesBTdyxrfMiB7S2PN1OYfS84u/qV8e0Cx10cFLrgSj7Ij/VFYkABcB+GeT2KnjR/GhyEs
    zhjmh6x8eYibI82GQ97wJ19Sc3Z8IJUf+/DD5G2YJ6ZU/B0hfj9zC7PP84F4vB5j1gNCLN
    Q8/YYP2AsiZHeFKuFFAJ0SShvu7ZbBTbOSdMCNEF2/kDAF+woUSy8QBIWoBKVF7Q+pLkgz
    ybHaMYSbjmO+bnQd298fUFRQkGcoYUXcWf4vWwlZKrnNHyXUPvYj7VuxusjVRg5WyiPJx+
    PL6mps7NRlEYgLj0pQcK/DLdpJHLnqMoYi55cz7X7exZxifJ9Bxx/ZqA3MDw
X-ME-Proxy: <xmx:3QhzaljXnpTOFOoifLUwnsMvT-5ignBSBV_RbZ8PGFCxSVbpDvtanQ>
    <xmx:3QhzavbTJVp8wIGNqQt1UECdYdcUhGYI6la3qabsx0YltMawfbwDnw>
    <xmx:3QhzalQqfzT2YUQHyECLxOGJwTpV595_B0sJb6SBatrqQEG5LlPw1g>
    <xmx:3QhzaqQQrxpYXREyuqyujwFrhboUmM3APAncKeZt2JkseqQ03TCoAg>
    <xmx:3QhzalMsnKtOpa9CrrzK6KkwREq0xUHr1KTKR5Wr9i3gMqVH35TjdYrE>
Feedback-ID: i1d2843be:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 05:56:44 -0400 (EDT)
From: Griffin Kroah-Hartman <griffin@kroah.com>
Date: Wed, 05 Aug 2026 11:56:37 +0200
Subject: [PATCH v2 3/3] Input: xpad - add size checks to xpad360 packet
 processing
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-xpadone_length_checks-v2-3-f3e925e0280b@kroah.com>
References: <20260805-xpadone_length_checks-v2-0-f3e925e0280b@kroah.com>
In-Reply-To: <20260805-xpadone_length_checks-v2-0-f3e925e0280b@kroah.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin@kroah.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785923798; l=2267;
 i=griffin@kroah.com; s=20260706; h=from:subject:message-id;
 bh=jNdWbaG1JTO4YVucHlz45Nf1w5WMDfgHYsy7ENTovIc=;
 b=QCytBoRe3Vtn8W6U5uZXZSgAA28DPBbtFjfL552fXO5n2yBst0E0pJoevzm3PfBHuoRf94NhO
 w1C7XBmrJKpDukPBPI8OyaQbWvumTEwTlpeqI7LQ4gRE4k0QAxBVZfy
X-Developer-Key: i=griffin@kroah.com; a=ed25519;
 pk=Hy1TuVHERdQhLAWwjmxLFNtGj7eEEjaZWPXehAlic5M=

Add size checks to xbox360_process_packet() and
xbox360w_process_packet() to prevent OOB reads with the data[] array.

Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
---
 drivers/input/joystick/xpad.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 83bc361b15f7..6f15eafc6477 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -870,10 +870,10 @@ static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *d
  */
 
 static void xpad360_process_packet(struct usb_xpad *xpad, struct input_dev *dev,
-				   u16 cmd, unsigned char *data)
+				   u16 cmd, unsigned char *data, u32 len)
 {
 	/* valid pad data */
-	if (data[0] != 0x00)
+	if (data[0] != 0x00 || len < 14)
 		return;
 
 	/* digital pad */
@@ -998,11 +998,14 @@ static void xpad_presence_work(struct work_struct *work)
  * 01.1 - Pad state (Bytes 4+) valid
  *
  */
-static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
+static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data, u32 len)
 {
 	struct input_dev *dev;
 	bool present;
 
+	if (len < 2)
+		return;
+
 	/* Presence change */
 	if (data[0] & 0x08) {
 		present = (data[1] & 0x80) != 0;
@@ -1019,8 +1022,8 @@ static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned cha
 
 	rcu_read_lock();
 	dev = rcu_dereference(xpad->x360w_dev);
-	if (dev)
-		xpad360_process_packet(xpad, dev, cmd, &data[4]);
+	if (dev && len > 4)
+		xpad360_process_packet(xpad, dev, cmd, &data[4], len - 4);
 	rcu_read_unlock();
 }
 
@@ -1253,10 +1256,10 @@ static void xpad_irq_in(struct urb *urb)
 
 	switch (xpad->xtype) {
 	case XTYPE_XBOX360:
-		xpad360_process_packet(xpad, xpad->dev, 0, xpad->idata);
+		xpad360_process_packet(xpad, xpad->dev, 0, xpad->idata, urb->actual_length);
 		break;
 	case XTYPE_XBOX360W:
-		xpad360w_process_packet(xpad, 0, xpad->idata);
+		xpad360w_process_packet(xpad, 0, xpad->idata, urb->actual_length);
 		break;
 	case XTYPE_XBOXONE:
 		xpadone_process_packet(xpad, 0, xpad->idata, urb->actual_length);

-- 
2.55.0

