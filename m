Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7503955EB
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654253; cv=none; b=rJlvPDD3YS19YqkNsTJCxzB/WC6zP5X7msbW3CU7IVJmHgW+Gu2oa1sQSpzL31HkHDhwb6BwPyJR4NmYSz5W8bw0Nup83BBv10Ruj2nrAi/tnxIkmWvgBTTjS1bdkCGlq1gdpcEs1anEGBz8QIGsEDugkaNSwgICZPGuSP1BeCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654253; c=relaxed/simple;
	bh=PwCVLPMGiYvP966qlBCxxiOxMIsGutesFDlsKAGQOjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyyikH3MJVBpuwsE5PCkpNu6oAcSHDq8cj3JjGbhr/04R2DeJciPwmsBQkPvAKFUQ0TCgxyIiNJzp3+HUxzstpORxHwaseRTWT+gOh7So6etgr0UMBX5J0sQ8joWTeGhcypKDcz1qUyEfzLgsJ2eHN8oWTfQuAu+NbkSdhMMtGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ER/d44dE; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ER/d44dE"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so3612230a91.0
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 03:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787654251; x=1788259051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dQgF77Mzfzvw01A6ShvT5BIDqsmlEOtbGFu9IoW3TwY=;
        b=ER/d44dENyq4EWVbWCGgHpxoFAy4BqjeGHQd+uZnHruVOAJY5ucVnBFlGZ/dxCwPMG
         YN092ncqWl4uqcVkm0b0zSqABvKpFk71NhdmtpE/M6sCdV0m/L72sLetrjTlmR6r8OTI
         DVMBPuoOoEIvX4lCh5YiDWwz0iSqVYZDhHDut7+gOJR6XZBBBNNaROmA6p9lFr10ejr4
         +sWNcmwPWNwY7qKcLbzvEtAQDBgb20By6+2+Fv3tjypP1izghAY/Wi1wq016NpwdfTqu
         X6MK77YoX1SERW9FeXE7C8CTED3YppQM+FIkU05qXI9BsnC2KPGrKBVyj6HQRfaDb+sE
         Avhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654251; x=1788259051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dQgF77Mzfzvw01A6ShvT5BIDqsmlEOtbGFu9IoW3TwY=;
        b=mZwTe8s3Q/gOPsOCXVnUsnTRUBQa5dC+bpHfbBI2W9/kz8gTulSA8WQjRdKDcVx4E8
         M797VbvH6QEhGpx5iXtBR46w2lWj+YPeWiJQ0oaS+FDQJZ8u7eXX5gVLkoKveMiIZeOt
         +wSRtKbLOMIu2zcibOIz0aCtYi19cgp6OjwcGXk9OeqZGapNQEvpr5TrMMkpv1CFKhly
         oPXF3POqtxLxX1cOF6EYnC3N9GPJAhqQO5UyYwPGxYDzMUgXgBOQCr3HFRZ/CW2/EXfp
         odxhtq/O1fNs2vT1G2AqxDg8WDIX2PP638AqS3SkVvKXnX8ml77JDMfzTFAfTdTt/7B+
         iVuQ==
X-Forwarded-Encrypted: i=1; AHgh+RqxaMKdlsEX4ZBMMb3SxybEhCB+m9OPVD9tlaLihKHNVLwWJwK+793+0bj4gTWw9V6cLt9tUrS2CIf5yQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nDZ36w2g9zs9b3iRMpistO3/Q44Noifj8oENb1sa0wcZlbcYS6
	gf39PvvmkXL4d+ktlb4Y4FTKoG/FjVSAAO+jUhoSyzDGNKaeyycFpPM+
X-Gm-Gg: AR+sD129F3vU2YGwdaJ5xd2xnmRFCgaqtBOpH1GfmCSTw/JAHPdjSYPzfla0qNSluS0
	YlZil9EeM17xlwXzNQ+iI8r1UxD22lt0SMSFG+SwRJmUn330duMmYgFdNWoYEjBxAFknVG3Sc0a
	Be2wjayrdcG4gQEeXOn9XZtyM7BxEcY9U6YfFUHZ5wk9EKGea07ZjbVA+1LPhuZYhXcN6Ns5cQ6
	zDmsepPUJS7bNSkpBC/79RxrO0nUa4F5lExp1XHBquK8ZVe1Dl/J+Jj19Hi8ZGqGhYlKuE3Uzxd
	0H0zuNyj8RKAV6CIiiGkqRNDHRtUuhdDBMoerDZBEXnyorobYGmNREiad4dZLDguMy/wsIqtj4m
	zZwofqzRg8pYJ1djE5metuXpNK4qMHmRXRy9/DL3PHdfOMx3rB8RYow2kl/kj5eRC5Zi/gmQBmh
	P/kO0XxISid69ML0EG6HjlnxZknZ9yH9oocUeSJEZcXVEpILPseKwZC3HUDupdRMREORe1//Lqd
	t/+LVQlyBUGm8uGFTmzaddsi45f6BR2Jwruvh3JvUwiN6++xVogPQy8/Mu4PrHPzy2McVMB978f
	qY3ZPrbhjWsHdCrrCDNTNaLm
X-Received: by 2002:a17:90b:3a08:b0:38f:efed:5448 with SMTP id 98e67ed59e1d1-396463b4454mr11748606a91.8.1787654250829;
        Tue, 25 Aug 2026 03:37:30 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d33dcsm46097533eec.18.2026.08.25.03.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:37:30 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: 98lawweijie@gmail.com,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: aduggan@synaptics.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] HID: rmi: fix OOB access with undersized RMI reports
Date: Tue, 25 Aug 2026 18:37:24 +0800
Message-ID: <20260825103724.13820-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825060954.104890-1-98lawweijie@gmail.com>
References: <20260825060954.104890-1-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Jie Law <98lawweijie@gmail.com>

Superseded by v5:
https://lore.kernel.org/linux-input/20260825103117.12180-1-98lawweijie@gmail.com/

Please use that one instead.  The only difference is the Assisted-by
tags that Documentation/process/coding-assistants.rst asks for -- AI
tools were used in finding and fixing this bug and I should have
acknowledged that in the earlier postings -- plus a trim of the commit
message.  The diff is unchanged from v4.

Please mark this one superseded.

Thanks, and sorry for the noise,
Wei Jie
