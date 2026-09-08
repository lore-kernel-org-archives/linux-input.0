Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0BA1A6822
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 03:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788837828; cv=none; b=gha1LivBMRgZxypev54UON3HrVYugi68zR0fK2hJ0HeIMDtzGkkALWbb96S3/xwh7x3rHmKJE3wJa+l3KaX0o1n77aQdMx75lpBxNx95Be/Te5yyc1gRQ6Rmouauop5l/XQtCKd6EICFiJzNUSBUNzDCvVsnRydomFiAS6cso8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788837828; c=relaxed/simple;
	bh=hmpEm1iQREvv6xqecXbBvzDEykBg6VO0WVCyslh1m0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qs1agLlb7A7+mji/WGp7Tcl8bVnJ7OXZhUUC3h/RcxDC8cQ9xyRcgUbk7KJ5xwZHo7925NVD4o2CepBeb5P6m+GXlow5SNDAsfb21EGGHjkXj3iBhxKTLB+tqgQTDTSUd8sKF2bSouI732x3YAfhRReEEfOAX1kOiRyPcOkZ8G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=VUU+Lu7H; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="VUU+Lu7H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1788837819; bh=hmpEm1iQREvv6xqecXbBvzDEykBg6VO0WVCyslh1m0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VUU+Lu7H9O+a5tA9iRYhmdXk7HuKUftcQZK50DInm5J0EVr2tMmnAfacvkMd6kfWy
	 B8DY4T9FmNVSl5bgchEWPWu9VXCmJhHJGLdGl66Cm0eCk2cxO5W6NR0NshQpIeX82E
	 sjm6mZ/gAC61m8kmpaAIVlf3MzbGWhrC2dLT4Y3CHwqomtcAu15HARwIu/Caf4GHE+
	 770ZcY6L3KhtTS7MQJ+GUqv773X3DxGU0Zj0J1d0O6K2oJ128Y1KUfgb4x+ONPxGYU
	 I2RAdrOgDkTT35L6886cHWzbBLoUETk5l7eFNNIESnQCledt6XDTW9RctC2xf2OFJU
	 paVqzN4IZQbuA==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 404F313208D;
	Mon, 07 Sep 2026 20:23:39 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH v6 11/12] HID: Map more automobile simulation inputs
Date: Mon,  7 Sep 2026 20:21:42 -0700
Message-ID: <20260908032145.2118234-12-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260908032145.2118234-1-vi@endrift.com>
References: <20260908032145.2118234-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HID usage tables section 5.3 specify clutch and shifter values that had
previously been ignored. As the ABS_CLUTCH and ABS_SHIFTER bits now exist,
we should use them appropriately.

Signed-off-by: Vicki Pfau <vi@endrift.com>
Acked-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/hid/hid-input.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 3487600cadb4..6ade969412c6 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -828,6 +828,8 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0xbb: map_abs(ABS_THROTTLE); break;
 		case 0xc4: map_abs(ABS_GAS);      break;
 		case 0xc5: map_abs(ABS_BRAKE);    break;
+		case 0xc6: map_abs(ABS_CLUTCH);   break;
+		case 0xc7: map_abs(ABS_SHIFTER);  break;
 		case 0xc8: map_abs(ABS_WHEEL);    break;
 		default:   goto ignore;
 		}
-- 
2.54.0

