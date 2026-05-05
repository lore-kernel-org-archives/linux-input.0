Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F26E3E1D12
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 08:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.92.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777969076; cv=none; b=ipm8RDci/3oZbeFJ4jq/JyfGpIwgcVchwzGl4tAhpv0YWDXqzIdTSmRetsTyviKfrSLr5q/tEgnMorR3R4gUkZKzIVEX85THpRwY1p8wO0pMiBxNeqKIdHQ2pFk8u7TshEng0wa/kiYSNya+L/5gRkFuZrb916AYjcwmYYjmWYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777969076; c=relaxed/simple;
	bh=cDggRqiMs/ONcfc9HIBOYP+wTTp82w4uSnL1lEuEBU4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=SRiF4FtpMvv8DuZ4n2AafWYuaoluRjAeVzyoo9iXX6RzrWNrPJcsrA5qspDiqIACbe1VCC/pG8SoFVoZgd1/xW1zYmGKHpLgGuibAQSr968+OVCcdEtDm3sYOHS3wpqPoUFyTIXpj/B+XvVuJVTLbk/5jXTPHwG2E1tG3+xsYkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=distanz.ch; spf=pass smtp.mailfrom=sym.noone.org; arc=none smtp.client-ip=178.63.92.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=distanz.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sym.noone.org
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 4g8rkF4XfTz4Hdxs; Tue,  5 May 2026 10:08:36 +0200 (CEST)
From: Tobias Klauser <tklauser@distanz.ch>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: [PATCH] Input: xpad - remove unused xpad_init_output intf parameter
Date: Tue,  5 May 2026 10:08:36 +0200
Message-Id: <20260505080836.29025-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

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
2.52.0

