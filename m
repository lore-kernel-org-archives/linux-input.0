Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795671159;
	b=fXXawX3B1MpJ2oV/6w5pnx3+Wk/XddiKr05CEqiApFhwsw5iM26/vSAlUGMn4UmXIiwY
	 Wv3uL6XUaHWLKtRbIfzacNrAnzuehxLNpAKPIsiKOxvLie6lVFEcPbKrvN+ezZJJwqAqj
	 UwdKh1wR7glYd20tzkMm4lsMIAgjL3YZtyHMqFHw2dBH14dGtkA6qZofryFh3xfU/VwbT
	 ufXR/c18top0uNubBke+lu+ikgeh7PVq5AgsJ0E2oW77SKwhSYrjZLWG7aMAALguyz4KX
	 yobIqhuv0SleR3KY2X+Ny9yDAYJepdm09aK9ZVUlKYusUJu3SWtAFOcGq5xpx58v+Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795671159;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AK8YR/faO5Yj74bufeTDUyirWZ6wuURN4Vf8onC3ob4=;
	b=UCCoPgwhAzj6P8lSaTFkSaQpFY3HTQ10Lwhdb0fRlC8u6AwuFKkHvookAuVfHCgjGcnv
	 qabs0XWfV/bc23Bad6rz64E+JWHWD07bcF+8LSibxW5qz1LMeRYAsfINu7X0kF2M2Lyi3
	 fCG1F3JK1m9OF9NVIE+XNBqaZhbUtBMwBEEvWLp8TbnTVBYG0wGBiQMoS3fp4cCZIGToZ
	 mflGNd46caC3hc9olkRGa+v3hpXVFdUPxuI5Qo+NHhOpIX8x5s6+d2SnSuDtrIFSz328k
	 Iza94xLCo/GzuaGMGuEFe+85S/iUxjZISKVUlCb9cNDKIxFN2mkBYof0qyd26qq9hPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ggrxGOsi;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DEF606A31C;
	Thu, 26 Nov 2026 05:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84DEF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ggrxGOsi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=ggrxGOsiNtt/VGNEZ/PeulB4+nAbFypW+atC8i3w8Q904+Ku8QGx01BNRJ3j7VmGAiyHoKqcjwvIx
	 ZDoCvzhMHw6DVursq/bgjV7d/sP/5tbGKWq9FVbLhpLYUlfZ6rI3ITYnq+7EtQhDfRt5F7FhbcbpCd
	 yshnlvcrcGmbbhIY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46b07c473ac9-f839b;
	Thu, 26 Nov 2026 13:32:36 +0800 (CST)
X-RM-TRANSID:2ee46b07c473ac9-f839b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHD-W7400297 (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46b07c472e07-5e67d;
	Thu, 26 Nov 2026 13:32:36 +0800 (CST)
X-RM-TRANSID:2ee46b07c472e07-5e67d
From: Aibing Chen <chenaibing@cmss.chinamobile.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: adi - use scnprintf() for the device name
Date: Thu, 26 Nov 2026 13:32:34 +0800
Message-ID: <20261126053234.455-1-chenaibing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

adi_init_input() composes the device name as "Logitech %s [%s]" from the
model string in buf[] and the controller name in adi->cname, into a 64
byte array.  buf can hold up to 63 characters and cname up to 15, so the
composed name can reach 90 bytes and does not fit.  The name is
informational and truncating it is acceptable, but the call site does not
say so.

Building with W=1, where -Wformat-truncation is enabled, the file does not
build today; COMPILE_TEST configurations additionally turn the warning
into an error through CONFIG_WERROR:

  drivers/input/joystick/adi.c:395:60: error: '%s' directive output may be
    truncated writing up to 63 bytes into a region of size 55
    [-Werror=format-truncation=]

Use scnprintf(), the helper that expresses a bounded, truncation tolerant
write, so that the file builds warning free and the intent is visible at
the call site.

No functional change.

Signed-off-by: Aibing Chen <chenaibing@cmss.chinamobile.com>
---
 drivers/input/joystick/adi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
index e07b71978..0b60c8067 100644
--- a/drivers/input/joystick/adi.c
+++ b/drivers/input/joystick/adi.c
@@ -392,7 +392,7 @@ static int adi_init_input(struct adi *adi, struct adi_port *port, int half)
 	t = adi->id < ADI_ID_MAX ? adi->id : ADI_ID_MAX;
 
 	snprintf(buf, ADI_MAX_PHYS_LENGTH, adi_names[t], adi->id);
-	snprintf(adi->name, ADI_MAX_NAME_LENGTH, "Logitech %s [%s]", buf, adi->cname);
+	scnprintf(adi->name, ADI_MAX_NAME_LENGTH, "Logitech %s [%s]", buf, adi->cname);
 	snprintf(adi->phys, ADI_MAX_PHYS_LENGTH, "%s/input%d", port->gameport->phys, half);
 
 	adi->abs = adi_abs[t];


