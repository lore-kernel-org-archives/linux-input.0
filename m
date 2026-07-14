Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2300B2848BE
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784049460; cv=none; b=k4rcPYyX87D2XWsjTEJ6EUXEwl6ERLrZhy3QAVKonC58YIxprjD75M0iq9PXHUgpVpkg6fOpNzdv1eQ9VjdL4lxcrh5KozHYfJ00ArSIxr4N/XF+6r7Ij2P7UyrOZzeFzFEHbJvvqqk3RR8+nSkhZ+LWGqpD4qSfSwsuztGyF8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784049460; c=relaxed/simple;
	bh=jMUtk5clwiAw4sDgcRhF6FAj5+TI4SNb8MFpEDMoI88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcKpTmPw4ZJTrugmtr0V0hwthcyCK0yyZgN70HLa9RN9bAfs0qsWA/L8FMI1lwI0kKZ8uadZ7AAacIKpN5mpQYYcQaV/0D29TPsRnHVpk8hqTb02FQoKq6vzJb4wAL8dyYAOgKYejGLjRR/qjOfuV1lQW1jFlqWEJJuoEVIh/W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+zeWs0C; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+zeWs0C"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e55b62640so274701985a.0
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784049458; x=1784654258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KRUkamzsdgUYVeTV99JWTA2+xD3soq3oTaz2B1+gwYg=;
        b=o+zeWs0CWvNm4rjIMXFp991Bg/i5aWfPa6e+VGm570PCDjfL4+JCOgjNFvDlHrVD8A
         zjTrNs6s7Ra93KRgkI5yHSMaNPUZx4oyRDQyhsSNqMoJJYYl09gPfcuwT5ZAp+8zlHJK
         s4bZE9lmCP8D0f81JnFAjDaIjwtkV/1DNxEL6NIijWoJtK9WsOa1aPzY/UhhW+vzgd7R
         IjfAGc1q1vzsPSTTHEFOJOX72l+aMk1CEqlfMnXMXi2+/xYz0Q4XfLiFgbJDcLc2vAFl
         JHKfuNSw0BlpIuumdFgi72x4wRlDhFBrfzhiog77a3Na2eJHkVtQnQO3+8Pg7fQp7hL5
         5/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784049458; x=1784654258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KRUkamzsdgUYVeTV99JWTA2+xD3soq3oTaz2B1+gwYg=;
        b=qMmmM9mo38lO974s3r1FBxm0GwpvefcVN3Kz2XRxBqfWF1+J+KZtceeHL6GibNedj1
         2/bE1ptvou22jWZkg+3eV78+1FrFBYIX0fA6lfECQrsJ2AFRtbO36v61i1tLShLjEs46
         pHy/GRIdmV4wHDidt3KV65XUDtF2yLviyfjydSmxPp3saNtvLnSvNCG33zdBGJmi0RBD
         hfmOAwVSUou1wLe2BhRauMsaPVEdqmNjF7JCe8bNB1+rifsdLJBurYCRPerDpIfLCeGe
         AyWA3KQkaMHdxeZdb8WGH4gRqInaq5WARTuljgSZCntsXFmVWE9reHY1mdeVs1btvtpg
         sJIg==
X-Gm-Message-State: AOJu0Yya8nuCslTgluZGxtafLNwwKKzY2XXDeWAmwidF5Hk6zZ3HYS0g
	Uqw14CPWJh7bI7UNWaogAI/GLY2GHwbgc3dHUF/jVXl9kYoX45C048cOSkndQhhqduZZAQ==
X-Gm-Gg: AfdE7clO9xonmjvpVagGfnUSWj+jJbruwunmUXsAxQVQ7ZoKUvHj9NUgQYAhCeROpol
	33HtZ/4uMsFBEPiOSsWpVReQ+Ij5HuCyKflhTPwIk+h+eTAEUY0jYwgIku62YAB3Zpb2mztvY4S
	vF/ovsEJqiRX5idvwO9xxGdI8CEaA7HxXLimHd64LVpfhM9vim0qFlDhCZfftQzfv5g6/zWRxIF
	WHxRpAoAapj5TQfKnn/4ocldC4SX/mLVMUvbk+MKRU6HByo1oPvHvzBEz0Hl3qyVV+JBworiyiG
	LjvTEQUFfvPVlb+vclOrAQQKb6tJ+0nqyBBaGSQ2bPoDv9omtlXxq9oJbtRDJbE3X4/Ep2k5+lS
	5S6AasnZZ7J1e6PDr2ZFXhAwP9nhX238g9PdWRDlzc0AGpoXF+c8OOGie261VUgRfUKu/j/vqV0
	c4uOWeK4nXGT68ET1HmaWlfRYUODh1zTgw/g==
X-Received: by 2002:a05:620a:25cc:b0:915:a953:4b9c with SMTP id af79cd13be357-92ef2b11c6emr1354758385a.3.1784049457771;
        Tue, 14 Jul 2026 10:17:37 -0700 (PDT)
Received: from FairplayBox ([2601:5cf:837e:d920::f9a2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d34f76sm1547107285a.35.2026.07.14.10.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 10:17:37 -0700 (PDT)
From: Alec Hall <signshop.alec@gmail.com>
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Alec Hall <signshop.alec@gmail.com>
Subject: Re: [PATCH 3/3] HID: magicmouse: report charge status over Bluetooth
Date: Tue, 14 Jul 2026 13:17:33 -0400
Message-ID: <20260714171733.413339-1-signshop.alec@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714102540.3EB2E1F000E9@smtp.kernel.org>
References: <20260714102540.3EB2E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Sashiko AI review found 2 potential issue(s) to consider:
> - [High] NULL dereference of `msc->input` in magicmouse_raw_event /
>   magicmouse_emit_touch
> - [High] Unbounded recursion via nested DOUBLE_REPORT_ID (0xf7) reports

Thanks for the review. Both are pre-existing and are neither introduced nor
worsened by this series, but they're real and I'm happy to fix them.

> can this function trigger a kernel panic due to a NULL pointer dereference
> on msc->input?

This series does not add any new use of msc->input. The battery report path
added in patch 3 returns through the switch "default" case (report 0x90 is
not a touch report), i.e. before the input->id.product access at the end of
magicmouse_raw_event(), and magicmouse_report_charge_status() only calls
hid_get_battery() -- it never touches msc->input.

That said, the pre-existing exposure you describe (a device that takes the
early return in magicmouse_probe() and then sends a touch-shaped report) is
real, and an early "if (!msc->input) return 0;" at the top of
magicmouse_raw_event() is a sensible guard.

> does this function have a potential stack overflow via unbounded recursion?

Also untouched by this series, but yes, the self-recursion on DOUBLE_REPORT_ID
is unbounded on malicious input and worth bounding (reworking it into a loop,
or capping the nesting depth).

Since both are independent of the battery feature, I'd prefer to send them as
a separate hardening series rather than fold them into this one. Dmitry, would
you like me to post that now, or do you consider these out of scope here? I'm
also happy to add just the msc->input guard to this series if you'd rather see
it alongside patch 3, since that patch touches magicmouse_raw_event().

Thanks,
Alec Hall
