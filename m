Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEE63016E0
	for <linux-input@vger.kernel.org>; Thu,  8 Oct 2026 06:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439386; cv=none; b=ZrgjKlMOHuvJqggOHd/B/w6pjH3q0SDp2xLU47uxiYa3o1g7C9yGo5sndK/xcwMrhGOwT3DAqc6CUTEYAZCsKVsz1rWKRo1KhrHByYhL1QfW0qKhbReDjCGxAGKpWqzlhB0IX8gPoDqq57vY57ry7mfePPPC6IB5UB0PeWOc2vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439386; c=relaxed/simple;
	bh=fIRMhCIOyrVw9rK5CsCSRNLHttPMgUeKuQmICivAfvc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N9qomlXzkh1y9XoZYL8i8A5FOC5HWXk6B1XRNDOVJrKI9eiotNNy0sLQQmrJ1GP+WNucrcMbDfLKmBfJFFvvVyIr7wo3hgFgBWUMs4t5iYcXuCj+3D+SshBl/SDNuJ+Tw7Qiy0WhkC3eygycU3JsXznHUeS8q/fTZfMuJz89MtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjCYWNN0; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjCYWNN0"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33c2520ad38so6154139eec.1
        for <linux-input@vger.kernel.org>; Wed, 07 Oct 2026 23:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791439384; x=1792044184; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hVxtblLyGNciWT4y5SJ0lTWFuCiEjX394rt+jaGOGh0=;
        b=PjCYWNN0irK30+YBKuZunkP2rBGIrY3MhHwpLTcT4ZzbnEe1EfQAXSncsq438/3s2O
         Kn/G53VYSG/gOAOygQ/2MJDCsnlDdauPUQOSuBrcB8KUWaN6ihIcAWei8ZoPLO5541TU
         5zEdK4WMi6ecJJIjZraBYcnQO1KNZE6E+Qg8Q38Imhv46ISXNuRnaTgZsL3uqAEvYqIH
         VKzDNXljXlFtpP+bNolJ4XZNyDD8TFcelnMBaBXwoaQRl89cPteXkoymb632tF73DptB
         Zlp2zkAyDZUUi8DazBwJa38DzHerUP3bHJkzonFq/8Ib/rcWJ7ulDJv/dhu9JeKu4Lri
         Upjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791439384; x=1792044184;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hVxtblLyGNciWT4y5SJ0lTWFuCiEjX394rt+jaGOGh0=;
        b=G4sD1gtxClii978bX+HLTzxFdiAEHCc5KpmXOYZNOFnPG61bylexiLFLP3/Xm8FhpZ
         20jG7h62uwlStBJE3qDY444f14XxH8Nw04r33/DFlRk5ETIkE/dDOCuI/wC6T7qc8Jg3
         yv3V9JBSiuyyE1rA32tUoMUdH/fqQQwx6A3uBbkykt+NW7UVSe8OSf9/fmZsOC2BT+DV
         Xn+xybBSu/UkmG4kiiqCX8ToMmqwTOVuEQ96gkYKU7c3PT9Opk+R2bcBELQ52hUHs6T8
         9RHAVw0aOZntZuZR/Pfd60WXIXNICf9mi7RUugfDpuShyb419SPWR6h0xgxo4tffWyJG
         KerQ==
X-Gm-Message-State: AFuF++nqwJ8VgHcbch/Xag6SuAaY5AAlXlXmHj47MB/m9YNEe5uaalKc
	AjXrCE5zIDanzvKM4zWLCJ8bIWQE2Ae2d9ey02mH2sk2waH2cFoPCRXDmtBsV9xYvFY=
X-Gm-Gg: AYBFou1ac1a+UGv68bBj5wTCbZDUr0np7bQx4MesWLImNKfmPU9CUN6F2I+9y8gg53z
	aXwg+tolb0J0zOhZwR96sGSEUZv8towFtECRFaPeBw8WL6+ZSdRo6ZB1b7cseqB0S3Rtn3NahHE
	4pnJKUqO9LdFNPNFd90aKQ/OdWJULvC1hzEU1+Wd9NqpEzqHVi6swP+TniYMG8nToXsylwI63SF
	6QXSbYdiNbVx+dbFGatpWNhHBbUS6Echr5n6emYpMrtcZDuFtwePkrgC1yuC/NZlWSOOKBGFCrX
	Q7TF2NI3j3SugBhT081Gyq4+5G0UCtJX5xLDFM6/tv2Bqr98Ue9n73XFIxyhNJcScJI/UHh1D1Y
	2glwzi/wwI6Zpp7GlomMALR9sqbTZ1fjO7nfjU4HsiWlx/WGzXe18AQ4RS1/4ylzaN1Sy+aka0Y
	jjuea4Cg6qBtp0gaKsdVU6THuwbWXPsINObt/5+gaWtr0ezJtC/Z8uQgyVTEqgWWxiK+RHYn4c3
	IBN5ABB+e72yFo4ntiD1kX37OP8Quo4UzfoYGcIsg==
X-Received: by 2002:a05:7300:ac94:b0:343:4a95:f120 with SMTP id 5a478bee46e88-3515dddaea8mr6197394eec.25.1791439383599;
        Wed, 07 Oct 2026 23:03:03 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:3002:e11e:c053:ebcb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515abb67e5sm12906403eec.4.2026.10.07.23.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 23:03:03 -0700 (PDT)
Date: Wed, 7 Oct 2026 23:03:00 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Input: cyapa - drop redundant input->dev.parent assignment
Message-ID: <ascx_F_LzRalepyi@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

devm_input_allocate_device() already initializes input->dev.parent to
the supplied parent device, so the explicit assignment in
cyapa_create_input_dev() is redundant. Remove it.

Reported-by: sashiko-bot@kernel.org
Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/cyapa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index 159cae446824..936ca4b08550 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -453,7 +453,6 @@ static int cyapa_create_input_dev(struct cyapa *cyapa)
 	input->id.bustype = BUS_I2C;
 	input->id.version = 1;
 	input->id.product = 0;  /* Means any product in eventcomm. */
-	input->dev.parent = &cyapa->client->dev;
 
 	input->open = cyapa_open;
 	input->close = cyapa_close;
-- 
2.56.0.385.gd3acb90ef8-goog


-- 
Dmitry
