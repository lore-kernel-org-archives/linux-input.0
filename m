Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CF238236C
	for <linux-input@vger.kernel.org>; Sat,  8 Aug 2026 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786215940; cv=none; b=T/DU5adaoOIMQ8MMgPRBsSYLHwT/ls4YpDVTY059Tx4Q3Ax3Dn5LglOpgLiRwdQixAPg/+g9EhT2hyidvl0lsVTAxOBUTRl5HpVhIK1qUUJx5dSBSj31cIK23j8tiofqf4ZeAgFSJZbF3QjDzNxdKIHoJ24I/KZsnTbc5yqGSYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786215940; c=relaxed/simple;
	bh=29yw0q8z7NtZRI32lw6jEXo+x9RKXuP/0Z3y3Whaq1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mwZlCosxgaG0JFaO/XcIFaXHgADN9S4TYON3FK/h23pbXxkLXf/X251xMDDzPQ3PohtSQ6537ywM/pKLB976z4TyhzxApfLRy6FoNhLRzfLUvIq8fky2h1cqBdKVSpNNic6qqwTJbTRGxeATSlMy/zqsp5jwnSj3ruWSp+95U+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6zorYar; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6zorYar"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso6438915e9.1
        for <linux-input@vger.kernel.org>; Sat, 08 Aug 2026 12:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786215936; x=1786820736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W9BnzvGcSpznT+V9trtve8n8y5TcNog+miG6h2jf2mU=;
        b=K6zorYarzPH+wBG2F3wxKjcsYk6x/sy4FWnW62Fgqi7zmUZMG6Iq1M3Q9KpyXyhYnB
         R+Lo4AzO0Xo3Y26UXHzqCG835nxwNa42fuNYZ8M7FQ4lgvbcYeSs3FfulR/OuckAIpMG
         npruwx2sLvme6qaISSnxqpqncAEA0Bxdibb3+k0yxIM8NGQC49c99baYKc4yykueYvGA
         2UxTeNWw+TEnYpOwpJcjtaEdeXq/V+VuSq09LRJ3VY9byW/D0GFbB9qJqgsr+fvbZdqF
         y8BeT5zX6bDRNcR2UoqLFyfTndMPq2AiZ6KN//+ecfwr2GF6GTgsJFbQ1j5BX50Z7rCl
         3HZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786215936; x=1786820736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W9BnzvGcSpznT+V9trtve8n8y5TcNog+miG6h2jf2mU=;
        b=U1fKCLti1PBzrqNODfD/paR+gWWPU9L8C/iuFhTGKi1nJx1b/ecQ4HA9l6MMVzBpDK
         g5xvGc9ac0i/Tauhzt1x/G8cwrt98d5cxvMNtcmppJWf9P0h2SQLUAz4vIQVTaEQVBkw
         0mGUp7if8DvJCe58hU8awz14XU4UPzzJZEcpE11uu+hJi7N0Bi2z5MP8L6Hnr+Dv/O3S
         3m6Xfk920Q64+QhlXfFA6fVY/Z7PaZFBF5Tg9yKsA4DKPszQZoaBbVQInBU1WLG8QlL0
         N2I6V5lNrQyu82oKYIWwTq7gWBObxiJeyp7UVnr7ebP2nmk2zp9tqn82FrGC/+hS5eTA
         Yj+g==
X-Forwarded-Encrypted: i=1; AHgh+RrWHyBT/sleV4iIdVl0V9kfMonJo/A5poEe9ka6NHAhuoLFSCW9posul45XOD4VeqTsB06RVyUmuhGSjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjoK4zngENB2DmqPgLJZMICtz1yDxwv6M+O5D1PYSg/pTwOG1d
	6MiYsL0hXXGFbOesYpb5jB5eoz9P6P4SLaf1TSD8Ea/bfXfIBf1ZHbZp
X-Gm-Gg: AR+sD1167w+OlUODsmVkFjOWMLyHnLUMGLsuLIbg08s5TE/Xgp4aETlkaEY3NE0uHu3
	HvLwbdwe9BxiEUxS0hfy/cbh4SZv4voHpwQ0N10rhJXBvhd01dqqi30XgKpUzdw0zOiFaGKxn/q
	8dwz7EU95u2YnQXiIfl/RsLdFwCtK6PfQmYBqJ5aKmd6XqIpYUKGoMpzs+Q9OFBHn2uSVslyxbj
	RSqQwC9RZG5fMBWblBb5fjpq5RG7TDt92QeC+CLZzcOixTa7t25mKuYoFt6kYoNp7xCzYiqvqHa
	5VgxQZBvmvymbnEpyAu1rkcVeMH+avdVBbIgi8S+lAGO22ploonoJCoMoiH6HXRsbgdg1a/s1rC
	rAXbZLgcsDbbYjKkeQ7BUPELKrqq0xPtz1HLYoUinXPBCgoxd0PhJlRcW4qrOnUkrCg42JePvgd
	/DcyVjFnxOgJrv6UxscdwhWxK7vg7GA5lDitfi+ZPxLKIbGEpShPoBt+OH1NNiw/M9AiqqyoEQY
	V+VN4769/Qgppnp3J5FDMn7i6KquV29GGvUKk+u4sPfPDhBtefECr+3nwWrMszenJM2q6t24fWx
	y88bVsUQpdws3S3iZ0yKSR+62i/ysBATZGU=
X-Received: by 2002:a05:600c:3b0a:b0:493:c47f:3c55 with SMTP id 5b1f17b1804b1-4994e71d7b0mr393658775e9.5.1786215935751;
        Sat, 08 Aug 2026 12:05:35 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-077-007-004-134.77.7.pool.telefonica.de. [77.7.4.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9e702dsm164974455e9.3.2026.08.08.12.05.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Aug 2026 12:05:35 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: haptic: don't write an uninitialized value to unhandled usages
Date: Sat,  8 Aug 2026 21:04:17 +0200
Message-Id: <20260808190417.87415-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fill_effect_buf() initializes value only for the four haptic usages
handled by its switch, but writes it to field->value[] for every usage.
An unhandled usage can therefore receive either an uninitialized value
or one left over from the previous usage. hid_output_report() then
serializes that value into the effect's report buffer.

Skip unhandled usages instead. This also matches switch_mode(), which
only updates fields it recognizes.

Found with Clang's -Wconditional-uninitialized.

Fixes: 344ff3584957 ("HID: haptic: initialize haptic device")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/hid/hid-haptic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-haptic.c b/drivers/hid/hid-haptic.c
index deadab28cdbef..66d90f0f78a3b 100644
--- a/drivers/hid/hid-haptic.c
+++ b/drivers/hid/hid-haptic.c
@@ -187,7 +187,7 @@ static void fill_effect_buf(struct hid_haptic_device *haptic,
 				value = waveform_ordinal;
 				break;
 			default:
-				break;
+				continue;
 			}
 
 			field->value[j] = value;
-- 
2.53.0

