Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.63.92.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581999;
	b=W2W0SM50ltQGFr/UF0rzHvP6HVgHmpPd6wO0Itozru75TQZj8XzKIcbq7g2JIQ/wykTt
	 RDyiAaudOTq2KteLa9lSnS2IYY0CWbfQNyVNonDS3lRRn+UOHnJXQuTCapTBhZ0IIMiyN
	 eaoCNyIHLmNTg5PEdPs6/qVzFBvSbf7W4gu3QqXQfBm9k0YBn22B308Rh9v0VBSHDF/0J
	 LQFMB88A/9vVu9xNzIgRNj4V9/17OMZfL14yhq/HiTKqpmG92mUbk6klDQLOkwr637C0q
	 T7LFrGr61uMRRCMxpnoB9SPPyZVljeuvo3USTcYwwIYKou1zs6dtUmYWrTrlPMav0Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581999;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer;
	bh=Q0lxaogjG/Y/TYaWsG8EcztbOtjUc9jjj1x+9dmoKOE=;
	b=YY/aKkpUK4vbDNyVfsHCdNaCYaYshUmBhzJwACHCOM3rytn8MQtm1LN4VM12XTxBoXU6
	 NKLW4CkajdeWg5oyKDrhuxFJunJ4FztP8/fetdP4FotjdJ8XP+Oo4UkHnzgWrwyBiawqX
	 xBWL3O5SkOlN96CB3MCImrBIwUSuk1L0tPxl8U3bXnBGJe73nS5ey4WYDMmSeNiEnHHV5
	 4OqH2ywJ6fqRS3oixtS7G/zvaFY37MM3stUi8h6TFCErKp6PJAzSZTf3IU4rq5zcTI+FP
	 TvGe/Z73mU7LjU3rbKsxdb56MV68wKwypinIxYyKEs4EJEWFDPN2lOBtt4dQO97NOzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=distanz.ch;
	spf=pass smtp.mailfrom=distanz.ch;
	arc=none smtp.remote-ip=178.63.92.236
Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0BF606A319
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 11:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD0BF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=distanz.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=distanz.ch
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 4j8n6M2q82z2FtkJ; Wed, 21 Oct 2026 13:26:13 +0200 (CEST)
From: Tobias Klauser <tklauser@distanz.ch>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [PATCH] Input: xpad - remove unused xpad_init_output intf parameter
Date: Wed, 21 Oct 2026 13:26:12 +0200
Message-Id: <20261021112612.31851-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

The intf parameter to xpad_init_output is unused since commit
c01b5e7464f0 ("Input: xpad - don't depend on endpoint order"). Remove
it.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/input/joystick/xpad.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f834..4c5528eb94b3 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1388,8 +1388,8 @@ static void xpad_irq_out(struct urb *urb)
 	}
 }
 
-static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad,
-			struct usb_endpoint_descriptor *ep_irq_out)
+static int xpad_init_output(struct usb_xpad *xpad,
+			    struct usb_endpoint_descriptor *ep_irq_out)
 {
 	int error;
 
@@ -2136,7 +2136,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		goto err_free_in_urb;
 	}
 
-	error = xpad_init_output(intf, xpad, ep_irq_out);
+	error = xpad_init_output(xpad, ep_irq_out);
 	if (error)
 		goto err_free_in_urb;
 
-- 
2.55.0

