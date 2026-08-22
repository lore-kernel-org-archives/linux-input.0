Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92E52E22B5
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 02:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787364807; cv=none; b=lgLWnlzL5Q1bYgpVmUtyYtOGJilbsYeNLniyOEH423RqyuBl4Pz18SzfKX5wFhPShCki02rUDDQz93vrWXWHEGA3NzuDUxCYsWvrZ8Bkd3yfp6l5hb8n7N87S5YVMHZff2E9uRNxU1+Rc9tgHFl4HRB0JlJ78Y/WUsKfDs6oFJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787364807; c=relaxed/simple;
	bh=hmpEm1iQREvv6xqecXbBvzDEykBg6VO0WVCyslh1m0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4aRURl4HkfT9lVt0cUmZlcb24suqYJaJ1lVVfHg2yfQTC10SkzN7rlpRxqIYHJuzphFWXSv6ItGCvArs6ahbvpig1+RROXecZ9ESsBXvINdK/gc0sxAhR0Nbe8mwdYUIRXn3eqM3ESxEXkaqObOtgWK5V29OmMUBqL8X5iEtoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=PnHwflN0; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="PnHwflN0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1787364801; bh=hmpEm1iQREvv6xqecXbBvzDEykBg6VO0WVCyslh1m0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PnHwflN0Z0yrWYedt3tf1bmRDEmDdlubc01CIRWUCCa7CiwalOiCF3wPhCYBcP22o
	 txvrU3w6wlZL75GSzZIDEd609KzraQaMcFVFNGpi5Z7ZTIDa7mGYkd87hpl43j3Q3F
	 oqlhug9yaGkUPf+afYBBsHIbrRXEDDll5TAPfXbTNHqKitCoHtI2bsWIZSEu8/awSK
	 EYHPaC11sTcwm7CcpVlNE3GAo//qopTj6GjGmPfxrQD4OTGr455MZuenTyQN+blp+e
	 xhPSyzkxHCsTbRP6CcuI3jOb8PBVnLO9+1KsGbQlXxVuvE0bY74OPbR8CSD781wbqj
	 2L1CLw4I/rDZw==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 8C48413208C;
	Fri, 21 Aug 2026 19:13:21 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH v4 11/12] HID: Map more automobile simulation inputs
Date: Fri, 21 Aug 2026 19:11:35 -0700
Message-ID: <20260822021140.1149546-12-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260822021140.1149546-1-vi@endrift.com>
References: <20260822021140.1149546-1-vi@endrift.com>
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

