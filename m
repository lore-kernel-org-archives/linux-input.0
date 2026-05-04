Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98FC3E6385
	for <linux-input@vger.kernel.org>; Mon,  4 May 2026 18:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777920895; cv=none; b=SzV1S3chF8ziJNR9ja0fG5CQDY+zE3yDLj0mM5kyBsBYpR8hWP5kxEj+XZC8r4XK5tDsajSWKBFlbwl1lnW1VYPPMZZgJe+M7c6ZlTmNrZGAGWw2OH+Df2l+PxYJyWsfe+fbADes80SUIw8PIflDYva16yg9+eJC8dJH+7KNeAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777920895; c=relaxed/simple;
	bh=X6ZP4AbUQhy+1vK6aIjWYBb64FGoaXW4biQJ9vXhYmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FuL0PAhDdTDNfexM9EG1tot37PcJYGgNrIAliHdMwmatGJQFE4hkByyh2HMSxpznv/axYWKu/b9DFBSFNtaqio+cVR0nWpq0jnUSqOY/x4cwIX9FjYDbPDufG1KV+ws5W6TsdyBJSQMUXaZvQHEe+S1AAqXYCk5o10nLnWEBTdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhEnL2ps; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhEnL2ps"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2f3c623322bso583389eec.0
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 11:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777920893; x=1778525693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dW2xmDUvOx56Zunc2V2z3nQF+PhXC6PyTRu9F8brLyc=;
        b=OhEnL2psm1IRKY7LoVKxmvCGv/CRp3EjHaUjIu6k97BBg4sWDPBkbyP7RGN3eZ7Wgv
         cGGeQyg6ngfKOt6Eb3Ht/YCGXhgECWm8sXjyMbq8VFnNuOEUU+Px6p+qS6m1cKibQ25y
         ueLRc/1E57bOBJFYU2ljquV8La3AtrXj84bQkADu2SavoYQ4CAoWbRhkC4mIkHNFBD1Z
         riXiRZSXBr6cWKb0FlNxU66OpDP/wmngwoyq+iKyicDjAPGCs9k1XsJpRh8yLuUHq5V7
         V2TuXAGJFjqzzNIUa492UgfVSsBCvH68UexUtjC5SZ9tzzB/u59ArEs/yxd2cUVF3el7
         zuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777920893; x=1778525693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dW2xmDUvOx56Zunc2V2z3nQF+PhXC6PyTRu9F8brLyc=;
        b=nfEDjZxs4gHF3xQEuPInmvS2Ajg3/fwAD1plh0KwCvB/c1Q6pDxZx0UzskCw3wC/U+
         YxVZLv8R4CDpEhITFPUYr4WIEsj6nLSXxyXoNArxl0kB9t87uI6ZWADBOxwTZs9uT4xL
         +/GrVNSrf3bLmGtDUkIF+RpAavvwR7SXnyyCMgxTJA/9cWkWWSgEwNgmD01odIzmtlrK
         Dn19XXwvZn9jkCFZWU3dTq6cONhGH2gV94YoJ3R+stGTMKtw/1Qv1wKtkeprJpPu4/eP
         DAClltwJEu0jrYkF9i/0IwthAR7hv3Ln5C54iE1qAqwdOMSQXEH4LAYizQUO66Vv7J+V
         ldlg==
X-Forwarded-Encrypted: i=1; AFNElJ8jGTW8o1Ms0UWQshttT/weuT9zXbW/xiGsHjyz48KZpy5IIKM7Bmf7roz1BqAWgTQS4YJnOtmSRJSPdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIb/c1bPRoqdV9EpN78MV43gg7/pGbxGXUglRQa6Ry0ZhaHBxS
	xJQG7bPK07gqhGTZdhJtUX7je+jXuEyverj1QkRgNLfxty9VV7+PntlH
X-Gm-Gg: AeBDievGj+DvVFAGnjx5Qtr+oFaOAMFzTIj0XNOx4S+9lILRB5zTc1nkH3nvcjB/a+k
	Qh7cQPzJ13hjEEu/74Q25oLbENEiAttUd20wiAJP4FcvyGJNjQF7wRYRv/kebpfGWtdeggP9Taa
	A0i7upIKnbbRnfP+IbFnh+ROz7Rxwya7tsbG2jOa+9ttEGsOaCQi25owG/qTV9kuek1tLCdFFJj
	JM2iai+O676ciHlaaCQAQmBdWNSuvZ3wtBYh5aKPo1GNJOZkIBreif7KGlEL4nTd6c09ExgXDdT
	XlxSBke3jEWZ5d8DReG8ko7ZJUvcsZf81OBkEhYYY/tlj12jN37Ij9zve5b4hJvyQqrOU0XK2Rv
	tKgriMTH8PTaKl6Vmm1Cz6JgMt5Vhj/Iv6oS0hJCQaumLxZrqT5CxS+fNYza9vFt1cvP2oKUU30
	oZrMjDzCLvbA990YNrxri1GMgTLZATOzfgdRmHNZbrd0hH7nv4M6zC6VZQ4i+bZ3B7hVBLsY2AO
	+wwb+g6UKY8LTKdJwurQzAZaw==
X-Received: by 2002:a05:7300:2316:b0:2de:c5ca:c1f3 with SMTP id 5a478bee46e88-2efb7ad86b0mr4848561eec.4.1777920892917;
        Mon, 04 May 2026 11:54:52 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:5b87:9b19:32e2:2981])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3bf6812asm16830718eec.28.2026.05.04.11.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:54:52 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Nick Dyer <nick@shmanahar.org>,
	linux-input@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] Input: atmel_mxt_ts - fix boundary check in mxt_prepare_cfg_mem
Date: Mon,  4 May 2026 11:54:45 -0700
Message-ID: <20260504185448.4055973-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a configuration file provides an object size that is larger than the
driver's known mxt_obj_size(object), the driver intends to discard the
extra bytes.

The loop iterates using for (i = 0; i < size; i++). Inside the loop, the
condition to skip processing extra bytes is:

    if (i > mxt_obj_size(object))
        continue;

Since i is a 0-based index, the valid indices for the object are 0 through
mxt_obj_size(object) - 1.

When i == mxt_obj_size(object), the condition evaluates to false, and the
code processes the byte instead of discarding it.

This causes the code to calculate byte_offset = reg + i - cfg->start_ofs
and writes the byte there, overwriting exactly one byte of the adjacent
instance or object.

Update the boundary check to skip extra bytes correctly by using >=.

Fixes: 50a77c658b80 ("Input: atmel_mxt_ts - download device config using firmware loader")
Cc: stable@vger.kernel.org
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index d62bf2c95578..28b2bd889c70 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1503,7 +1503,7 @@ static int mxt_prepare_cfg_mem(struct mxt_data *data, struct mxt_cfg *cfg)
 			}
 			cfg->raw_pos += offset;
 
-			if (i > mxt_obj_size(object))
+			if (i >= mxt_obj_size(object))
 				continue;
 
 			byte_offset = reg + i - cfg->start_ofs;
-- 
2.54.0.545.g6539524ca2-goog

