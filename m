Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D028B3B8D4F
	for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282273; cv=none; b=Wj/lblUsvNQTttwuH95iWAdAa8Wt/5Xh/K3sHB5Ox4MSB1Sq+UKPrLZhpWQvS3qrMY/hipV4T/7AkvCuDtQvWSN3LQwPcrOu1yxGGC7LamfN9qS4UZvP76sS04y3tivXpLhegaEyIZBSbEgr+EWmlQZfRXryYmZCxIoRCbMjAqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282273; c=relaxed/simple;
	bh=Mt1Am2t3biaKg2W2NtWGSBBeDYtWKoivT0JvQXeI0/s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dDQdoNO/BahaxldHG/ktn+g/ODC/46e8FwxPngXJekP32BN4JflAn0r9AyBuJ9zcS47ONcpqEk17wOi6NwjLEluCu/pbHW3JiidOgB5HbgnWzqGbCnwLwAaek/QnZOjfAOzbnJwgJsmaQhfuKOXYv7rxTIyJR2ymv6DbHE8giGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vq+3a47c; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bsevens.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vq+3a47c"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4853a9467c5so31713535e9.2
        for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 09:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774282270; x=1774887070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iiQ685EgAbrcxfrZUD53HFGBnXDwiME7qlRMAdkC2yw=;
        b=vq+3a47cxc8aGN/XdmmTSUlY3i4/U9+I8EuOSjfqPdcOzn81gS/bfiFdKVFbZ4wewG
         nqencMYa09mQeRv4SLN2HoMXGZEIPVFUP09Qxgbu9HmkcY3mtqjnuncG/TMjOaqmJcfP
         X5hYMZhE5Mtbc/0lJkmYQLgDlwZ8QtJdWpUi/P7Xm5R0MVwAz5nSVdYtT5YKAfJePvxf
         Ptx8xkidUwB9+oCKxSEKpMoNloKjNf7WLd692grAwHmsD0ORX/Xxbe8viEwT5xgoz4Um
         khphQ3HCjgih69IOBAmP4GKRPO4+FSKMsPXkPRhGgwqSna7eZZtgXicCAW4IH4fy7IEv
         GdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774282270; x=1774887070;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiQ685EgAbrcxfrZUD53HFGBnXDwiME7qlRMAdkC2yw=;
        b=k9DO1nuGxxteAz9UV9flArmR3JDVD+aej+wss2FSM9t0p0HNOMcaHoOuqWHoCrRR2f
         5Ha+HU/Fb84nRQHA2jgqAEP/4gwVQ0LPPyOn3r3KkuBj9G9TmVBiwso54BYoNWyXW5Bp
         448V9G/WNmC3ua/3a1EGUT9FYTlFahb+GtsB+YsWFZGKOBHUQUjt7PZR/Dqia5bRqST4
         ugd0N7mzgg3CzA2XUrazpTyyq1y1lTqGdxtWCbzaOUMWBvKRG5BNF7cO2sN39ZR7qkmR
         MDwI4cjqHdLpm2a4/BCcM4NsCqk5Vw7xSoxEgDqBElED+uEECX/S63guKjnGi/1+I6Sh
         G7jA==
X-Gm-Message-State: AOJu0Yx87aEglwMuy1My+jQ3yLoTSanFF9GsIcokosc9C0myJcGr/Z+Y
	idrycPNGaFbl6CIkeHi7GSSzYw+z594ULTWsCUI8qYtVJdMn7PdHR0zF0JSDluQX1KqMlVchRxt
	BJ8kCywpn0w==
X-Received: from wmbil21.prod.google.com ([2002:a05:600c:a595:b0:485:35d3:c8b9])
 (user=bsevens job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8908:b0:486:fc95:1a91
 with SMTP id 5b1f17b1804b1-486fedb9003mr129206635e9.12.1774282270059; Mon, 23
 Mar 2026 09:11:10 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:11:07 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260323161107.3478633-1-bsevens@google.com>
Subject: [PATCH] HID: roccat: fix use-after-free in roccat_report_event
From: FirstName LastName <bsevens@google.com>
To: Stefan Achatz <erazor_de@users.sourceforge.net>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Beno=C3=AEt Sevens <bsevens@google.com>

roccat_report_event() iterates over the device->readers list without
holding the readers_lock. This allows a concurrent roccat_release() to
remove and free a reader while it's still being accessed, leading to a
use-after-free.

Protect the readers list traversal with the readers_lock mutex.

Signed-off-by: Beno=C3=AEt Sevens <bsevens@google.com>
---
 drivers/hid/hid-roccat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index fd0ea52f7cba..d6fff53d4ee7 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -257,6 +257,7 @@ int roccat_report_event(int minor, u8 const *data)
 	if (!new_value)
 		return -ENOMEM;
=20
+	mutex_lock(&device->readers_lock);
 	mutex_lock(&device->cbuf_lock);
=20
 	report =3D &device->cbuf[device->cbuf_end];
@@ -279,6 +280,7 @@ int roccat_report_event(int minor, u8 const *data)
 	}
=20
 	mutex_unlock(&device->cbuf_lock);
+	mutex_unlock(&device->readers_lock);
=20
 	wake_up_interruptible(&device->wait);
 	return 0;
--=20
2.53.0.959.g497ff81fa9-goog

