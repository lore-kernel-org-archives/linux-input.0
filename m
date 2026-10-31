Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793440513;
	b=jBY7iTXhDa+4DZd9sJH6Z6Sp1PhHIHQemIu2LD/VpQW+ZyX8JpVXnyo9adAvfm8QDvYk
	 hnlAn/QIrJmpY8e+IehbnYdH0/BdqUCVBkz45jCOh1SqLXau5gVXv0NCQlj7ATp4nJbCG
	 cyGn9HpCRwyEqpLXmUChWZT8Li5u51sSeoR2sEd1QJTdXWKmQzX0thq5RODx/+hs6XiP0
	 p7BqdZgugxJnXKC2DzPhb0CA+glLEbuJjZafyQEEFxDa4rVTPA0otzVKH1Hk6/pDaM/4D
	 BrPAVyQxQ8JUYhkQgyZfZW6wc1XzE8YFOeZ3LphbujDGU3WOwhQXriSvCJCUf8uJ/Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793440513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zUoiAQ/eIl9mxZDtmdwiOfm6Vo77qK+7yYPtMHdNZHI=;
	b=M/pYktH0NU4U+5F5tT9r4BunhSnST0YpeqdlTJnghd0vUNco9TKQFtsmo1+Kc55fsFGc
	 tJ5ueCR8uyd9W2fa8arKy0We8YdkGgbEv69PirCqr472GixAH4cC9SxHXdmSysfep2d4k
	 llfW/noWqk+Z2tGxoGlcMJCe2uqegYo6chojtLcLrgZewTBdlCr4B5pMAQc7jIsSAFgD4
	 iYfDnQWXcOjou/wU3FTl0gbNlyl573xweyHYG1sMurict/TzZp049M59FbSNSQd8SViYJ
	 DXvKPF0HCm1/idAYBbL/ShlSYg1DNMv1dwGLXncHY/dt0A9zS1O0J3NCGc7uSuJRZPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="BL/zvNX/";
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0790B606A31C
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 09:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0790B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BL/zvNX/
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so15608215e9.2
        for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 02:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793440511; x=1794045311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zUoiAQ/eIl9mxZDtmdwiOfm6Vo77qK+7yYPtMHdNZHI=;
        b=BL/zvNX/tBrF6IXRqpOnI0jDf796deWz5IB9oDGIraKRvWYUoRZrsdlICJzU7YUx1L
         A5lY7thvAKSAPQfvF7IpAVWPxnH5oySXW9I0vKfHnZfsg3RWY593Y3EPaFgeh0e7OFGB
         Q8SJ5KMqgR8Xr+52d+tZkXlv6P1XsPoMuvwo3yZzUXLdvuGBUebZo75XB0nvudrG7ogS
         PXoOkVU0W+Z/NwDEw7JTePQsMh+gJXaZYAFbDDqD6J8KfpC8ns+AGDMHCkamXHsPJ5S5
         Nw62fFp3kik8vLKa1FR5MfPzCy6RMgjQRDiv15YF875DzK+IpA/VGQmldHTRzxg82A7W
         Czxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793440511; x=1794045311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zUoiAQ/eIl9mxZDtmdwiOfm6Vo77qK+7yYPtMHdNZHI=;
        b=q6DQ2uWjAHz8Z5HLZ1NuQV0qdQhqD1dTm9OJTU/ecjDcEJj4ne8+q4tttU9/R9l+Dj
         w17EMM0ZPbof4s7FDfUtW69gbtVuQIsKWdFHOItjnYLqqGaCo8iz8OU6YipjWz12nPkt
         5xydpKPwL6G6VWNEU92/B5JVikMSkdqsSsR4+XrGUZJXox9jrHHZMSvraZEZwvSLIThV
         L8Mycye4t3R9Diyb06Dm753b16n+cLBjxTdAssq8bgrBE3k7YQFTdNfABWvWBpwBHmOL
         rm3r0NBnhsvWvGt9APb48Kr973g/zQCWecZE9++RN8U+71nvCAA7SZ3ZCPYaCk3D7iak
         K4QA==
X-Forwarded-Encrypted: i=1; AKwUvBxhawGxsw/TV6HN3Qu/AwxzPyMPVS95EHQ5p1AS18Hm0O7vdLtDQSU4vJKPKDuO0YJJHzcXmXi8FazN5Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYKW7nwL1O/rGsDAsKzrgxwGrX9xjXy76TM2G3YyTJkUHv95KSaV
	V6UvLvGwUi2YzhaAnu9gFuQL2vPcy6KvR5sVTTOcTGiI8qcVLMdCAMTo
X-Gm-Gg: AYBFou0LOh2IaWMf85ozJXdsl7K4XaZHBpykAIePXpy4YCyTW6i1m4B+gwqvIJosGP9
	NOcnkWyIc6zv+zcY8GA2NS7JWqlI+QpLu0k3xJSSzR5Gyb6pzHlLsmsVwIVMa7RtNgyjadMPGyU
	nSKnDepIhEGbw3T6ulaiw9e6/SagFQ6SOIGWWVnwhS73gIUU9r84iYlzSNQJAo0nd38XwBAqOqx
	t88MB4xNr4CQcyuqdSIQ4pSX0bi81HoYyl4NyzeTVwch7NyUANW0ksESe9MYpH5sfuNyIMf1+kX
	vSwZeXcggJHS9MY9cbp4fYeC6fUEJowkhK3FNkX0tFZJ6dBZ+fPK7zJKHMNSDcLqy726IVZUFjJ
	3nSnC8eGAoNPbpn24x01tdrgPsG26H+P0unOT0SPOk9aEvEt5bbRbsPXFd/Ap7OlmULSnUYucYz
	MVXgX9fxTfXHzOrGWQjWfu6JZe9g9IeFxmypMDsF4d1La4YL8Dll+TC/dfcpNuV6gkJZZGmpKpP
	PpZfRyqz90qlP2Y2yHcYnRWuuWHo5sSbFImOkHl9BzcS+P6cuiJA3zNTCQm9y7wp07/DHvvMCVF
	OmDgBUX1Gvn9BvDomGIuchlgMVRDafsVNznpTiaSxJ2xADwIJb6LiZVxG0DpBDbAL3uG21xCfjv
	7zsBomtmR5aCFCmEudtzNVl/PEWFY9dm1sh1WkLZtAETND0UNRADRFrkIRwcqYEYWVRc=
X-Received: by 2002:a05:600c:1385:b0:4a3:5991:718 with SMTP id 5b1f17b1804b1-4ac182dc0a1mr114344385e9.16.1793440511385;
        Sat, 31 Oct 2026 02:55:11 -0700 (PDT)
Received: from archlinux.tailbe3ea7.ts.net ([95.173.233.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a6bsm7869505f8f.27.2026.10.31.02.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 02:55:11 -0700 (PDT)
From: Ismail Tarim <ismailtarim7@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: James Ogletree <jogletre@opensource.cirrus.com>,
	Fred Treven <fred.treven@cirrus.com>,
	Ben Bright <ben.bright@cirrus.com>,
	patches@opensource.cirrus.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Input: cs40l50 - fix work item leak in stop worker
Date: Sat, 31 Oct 2026 12:54:35 +0300
Message-ID: <20261031095438.3070451-2-ismailtarim7@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031095438.3070451-1-ismailtarim7@gmail.com>
References: <20261031095438.3070451-1-ismailtarim7@gmail.com>
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

cs40l50_playback() allocates a work item for every playback request,
and the start and stop workers are responsible for freeing it.
cs40l50_stop_worker() returns early when pm_runtime_resume_and_get()
fails and never frees the item.

Free it on that path too, as cs40l50_start_worker() already does.

Fixes: c38fe1bb5d21 ("Input: cs40l50 - Add support for the CS40L50 haptic driver")
Signed-off-by: Ismail Tarim <ismailtarim7@gmail.com>
---
Build-tested only (W=1, x86_64 defconfig with the CS40L50 drivers as
modules). I do not have CS40L50 hardware, so this was not runtime
tested.

 drivers/input/misc/cs40l50-vibra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/cs40l50-vibra.c b/drivers/input/misc/cs40l50-vibra.c
index 68f0c40ef..cbe69f6c7 100644
--- a/drivers/input/misc/cs40l50-vibra.c
+++ b/drivers/input/misc/cs40l50-vibra.c
@@ -384,12 +384,12 @@ static void cs40l50_stop_worker(struct work_struct *work)
 	struct cs40l50_vibra *vib = work_data->vib;
 
 	if (pm_runtime_resume_and_get(vib->dev) < 0)
-		return;
+		goto err_free;
 
 	vib->dsp.write(vib->dev, vib->regmap, vib->dsp.stop_cmd);
 
 	pm_runtime_put_autosuspend(vib->dev);
-
+err_free:
 	kfree(work_data);
 }
 
-- 
2.56.0

