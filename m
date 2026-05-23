Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9103126CD
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 05:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512828; cv=none; b=SfjiOjajoCBjyDQ0eqnMe65LNTpuL7WLp5oH7gFiQpL7eEBRmqguMuGXdTbe/tMHkzdBuMLfx21kmudWJDB9bwTsdT5wNsWIl/uEK1LpJQYDa0Nge4u2kn/PwZquV1mvXsnWmtJxTEenqkDx0Eb+pIGlPoobSQ9gQ/95hoL4Ry8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512828; c=relaxed/simple;
	bh=Vv+rBXMg+Icog16Aty71Q7I2UIjL+PEAOQ3S0oWuL+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOB4ANFpJGNrCnyobZ1X8C6aNQeZD3V60vVEh4L4z5McDfGdqfojZOBiAoVANaSl0f19G1/xDLDaV+ikV90l533q2e3xbMahFQuPoJtPD4dUeJIwkDQl6HjkUfjbrW0YNEqNacSYV9U5AiJgazRiuo7DQ2X9dDr1X1DScRcPM/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgrIcqG+; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgrIcqG+"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-304545f5206so1688761eec.0
        for <linux-input@vger.kernel.org>; Fri, 22 May 2026 22:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512820; x=1780117620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJzf0QxClXhAIoPHFsXd6Vs6F+rAvHbI6FlA7maao6c=;
        b=GgrIcqG+jISmcVAp0K8lkOyscn8ul+BfMgcVG0jAeAwie2jDUPn6nTRi2/LQMsPSxn
         sDJZvwQ8q0lYng6Qam+wEVXdAlNy4rUXrDSotGosmwiZaBQ3JQQ4Kpj8ENbh+kx9ePUo
         vtjEZYtj3XSE5yA1KhpK9yp03VZ1ZJW4qn4BCEPlkFV9/kZMqym7HspMkdZcqM1V6R1K
         vLeiUZ/3HkdclYlJYwxzHbOYsONh5ic/pmsk5iUsdG6jsmG9XUHcG+EM/K1QROMTn2+n
         TsnevjkwhZ/M71tAzI0z8mrDuMs9IFMd/FycnRw8NggLuU74kNvK15uZh3HadU4e4NHM
         CKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512820; x=1780117620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JJzf0QxClXhAIoPHFsXd6Vs6F+rAvHbI6FlA7maao6c=;
        b=QLBYMKsedcdagf65Hp8iUBsasKeCGoDNvaW48F+mmtTCicVGfFK7+Vo90z3D2a1ACF
         4JEmJWpOIsFOC6c8VaGjEMr3dpYrksChIBlke1JgkwMjicP3ZMFZ3WCH5rOksiOkNrVH
         1fpuiLKr0K3BfzRt7dJOceFahPPceGQjHS+O3LAU4f+yprSxg6yUHojhmUYNUDfPs0zg
         hb9ymloRKNxCGIrRHD0Cx/IrhTsr1y1Vm8ZFJCmRCKK0xO1gUr8whemw1Srb3d4R4/vz
         RzwtAzj6ZvO5Am29yOTz+rvKlYldevm+8nv04aQSfG5Em2046IqtzIQCwuDN4NAMLpvf
         TT7w==
X-Gm-Message-State: AOJu0Yx43O479M4XYmeNCPaqhGjSBkjn7HrbCeOhXJeG5tWByx5r1xtX
	pPOkKpfMNLbVX4xlJqD4eYBHaRt/vvxv/goBXGy33njvgMEutRYUaCpKADKTMQ==
X-Gm-Gg: Acq92OHNiVrLBq+czKPsbMnQqYtWA358buPMUj2bJpofpGIAqwy7c7Qam0gXw7YJcYp
	ujYc0tFA0vQs3UMoawtosauxKNHaZ1PqZpTYIJv+KD1xckEU+rUPQ+hZUWlM4oTGAHx/LSYykIv
	bGoDrKE7BLAHeJlAaaBJroOyZBagysMwBpUq2Wdb8ROdUtUC6OwUXBsgc80iqBLw8791I5QxvE3
	JHimVxzaktTytFOkuoUJ2c1gSMuqrvhapsCWoFuQwxhc1DDrvyHw7fYBgWNiyMBCW4wqPWS6Jb2
	uEv8xeVxjOAu93UXrVoYYmCjeT5QScKTklrb9NUhXHyWBWHTYRte2jO5IgddYUBDxBG3aiccqVr
	25sBrWgGpyXnz1elFqLdyeL55dITgyWnQXEHyB690ITToH0+NpF9eHMIOe4OIjIB5Qk47xAg0P2
	UfHeUEPIADbCfF2ZD9/m1CucFXe6hrlEyUgvE/UQcIxykwaBUK836I82FxzjTjtxUfix9Jyv1PS
	FQz9qI6tBkzhw==
X-Received: by 2002:a05:7300:b104:b0:2dd:6937:79d5 with SMTP id 5a478bee46e88-30448ffc85fmr3364295eec.8.1779512819705;
        Fri, 22 May 2026 22:06:59 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm3502583eec.13.2026.05.22.22.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:06:58 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 11/11] Input: ims-pcu - fix potential infinite loop in CDC union descriptor parsing
Date: Fri, 22 May 2026 22:06:29 -0700
Message-ID: <20260523050634.501509-11-dmitry.torokhov@gmail.com>
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

The driver parses CDC union descriptors in ims_pcu_get_cdc_union_desc()
by iterating through the extra descriptor data. However, it does not
verify that the bLength of each descriptor is at least 2. A malicious
device could provide a descriptor with bLength = 0, leading to an
infinite loop in the driver.

Add a check to ensure bLength is at least 2 before proceeding with
parsing.

Fixes: 628329d52474 (Input: add IMS Passenger Control Unit driver)
Cc: stable@vger.kernel.org
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 422b1be62303..a04dd3ea3a48 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1678,8 +1678,9 @@ ims_pcu_get_cdc_union_desc(struct usb_interface *intf)
 	while (buflen >= sizeof(*union_desc)) {
 		union_desc = (struct usb_cdc_union_desc *)buf;
 
-		if (union_desc->bLength > buflen) {
-			dev_err(&intf->dev, "Too large descriptor\n");
+		if (union_desc->bLength < 2 || union_desc->bLength > buflen) {
+			dev_err(&intf->dev, "Invalid descriptor length: %d\n",
+				union_desc->bLength);
 			return NULL;
 		}
 
-- 
2.54.0.746.g67dd491aae-goog

