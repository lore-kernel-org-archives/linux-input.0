Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA9A30F7EF
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 19:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772308382; cv=none; b=KbXQQcQqFbWwPYPy4mzouGMGEMUECvJMleJyD+as7oZhYb6oTNU3iN5SVachCEeGtkaqXOkpgqRgUF+vmxZyWZpwhbD+srLawCvcuOdVy/j4Ar7N4AGwsvHGt82X2y3KaSB9SD3izNXi5Zxr9iD5aV1CEZebOZ+PydyRgkMnPrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772308382; c=relaxed/simple;
	bh=Pb0hDyfrjf4JP7irBYUuhEIF0rGIDgqf/LK04l9CpKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cMb7JaNvEieBchukMKxoa5RLJJ6pp63h2r0M/0dotQsckiqPterMwY6ICVyh8Dll4+txdytWJuII+UZHxMbl7eNvUYpytUHNSQ0nXeaFUVVzucTUxUfHxXLnnwPng6eMy3hMV+xX9X57XqJ5SKgup4o9htS5lPe/I85ynuk4gVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glrQh4hZ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glrQh4hZ"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5069b3e0c66so59376301cf.1
        for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 11:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772308381; x=1772913181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4HX7+0nOFjK+1quHdf7pjpY5BAQVLn52GZLqmncp/M=;
        b=glrQh4hZP62H3sB4Kf2gntyMJ8cR1GHQGtt4g1/WpGZScPWGvddi8hW2R1VJqByuhY
         ZpJkHuKmF9EJ8VApqeNE8zks/udALIwmDJBSCNkZBkQ0ALVHHG7bNwwL6Gf7ii+/i9+T
         Bas1kIf/hldlDiwODxrwtpcneVOJIx6sx5Kxixkl2w7ZjVOC6zU23tXl/whShrHPuDxI
         w/PWKyDaIu2PiZyMnngInOvMElXC/pM72fI923fv9NR/8xiekIHWa1hNo/PphXIItse8
         nzPpk6MdUdLkMs5umdE9ZVxua2JphXiRN5yQf2OJfgKVzKFrsEKrhzxKmE5ZwS+V5Ni9
         82YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772308381; x=1772913181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4HX7+0nOFjK+1quHdf7pjpY5BAQVLn52GZLqmncp/M=;
        b=FKzZc9B1RPW2DX9c2hcqlye+uLzFg4hCDW3PNmzj5RjrP8vt7HRss6DwV/P0oep/gC
         gFPpjjx92mi1cBDbka2qWYfCl4TkzJWh3z8asJ8u/JSZ7v547E/JEAJHrBD0R8Pc0ZmF
         41wgSanMNVQOb8ZR0SQ1uNKRiUR6g27xVJZHmF6n/6NNbCa0JNjDXqq1W118fUs/6fxR
         rwskKKBUK4MgdTYWgx0OLmXEy0XY+vOJDQz6Dtrk0dOrt+w4F+zfXBcTRYMCYz/MM6m8
         h1vwT1fbkOP9wnelsipKpJRHynnmjLF6V76Vzd11XJehca7P4A2CTMYaA+9ST4+Kj0nm
         MZ2g==
X-Gm-Message-State: AOJu0YzmaoIow7W3NbPhwidkjXKeeIgb2/YuCyvUCkZPEvYgohp1Cfwo
	8nwH7Wg7jxDon7Ou4DAIndGcQ+gDAtNLxgD35cKthTLlsLg40IShN1OK
X-Gm-Gg: ATEYQzz2QI75P45mRgwHAdUOHyBiturAY9x+2mAQvjKa3D0e2rP1Swd5+1mlvVpJRbk
	/WScJizUwWlWD5MuqH4CsMochZ8NDsQ0PUrzYzdKNuElz1nEazjr76Jwd732D3fW5EmDYqpHgFu
	6cbuM/QQSWIx1pkk8KtFl1t+ZBeyguHOhFOag4z4mkceE3YZglrdAW1OvSFj1cg2CD+a7vQnVFN
	erxmlXoqzL5qQjQ3tmpA/Wle9GBMG249inv0LVEw/FisJMRaNL1C34r9+HW0vyjraM05f79OF5n
	m/e37M3aD1fwn0MbYzsAIu3f4YnPg780Ovp3q80ZpGxKbmf3ddYdFKz8ilQFdGXSWX7Hm6IAZ5W
	A7kICC93Ly1imWyFeb0M9YkIKNCtXgtNc/IGa2EmSi01Wh5vtapj5yqwlKOgpOsEz1yLZVM+RkO
	zb0vvOlPCxm0/4KBabIYnaUfZ71vsrLi+TU8U0QdAmkkWpyCc7MnQ7RseLXWOMKJu6An2owb8Wx
	a7v
X-Received: by 2002:a05:622a:15c6:b0:506:a574:a98 with SMTP id d75a77b69052e-5075240cb43mr98809321cf.25.1772308380692;
        Sat, 28 Feb 2026 11:53:00 -0800 (PST)
Received: from instance-20260207-1316.vcn12250046.oraclevcn.com ([150.136.248.187])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507458f8b2asm91382471cf.4.2026.02.28.11.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 11:53:00 -0800 (PST)
From: Josh Law <hlcj1234567@gmail.com>
X-Google-Original-From: Josh Law <objecting@objecting.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v2 1/4] Input: elo - fix style issues
Date: Sat, 28 Feb 2026 19:52:58 +0000
Message-ID: <20260228195258.2468296-1-objecting@objecting.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix array constness and spacing issues reported by checkpatch.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 drivers/input/touchscreen/elo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/elo.c b/drivers/input/touchscreen/elo.c
index 434b9b47e964..40ae132cde21 100644
--- a/drivers/input/touchscreen/elo.c
+++ b/drivers/input/touchscreen/elo.c
@@ -257,7 +257,7 @@ static int elo_command_10(struct elo *elo, unsigned char *packet)
 
 static int elo_setup_10(struct elo *elo)
 {
-	static const char *elo_types[] = { "Accu", "Dura", "Intelli", "Carroll" };
+	static const char * const elo_types[] = { "Accu", "Dura", "Intelli", "Carroll" };
 	struct input_dev *dev = elo->dev;
 	unsigned char packet[ELO10_PACKET_LEN] = { ELO10_ID_CMD };
 
@@ -273,7 +273,7 @@ static int elo_setup_10(struct elo *elo)
 
 	dev_info(&elo->serio->dev,
 		 "%sTouch touchscreen, fw: %02x.%02x, features: 0x%02x, controller: 0x%02x\n",
-		 elo_types[(packet[1] -'0') & 0x03],
+		 elo_types[(packet[1] - '0') & 0x03],
 		 packet[5], packet[4], packet[3], packet[7]);
 
 	return 0;
-- 
2.43.0

