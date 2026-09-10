Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765CF3655C2
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 01:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003977; cv=none; b=fmOtsNZHXoIGmfFGonsNsge5/1qKionZBeFn1ewWIbDEmW2lmDHX0wP/R8QWYKRhVoNQH8Ue76XmH2Yb7cg6H6KhAvKZu6JzBQBrocvlCHJG2S3BErcbVU65qpEWdZ3xROXzF6ZJ3TN4hpGsCBw6wKhg4Y8YpbyuSiFwsxdJaYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003977; c=relaxed/simple;
	bh=Wrt5BREBuyuGcYt2aWXWslgff0dcwvsUynDfCbIh+Rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BK685IaVkK84bOpXKT1fswZmxmYbrDsXXxqtADhLANoEycQrmBFUNHIRzWCoddb0QcWY0PYp72CUybTlp5Ujl/yV33+/8epSflVSqBC25CFXc2AaixkOvCvva++Pf06JYkYZxm/fK41zoyIeq7ECKsjsGmMW7uT9L05udTXxOMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLT3dHgC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLT3dHgC"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso53320365e9.0
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 18:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789003972; x=1789608772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G0noSNcNvP/+I+rxnaf4LKhy/qChedg87Os3I3Fnbpw=;
        b=eLT3dHgC7yMLi6m1347n09ROs3vSYpE3Z6WyNi9WBErck4EuuWeauqwJmkKbS8Jddu
         6qK0q4ehhAXZKenmNiYf3ob//zR50xGqFTgEmT8ONXJOlw/Lo2ocn3k++4zHV48AiTUj
         zs3emWmobC0Nv0/m0/k9qfYexRAOQH24/D2N3zHF70mRogXpH6FKD0b1FbZe1Ll6DjVt
         iUiQNxWlTM/gP2irbowpAQbvFc1RkJA0QvT5Z3UZkO/ZS6zNg16tBZkjiPZycW7x6HhJ
         LrLhvd2zvkAFqoHchCXt3xQxta+aUSvlvUUD9pvOdMVGc7zQ/9br7uZ9d+6fQZNIUcwh
         E4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789003972; x=1789608772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G0noSNcNvP/+I+rxnaf4LKhy/qChedg87Os3I3Fnbpw=;
        b=QvunKvvSRsO+61lnIenCXOJarMiR9csevaUxVqaUCQbpPfDW429Y/krsturqhnLOe4
         d6RTI7lmTeYWwZ4zaSQ48Iyooxwa0d923vA2sT3cFV5MTsGZy7a0uzHEZPrnZcjL1Sen
         kFIzNAZRE2TjP5+1GvhTVOzDYfZLj53SK47icbFcXoBWSubvEQtuxpdgmVaj9brGh359
         gjohEZm4IuW335XstVOMLInEYAFMoMNqIa5G3UthzZJrg6VF5161LS9cbiZ/nMbj+qz2
         X5f/pD4/RoNZXx+2vzJnIJwMe+gAuvXUbrfLE6GjEWEyc4G4jb0FOl7ewSwGZLSFkWGc
         kVAQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDIg3I49AuvY/MBgo6QO++QY/3YTWMF9CaxWpIbUVAWqPM0HUlk6HNkOESPjZHxTHF375xaVwe8TSvYQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kpg8onDkuoj9q0HowPlG7rMxQ9QJb8FzqPjNJQvGDHGXhD51Uh
	54rs5wAD1RM+YQJimoHf20f9q0kNNu5DtwH7XB4Cl1vy8eA4W/KNf/9o
X-Gm-Gg: AYBFou3tyjTliXlSNZ7PedXEgeaL0dcn7lr1dlM1EyslnEVItsmS3v7reawFPO6ULjt
	r+hp3lwPDqaTQstq9TfjquxnZSva4v5urOnJOatqgUZKI63xmx6fG2jPs12w24NU70kYiykmSPu
	frLZyrFHzVPFJH7VLs/v4uVjVaml3dpm8i+KkVbDwpre6sirQ6lcgHCKpLmDbfeQp9ETkUV0BLT
	cHScuKV81tfa9h5SWvx9LMo12HZFqe8T9mLuPVPjhcT9UF1sfrFDwTuBP2KbZADWjdWZJqFt2KV
	XPtxFEuvaUtZJpQBkce7swQ06quODd9rocosrmcbPtKT/Jp69aHAcoQt3k0pMKpk9dKLnRXaQBo
	PVlTzzIjen4WJsxCpYKdIM6hTr7Y/2gcdB67X5BZgwFXIj9srg1wF1VAwLKFw+h2frLUAa352m9
	XVaTUSiIr3oi3gFjPZWeZcm6olai1k52HSEQTw1yiBSGe0anI9XqDBWQc6M/WWND2+HkQ/+QCWd
	JKzBG5+GwtX7H50vCJMxBai0x7PJ5rq1r4w3ldaeHSEfwJWCf7IDbnMjCgoirvdRoAtvX0BDDND
	1Zzwebhx/1REqVuV02TWuOSCg/7sGNWjDkchL70VOe1uApmOvQvfer7GzKA4dpGTLK4/K0bV8eL
	S8g==
X-Received: by 2002:a05:600c:3ba3:b0:49d:e79:612f with SMTP id 5b1f17b1804b1-49d0e79635amr237510065e9.26.1789003972418;
        Wed, 09 Sep 2026 18:32:52 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b090-6201-5565-e933-e630-1831.310.pool.telefonica.de. [2a02:3100:b090:6201:5565:e933:e630:1831])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26d4e3f3sm35852735e9.15.2026.09.09.18.32.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 18:32:52 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Steve Wahl <steve.wahl@hpe.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Mike Travis <mike.travis@hpe.com>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Tony Lindgren <tony@atomide.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-omap@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Michael Schmitz <schmitzmic@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 1/8] docs: kernel-parameters: Drop the atarimouse= entry
Date: Thu, 10 Sep 2026 03:32:38 +0200
Message-Id: <20260910013245.8619-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260910013245.8619-1-kmehltretter@gmail.com>
References: <20260910013245.8619-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nothing in the tree parses atarimouse=. drivers/input/mouse/atarimouse.c
only takes a module parameter, and git log -S finds no __setup() for the
boot parameter anywhere in the git history, so the entry has been stale
since before it.

Drop the entry.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4bdd2..c8d96de4c00d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -591,8 +591,6 @@ Kernel parameters
 
 	ataflop=	[HW,M68k]
 
-	atarimouse=	[HW,MOUSE] Atari Mouse
-
 	atkbd.extra=	[HW] Enable extra LEDs and keys on IBM RapidAccess,
 			EzKey and similar keyboards
 
-- 
2.53.0
