Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760D639150E
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 03:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789182385; cv=none; b=W36Jp4clrA8NzG8hWWwjNvq8s/6Mc3wFWL3k/1+b0Ia4UWWVwnYAv84QqF1592nenFPwjTGera0DiIa6zBZ79ZMYVmoVmwcsmJVlpnFuHlqAdXLDIAG+mZGm+YNCPu3aAjVjwQDR5VfeZaNfyITfZBX+ZBjKLyV+PzJcM+XgBdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789182385; c=relaxed/simple;
	bh=hmpEm1iQREvv6xqecXbBvzDEykBg6VO0WVCyslh1m0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pm3mmi5w/kueinF/ybYCbdfgrQRAXfzt5+bwwuq6lXLxmmcYci8ufX4PEmxn9ywYOI2Z9MgXHjXSsKeYBNaq4EvyQ3cfEwQOQmWzPdfnGYW9QaBuwc04HM/7EXvhWv8SchhJ10yMDJlTwYbKjN3d17oOfvjRkPZjhbt28IVRX7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=YFypnvbC; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="YFypnvbC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1789182376; bh=hmpEm1iQREvv6xqecXbBvzDEykBg6VO0WVCyslh1m0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YFypnvbCJlQDXdcO6a19BzE2Tcb6WpR8oKxdfdebnhhJyST/l0Q7KX+BDTPCJ2K40
	 NftN4zA0Juo6FPRPCpWPpU3h5mdkbt0xGBnvxO0we/idpDruPYFJ02owhyHS5GOJsz
	 3A0EUPr/lrbIhTmM1En2dwbRIqHzc2fAgRX8pIUpDxJhQ6665lB4Y1ed6wXr1RH/Y8
	 w05wU9SVSD6sHogd7GARTVjm+zfBi4d4c0urkYUjN2g8gsdd2V+OFTNLCsOeZNtheL
	 NUC94Uj96LfPF+f1i8/7GiGSJw6tf/yEkg5Lwqx5w+R6Kj3z6mijkBhNIV5udyPXqL
	 1qXEX7go3ZnBg==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 3B42B13208E;
	Fri, 11 Sep 2026 20:06:16 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH v7 11/12] HID: Map more automobile simulation inputs
Date: Fri, 11 Sep 2026 20:04:22 -0700
Message-ID: <20260912030426.2997003-12-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260912030426.2997003-1-vi@endrift.com>
References: <20260912030426.2997003-1-vi@endrift.com>
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

