Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6193BCD32
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 22:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426395; cv=none; b=jswyR8lox0N2POhSS4Sr8Otz1Ad8+S3x3fMnBAE6OxPOIio70G68sLfau2YlZZW0Ppc8sZhHbHhjzroygkA1JEjBhR1eoGe7zeQjJHr+q8MN+Q7vJ4Cv5ni2cLliyE7FG7LRNvYJoPRsaQ/G8cFCpK5eh0xhOafvmAqkYS6u0GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426395; c=relaxed/simple;
	bh=BiHA2LT7VXF4lmqoIJBRziOH8CBF0C2zrU9LI3lG4Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STwnaH1RNfW9hyJnsWTB/3zQC12TFjxN3En+igTGoZwYXcq61LiPxnC1dDh2YehWaMrYpfwNvFXLncUzWsgWt69OHu32+hFKPDogeHjlP9B7Pl9DgNUdchdUnCyVAVKwxJLPRv59od2BTDz0RjNQUpyMIRmA00150CgEHLAXibc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Du2cWIiF; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du2cWIiF"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469d249c5so2223151b3a.3
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 15:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789426392; x=1790031192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T1HiEFknvKCDeWKiMrML1PicHIEUqaWiAMUs85FKMew=;
        b=Du2cWIiFsr4HicHADRWDlAtd9D8PjVL9lUtzdW28DrgZabvAPYG42IodBGVI82I7YD
         9exlAMfIm1Smf0GskSm13WkEAb5Ztn+2VcexeQJTeD3xbz2yAYjSuPseX6xW2hSMsXLe
         qONYSKEtvH7ZONJjPtq89+lyKhI3bGfddD+Bb4UQncz/+TlmlApvo9S5pTAuGHXsrVwJ
         mUSK71amq4K+lxI5C3kep+BQmBzow8h3HeaXQH5o6KwzWO8snT7z7bkbxCha2YmZcP8v
         MMo9+2A2fevRuxr6dI24aNTwQSdvHsSZTZBqTQo7TVM+X9EicScmv+LdmCBaWmOFjsLW
         S2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789426392; x=1790031192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T1HiEFknvKCDeWKiMrML1PicHIEUqaWiAMUs85FKMew=;
        b=nKDmGFpdNEQ1V8c+rTtcgP+PrSxWIcV9ErVtfDDqsHGQj3WEYaTk8h8BKCRkGQbeeR
         9lalClrBkCVir83dNa/OjsyvlKnwmyVzkXBsO/y7kMlCq8n4bg5V2chOGMdZK+pjyjjv
         q7uXYz6Zcn+jWCBYD124GM1vwidWVZ8GbXyW5QLycPCUA9eQbT9VYnlJ21lggMJxUmyt
         LVVYntIIJ2qK/ljRQa6YrH+DheV7rnrO2PdaxLCrabD8cxT2EOpuhO7uUVHAPwNcIJyV
         FYXl4OW4BF9C7ibI2Bc/RVIXSXVfR2I7B4vuWadRSyPTvVxrtEeAGSBbJMmcEULiQpDm
         A3ew==
X-Forwarded-Encrypted: i=1; AKwUvBzSji90kLJ0ypSWiZ/2xJFNeAmq/O4POcxyrH97As86QxAiLP1euVG5MuGuuXQUYII22jZ3i12rHKLwjw==@vger.kernel.org
X-Gm-Message-State: AFuF++k2wuPkJ1OhBtOYYbdtTeDJ4Sfx64B37a3yUf06Ki7CjJlVqY2z
	AzzFgPw7OG+/yOR0TB8mXH7VVA0rk6NGBXLS3DbMUv+sFAUkQXT+fY4B
X-Gm-Gg: AYBFou0R8UMCjCrX742bBA+NkAAbr6x/r4oJ3HvER7ZT8ogMCx9k+KVx5xJG6y+GfCz
	zRGIKVy0ERoyyg4PooVgPlBmGzYMLSm+V01R1L6KZKPbxQpr6Pt4UO0yjuz9/cCgqyK3qGgTRUH
	Xt4dI2SEF6MZnAc3Q4V1iB/0RCy3BSfTdZXVyHgi8TCfXNRVNJlpZrqZr0PhGzmQd38R2ZMiYDe
	1/UuFtKLZyoGBbCXH9rKPcz3EnqdDnGUbGSkt3HU7q3yhB16YTJIM7nYEQiwYGY3IB7OvLobbja
	DQwSPJKOBQNIsILwxCUg7LPC/41E6x7pxy5MnaTNRV7ga/mI8EPx8jRStpq07erWNc4qbOxWiUh
	oXiwVPf9kF26vbs4OUYEWBKAQW/UCzIn8lDJvf3gvYxBK2QF1YQfnSwvC/OBggcRwIOXirRU7LJ
	f626jqS2vz1wpc2VDEgXGgbR8ezRuxGiFW9RoKRqiN+TVdzYFlavxeCOzOhIS/kJB+9T2S7I3m0
	LmRSCLfEFsO2u5yO30GIBVbIRRRpCYy5nh2Lyi40nYofpVfgUIM
X-Received: by 2002:a05:6a21:b94:b0:3cc:8f53:26c0 with SMTP id adf61e73a8af0-3db405220aemr10555230637.17.1789426392490;
        Mon, 14 Sep 2026 15:53:12 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bbeb053a5sm14924296eec.27.2026.09.14.15.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:53:11 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH 04/10] HID: hid-lenovo-go-s: Use pm_ptr for reset_resume callback
Date: Mon, 14 Sep 2026 15:52:57 -0700
Message-ID: <20260914225303.868569-5-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914225303.868569-1-derekjohn.clark@gmail.com>
References: <20260914225303.868569-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds missing pm_ptr to the .reset_resume callback for hid-lenovo-go-s

Fixes: 3524900cc571bd922a ("HID: hid-lenovo-go-s: restore OS_TYPE after resume from s2idle")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index 8b16fc7d151e..b6850cf2c029 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -1556,7 +1556,7 @@ static struct hid_driver hid_lenovo_go_s = {
 	.probe = hid_gos_probe,
 	.remove = hid_gos_remove,
 	.raw_event = hid_gos_raw_event,
-	.reset_resume = hid_gos_reset_resume,
+	.reset_resume = pm_ptr(hid_gos_reset_resume),
 };
 module_hid_driver(hid_lenovo_go_s);
 
-- 
2.55.0

