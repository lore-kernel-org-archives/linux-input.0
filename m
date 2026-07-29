Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7AC45FFBD
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345012; cv=none; b=igjo5KVK+AIdpwpnFSQlMVeVrVbTaPOJlnKeInT89BzYPuG5e0M4MZiNQd+5LheOiK428rpm+5PZt54uLFprTryDMr4NwrhEermaYVYvHuDMKquhpveDBMIOqIbLyUNuGOovZwTAdgaPNdRgy8jW8ibq2GrFe5Mr8cbaHioVw/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345012; c=relaxed/simple;
	bh=rW1UH6QqT5HoM3X6vIUIhx8zAo13pIpUQrcQ0zBoEKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R37pHMvjYbVikzot6GORMf3OmuuKJL5/nVSL+6AMprF3uOSd6noTaTmcbafFXrSBC9rDm5xixDoznEgpHtJgHxbrZLFJwb2JbSpBuJhPhV2aXVYnMlYdbuwVyObC1fiApV0JkokFizPSV2y4Ym4eS/fUjMOZAigtJgbyqvhqgtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5/6NV2U; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5/6NV2U"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso1382649b3a.1
        for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 10:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785345011; x=1785949811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8KfsUxOImFYNB/Y0+13Cr6DSQW6iSW7V0sSvSozS8cU=;
        b=P5/6NV2UTEPeeugJ2bzkHY3xHX2LdODfaZGOKbqnoCpHd1RPQ6kgCMwlW+ktxskQJ3
         moxYYteRQAxDFuH3K6Eqz6XBb4k3mQIlp6vX57J6hN614gV/wdDDi6120Z07VYDwuD4H
         BHzGqqHDZbq9fEKUbUgPTd24G3W4kL/Lt2FDjQwfdrJ7NS3zKjvE0RmaRNg/4Psm/7Xk
         97/z5eNsFXIIkEKESjg3MKdsmV/OCQ/qazxBiNULVbHweOQLn0+5T56n+8dMO932/zOl
         wLqEF53fAhhezu2Q9snnFBflGw2MxFg4SnhNb1pb4b+VBRg5xlYjklacGZt69YBslzEf
         /Ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785345011; x=1785949811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8KfsUxOImFYNB/Y0+13Cr6DSQW6iSW7V0sSvSozS8cU=;
        b=Fv4H+LRgopsPlgniTzi04Ppu94EAcFMg46+LEPcXkMr91vuG3/RID6x1iUbCPdTZ9o
         b07fet1ncgMe0MTg6okTnZtPselFFIC7mSDi307RG00mlc4MfNtPbVHLjBjR0fwJyGcC
         z4U5PDOX4e1mxpZWGj4btYKm6oUaDHLl7O7NKBWt7DRBIhSQSt6+1I4Win8EKdjXx3an
         SHCiV26TmStYuV7qKIJOdIsuS+ybfi8Jsgp+K8A8IL/BEkfbE4IBA4ffi5F4gTcat7Qe
         EN4uhE2CmHJ5FuVXi+R5DmTvIv1MmxqDiumjuuqHbRTGREY3vKnRjIzJDRDoZGy1hxY5
         u1/A==
X-Gm-Message-State: AOJu0YwxaOVslDwpa1ydIhqEr6QVW1CswsnjKMFfemOfRiEpmSW3C2tr
	+R6xZTe/nUQ47vZlfhdBxCAxdbWB4eqQekZPerxM+NYzUyKV50B9octH
X-Gm-Gg: AR+sD12t7S3u1T73naZitk/RDICUL3W5+5dGK3e6fuSc/5od2SDE7BS2XF3uoABjphi
	LR0bPu5R2HSJqgvsKEkGeF+3HXPV2Hclr44uT8BmsNIwcTdSLlx6kgZXxM87w3PocRv9xCO8UOk
	eJKTXvWCvbiHjW3M8H4z0Et2alg+oc43lmmCJUPFgyukcy5PMODCQ8Foik7F2KA0QZjevWyS+ql
	Slg7UZv1+ZAhgMwodDCetNrAtBx0sNCcdXkrdGZAiUAfu8MN18zC6K4v5qnYUbLnlzPgZpFU2oa
	Q+vvWQEPBUH6obFEPtAzpt8Oo6Wc7Ki4DC8jDjDGEJrq4bEFcFFZYfwLbXByDUCI2vOW3HVRYxg
	bSqEXAvDa55rX+TUSoimJSyCVq+v8jXM3ipuGRSqVDz59Vz5UxwQqDmI4JFhaP7g2tZX8a3Cx27
	vnGhJv9AIrDOwB97kJg1ai9phL2bBVl0sQ1Hmkyq+mU/oecfMJduoUalI=
X-Received: by 2002:a05:6a00:189b:b0:841:dca1:8b69 with SMTP id d2e1a72fcca58-84e93196934mr8144425b3a.5.1785345010870;
        Wed, 29 Jul 2026 10:10:10 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0052e04sm1694231b3a.22.2026.07.29.10.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 10:10:09 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] Input: rmi_smbus - remove conditional return with no effect
Date: Thu, 30 Jul 2026 02:09:34 +0900
Message-ID: <20260729171001.260698-3-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729171001.260698-1-ekffu200098@gmail.com>
References: <20260729171001.260698-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both branches of the check return the same value, so the check has no
effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/input/rmi4/rmi_smbus.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 6de68c602558..3160714a514a 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -177,13 +177,8 @@ static int smb_block_read(struct rmi_transport_dev *xport,
 	struct rmi_smb_xport *rmi_smb =
 		container_of(xport, struct rmi_smb_xport, xport);
 	struct i2c_client *client = rmi_smb->client;
-	int retval;
 
-	retval = i2c_smbus_read_block_data(client, commandcode, buf);
-	if (retval < 0)
-		return retval;
-
-	return retval;
+	return i2c_smbus_read_block_data(client, commandcode, buf);
 }
 
 static int rmi_smb_read_block(struct rmi_transport_dev *xport, u16 rmiaddr,
-- 
2.43.0

