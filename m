Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C06426EB2
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 22:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426395; cv=none; b=Dwcy9NPhaFwHxj9OLGLkR7DpLdV2gTmolsqXxkkAHWmt49ybh2vYWFYwsIZAfMuPzRFzQVTZF2P3tc98ScxD/Yrf+rDpIMj0n/eyZwLoLmkoMSNQwz0Fal5pHfEipsncRyAZYAgakNwOR39AKx7W8L7UC8RxhZAOieCAPId+oSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426395; c=relaxed/simple;
	bh=v9W246k4i5nC9ZdyWZi1OCDWQVULW5oh4JWWhuxaeuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9D7wYiled6QWJ6+w/2I/b8BtuAZEJ6BCn08vgvH5HGuiU1b0C/R1P0N6mviFDWuRyzsAAkQ1TixH8YPwvZNELvISuXRyDutQhaQGo+iAxBEE2NEaWhTS9OPyDWFqW1boOoLeVWouiTXDSmpFeMQMPsjxYX9DpcfvAwB6R3mKTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dohM/q/L; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dohM/q/L"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso1665293a91.2
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 15:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789426393; x=1790031193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BN8kNGGOstdu3D+3MzZhZpT0mSPpKY6fG+DlEioFUuE=;
        b=dohM/q/LJrug23wvrlKE9g6q5ylcIts8vsVeDy+4lQjcALywDDRVvFZxop2mzLr6vK
         o6nCS15ea0aMk+8b1ONVpHUFGtT9ef2Pzwr/0te32027H27PXL8j3PERSyY3LJvGgGvJ
         evAzZWdrGBk/Bp2y5zCeS5RO7T0shNFkoH8/0Rwo+W3rMsfXdSknhKIOulHxp7M4p8sG
         xh8hdt58+HON/OTWKwtvsRCwEZ+6M34bDA/XWqUlAyteHMTDTQ0XZ9i1T0Eu+s4cP7t4
         d0/8/a3K8q83fr0qhRpscYfT7XNaQQYY1GwI7Dzxd7Vo54c3mCvD62E4FGitCAU24jfd
         aVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789426393; x=1790031193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BN8kNGGOstdu3D+3MzZhZpT0mSPpKY6fG+DlEioFUuE=;
        b=aS2ZQ69qIBBTzeNgllcrwXssH/wM3sngyBB/WWpz05i8xvk15APk2jNnhjRCd/lU+W
         e7XeycXZRpXXOjUlC4k3HNGi/Y/ZqdYioo3tYaUWi7LwuAQOIcoFOhtCUjBEJpca3vuq
         1DW4Q7PZyXNk12N5Lyl7v6lFl85ef6S7l2OQ8AedUJsETskLu5g8bvCEoYv7Mb68qYyE
         /MzFxrSofPyLww2iIvCCZQfj+JYd0+//sCcjWQsn2K1wiChucGZfrQJDlXKu/7SKnppB
         ltYwnVQiOUF3O0aexvkQYrK6zyo4fbFvVmxm/sA9faStO/ijLmlWg3kntTvKOW3olp8b
         6cfw==
X-Forwarded-Encrypted: i=1; AKwUvBzhMgWi09yFfJIbZJ/iGpt/h825NK4rU5zb6Y3ddq7nnqCyxwIxGQtIt5CnJLFmdydYGwKODCTlog/5oQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nrOCXQ1Wpge77aangcsCrPnCkbaw/+7p9qJTVquk1M1C8doAVE
	yUpJr6KqRtNGkARhMzeJ2/9dOl8gQka1UnqTMPXMxVbVKE19HRIVc9rC
X-Gm-Gg: AYBFou07tm7XXNC3/Xq/Mh1u1IjJLLDL+OoR5Kq0INA8kx/eZ93JXIWkAOGEv0OBnsM
	UCZ7zYWKpHkRXcDXGVWaid/j601GyLybj4SkR5iKbBflL6pRgpGfmN1PW1f62BCqKqrWglYtvbE
	OqP+YVBvHdmbx+dtkM8esXlz5YcB9GuAQ6VvVj2VJAXF+vVzQdcR4J6ijKFc3qSloUXcqPehrBt
	577elkTJDXnbghFR+KRqYPkHdzq8IHxYjtN85gsPRPTTdpMkUeMQxtiOR0wHIc3v+HE7yePC2FC
	H1yNCbP8+aUdagxLFZpfFdTWcNWgBklnhvv3ev2AYINskPes7nyvSb7l/FJVPXu1AFx1aITWaQQ
	96kznNqVDAWTsrGwmvZcKL95hBmAUcsChoFcPMMJJDo58TwbkqU2vENNhxrDSVLVUc+WbD77+m4
	7XySqTicnNQ8Foj1jyob1rYB1FwiC87Ftm1Xt8uhEy6GtyWM6bZlMfD/w0kKeC1ZwifIPHkC/h1
	p+nXYsJ3sjKTGz+5Sn6vFi+uf3KbnRtObVWCXVsIm9dco6q+OOr
X-Received: by 2002:a17:90a:1056:b0:39d:ec9a:8f8e with SMTP id 98e67ed59e1d1-39dec9a90b5mr6114824a91.8.1789426393321;
        Mon, 14 Sep 2026 15:53:13 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bbeb053a5sm14924296eec.27.2026.09.14.15.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:53:12 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH 05/10] HID: hid-lenovo-go-s: Add kobject_uevent notify during reset-resume
Date: Mon, 14 Sep 2026 15:52:58 -0700
Message-ID: <20260914225303.868569-6-derekjohn.clark@gmail.com>
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

Adds kobject_uevent notification after setting os_mode attribute on resume.

Fixes: 3524900cc571bd922a ("HID: hid-lenovo-go-s: restore OS_TYPE after resume from s2idle")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index b6850cf2c029..712823e22bea 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -1467,6 +1467,7 @@ static int hid_gos_cfg_reset_resume(struct hid_device *hdev)
 	if (drvdata.os_mode != os_mode)
 		return -ENODEV;
 
+	kobject_uevent(&drvdata.hdev->dev.kobj, KOBJ_CHANGE);
 	return 0;
 }
 
-- 
2.55.0

