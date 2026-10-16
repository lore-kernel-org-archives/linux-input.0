Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2F546EF93
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145719; cv=none; b=AhHfb3OClF4ssXI3OATGaEthA7uo6c3iv4KB/h8hE5Vo1T3qNY9ArFviJ27loGCMdUYGUFoeQuT2m6BgHWS0uSfl5uMKLylGJCAegs9RH5YGYYhX50SSL6ss7Bp6D0blXBow6nc4JynMlauAk+W5cNnKLVf9h1az7P0/6URq3RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145719; c=relaxed/simple;
	bh=D7sxvwTQORDG9UZDgAwID33nx8Gdqdcm0JU1TwJ2tdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i3RWlNF6GguFMaW7mqMJhhAGlAsF2fIKFFZ2jqgZhtpV7qvPDFYlhf/nnTucbbp03eyufKriUgb2y13qgRXkH8BUqQKtDeJTQW747ZAxBJ2+x6EFKBivRwT9FVPDg/qoz6hHVsl4qYAT8Bf5dSkSAqqZr5Q9+kB+KRIUTHM2tHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPGiuZEl; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPGiuZEl"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15ea896ddc8so4247159c88.0
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 03:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792145716; x=1792750516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XsEajUbPO5LI3z3KVxIR8CEQ6sxYOQ2C/IR/YdstWrc=;
        b=mPGiuZElz+S6Aypjve2nCZ82notXj4Ady2f0U472EXWutdT2ogsj9MH9XnllSSerde
         fbVcYuM2P915+jkxDQ1cE4qoHHEBV3Dkhpto7ve2Dqwkzhakd6zkYswOyXJTZ0Wxj3Q3
         V5zsLI/GgJFyNNj4qaUJVHRdGwb/JLKuPZ5kT/OmniZ79vXmLtKZPTzeSMuvk7NRP3Jk
         FMSA+iMUwvPSuAHmlrc3/Y2j1aJmRgxuXno5NSAFa2wyDKc2Slwx7Wa1N29e4rBsAaSu
         L9ORGPhCH9kpdXYuI0xwLrRDvQDgvdHV/HhHqp225c1HZLJU4WiES8yPI4SFXG0fCkW7
         vQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792145716; x=1792750516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XsEajUbPO5LI3z3KVxIR8CEQ6sxYOQ2C/IR/YdstWrc=;
        b=EOo4krpCpavSuqTs2OuOy5coJ+HdDnb2H8d4ieCTbmSBt9mvP7F/EOR8IRUFcvkdef
         GzM+hApS7qqEFt4NCfywsq005HQ9uqegfikbAWIrslqNIpmwyuywdeAqCFt80ZdxarrU
         bihFB8ydvwKtmOZvs84YZg9ZWFDGmjbP6GzsIJdRgXFDofBTWmxPI8YiCjyymkbTF0Ui
         nfvFd+24GJzxl2VfJikaaB2I8jhNx/x1U3bFNGzn9Dka1lcBs/uz8Y6D8C13IHpO8yvN
         yZge2P8htseYE09qBNxd8AMJj3ARtHUmqME/BGcmAh2IlCdN/VJAGVt88RzbZX2xtWk/
         1J5w==
X-Forwarded-Encrypted: i=1; AKwUvBxig5PPgxCO2RKoVc9/y5XbvNTIPnbHYVfjG12pjnSyo1POvOtJHUZPL322zFFK19+XzB0H99x+DAjfHg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIYX+gxHFZjrJCz0B1BZBoUhDmVysFyPaLaezho73KiCn087sGd
	UcBBT5I9tWveUOo4/kalLNPbz7f/OWxihw0P1lNFCRPJGq4q8Sr0saOU
X-Gm-Gg: AYBFou2OtS7ivFA1iH2j3HpvQR0kyMsniuBVFZe6dAeQrDftTQVO2T1C1sUp4XwTTxc
	23tWVUyKYn7/STE4tUpMNgbddq4RoSgOrkOFrr90KQUIoPduvTebYAj4GK4ixbzHWlcxXT4ixhu
	Z+jeeUcpkHAIC41kT5mDWW5jVnfjDfFEl+gondAlw1p1/C/lzIweo/TBD5G43nSfwNo5ECt+MuP
	UI0XYT0DqRJao+NMbul/btVCJNtVvFgSgypm5iGxmFCVd8+1KzFbo+u/7CpKVZcmQ3ndE1RxY+B
	oJbnS6ngVTBWfu2QDXz8uCjmYA97VnPYwkmAxRDkjj08x0Qo352pcspdM2pbBdkD0QzbrE+A99v
	GcPDZwt/ENnl/earX3Dr2mzTNJV4xoys8OUcq8SNqoNU7t51aILHhJNAM1IYsbqYgHqys/oWtcp
	isgaMnO54I7Vb/7Se7LIKrDjTFx+4/wmVB1yiwoIVLPSw/ZVGqlXrCXIW6DTmubvSxSXEhr64KS
	grTWTpfp9YzxbKemrvuKxNDtnPMpMxFP051AyGjZ8WIUn9eoJVNZUPUD6l5VNqhEqrSfakZ
X-Received: by 2002:a05:701b:4281:10b0:184:1898:adda with SMTP id a92af1059eb24-1841898afaemr832160c88.44.1792145716297;
        Fri, 16 Oct 2026 03:15:16 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:301c:f8cd:1467:1666:71b7:b993])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa3ebsm4294724c88.8.2026.10.16.03.15.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 03:15:15 -0700 (PDT)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aryan Sinha <sinha.aryan03@gmail.com>
Subject: [PATCH] HID: hid-msi: Use str_true_false() helper
Date: Fri, 16 Oct 2026 15:44:58 +0530
Message-ID: <20261016101506.14084-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open coded ternary in enabled_show() with the helper from
string_choices.h. Gives Same output, but with one less conditional.

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
 drivers/hid/hid-msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
index 3225d3bf6..4822b5d6d 100644
--- a/drivers/hid/hid-msi.c
+++ b/drivers/hid/hid-msi.c
@@ -28,6 +28,7 @@
 #include <linux/mutex.h>
 #include <linux/pm.h>
 #include <linux/spinlock.h>
+#include <linux/string_choices.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
@@ -1586,7 +1587,7 @@ static ssize_t enabled_show(struct device *dev,
 			return -ENODEV;
 	}
 
-	return sysfs_emit(buf, "%s\n", drvdata->rgb_enabled ? "true" : "false");
+	return sysfs_emit(buf, "%s\n", str_true_false(drvdata->rgb_enabled));
 }
 static DEVICE_ATTR_RW(enabled);
 
-- 
2.46.0

