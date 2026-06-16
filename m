Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9543CE099
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 05:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781586767; cv=none; b=rSXE1vLwDp4UdbnLYdXiH0TazaN9wB9MA9UBtFq8b6p65sjHW0ou4Ft8UQNUY4jhu6tJU52DjOF1E9bdyxDwwRdoT+ZDznlWVragYJwj3BI2LMzPfO5vC7jpXErk+QYFov8aGzJdBDRKE5TTHgGCb6oxlsrMLV7PIwX+NEgPaq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781586767; c=relaxed/simple;
	bh=nKpdkPNMpYldRLUe77m/lDp4IURNFikimWQ7kkqhQ9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9Cp55tRQUy26OpvPoyMq8m10/zFaU4ibo6diTB9xYRdjqB6OY0kLUEMMC8QUjFpUPtF1h2+M4sxAq0EequRq+l8EXyeZgmAIMzgZO1fQwLLCd6qoRpS8SbEt5dwQh8hRTDiB3wdjdshSxrn4eH4/LmjJAVt+ajGh/obS0iQ0Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzLJmUTw; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzLJmUTw"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3074adb8fcaso6931787eec.0
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 22:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781586766; x=1782191566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EW/pB55oGsaV6NXZltwH7jBTOBtry9BVGiJEbLm/9U=;
        b=SzLJmUTwQaDahrF58k6TkPiNXICaNwn7As9pyanZl6Fno7cNlLVvcA8t2KWKCIRkLE
         bXGGK+YicRz6np43XMxnoFavIGLuNhefYTzAyBea4AfYit+fpN7fOeUf4Pc6aj1be4sj
         KQ8rK3uv8Bdgma/OBPgbyPNfjd0Dm51UJeho2cn5F7bdvntQHxtGZNlPtAmmDuH7R0Vt
         ovm0UZoMZtSB0qI5pKMxgn4QXZWjv0zQloCGNdToSrcdGgx6BVI7AiMV3CcRMX0ek77a
         SpwKImWulTf53YnVxwPM9CjyqHHvextkj9VdSxuy8XFj6axFvdL+uI1HAP+kVtz81IC6
         xN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781586766; x=1782191566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/EW/pB55oGsaV6NXZltwH7jBTOBtry9BVGiJEbLm/9U=;
        b=CrCuZn1qYUCB+ZWai2QaIhtw2V0zI02cMuxrN9iIfU97/3BI3od5GSdb2HlsI8QjBH
         bJk/W4ZyeCxhSbK0YTrdpJn+F9/QmZFZi1MH5G4aO1zxkjtj054fatwBPB0zOWbsQGxj
         UYf7bM0fWaWG+2E5Nfk8DlbkGqbuTN+CVG0ibDRACuD8+0hJlb/SdUMyzXJ51Mgj4m1f
         GEgEg8vG2unTI36jTpke3j8vxlQnP0h1R/3fUTAZUBeP+tEWrQ6/7mKAkqe9h0pTFNcl
         VGUFoH0SEzaLqnSNx0JrIXU1HSwHnBaoYjMNNTfxkhgwkZFYDm/zN/SdJYWHnubUkzYE
         OHkw==
X-Forwarded-Encrypted: i=1; AFNElJ/afXi37WD6ZK6R8dbyAx3HA2VTTzfA/5aPiN5xrwHtAEz7ZT+TDjdZc4rauTO3O/IeB6uwnLldWc9XxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNfPsbZRoDLS7cxdXpLquCAe79LbbfHssLkyUeiUPXnlVBcrLp
	2Vf8lr2ABzJ3BDHxWuoKdr4PBht4jtFy1o4EmV9M4tkux2bRmKI95a+T
X-Gm-Gg: Acq92OHLWTIbOWjVA/L6R47ueQreSwOC1uZy8xPnocKquPP0jet79nfzACEJFXRN93s
	2n8JmnA5W2uMFD1ivYF9srZR2oBgJGqhe2xv4fFgIai7I5h73smdh4rRLP0k1ZxbwZn8NiSBCG6
	NHtWevf5ItTFrxEv5wKHaQ/Bm9qkQv+hQ/rpHbgNfu2+S8KeTRtNd22p5DQjKE1hg5A63VVvFfL
	TCankgRj65EFmLiJ6YONV1UW4HFk36cGsTGn4/IKtNK/SNwVQiEpLxR5suvWMQobs0LtlrTfk0Q
	GBsQD9JI+LF/YcnnJZURbMZ5PjzZj9+fn34Ck1Fu991Yk68NFh87nCny78sWMDMyhBNTZiLaeuY
	pZuC8fG7r9DNarDD002L4Y9Tt4hOv69Eft7guq3CviRpsRpgWrnV8tkofjP8iOIMcaryA4mTpB9
	iJEszMORpfBa4xL3kxfKsH1R2JqLQ852ObVSQoJ47OMO8zji2GCTP1pHpYDTQSmuzvfT9SYEBhZ
	ybyfaxUbUoLnwo=
X-Received: by 2002:a05:7300:fb8e:b0:2ff:c84d:44d2 with SMTP id 5a478bee46e88-3081ffaf9acmr10481839eec.12.1781586765835;
        Mon, 15 Jun 2026 22:12:45 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3714:f5c2:9b83:3df1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea43b80sm16726052eec.21.2026.06.15.22.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 22:12:40 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans Verkuil <hverkuil@kernel.org>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/4] Input: sur40 - fix V4L error path cleanup
Date: Mon, 15 Jun 2026 22:12:30 -0700
Message-ID: <20260616051235.1549517-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616051235.1549517-1-dmitry.torokhov@gmail.com>
References: <20260616051235.1549517-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In sur40_probe(), if video_register_device() fails, the error path jumps to
err_unreg_video. This incorrectly attempts to unregister a video device
that was never successfully registered, and fails to free the V4L2 control
handler (v4l2_ctrl_handler_free) that was initialized immediately prior.

Fix this by introducing an err_free_ctrl label to properly free the V4L2
control handler and bypass video_unregister_device() when video device
registration fails.

Reported-by: sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/sur40.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index 8639ec3ad703..e9089b0c3e2f 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -787,7 +787,7 @@ static int sur40_probe(struct usb_interface *interface,
 	if (error) {
 		dev_err(&interface->dev,
 			"Unable to register video subdevice.");
-		goto err_unreg_video;
+		goto err_free_ctrl;
 	}
 
 	/* register the polled input device */
@@ -806,6 +806,8 @@ static int sur40_probe(struct usb_interface *interface,
 
 err_unreg_video:
 	video_unregister_device(&sur40->vdev);
+err_free_ctrl:
+	v4l2_ctrl_handler_free(&sur40->hdl);
 err_unreg_v4l2:
 	v4l2_device_unregister(&sur40->v4l2);
 err_free_buffer:
-- 
2.54.0.1136.gdb2ca164c4-goog

