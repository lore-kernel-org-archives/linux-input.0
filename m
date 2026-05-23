Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896953290C9
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 05:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512803; cv=none; b=maspq2RqEqloapQu49lfyXNbTws99+aLgEDeodSlIHlr/T4Gvqg0it6I836Kq3I4EJAx1ac+Rvj++5t9mn3rQCOLWLDC1m0V3RtlGN7UyyjF28ymXIHJCtqlKX4pG1LJV9Zxxd53N0+AAveEhUFp33h8URTPR+ticgK8YEg3Nz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512803; c=relaxed/simple;
	bh=khrnOXSh64A8oBJ2XH2OmpvJLC2kKn0IivBd7kZb3z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZfPpUfgjy+lIUUADwDxAYu8xQLs9Z+K4ZcrBVMRdxh6Cpt2V/jNDYKIu1BO0JcQqkQEYAgoUMMnC4Ce2ci+wVd6vtJn0Vy40VZg5+h/rqe3uIiBm1iaR3d38YxmsqaINOF178qZunG5SyEpMYk4dJwniCu9x/e4vm9c/xpP47Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1OVd+/i; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1OVd+/i"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f33ae12f97so2499069eec.1
        for <linux-input@vger.kernel.org>; Fri, 22 May 2026 22:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512801; x=1780117601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktEAdZm8Qq2zkDwBfCfBkczTqnA0709P/kUhmmDv8dA=;
        b=C1OVd+/i4AGkdvJKWuimx+2U8Tw+TgiY0pm85U5Y/KiCq1tMYTUKQHIcfb/gjWscL9
         XdYba0o0sq/438RWVjmHTMEaO9F+KmM0yVSUniYxF6YzOf7r7X1H5TRQZdzq7ezhZkPY
         lJRz3hoQktYdfhgBoxuwFDjSQgBpjjpGlpAJxHvyK3Huq6w1w8cd2NQm0SIJovDaTkw2
         IJ6+9z7X/t9aVVuvbsnnWsQ2cmXrmdefFQqC+5p4AHFHEoGnsG4G5jbYs3nlQ742Xv97
         wMA6yMW7yTYDHTCKgitXqSB/vdbQDTXw1NrLqgPvHR3Qk3KrQkNUk0T6CaIsmpxoEz6T
         TfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512801; x=1780117601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ktEAdZm8Qq2zkDwBfCfBkczTqnA0709P/kUhmmDv8dA=;
        b=rkn4PBF7yWtMapuFbh21W/C/ImkojIlalCShCiv/pRNb3Rvul/4ZvlG7gAn9EyRNWO
         ZH5F/FMd6xg3jzMO0aKziYjhHJrdY7N+zmd6hMOH3zpbaNJnnZZqDtMFOH1BRgv/3XJ7
         /b6vOKsPexVWq4Vup4jtooa3vVfFIFNwFV4FZ10XmTxW0p68mDOacJM+Jw/FE1iGVkC0
         YuOYnv/WxNDfaSx9vJVQZzr1hJJoq2Q8rJwl1gX0ivdc1i4JZDnUsn3W737h97I7peCH
         hkfIu7UCA/vOUnoSbLz7meersL53Nx1Hw0nowwr5edVksixlWDa9sdliP4+KXmNIvwv6
         JSHw==
X-Gm-Message-State: AOJu0Yx1pKrMH3s0Bg9TL9XpsLx4+3Q31jFmkcFIvNBOre2bpt5eNNGe
	LFmaPW3TatHURANgQNDwU843apjEDqm/Z/FImGcqOOt36pMvLPpDfSd7yOtjzw==
X-Gm-Gg: Acq92OEBB8YfcIUkhhv/5I6+GHKax1VKeIO9HJqNLqWUUeAMRbpVBvDgl9X1gmBYbIc
	f8L9NjRMVrSPpI6450QEhSEZORWBUAk/lv95JaReozcN+yGnSqQzUYS0c9o8hc/siwPC0qkmY9P
	VAJDGuxcCqJZe66B4KhfBfPdPrMSaIH9VSClDu35EDDtMQh4+FJTxr7nEImka/G3r3ANlK3s11/
	+F8V2IfUXzqeKGdG7U+L3PVvhXnkZYkxDv2XlLdmza+nMTQ3Zn3y0rZSbYzDMScrQaJBouE+47H
	Etu2j0INm6xFrC3xMk8wE9QlIRyrA1yp++uujBasxCtq51R3GQLefCOXJnMjU80aRKwgZpw9Csp
	ZPtNtaITEDo+pG+Wa+AIRiZK46ZUH2uIpzSlbG5UNbHyZ1yQD/xEMwY7aFwCN8ZzdAtqd9TNwtW
	6sNrxDxaTX1+cD6PRnv6KyXmFiwJDeLHkfKkiz5lYF2p8rj/btFKPHpc0G75qWN1rq4qc88i49G
	ZyiyNa7Lh0K+ujElFsftzMHkRRu8b17d4Y=
X-Received: by 2002:a05:7300:bd03:b0:304:188d:d0b0 with SMTP id 5a478bee46e88-30449141795mr3396835eec.20.1779512800552;
        Fri, 22 May 2026 22:06:40 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm3502583eec.13.2026.05.22.22.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:06:38 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko bot <sashiko-bot@kernel.org>
Subject: [PATCH 02/11] Input: ims-pcu - fix use-after-free and double-free in disconnect
Date: Fri, 22 May 2026 22:06:20 -0700
Message-ID: <20260523050634.501509-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
In-Reply-To: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ims_pcu_disconnect() only intended to perform cleanup when the primary
(control) interface is unbound. However, it currently relies on the
interface class to distinguish between control and data interfaces.
A malicious device could present a data interface with the same class
as the control interface, leading to premature cleanup and potential
use-after-free or double-free.

Switch to verifying that the interface being disconnected is indeed
the control interface.

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 57d917387544..d0934d577b5e 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -2071,7 +2071,6 @@ static int ims_pcu_probe(struct usb_interface *intf,
 static void ims_pcu_disconnect(struct usb_interface *intf)
 {
 	struct ims_pcu *pcu = usb_get_intfdata(intf);
-	struct usb_host_interface *alt = intf->cur_altsetting;
 
 	usb_set_intfdata(intf, NULL);
 
@@ -2079,7 +2078,7 @@ static void ims_pcu_disconnect(struct usb_interface *intf)
 	 * See if we are dealing with control or data interface. The cleanup
 	 * happens when we unbind primary (control) interface.
 	 */
-	if (alt->desc.bInterfaceClass != USB_CLASS_COMM)
+	if (intf != pcu->ctrl_intf)
 		return;
 
 	ims_pcu_stop_io(pcu);
-- 
2.54.0.746.g67dd491aae-goog

