Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614546;
	b=NRuKPIIuLSTCHZiDi9hriG3QY8H8NQgsDotT1hECOrrDe9KHwoPx5UPW0XiJWqykZ47s
	 p7uzBuZ8FbWUT6DZ2z0fpLl7oDNTQANuCmB45jpSB+yGOaYHz7l3zDP1ybMsPDEehCZi9
	 PLwkSOQHkKxNULOq4YIdxLJFszTqt2uoZvPBy5xK2CoSjYpgHaALxN3pLPR49wUeI8yGL
	 LkAVbBVMES+fmP8EjPvHXjaus080rvTakB/pKQQxBZIMpHkcqoDAXiyZPDAsDmuXeJiWV
	 pM4b5Q6j+o2eCV0CZQw+i4QgYfd4yvdPFwPCWMhRBRAWZQZzr0Q1t5c++ffhhExTk2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kxRETnsBm6VnWvhVvC7Nguz7Rrl10P8nelMFGOXi2xg=;
	b=gXS9nXCvENeVH3Dtt7e0+NAN65pEHUii8vDA/BTyeFVscRMgCEY/MnfrrOid7hBGt8fy
	 4T7I7+FuK23pHbHpZGEtb/eH9fneOgald/p9MHEBJcep+S2VC6dCS0uMasbUcOiENXwoD
	 v9jmEd+pCY9cqR5Ta5fD6fZLYdUyp/HwbgXxOwIqqBuNPlqbVQHUwJv/Gagd7MDm31rH9
	 SVb+4krCr3jLF76FMu0zxtr1eGqRdilnLjxfaW1lw1fIwev6Sav5fBFdbAjrXlx3TESF/
	 HXug36iNBR181x8taWZIF1+pUYY1SfFzWMntKyJ93RpV8nK4//iP7VdowNcrYPU4/5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N9buWkxV;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9664606A32D
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 00:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9664606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N9buWkxV
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2700336eec.0
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 16:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794614545; x=1795219345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kxRETnsBm6VnWvhVvC7Nguz7Rrl10P8nelMFGOXi2xg=;
        b=N9buWkxVsPWUF7Wm8IEY+qKOjay49Vms7+Ng+fde0FZj17F8b1nXN9efqNsI16Ee97
         DkLj1XN+FvhumFynxFuMeMTHQLp9jIxc1FgsbO5GWu/m+yq1V0gsfr1A9S5bvywswmco
         7tArPcpFu+TwZelBZ1Yq9/qZIEawBJvanUdNTSSaAT+Mlv7W5vSf9WztzClX+NsdEo5+
         p2gBNuB1twVFSw0Tcd9/QsCevKIJOJkkf48/6PV76ObeCKS6lohNqb9EOag63uiTd/Vn
         jFvVsuOGUm7PZmxStFBjVfbysYfyErbWXYwnwU6RUed+dluW0Tc0VVyCtUoL2kL04mNo
         DSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794614545; x=1795219345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kxRETnsBm6VnWvhVvC7Nguz7Rrl10P8nelMFGOXi2xg=;
        b=yQIkveyWHeiuDzEM9TsGgwOLfrecCL+M8KDArmjgCyijV9n/iHopFoVMqK0/1xhiZh
         19bmtlyHAXvrWe4yjm/i0xxyjJIgzq7CFbVCjZCAVaZ3g2K+sIUM2mNxMemmUBBUuWf/
         HlSAUeWSRlfLohsaQdLupYp+Di7l+utfAjXtzIOjEhSjKC10Y4DunfC1z2S79+kqJsEp
         WUMMNmYCzwUcFtz6l/1vyuCJ6WrVt4jEEHnzjdv5uEbHvREy0QwjJUauEXO1/PVCMtxq
         eULLaP31Vn8Zm0LBoxzxIpNkOUM78IxPLtMCqz3VxRX9ERsgsh82oLSwVg6uwNg0EMOS
         VHXA==
X-Forwarded-Encrypted: i=1; AL+hErFKW6bifevT1YeREkcZkvBLwIRUprWCiiiKMp17kuLNf3hoalVdecGam95gP5gGc7Wo0IYIMDBBMMzw/w==@vger.kernel.org
X-Gm-Message-State: APuU4Z9wxZDJOwubW/+NNMuBQdHYwRuAbMp5dAEHi67myTfpybVkluyt
	VBqAEAgU60DMf0c8PioyX0Tp4jbpYz1tNrM8LsaXsixqEkrcBRClcsfq
X-Gm-Gg: AYBFou24D0er5o/h7P+8scBdmWj0q0MHzmirZrR8c8VIO/ZLHrJ9Lp2otWjINJ30FUG
	A8GXbsCwB15QoO+OpB3t70DVE/ZnJQpQqt5h7NdQKwZSV9/0uLFJ3/IfF4US14ByLkPRUrV6plO
	8bDNjbo3Soj7tlRVHfz65xM3NX0myxKV7hvmUbrdNncfBK8apCjtKmdqV3IKZMeE/wfPgZW0M3q
	VMaKdLvz76v3E2G6iqX0MEea8mPDO4Mo0cEnLY8FA+LqyGr1GRoMazu7FpdNfL2z6s4FWbN5dS2
	2OVzfAjnWunlvH1he9GZcY0VHPA3FeSi8fS0U2+3ScEb+2vrBkPgz8LaQdwxs0sXaFbXWrM4uhT
	2fk6VreQrIQsc1QfSTSPzjfVnC47YinA0vtcDvBTwILvPfLKKFkUXvadnQGLyTa9idkFyLQiSLy
	Q7z1oiPgfc7xASY/J2LJkLLWME7VV+a9u/D+X9M2Bae2ixn1eC5bb44eLaQKr2dXznb8A0FWtoF
	UmRCOWNpX0VcCkih2Bze6amC3Q0s2+wmIvsq8tpvSvzj+/eaTDuVEnvBDrTKXRYXPuECZF2a3Uk
	rPQRyrPqJAEMR98RUCFvOpuD6lBIru9O5fsgPezxTL/SBEKN2/vNPplhGtOPmMiwyUSw/8VrM6e
	FrYfCB3HFzK9MLkVNMQ==
X-Received: by 2002:a05:7300:bf9c:b0:375:370e:f1ff with SMTP id 5a478bee46e88-379671238f1mr3369208eec.35.1794614544915;
        Fri, 13 Nov 2026 16:02:24 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:560:7267:5908:e9a5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d269asm11309849eec.23.2026.11.13.16.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 16:02:24 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	"H . Nikolaus Schaller" <hns@goldelico.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Johannes Kirchmair <johannes.kirchmair@skidata.com>,
	Yuki Horii <yuuki198708@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Input: tsc2007 - drop unnecessary cast in tsc2007_calculate_resistance()
Date: Fri, 13 Nov 2026 16:02:18 -0800
Message-ID: <20261114000220.1280581-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
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

The resistance value is already bounds-checked against U32_MAX before
returning from a function returning u32, so the explicit cast is
unnecessary. Drop it.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/tsc2007_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
index 7660504f58ff..fc707e672424 100644
--- a/drivers/input/touchscreen/tsc2007_core.c
+++ b/drivers/input/touchscreen/tsc2007_core.c
@@ -82,7 +82,7 @@ u32 tsc2007_calculate_resistance(struct tsc2007 *tsc, struct ts_event *tc)
 
 	if (rt > U32_MAX)
 		return U32_MAX;
-	return (u32)rt;
+	return rt;
 }
 
 bool tsc2007_is_pen_down(struct tsc2007 *ts)
-- 
2.56.0.679.gc527c65306-goog

