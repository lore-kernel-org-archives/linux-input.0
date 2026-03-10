Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D142877FC
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773120037; cv=none; b=UIxIPQ4niHHe2kIVDboYbfQQ+GI/AGhrUF3o9ClqXwRVmhRov9bBo/oLyAXEifIvGTmVLTgcoFHhIbGF5k9wScpyOrNanYVSIfk8RO79xzYdIy+tzpTvsZy0bytoKRD+fvK+mfxsIXeIf9emZlsJKe3xBmoTEyUosrc+drUP6Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773120037; c=relaxed/simple;
	bh=PiJJBE5+libMfuAlrHtcEehcGN3MOEzhUx/8ZQ4605E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JF3ny7s+wWxUf9Ks1K6ILpzpG56M/kMylmxXN3QFBRg0m1w+SIqH/jV2HSenPWUScG5toIbNvUMTPOCFzMhgUjypJtV9W926wJktyl6Zw1n8koo/EtHssN67mqTVunEXN7rXCVjtjZHatnn7pImy5qxGNpXngjnJoKvj1Q4pPts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=J9ZTMRqR; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="J9ZTMRqR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1773120034; bh=PiJJBE5+libMfuAlrHtcEehcGN3MOEzhUx/8ZQ4605E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J9ZTMRqRUFhwYV7TlfrtRv9qu1845hD2YxMKu8F5KFqqMwShljH/JbppzjIyCTPXj
	 zfA+S9EwBeSh8j31HpoLLh7PThg24d82Af8JkbxiOX/6F11Hgb5ZJizrvpeCIfV+oq
	 xFkldhFjWlf6ZMFMXHQ1gLrU0w4MqfE4e0IYFvpWBeia8+LYWsPdIimu70sPDkVFTy
	 JUKaec2mLllZhuOB+aMBJCC0iCIreSXqtY3BINe6F6BzuFQ6VvRDaq3rryCDw+tiWf
	 t9+GWwj4m+xOR4J6oHbK58JvFTSlnT38ZF1k4wz03pKILgaMDmYCW2ACNWY5OqSb4i
	 I0Exkk8cynhSQ==
Received: from microtis.vulpes.eutheria.net (71-212-14-89.tukw.qwest.net [71.212.14.89])
	by endrift.com (Postfix) with ESMTPSA id 8CB41A0D3;
	Mon, 09 Mar 2026 22:20:34 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH v3 08/10] HID: Map more automobile simulation inputs
Date: Mon,  9 Mar 2026 22:20:02 -0700
Message-ID: <20260310052017.1289494-9-vi@endrift.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310052017.1289494-1-vi@endrift.com>
References: <20260310052017.1289494-1-vi@endrift.com>
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
index 2bbb645c2ff41..f14d9dd2e4fbb 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -801,6 +801,8 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0xbb: map_abs(ABS_THROTTLE); break;
 		case 0xc4: map_abs(ABS_GAS);      break;
 		case 0xc5: map_abs(ABS_BRAKE);    break;
+		case 0xc6: map_abs(ABS_CLUTCH);   break;
+		case 0xc7: map_abs(ABS_SHIFTER);  break;
 		case 0xc8: map_abs(ABS_WHEEL);    break;
 		default:   goto ignore;
 		}
-- 
2.53.0

