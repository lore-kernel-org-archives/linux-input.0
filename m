Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0EE35C6A0
	for <linux-input@vger.kernel.org>; Fri, 31 Jul 2026 05:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785476550; cv=none; b=loG/q1yYX7C/gfuD7h+cQdYhZPwDwLLs6PNSB7kuldjjw7/agBDHu2XzF5Ryou0GPeBfjsrHu0pOAiISKlR9SN7YWCOvK+YlctQr6pJTd+gx1hFg7IkCuOkctlWqi0BU0iUAu5v5EzbuxVArBPIqaJFUZ82GcsDzjCwghIdVCJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785476550; c=relaxed/simple;
	bh=eEglfdU5NKeCVkGM1ZbDEcNdiQaf6a8VpYub4K+kR2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOsAXIiGiQDt2XN90xhW6niiu2CL129ARlnbEWsE/Zokb8lLTFeB1z1hHW46Aurhobiy1bLCBoOU0T6mSIz5BFpp1PmVRx1zuKXiryEl9kHiiWJ0JSLH6fZaoL4+BeXztBNrTiOgdhmmfHa8STKX94kmEpNPwj28id8RlkvRPEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggXY5dOc; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggXY5dOc"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f7872abb6so329306f8f.3
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 22:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785476547; x=1786081347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cXlmEM+opo6hR1/SsuBV9a6HOAEDgwAGIwmp3dr8Q0U=;
        b=ggXY5dOcUETYJARjzS0VzOkwtZaZ+EdapAHc4p3yxOGHaDynk4hDBP2iPXYX1qkVC9
         ghdCHpFE4S3Etj/hl5L/0JaOtMO0Zx6icv2KgOd3hLjlXm9tUOp+e1D+nI+XyRet6TdE
         +KOtYLG2QOy464ZuBxTKy7RsAUwlQjYBd1iwnrDrpwc8+bM9BVTQfEVawKThdYRLP09c
         /qGtBlnTQil7dcx1qnxJ0RYiCFdfnpZqMWIqSeVcnOB6rweYGpE9p1KUAe68zxkWRzAZ
         KzuqyrEr4tuuRQGpAiM2GQkMzc02abT88pdwlvyRnWobKw2kfQw9K5Wap/XTc/XY9A2X
         MLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785476547; x=1786081347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cXlmEM+opo6hR1/SsuBV9a6HOAEDgwAGIwmp3dr8Q0U=;
        b=BdZzwDvALSx6QrKkmq+RhsOPq0kxc/FtkXkC++04/Kh+LYFSafCrXVkV4sTx96knvj
         V80LHKrhnWfmIRag91TjDYt8n9iKfIaJLp0rYomufdD23PhS7G19OkqEFdu+jiEmxcEC
         6G5BT2z7QOjx54PVJOZULMBCbOLb/CcfQ2PQXHOCeuTXEH3W3kUAa0bpnfAuOBkk0Sqh
         taY6LdiNgdt47gS7Ln5BNdzdGs2yLtaToYUXAdVSJwWhpg4a93nEqyL1NXga11MLvpId
         VwVkXc2M868saSWIg0ipuSMpiHNbg6WnfvlahxmgWXJNXke/n3kj6nDMV18dq98kgG1b
         ELBQ==
X-Gm-Message-State: AOJu0YxqoIbmyv0o+RdIEs/6PjXZQQBJolbqoJe0sL3b5X+pYHNz+Hq3
	yINJRtcVs7cAl4TUYfaAqWjp3o0Bq7e0pNQ796YZKsjyVuu54Z4BO6Ei
X-Gm-Gg: AR+sD13M2f/ewu6XYkU+/WTM/wltzZmDuAGNXnw9Kb3EIFSJEdCBM04ns4Oq+krpmFZ
	VdYCyMNuIrpjzaKQLrMrbbQH4bnOFlgKSYJMlBC+0dsoYCoDFs4dMK8JkSM9aJn5A7lPIBr8mWK
	ALxohYybrG1cgHNP+Pc04YGRDCTkHQ2jcR71vjThEiQM5+aoLoc1mWLLjPCB3ihjcLujNspECx5
	JKmNRDEDqmeCb4rKAvoJMTLls2iOi54sgXewTbC3WT3bQgKScKwncUF46PokbfoljJoDT641GvE
	+t2wyTN0nCVzN4DiPT/WOz+u09xyFZUU1Bazt9koUUvWN6t2CYzz3CuCFZPzWR4Z+9azLr/qAts
	3CQAZ6FWvDdok7+sH++6yADGCCQ7823f15fXiUrr4Iy3ibHD1EGsjthz+w+qL7uYbxNPHlg9GVA
	zVoptm9bXPgnOqcUfHOGvouEyFG+sNzVVDPSS26J/Ry8mfTbtaTIW93leghcdg744uiIX0uDBKp
	ro3KmeMM+2Z4VzWcB9VX6M1tW/u5PM=
X-Received: by 2002:a05:6000:2892:b0:475:f100:35ff with SMTP id ffacd0b85a97d-47fd2b698b9mr1419677f8f.60.1785476547145;
        Thu, 30 Jul 2026 22:42:27 -0700 (PDT)
Received: from mortifia-tour.localdomain ([2a01:cb11:e0e:6900:846:ff2d:816e:3783])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0ae0sm412873f8f.33.2026.07.30.22.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 22:42:26 -0700 (PDT)
From: Guillaume Casal <guillaume.casal.42@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dbdaniel42@gmail.com
Subject: [PATCH v3 3/4] HID: debug: Add FF_TRIGGER_RUMBLE name
Date: Fri, 31 Jul 2026 07:41:58 +0200
Message-ID: <20260731054159.1982164-4-guillaume.casal.42@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731054159.1982164-1-guillaume.casal.42@gmail.com>
References: <20260730134004.1118476-1-guillaume.casal.42@gmail.com>
 <20260731054159.1982164-1-guillaume.casal.42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without an entry in the force[] array, hid_resolv_event() prints the raw
hex code instead of the name in debugfs.

Signed-off-by: Guillaume Casal <guillaume.casal.42@gmail.com>
---
diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -3583,6 +3583,7 @@
 };
 
 static const char *force[FF_CNT] = {
+	[FF_TRIGGER_RUMBLE] = "FF_TRIGGER_RUMBLE",
 	[FF_RUMBLE] = "FF_RUMBLE",
 	[FF_PERIODIC] = "FF_PERIODIC",
 	[FF_CONSTANT] = "FF_CONSTANT",
