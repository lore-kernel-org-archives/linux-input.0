Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249DC38424C
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201218; cv=none; b=Prge+r8EV1fFwNFTBidPB1qzO8IQBztrVYkMH2/XxtLAXplQRmakKKSQvqu1b9e+2powrzw+MrR3h86AvxFZEG2fYMlb8kBMhJl+ZEZqNd1eBIww5e2YGOQ74HUlLPljVs/8ECwr7+8XQroXJa7Oqai8A+QdYDQC6mlOuGNOQoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201218; c=relaxed/simple;
	bh=03d2guiWqC1X1aeqO35/Sp8MAuCwdb5LIMkIfyXcbdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OctU0L2wV9upfTPqEmVL8657maTUYVnCLuhgs1IJLKAWWhoMMIa26APvXVh2jccFSAM6Gn9tXEnE3a7kA2Bsq1S/I5ntOFaO+4hHisPV6ofVDjOUe2i2V3h/9gJkfRCQhGQatXs9aaO+ktVmZoegXzKFQK7EB3nt2QNtHiMY7eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V04wgNz0; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V04wgNz0"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-16ad92569b5so457694c88.1
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 18:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792201212; x=1792806012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ft0AbSsRy9AcaQSCKpocR5zMuQhawmF0bk8dwTnAFcY=;
        b=V04wgNz0yIAxx8EGVx8CPycmVz2ayi9gJRKGke87trcTAEGqZvq9HvOxbYjqzZgiD0
         DC6+tuduQuSMS3XrzVlXDiGcaION0cL+53pbU+0GexB4aF988wy6bHuWePFGXZkabH1z
         tyyOWFUJS1uFOaCE3gIwF8L6LpFSYpTHBTqWfbNc4a/cAnxnu0r3rHY3Fyb0M9oJqrM0
         FIRlJ1dgZJb4VMGHGo64kGeQu8S9MxSbarVhGNNfdM7yFJBJlg8dhSeURHLdbNitwYT+
         /O8QZMcumXWwL6mOI//NHc/0BviRRovWBXtDahGB+TiXDxF2XWSmS5dXpV2A7frb5gLv
         cCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792201212; x=1792806012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ft0AbSsRy9AcaQSCKpocR5zMuQhawmF0bk8dwTnAFcY=;
        b=Tso3oNBie+CurxN2k93fhRLVfHTLIJ/Ri9F0+er3+X1LYuRDYVBmOk6ykDHIV2ufdf
         gemtmbBS+ybhhaIpAgmWVV8c7WnicmHF0cGVPk6vSXjygAVssjVPRTSb1Eb3WTBr841e
         V7gJLb7wBolm1VH+iYI2dB5whijogR3VCgWf4y8Q4r6M8OqTy2/9FO2dFrdJzu7ynuvj
         Wm1708AsBWibrlWO67k2jCRjrGA7XD7a1VivTPTSwy/2tLXekh2dS6XeyOVnnm7p6vek
         m6o/gy3VzewZeC0kD8kJ2PvCRz9/6QH6Z3LOJQeanJZ8WJ2Z6esXAAqWI4ZsOhsUTs/J
         y1uA==
X-Forwarded-Encrypted: i=1; AKwUvBxrJ+CbWkC7KAsV9QoskYBtX39PmbhMCMOUrEeC/Eq/KZjbJ9A2dq8Q78NMN0yfJz9fJ6APep5zkjmpOw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLoGxPR0Puf3K1axsl8iMf8PkUFs+0F9aF/FYLDTzzVCvaSBSt9
	J1oQExwJfMPOHuqsod0S7YrDxmduywfxDRvIMzEhV0LiX54JhfEDHcwY
X-Gm-Gg: AYBFou3yxMcGiGxRZqMxf4TlcREMJPSP4NBCFx75H9rlme7eFjyF8Har9CtGIYpKyqb
	ohMKlhMIG+u0ATp2uIo3p5FBUdHF0ooBOgJwCprAdmcH+PHzAJ0k1/XEhihiaC65+AmhP8RzeAH
	EUhYe/kRatC+HNHgfJ5Jf76sC5YK0aDl3yltqDQJGswFRHwZtKt4373aAIyD72a9Is7gl//SrM+
	mh3/LzDA0rZvvJqvUm7n8XT2FlX5mjbnuwLPdWjv6Qx+bPCE91cUWIPbg+EeahU0k6IJ4rTYVPG
	cVnaBmIHGhdRjtmolf7M+13Ax7godIM5Pl6YvmJt/ZzvBZoTZv+/MNpCFuwi4paxyfsGW43cQKQ
	uLsH/KJ5rMXQkYbjYb8JYSS+XETAJybX8PxI3rm4TbaTxpwsEVcgGxTYGfImKRdTck6OSoaNsc4
	53364pyYB3NcX1VVmGJ2v6RlvMMdvH7UAI5607Fvr49/F4pQBoGMtZdLdaSbeGkds24puT5zMtm
	9a1GqWrfmDD7YqM3e+YxE+YtY1pYjvzPJliTyNpjK+ZiXVPxJcHMRcSbuuLvmjsk0mr/IqxtVI=
X-Received: by 2002:a05:7022:ea8c:b0:151:2e62:fe6d with SMTP id a92af1059eb24-1851238aed8mr1925843c88.22.1792201211913;
        Fri, 16 Oct 2026 18:40:11 -0700 (PDT)
Received: from lappy.taila8a9bd.ts.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm12128429c88.13.2026.10.16.18.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:40:11 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH v2 05/11] HID: hid-lenovo-go-s: Add kobject_uevent notify during reset-resume
Date: Fri, 16 Oct 2026 18:39:50 -0700
Message-ID: <20261017013956.2440130-6-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
References: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
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
index a16733edad5d..ed08200e3571 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -1471,6 +1471,7 @@ static int hid_gos_cfg_reset_resume(struct hid_device *hdev)
 	if (drvdata.os_mode != os_mode)
 		return -ENODEV;
 
+	kobject_uevent(&drvdata.hdev->dev.kobj, KOBJ_CHANGE);
 	return 0;
 }
 
-- 
2.55.0

