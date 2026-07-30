Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB3243B3D9
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418834; cv=none; b=BhDhQMRUaZluurffYefLcf+mABw+/hTupJ7sxfPXN6+EKRdCAepi41us2cTyBas+vdSBbcJj+mTHJ36m4b24w7tbjUVzumsiMYuyywb3d1+zoHnoq8n/ZxO8ZHlC2PWhsLjHsYZPiZQTFumq8rfdU0UwaswvAChqVl8jmuF9LUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418834; c=relaxed/simple;
	bh=VlI5hPCcjD/xBikOxz9K5r1ucm9Lb7vUhxtLwEweh7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuXFAlFLQIbpWKOvpxLQdlv45FXVyc0LvW5245TKCMuK2rSjd5NZpMKS2zO53u9nigq0NombwJnbGYWWSKQoKmG2+NQJqJ8SM4Aqka/l1qW/2WGc2PcjGigw/Bvo7mg6QVInuA49GVVUjQP1lmj+ztVQ8T3hF8kFcnqzFtfZNJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4iY6aNx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4iY6aNx"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-495437bb891so6630505e9.1
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 06:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785418831; x=1786023631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EzVRN5A4VxKL2AL6Q8Jif/vHDX/nsL6ttUQeuroK6N0=;
        b=F4iY6aNxYxEthZYlySJSLeM6kl5xA9zAcANiYMImxfV/wMPJ3ohlwnfP4pdh10y/yb
         94/tg7pT9C0xQI4QsqMUGiweKeX9Pjyb0m/tLoy5usPdhoMNnFc2yAgdpwcg+dyjYRC4
         yIbtCZgyFeUBQQys97kNALNwV8Wdwm/QSgl3jwXi62O291GPiKsuA0hE6kildZsd39tb
         ruUqAocsaghizyk9wziUu9KNO6r6kn/YbMJmcixHdRLLBU8oTjFE/FFjX/05PNBikt1F
         Ddrw98gDWJ44aZzGeQc/RJwrU+0hwamLEx86GGfRMUD1U7ee/MlSbAuWLZoGF6kH5af7
         iCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785418831; x=1786023631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EzVRN5A4VxKL2AL6Q8Jif/vHDX/nsL6ttUQeuroK6N0=;
        b=V+VjpiIp/PfVzLHigjEZh9MWTFsR3CKMzHRZxC+oE3o+2viR/ypgJV2Fb/pTW9YsKu
         WRibxuExtr/MnuJQy/VGibDfJpQVRPbWxq2xWDwWv2ttdTVpUCWRROA7vOQzxXbCjyxn
         +8joeNrtIv5QGjqcNAY/TNY6Tm6yOfEluo/CJJ6nrGJ1E1YKfWtcNmss2gf76ei9WyNS
         2xFL7V021UsBeX2s0lbkfBxnCsgQ7ax/Hm9tMkIdqJL32yAb1c/71aqit7QndiIvdhcX
         aawQKqQnges4CgyoOx5HD4XwalTX2sL7IdDx8L8/4D9yn9LgnXcOIbubTcF4sxJWiZSo
         8+zw==
X-Gm-Message-State: AOJu0Yz+u2xvBbEpG8Z93EwAZQzw9W02oVYbMEHhFSNJ+gm9wPcyR9xu
	jOcAIzLic6AvhU+Kd3oG0FdkdDB5c54iUbyxcAqlIuKXPUTaGFS0VuMo
X-Gm-Gg: AR+sD11S5xs4yPc+jDBx//55XfBLEv5/xdnA2W3OshQuy6cixO53LjLyKIb1yYNyvOf
	t95rr+M8lmmX9YZeEkI8uPRnb+9qNIXTtE+bcWgIvCt+u0FP/tHaPE9owbilcScuywIBgMRCp4M
	7prGN004egyfe9u8YEhdbS7Ao9is4vEoMgooPG2HVdqEiZ1iMsBSxxxnQqWeMf/2BsqzCFFO+ed
	tyOoZz7DQluLwlQDDB+URJGg0KR3lVsgLHp43qwD39hLg+TkkU4XxVLkpg3V0lkf+hWlZJZq/LK
	4pSbKkZO29jmFb/iOfglgcFaWEtDIQdFpDfbfBJ8TgsbheDv3/PogVslHQPkI/ehp63+RmcZbLc
	cseb+vcFEoFi5Hee4CXC/hJfabt3AY7J1Tmw2Z/MdvsISM1Wg25aG5ljmp8Aa7craN2Fp0Xn+Hy
	dktFZ2a6JC4t/5mDeO4FmaV06lqMVScltktcYg0j2TrVdhztXg78Q2k/QYIIw2/nIF4pIwzEJ4p
	z8+YfVaggLLE2vJ+TqE
X-Received: by 2002:a05:600c:a4b:b0:495:6022:5a23 with SMTP id 5b1f17b1804b1-49804d284aamr4198095e9.19.1785418831351;
        Thu, 30 Jul 2026 06:40:31 -0700 (PDT)
Received: from mortifia-tour.localdomain ([2a01:cb11:e0e:6900:846:ff2d:816e:3783])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498012168e7sm66405305e9.15.2026.07.30.06.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:40:30 -0700 (PDT)
From: Guillaume Casal <guillaume.casal.42@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dbdaniel42@gmail.com
Subject: [PATCH v2 4/4] Documentation: input: Document FF_TRIGGER_RUMBLE
Date: Thu, 30 Jul 2026 15:40:04 +0200
Message-ID: <20260730134004.1118476-5-guillaume.casal.42@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730134004.1118476-1-guillaume.casal.42@gmail.com>
References: <20260730095317.767418-1-guillaume.casal.42@gmail.com>
 <20260730134004.1118476-1-guillaume.casal.42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

List the new effect type alongside the others so that userspace
developers can find it when querying device capabilities.

Signed-off-by: Guillaume Casal <guillaume.casal.42@gmail.com>
---
diff --git a/Documentation/input/ff.rst b/Documentation/input/ff.rst
--- a/Documentation/input/ff.rst
+++ b/Documentation/input/ff.rst
@@ -85,6 +85,7 @@
 - FF_FRICTION	can simulate friction
 - FF_DAMPER	can simulate damper effects
 - FF_RUMBLE	rumble effects
+- FF_TRIGGER_RUMBLE	rumble effects in the triggers
 - FF_INERTIA    can simulate inertia
 - FF_GAIN	gain is adjustable
 - FF_AUTOCENTER	autocenter is adjustable
