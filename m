Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BDF2ECD3A
	for <linux-input@vger.kernel.org>; Thu,  7 May 2026 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169669; cv=none; b=BSh+k2vkMu66zqYFqRQ94h9+rXoKEALskJmxg5vkXYhBSEZa0nJYJ96qCsgsjMJWXr3wIi41XDRWFO4aY2HS3SvV6/eY6hkvAIzBsEnjcUoWn7dSK6R6FpxlBt26rJ3MK5W5KZXkW1fbcu1CjlvMndkkvBgp1lh2tYD863ZGGSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169669; c=relaxed/simple;
	bh=86jRR31hIPAbTyJgTd2g7ztp0Z3nq4R7yWQU9JC2EgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TxB4dS0eajvlG7gRZ0bh82FBpjwD7W1Y3chG/MAyUfiItdt02IXdIgTnlNi7miql0Qh7Wd8wQ9tK9pufXOhVajvyE9FXE8UWutSlJJmxjvHcWaHOADrSVtKZEOVh+7i+vsj0v0Y3C4X+9h22JesZgNEowyVWkcANSYrj0J9JUmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=oWlxZRmk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="oWlxZRmk"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so12112215e9.0
        for <linux-input@vger.kernel.org>; Thu, 07 May 2026 09:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778169665; x=1778774465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9mY1tVNrW57Kh0sTQRfRQC2YJ59ZYARhe+FwxccACwI=;
        b=oWlxZRmkysia4RjSFkjpMyhcfPfbL7j8fYlloxdaNb4I+i4pHEQuUykjbUv53zv9ja
         gyAn9n0aW20stb0Z885/fQFQ0/04pK1xXV3rATeka6fQh6SQwCTBQnAUZVmz5kbHyug1
         +fW7gHQMjJPRcM3wPnivkmCts8b/94iQhFcNka8DXM0+fOUx8VJSbriLtfJhbR7u0rXY
         8XLg3ZZsjfbBllZnuQ4teME5i1i4iPZrqgSWvNDzhVDW6WUNvvcLtHq03j46q+xgIqcU
         2yrcmqYghTC3Whvmp8+nV3pFUQytVuXCn/i39THqomocjgtGwEPpK4jSpvjUC6+zlXZc
         2S9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169665; x=1778774465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mY1tVNrW57Kh0sTQRfRQC2YJ59ZYARhe+FwxccACwI=;
        b=KtR8Mrsf9NvqMfT/8uKRtkbt/kr39cL6n3piPcaksMtedNbTNfvJ1D60z51YS5mX09
         6sRer5q6UqFv1jWzBDjl+boy5CmfWK8pZEm/aWfHqQRDwhtM1igUWkph9DiuFXZ7nxLQ
         AQNEq2MZun43hg7qHgds6O1lV644V+9FRihk3BC14MXd1jX2jrpzofcqnaxcgMhHEe81
         M8Gn1sfK6Jm7MVfc8ii6YgMSRB2i1nk4sgf92EYxYGruUmQjMWZZVZu0v63KvGHVlsdd
         fb/CCeRJczAm2v/Az8OWx4hLWx8vyiYgHRcoZOLLuPMUZ4HoyF1Y7ct+kLGnCOOVwWTW
         okdA==
X-Forwarded-Encrypted: i=1; AFNElJ9heAWqvyXPbVjI5c0GBtE/vC9MsgyuVdbUWv85KfQJbsU+4/pVrogRyIgVX43Rhbii6aBex4niMr2KPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGyXed2IJCzz7I492HrkAGWtJ4C9TubirOf4o+BhBpTbgw1Y8S
	tAhNX/K74pkD6Rbvaz27FTfXSmvd9TPYcyFIq32CiKR6ghVk9ICh7Zd/z4XNA52RIGY=
X-Gm-Gg: AeBDiesTztJwm3MzTQSuw8x7YKNHTmPp6n46OnKuIqwvkrFGJwO9VKuGB/gH5vsDucm
	XUOhBi52JpaeTYVK+c9gI0RPFQhSdspMEE2PfS0Z3PGEXnT5Z2vOLYo/vxfxTjqc0l/C4Lo1BMs
	43EuDhdKgyfvTcEcJX5muduFj24AqvS64QYhi0DkZ5pDp+dg71+jP3PsoM5twYI2Qgm6/lECVyM
	EfRzGnf5/VdujoJTUQDQAu/KfbYfYBx/8OB4yfxE+MjH07Yivilnk2Ff70RXDLkcS7Wa2ATevup
	8uCJ01eLK++XhuYus4Dl2Jx1Siatn51ABmqv309Fg7GI3KSUR+fGvvcpri6VgVafhMGRSzRW8KV
	Ai7R4t9lXLcGJdXHufA/o/NBbSdWpmNdRw1zc8QZDZswvgUKRMzipNlG3ySaZ5bOg9+WRyuKXUB
	kDZR+vTDcx0IFv66ynZWqiOISJCU/bzSKfYaVAsQdZEt4RN/3vkuSSnKBxu0HytNUBI3jn5OSwY
	BCb6kn5RlPW8cqc1debXJxBoA==
X-Received: by 2002:a05:600c:3ba8:b0:48a:7676:30bc with SMTP id 5b1f17b1804b1-48e52bd5035mr155353985e9.14.1778169664638;
        Thu, 07 May 2026 09:01:04 -0700 (PDT)
Received: from localhost (p200300f65f114e08e9fd60f450b139aa.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:e9fd:60f4:50b1:39aa])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48e538ca8c0sm122659875e9.13.2026.05.07.09.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:01:04 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH] Input: gameport: fm801-gp - Simplify initialisation of pci_device_id array
Date: Thu,  7 May 2026 18:00:51 +0200
Message-ID: <20260507160051.3315630-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1639; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=86jRR31hIPAbTyJgTd2g7ztp0Z3nq4R7yWQU9JC2EgQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp/LczjvJtYopiO+2ZbYLnq/s9agZgC8fDURREc 2UElKtfRUKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafy3MwAKCRCPgPtYfRL+ Ts0NCACDP3GT0wUDd+Z7vZCKAhGBmOAw0h++WjUz/Ka78joOr2KmFS3Domr0Ly59ykA0meIoQGT +vtoZ9B/LkYEUctgnVGfXUZYpB7jUenIuzf7xm4xPRlFqVUvSruHr+E9yi/Lt1z/Q1CZ5tWahtK OMGwhsNPVWET7l5Y+QtGN6+9krQw7ChnUX9O9srl7kKDml4ebMDywUW+lte8S2x1/PfhSUvI0yX IMgvKuVbI6OS+GP1NI07782Htd/g3Wh5GTWw3bilBqakKj//PYNtNPoSPtqfmXCKi6R9UQnlEc9 OMToXCljmiRP1avxP3C97azXtsHPYXIWVcT4zN6y8UiR1VXF
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Instead of assigning the pci_device_id members using a list (which is
hard to read as you need to look at the order of the members in that
struct in parallel) use the PCI_VDEVICE() convenience macro to compact
the initialisation while improving readability.

Also drop trailing zeros that the compiler will care about then.

The change doesn't introduce binary changes to the compiled driver,
verified on both ARCH=x86 and ARCH=arm64.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

this is a preparing change for making struct pci_device_id::driver_data
an anonymous union (similar to
https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/).
This requires named initializers for .driver_data. In this case the
initialization can be dropped as the driver doesn't make use of
.driver_data at all.

Best regards
Uwe

 drivers/input/gameport/fm801-gp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/gameport/fm801-gp.c b/drivers/input/gameport/fm801-gp.c
index 423cccdea34f..1e8c6c044844 100644
--- a/drivers/input/gameport/fm801-gp.c
+++ b/drivers/input/gameport/fm801-gp.c
@@ -125,8 +125,8 @@ static void fm801_gp_remove(struct pci_dev *pci)
 }
 
 static const struct pci_device_id fm801_gp_id_table[] = {
-	{ PCI_VENDOR_ID_FORTEMEDIA, PCI_DEVICE_ID_FM801_GP, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0  },
-	{ 0 }
+	{ PCI_VDEVICE(FORTEMEDIA, PCI_DEVICE_ID_FM801_GP) },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, fm801_gp_id_table);
 

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

