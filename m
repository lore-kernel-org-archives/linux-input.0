Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11EA3D6478
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 05:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957236; cv=none; b=q/gyUNBz9DP4J2bzNAzFiwDPt5y71kJPwwsbniMC9HpATm4dpq9LlNEz0NjvO7YMp9rUMqMpwR0KowuQT6P4igFzxoualyTUYIaY5EgEZsgbPWqFVT6FNLl4rGeJ1uCqXNISEeK4AKilMC1zn5whhE7Et7kwoJszxOAqWvhUCOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957236; c=relaxed/simple;
	bh=4kkcscaZmHFJ4YWxD6BD9kpYK/3eYjWDpjnqHTFpBSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tnk8EerinWpslAv+ZkF3mo1+/+euIs/uG8sEW/AfpngsQei9h6GUCAoRtKo2s1ZdDs0/ndylyWAnb4PBPBinLppsXgyzKEUls/dABqp7FSU5CvFn7leJWoXV9UwHrCnhBXcl5cS+SelZ/hY/APm4UYLfD7boVbMN2jEwJXuAk8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m579pOkf; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m579pOkf"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12c19d23b19so7019480c88.0
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 22:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957233; x=1778562033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72V7ol7Ytc4urKocnYQLQfygeemqtzjda7Fx3aBgxpY=;
        b=m579pOkfZHTRdFknZ0+vysZdDfr+OmKxP6QmsG/l86hptvQW+ZfBmk9XlRUFxgGqE7
         F5DKnt60lznzlASIvkpPX6GwGBnadW6NcXLFnCbfkzBMSPHC7PigYKkXTfqfvH8U47cd
         bm1gB+eSPzV+cN06iMJ8PcQBqd65BcFvlSUsEr109RY+Ui7IXS49EuGWiKyUWPBZ7oRM
         wHW0TryRDqCD6LSkZPE/U6CCRRVOaPQtqH4f91grcTof5PQP1nlSCVAYPvcoL1bfSiAW
         8689QRoWbhbRACf1KccaWnP1/ROahTc/YVycpVEyruiOkdqAMmDlW2nj7U4xux1kReYT
         Pnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957234; x=1778562034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=72V7ol7Ytc4urKocnYQLQfygeemqtzjda7Fx3aBgxpY=;
        b=FeZHvHy/IWBfGjeqAr9YlEzZDDp7phkmzsnY/7KqTVcD0c2QwkQ8E+bau8MM/rID9X
         NdFG7M+6PgtP+aTqw+lKYLHb5g3c30sjROL1OFTF9eNxSoM8/dmimWR6jMZLBLMOmN1h
         n0ipzlU9OVnX88cbKUbDe+EMHYhYF2atbgB3gBqg0TsP7unynv7WE50J5PDTL9+QRcbf
         AKDatMLuAmhMhSLGt3g8XlzEcEf/ljG0QIegiq8OkwJVakWRO/5hq9hxzLcX7QzOFs+Q
         vzwwnY+cnBZZwRzdnc5liD9sVTUxA6zuGV/5mw7YGGXNfUYe2fijEpDjt/vlnr082/dC
         DH7g==
X-Gm-Message-State: AOJu0Yyc+HMzqERWdEoyY1pPzosRh1dkqo9qyEd8VyC4/2JesNhqYiD4
	mssF+uIGZqXq+r6gNVLy/PpvvBvlp6KXS2awWBZo72TpQBPRP7WuYDgzZ4OkoQ==
X-Gm-Gg: AeBDieuuFxFbqy7cgZm7ebDKBgiN+JzbOphlJ/t97P4Jo5rb5zU0+l1w/YQAjTfzQ8j
	x9L+DtA9MFBuBG8+N5EtsL6PDtDrDCqjnwLvYHJu1vuwhXr/hWoj2jM0XONrf67kF302gxGKhAC
	SB/uiVKWf/c8heTnhXRpF4lNrCmq8Xqv79RnEBYe/Acz21lG4zMWXnwsAvAAZ20Yon90UX14leB
	RS/fMRx9DESW6IVKy2W2BLgI9GZ9HOakM3/HXVVnh3CcdzD1y9lj6aUW29XKSE4iOwKZnCV18GV
	II2yPy5cyMbsZ5FbCKF5KjTaCiraUi2kesVOL+FzInp+KmRoaE3VWkn0DfvXzqvyvlJq//qb5ZI
	7w84Jl0x+BP/YjAKujT8330JfmY0YA3vIA4KSs3i/GvRg6B+y/CKvD1gSyvAP07+Lx1uMnnqqfz
	ZIsJH+5BK4NzRpzKb4D9gio9GCYMTgerKZqBuc2o68hZnCC8PzgogYQ20i3zY4yFaehhsmK/hRf
	c783knAgzvxUo+OhiaWOHzBvw==
X-Received: by 2002:a05:7022:224:b0:119:e56b:98a4 with SMTP id a92af1059eb24-12dfd7ba4cfmr6023780c88.11.1777957233464;
        Mon, 04 May 2026 22:00:33 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.22.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:00:31 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/20] Input: rmi4 - propagate proper error code in F12 sensor tuning
Date: Mon,  4 May 2026 21:59:49 -0700
Message-ID: <20260505045952.1570713-19-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
References: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Propagate the actual error code returned by rmi_read() in
rmi_f12_read_sensor_tuning() instead of hardcoding -ENODEV.
Also, since rmi_read() returns 0 on success, use 'if (ret)'
instead of 'if (ret < 0)'.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f12.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index ea72d5ce8050..bf8c4a0e10de 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -166,9 +166,9 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
 						RMI_F12_QUERY_RESOLUTION);
 		query_dpm_addr = fn->fd.query_base_addr	+ offset;
 		ret = rmi_read(fn->rmi_dev, query_dpm_addr, buf);
-		if (ret < 0) {
+		if (ret) {
 			dev_err(&fn->dev, "Failed to read DPM value: %d\n", ret);
-			return -ENODEV;
+			return ret;
 		}
 		dpm_resolution = buf[0];
 
-- 
2.54.0.545.g6539524ca2-goog

