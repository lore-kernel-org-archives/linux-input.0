Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E04D3624A6
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 05:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957231; cv=none; b=lAyhQNW3Qxk2bgYlxehXkmoJ9VLVYjRqm9uN/Lw3DhiN4xj2IDI49XTPwCNeMXvF2CiRSknG2weazh4x3/zEfEnQ1Kq2VjvPh4Y31r4c4BIpKyWek30ldDDphB1ZidAgBv2tpJoOmV/Mgfg6C/lraQxae2oLH+kVCi3bQR1wMnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957231; c=relaxed/simple;
	bh=lvgn7q0Ow84Yi1NlycJeboE0aL1jixpOHvToaCQWwDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=islvj4qdaGMKJqo1dfcb/sPcxWuP9e0NFrmGA2aXoUuHhj0FMNyBN4nlONszkqST+BjD09ShghV8QfByxSFNJMsyfZ3v7XnE7agN3MMQq4oaf5e76L/jtpmRugJqfyx9UCoJOrANMCcLKxG/a+9PAL5wli1DuyQLSgNcv8kO528=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8iwpY73; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8iwpY73"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12dfee30612so2048792c88.0
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 22:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957229; x=1778562029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITP9fYm6668VerGxzkCEPeFYtOb1KXTza8Qxp0QEEgk=;
        b=B8iwpY73W2vYctF2vgXT9+iraz53Xy9A21UeAl+eoSk10aQy3sZKGXa1CMm2lu+rE5
         YEkJ1fuXatEpOIeBwZFFTV/oUfKnUROphmrcr/5CtP14ZE7HyNFZdMGdesWDlULUACXY
         uoKSkbSSekXNfciIdeRtTJk//HYwDA11zlgZJym9c6mwYpa0bykiqYopM9iFwNcfIy/K
         IMT+nB+OQ89oS/oAHOYc3t9NJXAP02LPmsOuLDTiaFc0NTHFB8e/ORzr+FBGwfguJ+qj
         PLmudx105O2ZMU3Ef6EyoSw8aeeyVPkgxwWGrQC7+9ZPKupJ+z//IqGO1zmjk0OlrW08
         UtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957229; x=1778562029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ITP9fYm6668VerGxzkCEPeFYtOb1KXTza8Qxp0QEEgk=;
        b=GRSLfMuWLYTWiDtXlOtM359LOmPGh90PZl+x/pV8/51QZYz7P9EwA9/TgjoLPYGN4W
         buSC3ptPy4Pl+P3nLHgU2FBlhP0V145Q+HHeMUuWuBC1XJ0uk/pRd9bMhvoUnXD10GME
         tdQbUSbLIXzI+DrcQZf2jtmHPZLCkss6xiwBFOdV8SDzlGpFd+4y+EY0/3ZxNLyHQq0Y
         c63oyb8xgeJ6HT68sBl12v0p2RPj8BWumKePfbEAatJc4rG9bF4yxW3qx8jdr7sm+4hj
         5OcRSQvI10U/fc/nMcDQE+RsV3TRaozOj7tbhK1USskPzrmfEvOd2ytbQR2CUvgNnF45
         uiNQ==
X-Gm-Message-State: AOJu0YyTrPJvLBddTxagz9wlFicYp7GfN+ntdRXKX0BnGxUhZfazOAvy
	FPG+Yc39UXV+vO/jgEXembpOwH/UeclQvthcpuqsH2GpbmehRZolyJPkD7GNfA==
X-Gm-Gg: AeBDiesIzMbIBWs/3v8tLDSqf58tA2tGYbUUsSs2RhtuPnyoxfjgWy/oa/IwSaW8RsT
	fKYdWHckk4crB0kerxeLd+pSfD6DeUh4MBSiUE5KH1dvZKc9bqRWMd6utAfYdxVyI7hWsw3PhrO
	6dJR5DOrirmFAuRPS3btCdpzXQzJKU9ps9g08TNigJxkNXa3hGdIZU7zAuTwUlS5DvauDuN5XW7
	+DPhA8mxo7WTZkIv+QHWHVeYBb+I88ou8nIpUlxQeZdJ1Nqr7e+1scUjh4AyL4U4NrxBuAbBAbc
	3h9yGWvHzNDmSeiK9oAxANfQ6SkHt8YgtmlkDCXZILnSzFaOES3sVdRG18I195xyYsOwZH1idrw
	twQxkI61F1PobdMZikEIEFr3X3q078Ve4GIVzNLcdVt+EC/cAlS6s2N4fE0kApMQYSwhASM+GG8
	6xdWKdezln9wlVb9f9qfCk5UtzTycMd+02bCKOKS8xDwO4/kWbko/fZVm2wWHSlEcIvPZmkCMa3
	w03s/tB6fTuy9/csPZpqflm9Q==
X-Received: by 2002:a05:7022:6286:b0:12d:d972:b96e with SMTP id a92af1059eb24-12dfd81a804mr7139807c88.20.1777957229175;
        Mon, 04 May 2026 22:00:29 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.22.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:00:27 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/20] Input: rmi4 - use sizeof(*ptr) and idiomatic checks in f12 allocators
Date: Mon,  4 May 2026 21:59:47 -0700
Message-ID: <20260505045952.1570713-17-dmitry.torokhov@gmail.com>
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

Using sizeof(*ptr) is preferred over sizeof(struct) because it is
more robust against type changes. Also switch to checking for
allocation failure immediately after each call, and update
formatting.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f12.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index 01838907c64b..34ed02b7f30f 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -528,16 +528,21 @@ static int rmi_f12_probe(struct rmi_function *fn)
 	}
 
 	/* allocate the in-kernel tracking buffers */
-	sensor->tracking_pos = devm_kcalloc(&fn->dev,
-			sensor->nbr_fingers, sizeof(struct input_mt_pos),
-			GFP_KERNEL);
-	sensor->tracking_slots = devm_kcalloc(&fn->dev,
-			sensor->nbr_fingers, sizeof(int), GFP_KERNEL);
-	sensor->objs = devm_kcalloc(&fn->dev,
-			sensor->nbr_fingers,
-			sizeof(struct rmi_2d_sensor_abs_object),
-			GFP_KERNEL);
-	if (!sensor->tracking_pos || !sensor->tracking_slots || !sensor->objs)
+	sensor->tracking_pos = devm_kcalloc(&fn->dev, sensor->nbr_fingers,
+					    sizeof(*sensor->tracking_pos),
+					    GFP_KERNEL);
+	if (!sensor->tracking_pos)
+		return -ENOMEM;
+
+	sensor->tracking_slots = devm_kcalloc(&fn->dev, sensor->nbr_fingers,
+					      sizeof(*sensor->tracking_slots),
+					      GFP_KERNEL);
+	if (!sensor->tracking_slots)
+		return -ENOMEM;
+
+	sensor->objs = devm_kcalloc(&fn->dev, sensor->nbr_fingers,
+				    sizeof(*sensor->objs), GFP_KERNEL);
+	if (!sensor->objs)
 		return -ENOMEM;
 
 	ret = rmi_2d_sensor_configure_input(fn, sensor);
-- 
2.54.0.545.g6539524ca2-goog

