Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92DB2FA0DF
	for <linux-input@vger.kernel.org>; Wed, 24 Jun 2026 05:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782280215; cv=none; b=eX91ThDFCTchatSJwVkm6EmSxzx9fpuGdwOJ7x3U20jmgUO0fMbgv66HCO3IK/b5qq1xFMoGlazbOg5LF5f9fO2K3E3kzlC2VSDfhR1wnTs7zjDRvwj7dexLjZ7KuIUlDcktOg2WSm0s19pmjkzdGfh/xreJv0SPvyDGLDQg2fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782280215; c=relaxed/simple;
	bh=05+aOvlh0HZQOhYyVz5PrqvmvdEPjszq0SezpRNhrvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzsbxEmOrnfUT6NoYoHvSX/sk7ogWXj7Na5syvsmhWN4yu0anvY1OXj8NpJSQi7rFx3keWBmFba4hKHR9JKseg9huqUSgHi9HXF3UuKhr+w3ela0wXW1cJQ3/5UVXOFrLo0s+jboXzZqln5e9ionjPWtzJl898cYKxJsHF2MZcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCyK/v7L; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCyK/v7L"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30c591fb1cbso891476eec.1
        for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 22:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782280214; x=1782885014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AE3z5I4Z7m9Rcvx2p4OS98P/noBS4oQPrdI99uWQsMU=;
        b=gCyK/v7L+DK4H7PE5IBIDpmz0Nt5SIYUkc4kEVJWMjp/TaBlF89RMiAwdBBcxQHCnH
         dAfwYr1o0I+c9oQHSbThWm4lStiHBTz0c/AnwosvyYVEzc6Zf0qHdQC/FkH+0Qcq9HHw
         rmfcY/6Ibn2s81o6iRdd375Xfrlflej+Nm74KnJ3Y2pKBpJiav8gFUs+9IUxjGRFN0vT
         rlf7XGtAfO7KrjUalQFR2A55Bs1fV0cOB2mGdS563pU75OuY0R2yO/DCTbG7wWD/lHgP
         DpxihRi0VwKZlaCnT2ToYJl9Hs2CFLxEXGtoBUvy17Ql0AhU7ehi0dfO/Of6tPP8H7UF
         m1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782280214; x=1782885014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AE3z5I4Z7m9Rcvx2p4OS98P/noBS4oQPrdI99uWQsMU=;
        b=LQZsELGvIWimdj9u9XTANgxl/PeKUTk/MxsoDoBa4t/vdyIUPB2fDtk/PzTy+US2fD
         ltfYixVUiTy2Lx2ShSnRGAoU40YU7rUEVk45pQrdC/gBCYh1kmbE/HbDBlFGJ7A0VABR
         zlM1rMADOD6ZqVgSF+Z4cMTTBQa3tbKF6mZbQ6uJaHVV2UOnIJaRM7o8/6T475XnXqzd
         xyT4cvd6OrGCXGUa8IECWbQ8DzZ+bDR54jPgLMI2yMEJRpBt0mvCDbtP+JRVAmETShcd
         U2cSabLAIe5xaSXbuJdS18rMJFCKy20LFW3Kk5odrBsyTXivsbEyTEZInorLdhHXYAc6
         J1Gg==
X-Gm-Message-State: AOJu0YxYhUVRJTCxkiWdrM38Z59c/yx6+sWr9lvqvAUWLNSa+9XuZkxz
	gk96FsLoFwIxvc2IAYV/yQlkZhIMwsW9ElCPKtJrr2kDZB8YMQISdMBa3iDu7Q==
X-Gm-Gg: AfdE7cnwloeVJJr3DGY/DB/3QHQto+CVL40U2UoITYhqWUKk83wjXIc7HSxQMxZFzKj
	oor4k1TiOgpOz44/evY17l59ljJfLCs/hkzvD18OavUMDS/sckSwtT8cGHYMdVxNAFZafay6il4
	RAc7kopZcSvglL/tjz8YgeG+qyEVynzLSL4XJwPuBtpJWshAIM7tseKnjXL3qTj/UfEQ1icuuXL
	J+G5xO76OWCT+x4o4qn9VMctvZq2l9nLBxq0BjVdXy+V1Rp9lYK7wSzaw5vnQubyNvF4FDEjaIM
	2lBUR7qk+nJwuCbx4YOYeRvpnDXZej7y7I8efjl/MwKTvHDGoK67JkeWQ2BuHojdh02NbBNxnoA
	ubSr4xfJrCZf2XNjiPoIEReTIq6MNdJhf/xVr4xIQthWxk7ahYUTMDeUGHfnWkG0jbmAum525yz
	xQYZZWBOKuEW+OewJjjAV0KQCiKIk0co4R5TIgQtgDhS+gTEyXgPV3AEkcNPruqgFSPuwmQbGCh
	h1ibfsn7/c4rSQ=
X-Received: by 2002:a05:7300:1483:b0:304:df8b:71ee with SMTP id 5a478bee46e88-30c68c77c87mr2503702eec.7.1782280213830;
        Tue, 23 Jun 2026 22:50:13 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:6026:1e6d:4a80:9bd0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c430553d1sm14073419eec.11.2026.06.23.22.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 22:50:13 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] Input: call handler->start() when uninhibiting device
Date: Tue, 23 Jun 2026 22:50:05 -0700
Message-ID: <20260624055008.2494980-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260624055008.2494980-1-dmitry.torokhov@gmail.com>
References: <20260624055008.2494980-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an input device is inhibited via input_inhibit_device(), the driver
is closed and physical feedback (like LEDs and sounds) is toggled off.
However, from the input core's perspective, the handles remain open.

When the device is later uninhibited, the driver is re-opened. While the
core restores simple LED states via input_dev_toggle(), complex handlers
(such as vt/keyboard) may need to re-synchronize their broader logical
state with the hardware.

Fixes: a181616487db ("Input: Add "inhibited" property")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index d99dfe69e12d..c2a038d31beb 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1780,6 +1780,7 @@ static int input_inhibit_device(struct input_dev *dev)
 
 static int input_uninhibit_device(struct input_dev *dev)
 {
+	struct input_handle *handle;
 	int error;
 
 	guard(mutex)(&dev->mutex);
@@ -1803,6 +1804,11 @@ static int input_uninhibit_device(struct input_dev *dev)
 	if (dev->users && dev->poller)
 		input_dev_poller_start(dev->poller);
 
+	list_for_each_entry(handle, &dev->h_list, d_node) {
+		if (handle->open && handle->handler->start)
+			handle->handler->start(handle);
+	}
+
 	return 0;
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

