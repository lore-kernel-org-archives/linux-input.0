Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAA63BB9F1
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 19:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784143348; cv=none; b=aZDuy/ZRyCELfBDyNMNbO61t5bAI9GrTukYnlLAASTaxzfccHK2ZZKLK8GMX5q+L675AZsGPx5TLPUkHEqQgijd/qFVgMzyKOPgJBHItXW+ZrJKwq0PvL4q3H2g7afPxHZ0ouNmIHxqUWg0asthnh1rmcxwaxEL3oilzs4siSWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784143348; c=relaxed/simple;
	bh=rGn0qdUIWTWMlLVDz1oNCKS8pHSCEH2p4vrSP/9YLjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5CulUqHJwnY9f1enstVnd5orcVjssl751Jw4hqYmJFCeP6Qa9a+bMYcvvxD2ib2EFP/QjdnniSbwiFVVlo1ZCybqn7+L6NTH8U4KD/ltC6ukZwPg307fuoVrDZ6i3LJyzhfWM6IawDcjGk3xzI8a9dcBOnEzd3xH4N/QKGldtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWBm/88s; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWBm/88s"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51bfad59921so49245951cf.0
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 12:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784143342; x=1784748142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rGn0qdUIWTWMlLVDz1oNCKS8pHSCEH2p4vrSP/9YLjM=;
        b=iWBm/88snGoBpFadL3BhAmOc9UZuDWOEtqC9OIIOY7lUXEExJT35ECGtMue6Xva1ws
         HhRq4tYva/XKO+mzyGlFMvdw9BDKbiYjCA5XhRUt1tEjVbejLTKkJ9SsDt/uZbZMu3Pp
         6KlOd2XMnHiWvuZ7hmsTruFRuSrAghXl2XiG82ZpeuNJnj9yEgRPyfZdw6fSVcCuRHij
         VGVnYj3HBSXw+Wdu0ToVZxCnoPUl5pXu5f9vJnLGYNV2C0gmhPgCfY0VhigZcUsKVez3
         jNTvx55EckCP2dpcNWCIDefQ6ijkkavAgIA691ejzNAGs96mLmL4yd71w4PgqjRiEn4p
         cjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784143342; x=1784748142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rGn0qdUIWTWMlLVDz1oNCKS8pHSCEH2p4vrSP/9YLjM=;
        b=p2Itcq4vaIXSbR7/I61bcdmNtb+cu6sHiPddvXfwMpya77HcRty78UexpVUNwEsJV8
         H2b48xwt2Mj36UJdb6ruox/Ni9c4hskg1k9XEjP+hlPp/IIFE5uAaaJ3Jj+J+VO4sgQm
         mBIQdavmUX9f+RY5sMKYyrrkmpGBMZB08uKpv4wqBk4dgKM7lFb9tSsRd/DRWmJxncz2
         YGdPXeIuzGIrv3jzzduiar4i/QPeMjC7U2vE4DiW8ugDk84PTbVAoQNoyQxZpQ9N3GQC
         iD1sUfI2LBTF3F3XvqXJsa17yNaYcLCq3t7JDG8F+P7n8na8VfUhS0QUnJRwPZNaEhE8
         +8RA==
X-Forwarded-Encrypted: i=1; AHgh+Rq8qXX2DS73kPNWhAlRBz1+SocFbXt6uXOg0jdY6xOBmf31GNmiGPU7MLGDwCGcj7Jr+oFikKDgID6HvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWCfEdDE184ExFXOr0s/lonmtrvt0SpjSwVj1SAASQX5HgngNn
	CdOLWmX7wu09DZ5DgfZkLYtBWizIr7kCWTx6uMQ6mTmqIMp2sWxY2MxZrkOHTNSMt9BBKQ==
X-Gm-Gg: AfdE7cmFM7fMvHEQRCzGNarKdfNWjebRaiIrjbwhhCevnsbHV9RmQZp4OMoe0yGP/x8
	OZmZIh7v/p1UYWnHRjhYC5pWwr17ANOa6BeGi3FIF0c3TGnAZm2WzoiVBKWolzWnBKBz1AKesfo
	B7mv13GS+8/vS0uCAe9/1bZXVI3pA2dfWZM7/YqzZdJ6vhxWi2+CJwd1rN3SQDFL346/SZVCQTI
	mrDs3k5SGT8JE8Y8UHOFn6gtK9mrCUOQOszJbna4PTKTc8oQo2XEbV6LT/haF9NyCI/lBSbYbjn
	V686Yxg8wTzdNPSck7Q0JRlmNR4a5E1GcqesrZFq3RgmeKbjAEd0ABTMZnpa13cBBddxd6YiSea
	q1gene96mvhwMCFDZTsBtax2ScjU2UqQHJ+B19G1M9Cw+tIPq7MF0Rj8RhgbipYM3xnOPM53hr1
	qh4IMQhC61sYcEWwh03tKRuv2M/ySHpUehpTyNbPw+2p5ovuzfqCVAmr4=
X-Received: by 2002:a05:622a:2610:b0:51a:8c9c:7f3b with SMTP id d75a77b69052e-51e424b514amr78363341cf.62.1784143342102;
        Wed, 15 Jul 2026 12:22:22 -0700 (PDT)
Received: from FairplayBox ([2601:5cf:837e:d920::f9a2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caae206b6sm141746971cf.14.2026.07.15.12.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 12:22:21 -0700 (PDT)
From: Alec Hall <signshop.alec@gmail.com>
To: =?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>,
	linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org,
	Alec Hall <signshop.alec@gmail.com>
Subject: Re: [PATCH 3/3] HID: magicmouse: report charge status over Bluetooth
Date: Wed, 15 Jul 2026 15:22:17 -0400
Message-ID: <20260715192217.15327-1-signshop.alec@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715062056.616625-1-pepemontfort@gmail.com>
References: <20260715062056.616625-1-pepemontfort@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jose,

Thanks for the heads-up, and for fixing this.

> whichever goes in first the other needs a trivial rebase [...] I'm happy to
> rebase mine on top of your series, or the maintainers can take them in
> either order

Agreed, it's trivial either way. My 3/3 only adds a battery-report check and
its call near the top of magicmouse_raw_event(), so rebasing it onto your
__magicmouse_raw_event()/wrapper split is just moving that hunk. I'm fine with
whatever order is least work for the maintainers -- if yours lands first I'll
respin 3/3 on top.

For what it's worth, your recursion bound is one of two issues an automated
review (Sashiko) raised on my series; the other was a potential NULL
msc->input dereference in the same function (a device that takes the early
return in magicmouse_probe() leaves msc->input NULL, then a raw report
dereferences it). I'm happy to send a small guard for that as a follow-up so
between us both are covered -- and I'll coordinate the context so we don't
collide again.

Thanks,
Alec
