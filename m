Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9AA38D3F7
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 06:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144889; cv=none; b=J6uI24AqSB0co5JcbR0BiViTkn7+k9cc0fqq2wgQ0wxs1x9z3VGi8HzOXlR+iXLKOe9Y/VnPLzlEr9hZ1WUUxtcNBthdgXLvnJhswn5AOOB0b0FEqyIDYIMYBCxa3Cx3C29PiL4x9k9OliiVB6dLqtYxfytj0pbunUDHQd+r/ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144889; c=relaxed/simple;
	bh=nUO7dEkOKEvVNtuM2TAkm7x7KFkgTmD7CMdjUA404dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGmzPFMJgf0fLoPnfQYHFEAqks5z85ZKzoxA9TwVM2otUDZCFJBC3a3lnIDXE5O47oSn92swMyqkvU0QizwIJ5l6eYmnVZlgo61uk7eipOrN0wYJ9ZA/X8mK92JSIIB6iRajvIU/mZf3wCMwoJd0bIZt2wiA+7VwdGE4I/fjjOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePiNHNJf; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePiNHNJf"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37d82f3a244so1308934a91.2
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 23:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144887; x=1783749687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqS+8jznfiHJXZ6W2GHvBNlXgFpmVGJB+A9fPcFpydc=;
        b=ePiNHNJf412scRHStFYZLnB6pRixzAr1qp2S6FABZXV6bB1StkKErf8yR7Q46vsBN2
         eR9jAokCY87TnTdRc+oZjk+F9tYr7+v+YOAHenGtdIZcpSEWu0iqKYSPlhLxoCIvmCzs
         r7bIcPI+Lm4TSomCU08AjxGau7sRogGkC3r8a1+w6UFjSiwdFNc1WGkwIiAl65cIbxWC
         WVqTO+isiIIVouwjNV7P0/0ob+4q4c6X3ANcHv8WeaT8shwZjQfXhuOom9TQ2J/Kz0Dg
         7V/m5bnt3wrofCQ+2oQqQhcifytPtY4YEMoVJWE4f8pbFI1bBeGsbju/whri35Uh33Ld
         t5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144887; x=1783749687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fqS+8jznfiHJXZ6W2GHvBNlXgFpmVGJB+A9fPcFpydc=;
        b=T/Z0TCrNU9pPkbK4rsVkAbZbh/g603NdJJReT7ocLMjoXkFxII6VP+YbPlGd+jvY/l
         QT2l0e1OjKf3UxWyijxf1SFJ9fBCFwizWknL9dLg+j41ctQ6J74CDi9Sn8RiYj5/d8Ct
         UOl8SHHRt6gniNX2BV1mu/7W/m3jy1LFRJ03fsoHle67jVVpmgUROIkTQk/l0lqGoMMX
         lZlYijqJd7ZkqIT+6g8la8cOAzQwlAtItfZgpAGspyLR58ttTraNbezVfVIEzmy/FfUs
         5Ajhv4WrgnnOeDFdxhagr4GnaRtiKDpK8uys+fiL0KVo+RsugSp0iE4awXlicsXtbOC/
         VXYg==
X-Gm-Message-State: AOJu0YybcWgpD00Ox44k6/oUMvoQILWd+KcsdIs9OSAQX2x2bqTtvzdD
	aMASuIU/tdDLfnhgf4KmMXjUrX831reb9bNNR+f/WsCL7CFhIghG/QfQKXN3mA==
X-Gm-Gg: AfdE7cmfMDPlzST30Ci3DLDMW1l5ND2F3l2EVjR4pAq3H0vzcNPi8lRJKptrDI45d9F
	mKJKJNrQYTfuKJj+/lJbM7S5OaIOIhyiI0Aj1XPidYFR1UV4BR5dovjkRhLe1EHon1l+TaXit3U
	1FFI2G4BK+bVnl6Ql9qI0BrOELqMR1+vHkL3jRmm79jb2TawBGmfqMygHdrOLQGVs4r/fdJk3Gc
	M8zN/Ud62Ur/CJIJNqLME2HW1rbg5QB1sN9a7yZb5eMlmLL0pBl92JUC8ycvxQTr9k6TvcFKL5U
	YeEvLcDBQYyd77sQk/+LA0y5AGMN5/uMfs3hnmHLwFZeX97cqHHkiEXyuuqp0Qe6/6QwyOCWIlm
	EgDws1g1m/nwN3Hh1F9ZGrUk9IpaUB6Dgt3me0aeRkzkW0Fq4M+EdJIioEVVQdb8Oc7ZhtSP4YU
	PkcJDOX+i7xktEMkCdWd+0WCF9+cFP7tnxFXYpYMPKLzWKaZWgHL1ypZgZDZe4CrFujpUn7j+DA
	SA=
X-Received: by 2002:a17:90b:184e:b0:37f:9cdf:f0ad with SMTP id 98e67ed59e1d1-3829f9e3ecamr2167194a91.28.1783144886647;
        Fri, 03 Jul 2026 23:01:26 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f116065c5sm25081378eec.11.2026.07.03.23.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 23:01:24 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Linus Walleij <linusw@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Input: mms114 - fix Y-resolution configuration
Date: Fri,  3 Jul 2026 23:01:14 -0700
Message-ID: <20260704060115.353049-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260704060115.353049-1-dmitry.torokhov@gmail.com>
References: <20260704060115.353049-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mms114_setup_regs(), the driver mistakenly uses props->max_x instead
of props->max_y when configuring the low bits of the Y resolution
(MMS114_Y_RESOLUTION).

Fix this by using the correct property.

Fixes: 07b8481d4aff ("Input: add MELFAS mms114 touchscreen driver")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/mms114.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 84afdadb3bcc..27911a9f4e9e 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -408,7 +408,7 @@ static int mms114_setup_regs(struct mms114_data *data)
 	if (error < 0)
 		return error;
 
-	val = props->max_x & 0xff;
+	val = props->max_y & 0xff;
 	error = mms114_write_reg(data, MMS114_Y_RESOLUTION, val);
 	if (error < 0)
 		return error;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

