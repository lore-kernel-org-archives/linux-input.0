Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94271355F2A
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 23:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236253; cv=none; b=EodlftR2F9VIjnG3bMmo4O+0A1J8QvevSccxp0gahQik5w9v7HeBOFz9LX1eiz90FdEkx0uyA+A4zouyHtapBZHoA387YkR73lx5g6qS+/AHcSN7NwrnbBNGTj2mp/I6cdOnJEz9nOHiH0aE39Y8kTl6Ovfaz84bMFR5BKdTgVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236253; c=relaxed/simple;
	bh=izLNzxbsr1aPEJ1kfO4J3cElOdE5JNlIeAUDXYIIamI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlvCQEe8bvlfs6+st40Aqlv/fn7twIM9JbQcHKnmShwShVlw6lymBGVwt0zkK/g1DYCNvCNE00i+FmuHogi+/5iqPLSNF1rnDkRHhP+O/+F81iFqHfVfMTENB7pB6a1O9LYJwajQIbyVcsUTJCCnNkT3Lj0WVNR6WSvleth0QZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJXi7T4C; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJXi7T4C"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8954a050c19so31118736d6.3
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 15:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772236250; x=1772841050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=525zY6xasiLGk1IKp9hGTD1dTZkiwSaXW6y/mnA7iXs=;
        b=GJXi7T4CotIiox2lNGXsh4ezWBuOtUrp6Hlgetk6THyzBH3/X27yOgtIHP2vMUDe3l
         ynaVhPO5U1HwXEtOdLRTeeDLrsNzUjn9fSmMnfqssr6U5372rld+pR/6JQubeUOll8Pn
         5NYdIvdHpCn0qd1rvur1uOseaX+acyaIZdVgQ+uj75NDMxmDl7AZVZT3J2MW/zlCh++E
         fwXWHbVsEs35TnI4b/J/PcfeBBxVUTo9lAOkHs3f3GuVo2FprTn10vo/NcwY1y2bnzoF
         MzVwXuuFZWFdl4tAZbD1x5XSfhPyQP6LelwVVI+1qQ+9A477tP9Ll2r7GQscrhAMRCgO
         kuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236250; x=1772841050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=525zY6xasiLGk1IKp9hGTD1dTZkiwSaXW6y/mnA7iXs=;
        b=qdJ1L+UO7vid4qyVa/ndGFho1U9lQrIewRpM7Ds2cpot3GlZQpt9vNuY+fg3qY+6YS
         7BEp0JNVqN/cXkEy5mgtDNgnd7uW4psXxl2syssxxxxwLvc0mO2hny/Hw/s3I2ynJ5ns
         N6eO0B8yPSog+qntRpgXu5aT1Wd85yf7Y8ib1NJlTPyqnmo89eEQqm2j0xUBJz8F2xZT
         tw5CYY2ofciQmZermAgmqBrw/oJycuiKCEwBklsYP/83xSz09gNjR5WAuhvsKerAKNMn
         H5ElncsQjCXmZKCTFEDeuusENKCaG7jeSc43CG1OQ5WWugF0G433gpScxZM2zrdYYete
         kYsA==
X-Gm-Message-State: AOJu0Yzc+yce6WjwwO6R4pegvPL4rL0a/dmJlayKhD/H2NhVrN508mc6
	y4MG4CRqd57Yf+02pPl+DgGvnyyev9mKdvG4dIpkSMVaQenudukFquW3
X-Gm-Gg: ATEYQzwo9ARi9FGh8Aqd6WK/BkPNxLZB9UHeeg7nwDAv0VV/bfGQC38UOrkXXD/FYbk
	dFnIdAqo2F/RlLtXdGKAAgoA/jxQK/+Wt4Li7WhUd4rC2HJccwHQo+XcSFem+Rg7pxmgv38Kd6a
	EDTRmN82tRXhmPgfnQHHjgEYdHYu41fMUVvDfyJN6xHvSsBkdd38GXVus5mZFa+fo9x769rMoof
	7Mai7EMaGU9S1GuNTpAiksrmrjf9dSIh8eQtqbzuE6EQdcvcG55oETe6m87MrIngYuasfhjnhHx
	X8JyCrrNjmgRhK+LTRn9b+qRpnLdcfFaz9EoRlSLL7CwWrGqeOb9JEygaKzPB2K56an5C+XviLK
	kIvrAj8AT8UJuA+IXmVeprVdqRMIxKpTXNRACe7TFrHDU0HXp8MxfToTzdcCzr5NzFIz/jxPidP
	KWTKKIztE5ezQd221XFk7vM5VdeanH1yMzoaN26oi8VdOzFr3jrQ==
X-Received: by 2002:a05:6214:21e1:b0:894:2c12:aed9 with SMTP id 6a1803df08f44-899d1d83d6emr71564676d6.5.1772236250506;
        Fri, 27 Feb 2026 15:50:50 -0800 (PST)
Received: from achantapc.tail227c81.ts.net ([128.172.224.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c715a87esm52397446d6.4.2026.02.27.15.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:50:50 -0800 (PST)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v3 05/18] HID: steelseries: Update Kconfig help text for expanded headset support
Date: Fri, 27 Feb 2026 18:50:29 -0500
Message-ID: <20260227235042.410062-6-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227235042.410062-1-srimanachanta@gmail.com>
References: <20260227235042.410062-1-srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous help text only mentioned the SRW-S1 steering wheel and Arctis 1 Wireless for Xbox. Update it to reflect the full Arctis headset family now supported.

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index c1d9f7c6a5f2..29f05d4b7e30 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1142,7 +1142,8 @@ config HID_STEELSERIES
 	depends on USB_HID
 	help
 	Support for Steelseries SRW-S1 steering wheel, and the Steelseries
-	Arctis 1 Wireless for XBox headset.
+	Arctis headset family (Arctis 1, Arctis 7, Arctis 7+, Arctis 9,
+	Arctis Nova 3, Arctis Nova 5, Arctis Nova 7, and Arctis Nova Pro).
 
 config HID_SUNPLUS
 	tristate "Sunplus wireless desktop"
-- 
2.53.0

