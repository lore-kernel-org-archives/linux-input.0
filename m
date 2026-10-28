Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218128;
	b=3RNHAw6w9hXUExJoBo0/MOqXqx39lEmY6kMM9bP0jpjfOXe7gj+ZPG87hvu/mtEkuCRd
	 keg6McxwhGqeaj+nOgJQoKl05kr/fAjX61ex4OpeG8AR6Ex8SpEWrSg//9jXwUuIo+OtQ
	 xRW99kVbzIof5Y+lQcFlwNfr4yJxl1p41txaj21XfCWISDTve7D/XJZkxkiMNB3u778L7
	 JsuyOGvDH8D3F2yw7/pg0iYu4DeXVRqHXrc2Lxh0ZPGeXpVsrspeVdLALWEcW+fgjV2kB
	 4c0PkGJAPXufWDXtM123mET6tAN4oBOuEjC5Jk57uRA7CZHIFzQvzR6VzAacM/F30Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1Z0YQafCG/ds8K4nf8XstMQMpN2YG0GXfEJKDLgVft4=;
	b=cMJ3E6un0e2zVq1ihH3PPDeiEWKkTDNY8Hj9ET/+b22JOUy62Th78Bzi9RfUtr9MKWr9
	 Dl9Aft8A4+gmR1xPCihMHKIWBHMkDdgD+U+G9d4pIKeb3d1VgXLzoUA2R+KKGXW+fZ8sW
	 0zThqXCYcykuzUzvOXMPkMekr7Ngcv1px0EKCUT7C4H7pDf09NYvD+ivhToug45LpoUQf
	 0o/7iR5ob/CZHZazQKCY52MP/dor5PSEkA0KWpx/RN3IvMP4gKCERdXeCviGiCGW4LYre
	 mI/Zk6CFNIP7LjBkGnheFBSdZTIs0ux+H5bTBwnVRNXvJ3FhW+pBOeSZBec+NuKblwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oqqflOg4;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A6C60A2602
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 20:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64A6C60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oqqflOg4
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so13727755e9.0
        for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 13:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793218127; x=1793822927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Z0YQafCG/ds8K4nf8XstMQMpN2YG0GXfEJKDLgVft4=;
        b=oqqflOg4/vH1hCedy0ab+pYyVSsCyDf6kfCImm2ZNIfpuufIYMyu4qqV4z6BQUP2B7
         l19YN+fUGZkvtdD1IqOi97B/VPOn4WIZdb+iOWdVU8zZzyu0i2EDqY8Ft8/c+qN714ld
         i7ZFSgNbVG6twyWRBpqcKEUAkEUEin6n0+rCIT/VyC50vmFyJlO/BjdwYiVVIZUtCOFH
         VhT+L3VizqSK70fjyDl5UdtH0PkouEmQL/z94EcDBF8LjSw2tGTCjiu9hEQpEfNgFReg
         e6TvyGRTFEqi7qAf6WEjtdAyH2JCb7ky9AYFZ27IZ1pBeR611JBmmHQva5TQakQY6m+p
         mKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793218127; x=1793822927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Z0YQafCG/ds8K4nf8XstMQMpN2YG0GXfEJKDLgVft4=;
        b=w75dxMrVw07/lT1JVHyD0I0g4ZUwiI4S8QSpuVB4lji4McAutld9AuvrGeVeBRLxnD
         ig578Df4XF8YS4B4geDqsEnTa/UaG1JWT4tE0ADDG5YfljhSLtNx9IsqIAb0LEiHUoJg
         GkPOt0rbVWzP89Z5p1+AwCaJSKVzFc1gCVgMkqoDoiNUxYKmlvxV6ajzC5j0cfwkFmR+
         Nf8HY5ANKatS3wppb4m1PGtL/ZNKeLJBRIFnnAkYuCKt89xlivKNS4a9m/uxK5h1XoDk
         KY1OuNoADIVeTDoPH8AQ9Ym1rMgEOgGMINYyKUWmlky3BwPsP/sp1KEsCi4s0yFlLaUx
         mRpg==
X-Forwarded-Encrypted: i=1; AKwUvBy6PUj2HQZXc062hLXWi43QLDVf4Q+k8wou+bOAzOIOnYyNA63wJukBLf+xWFsFCqnh704H6LKAB82pxA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJtwJ7Yk6e53NhJ+KlmMGyPWqfkISv+r8Gn4vha+64F2hfRG0rA
	bNIdl1nEsX9T7WW+gmCCT9USq0ik6Lhq+N4YtTks7VXi79GKFyyqqLMs
X-Gm-Gg: AYBFou0CxqXoC1eziltaNb2lGCTeIh16Il3BrFK+cocvtV/31AF79D2tAPD2sTuvoYy
	oh9e16w4h14K2+EeZzGGfM15A+EJ+wrV2TKcIDbDDgOQselA1Rc9hjM2yrG1JEzGzbDet5FFjL0
	QXBi9NVwpbOcRClBQG+gOb8huN0umKI8tsiRZ0j4vYrYmrCuNtN7qTHkj6GMlq3eNVA8yR1Rs3H
	wOeg3LsEAVcRjBapHBJr0fJtGxK3pGLi5N5GV0LZNyHyKEMfEqATpiHzF/zkwg7ZXwMNqV7h8pk
	L2QG1EzdmsJEMQbgSFGGcZ6DOtZzNAi6xwv3AvE8cGcBIp0TJfWvbddOXQ036JHHK0K8m5+pwiz
	+KkFZWGAAu5lvUlByKRVLhTxvUtdCfnjBV8cSTkasD3zA7isgwDqbIButjhXJ/Mfnr5P3b3VJ3r
	ub+0WDEYFObVtvWf+k3+FqAF0QQLt8EanQlL5WIM+n3ByQFwq+1iFYEXyhMdy3hydFGH/nBDikn
	uT/oXxY4mgi4eivgIIcSDQ2m/hfkH4c1g0pq9RDhSl1xxgLX4Spi5uLZrr61e2Ct5h3J+PryEHn
	V4nNWvTtyd7WzYeTjg==
X-Received: by 2002:a05:6000:29cf:b0:487:1575:ebef with SMTP id ffacd0b85a97d-48e5d311eb9mr5672419f8f.47.1793218126745;
        Wed, 28 Oct 2026 13:08:46 -0700 (PDT)
Received: from fedora ([2a02:587:85d1:a500:5135:1deb:a9ab:fb3f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f387sm30134320f8f.4.2026.10.28.13.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 13:08:46 -0700 (PDT)
From: George Karagounis <taterraster@gmail.com>
X-Google-Original-From: George Karagounis <mail@taterr.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mail@taterr.org
Subject: [PATCH v2 3/3] HID: logitech-hidpp: Replace create_singlethread_workqueue with alloc_ordered_workqueue
Date: Wed, 28 Oct 2026 22:08:39 +0200
Message-ID: <20261028200839.202670-4-mail@taterr.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028200839.202670-1-mail@taterr.org>
References: <20261028200839.202670-1-mail@taterr.org>
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

create_singlethread_workqueue() is deprecated. Replace it with

alloc_ordered_workqueue() for the force feedback sendqueue.

Use flags=0 as this workqueue only queues outgoing force-feedback

commands and relies on GFP_KERNEL allocations, meaning it is not

depended upon during memory reclaim.

Signed-off-by: George Karagounis <mail@taterr.org>
---
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 27d83b8bbaaf..c4c578c42182 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2875,7 +2875,7 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
 		error = -ENOMEM;
 		goto err_free_data;
 	}
-	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
+	data->wq = alloc_ordered_workqueue("hidpp-ff-sendqueue", 0);
 	if (!data->wq) {
 		error = -ENOMEM;
 		goto err_free_effect_ids;
-- 
2.56.0

