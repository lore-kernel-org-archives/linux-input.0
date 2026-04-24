Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D023D4114
	for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 13:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777036924; cv=none; b=k1/y7VJMd19Wdd6V3vjJPck7h+Kz0pRujHpg0KFYUEoHdVbCirg2+E87lZH8dY0dbeKphykJ3YotQfYHSP7HCIQB0oEfRbuMpllVnE0UGb8TIIO0EZaKteOUwGIQ433hYohf37JTy18E/X98AF/0k8sH+QODDFun3Q0pISugnCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777036924; c=relaxed/simple;
	bh=eTYYUYoBCUJYd6cOvj5WMnAu4WIx1W9ruVTfxT+rW2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pGj5FF8u9Jfj7b41sm/tuovMIrQ9h02wLK5MPWlZap/bwR+SxbW8/CsUA+4CUGqhpcM2jYTwU2LvuOJnfRQES+blfgHulSD5aoFNbgSZ9ziZ3XleJCMiHEnPRwa+bxJhSoENGZ/s2X7T4/2yVdJX1DV//V0vl0eeMTj0Mpw3k2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dh+aCNsi; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh+aCNsi"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b2503753efso80207805ad.0
        for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 06:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777036922; x=1777641722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ybrSWmSvBg9HMhpBAZRFHbe/rCyD4fuA5/9B69lAdq8=;
        b=Dh+aCNsiDgxJuE3pAkIHdFua6DtTlEGMsHTWQJAGOEUODJNC95MJsiexaW38edR73S
         IjUkvJmUjXJ7ya7r6GuuHWeiBSotgcNJTAfdNuA0vGaorkbR18UVOt244kdLymxRzcG9
         94xjTyJEHtTIB1odu6Bk9VzoDWJkuqDpgPbaj+Pd+aGxQY7CDK7OVnME4+c4p7fnw6j8
         8Q5o+tUZxwy3y8OCLMJig623HeZR6S0UvRn+PlPg+62H5mvE2VH7BEv39oOuuAxxo3LL
         MILFHnI6CFOO1bMbUxCgZ4PggbVryyN2IesThAWWQv9OCbckH0NXxqXZN/waN01YeLdE
         duWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777036922; x=1777641722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybrSWmSvBg9HMhpBAZRFHbe/rCyD4fuA5/9B69lAdq8=;
        b=VXwyEcZsuSfd1uANFPxLgUs6czxS+vXu/AMQPMXmGr5kUK5sN28wox1by+ZKEQi59t
         afGOOxqDyvaqiFZ75H03vd00LoY7Co7uPf5fYYq5CGuTfwVZlXHTLVvNtnanZbn7HIzk
         MqElZ7RijAY0/bF3JqmPvyZ7MVCTjRxUQQvjXf+PRPQP6kuOQlUMy/+8efu6NbXaYlQm
         ydm+cjmWROPdC9N5Ldg7HNXrIu3FvsbzWkne1EEbgzUTIGuB5+bLytmdeT3Mo6x6YHG6
         VGU/+A2Gs38PXJxAlVYac4VBquOrA6MO0WwClw6/nI6MIacm/aJE59esYfJEqs4cBETR
         dLBQ==
X-Gm-Message-State: AOJu0YzCEjx/HqhifKi3vNELkrgM8kUPpYAmnLCri+DuK6+H5dDoC7G2
	5Nhl0YkXvxNt+mK1hOk24Id/NHz8BCvm3xQbK5c/3QfWm9VagwiQTz8=
X-Gm-Gg: AeBDievvv2mZqkElQ8LJKNUGq3LSCWk+Nx6U0h6cfI8TBe6OUZ2yPP0aks5CmZGEOZx
	HpyQ8BsImo71kjXR1KSsmnUkNkM7yPYvySYQzcLJXqrxbvuB9bXtwrqCdxNnQW4Uo0pYOE9bEVV
	Y6NPcxzXiq0iT2dIRi5i35rlIlDOWYfuOLMPZWMa2FQokDlK65EIfJtFdEIXRl3IuyVmeV0Mbz2
	chHkJ+fVTphjooQy+oJKUI4C6JgiIZnkUyITHC7VooB0s7ZBa6UcvMeQ9j2PzXz9XY97UxgQqvJ
	+gSbXoHI8mn3T/lHexrfIpVLt6DwG7rhhNX1eNAKAHcMpND3p4h3oc3BypknMu4wuLgoEcCYNxQ
	tICBtzAoWNCSIr2gNNGaGy/7s3VUHAUpBSgMkX+AxQbw3dJOVcuVZrweI89qBkL7fPIjC1DKY/t
	GIEhLVQkYLU27wVIo5zcfxJrf2wep0nA+qpsYqQdrBc5qi0p8m3xeizaOYp1fCxC7z/lfvnN+c4
	ZG1W9YB/cLnBiA=
X-Received: by 2002:a17:903:37c3:b0:2b7:aba0:ac10 with SMTP id d9443c01a7336-2b7aba0aea6mr72508065ad.11.1777036922129;
        Fri, 24 Apr 2026 06:22:02 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab30f29sm224955695ad.68.2026.04.24.06.22.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Apr 2026 06:22:01 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH] HID: u2fzero: free allocated URB on probe errors
Date: Fri, 24 Apr 2026 22:21:31 +0900
Message-ID: <20260424-u2fzero-probe-urb-unwind-v1-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

u2fzero_fill_in_urb() allocates dev->urb with usb_alloc_urb(), but
u2fzero_probe() ignored its return value and only freed the URB from
u2fzero_remove().

If LED or hwrng registration fails after the URB allocation, probe returns
an error and the driver core does not call .remove(), leaking the URB. A
failed URB setup was also allowed to continue probing with an unusable
device.

Check the URB setup result and add the missing probe-error unwind so the
URB is freed before returning from later errors.

Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/hid/hid-u2fzero.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-u2fzero.c b/drivers/hid/hid-u2fzero.c
index 744a91e6e7..82404b6e2d 100644
--- a/drivers/hid/hid-u2fzero.c
+++ b/drivers/hid/hid-u2fzero.c
@@ -341,29 +341,33 @@ static int u2fzero_probe(struct hid_device *hdev,
 	if (ret)
 		return ret;
 
-	u2fzero_fill_in_urb(dev);
+	ret = u2fzero_fill_in_urb(dev);
+	if (ret)
+		goto err_hid_hw_stop;
 
 	dev->present = true;
 
 	minor = ((struct hidraw *) hdev->hidraw)->minor;
 
 	ret = u2fzero_init_led(dev, minor);
-	if (ret) {
-		hid_hw_stop(hdev);
-		return ret;
-	}
+	if (ret)
+		goto err_free_urb;
 
 	hid_info(hdev, "%s LED initialised\n", hw_configs[dev->hw_revision].name);
 
 	ret = u2fzero_init_hwrng(dev, minor);
-	if (ret) {
-		hid_hw_stop(hdev);
-		return ret;
-	}
+	if (ret)
+		goto err_free_urb;
 
 	hid_info(hdev, "%s RNG initialised\n", hw_configs[dev->hw_revision].name);
 
 	return 0;
+
+err_free_urb:
+	usb_free_urb(dev->urb);
+err_hid_hw_stop:
+	hid_hw_stop(hdev);
+	return ret;
 }
 
 static void u2fzero_remove(struct hid_device *hdev)
-- 
2.50.1

