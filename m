Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990863CC9F1
	for <linux-input@vger.kernel.org>; Fri,  3 Apr 2026 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233466; cv=none; b=fL607CTB7fOcWXGCTZml1CH4WIFF6Gnzw6T8xtccUqNTmH0CDok7xwXeewxZUdFXpcw9L45rvs7JTUaLqFWcmyS8xOFAKcfUacd/5mbFANAwiJl4szyag3tHU4LITmJorXsVTFhKlYeqHL4V8XXGvg31br+KMKysJnqvFmG/umI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233466; c=relaxed/simple;
	bh=LvNl6td+yOoOIp43H/BnCgdsNVC61Ut85wDbtanlQkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bnjz5FYeIP73ktdaFESPRWmSPbg04gVYciVWApjHDf95Xv2SnDiuLnSgU51MupskhrXmwqxyWv0gH53TdDwAhSUx2lQNiSJoiqqDfKXJO0wIWSDrb6hoMhajwB0Ru0q4FRlEFz1FGbRkzcBecFLoGdaY7PpkBhEZ4oPDcKaifQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aD36p/Af; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aD36p/Af"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c56aa62931so4602495eec.0
        for <linux-input@vger.kernel.org>; Fri, 03 Apr 2026 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775233465; x=1775838265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FMnwSKi7dJI9JOxVy7E38ZpRdw/s8wxHsfzIYcdo8Ak=;
        b=aD36p/AfDSeHeXxlGsHk+GK23RlDuNp2AMubk7jYYJ6H75X3T69f2HkfTwBhNV51YL
         cdESHqyObr7eGyXXJ7+XvBFgH6v3GDIdVRMP8ckXX/D2C7z0JY0905b8mGnDoxaPwfq5
         LOvwYNrVZ8GVY7wjIj7v8KTjIRyX13If3CkIzhFUfUK6ZkHbRFMKzd9/8NMOzjiP9GjS
         wVxbR3O4GG5X2CfLHvt14wIjDLL2io6u3wTTySLtD6ZuXcGdV2PdjSOLIuZlfcKkizqd
         oey7485MYkblcnPDObofZRGPpBR9EC5vV7MvQB0xrhq+Yar8eA5362nJQSHR6F9N55vp
         3urA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775233465; x=1775838265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMnwSKi7dJI9JOxVy7E38ZpRdw/s8wxHsfzIYcdo8Ak=;
        b=SrPLXeseekPelJXorrdjVKuimfEuiA4KLSNlittNNEuxoCoHAChgCez+hZJhfzPrvT
         FVmsjiMrDDGzwHXeZur0oNs8u3YIVtybsBv2ku5koEACLB9LD4+WAyMypv5SG8pMBSoQ
         e+90n6t/m52XcdzKqo9TE6TZT+UByn187YzCiwALPI2kPgcfPj0jpRrIecGk/4ZMeWXc
         8G4syrZwo7lk3qcnDs0+1db3HgGSCeyVW9IXbaI7mvIjdeNVsr3oSs6cR+auRPFU0dgU
         Nx4gyxftPAdF6fnvItybheYSGW9mSDNNDhJ+X/0QEaGamVNHabeuWizp3/DgiIh2t9yM
         GvKQ==
X-Gm-Message-State: AOJu0YzVCRhY/hBGPWwyc0tGsvXR/5Q0Mwi6fDF7SjEfZ1uhRIrkKJDF
	7GOAxiu+pDKlzxBmQBSfhd49Z37HzvXL7OjyEGFSuUuf6R8CEUETlP/QJdYxGo8zU5o4WtZV
X-Gm-Gg: AeBDievlHm2jccaEx7kdmBv6lEBoW53fCaM5aIueORAkpqjRLk83pZ51m62UHoYd1lt
	V+UWnjiHXuG5g7BXHGVQeS5cItRCyLtxDRK1pRAtq+Cb6HMkpyZGpcBPRqqMPYRA8DsQXwFXLgT
	Zkap2ffxHIU6Pl5X911pMz4F6NacYAiQ3p1OEegWQ7N7KmFmGiiAQt1IZspVi7IG2JWhyaGIuJ9
	Yv5TwP+MZ7x2fgXSZzs2ZWry4e2122K5bc8p49ssElbnxo9kGyFbfwO9GAB1/okhNEbRZ/toIcf
	4H2R7c6KOkHJazrG+S9lzpQGxfoMKHfXFVS7P2/aYGqTAscmoPmA8tESeTlpbG6mBFiSbzAZvF/
	UcBoP9/A4iOxG2v+DCcZWNZZy2m5RhSoQAqzO1O8vk1oLZKKGc0yI9jo2gfa6LshQpPxztrKY+d
	J0kAedSXCKCxOVzVq1IgdzRUgE6MOEADz5OX4=
X-Received: by 2002:a05:7300:e8a7:b0:2c6:31f0:a025 with SMTP id 5a478bee46e88-2cbfc4623eemr1923237eec.27.1775233464461;
        Fri, 03 Apr 2026 09:24:24 -0700 (PDT)
Received: from dev (67.209.184.230.16clouds.com. [67.209.184.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cc6e17e0bdsm1743350eec.31.2026.04.03.09.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 09:24:24 -0700 (PDT)
From: utzcoz <utzcoz@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	utzcoz <utzcoz@gmail.com>
Subject: [PATCH] HID: apple: Add Niz keyboard dongle to non-apple keyboards list
Date: Sat,  4 Apr 2026 00:18:06 +0800
Message-ID: <20260403161806.31908-1-utzcoz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Niz X99 uses a 2.4GHz wireless dongle (Milsky LL Dongle) that
reports Apple's vendor and product IDs (05ac:0220), causing
hid-apple to apply Apple function key translation. Since the
dongle has no Apple Fn key, F1-F12 become unreachable when fnmode
defaults to media-first behavior.

Add the Milsky LL Dongle to the non_apple_keyboards list so that
fnmode=3 (auto) correctly resolves to fnmode=2, making F1-F12 work
as standard function keys.

Signed-off-by: utzcoz <utzcoz@gmail.com>
---
 drivers/hid/hid-apple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index fc5897a6bb53..c29834cfa468 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -368,6 +368,7 @@ static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
 	{ "TH87" },			/* EPOMAKER TH87 BT mode */
 	{ "HFD Epomaker TH87" },	/* EPOMAKER TH87 USB mode */
 	{ "2.4G Wireless Receiver" },	/* EPOMAKER TH87 dongle */
+	{ "Milsky LL Dongle" },		/* Niz keyboard dongle */
 };
 
 static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
-- 
2.51.0

