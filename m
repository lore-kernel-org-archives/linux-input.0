Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7C63947B8
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654341; cv=none; b=lJRm42aW6GhU8hLR0bcduekx68SpTmDV2RVikVZ55vpyayxJzGa5wH7C935HtQd2pwXmQEzsoYhGAE82HnivNp3MAvTc8iSGDDH90WoNfIueljJXLrUklmC3YfR8z54kfabfhKfrTpB0ih0QWLjT+6If8ulsohvmSIG36jj4ZTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654341; c=relaxed/simple;
	bh=ISVfKl+9f4eR/32rkiBd6wjP58kml5FEuffdft25DGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEEZlehRk9MnXyDVVpoLvnfGs8F8ntXYB7ELS45imPN3fd2xDM2eEu0GgRdI6zaFi2TKyBxRw8gRXdXwNo81weunrNPc06La7BefANJliMo2pup7YwAhd2SjzHVZ5cOobS+F/bvDtYT6V52WEPj5KI5x3KVpvX/aicCkD5xn1ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJWfqkOp; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJWfqkOp"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c998fd549a8so3573693a12.2
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 03:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787654340; x=1788259140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zOxGyS7OvO/OsJZNuAy0e1GStWon9PN34Vh5qY3d7Ec=;
        b=UJWfqkOpheKnj0bajVPeMPBrIEknVU9CSwwXO5TuOwyVKtBM0qqNl3fJMsr+2FRLce
         6xXQmFBodXtgj5GUmTyjJZ7Y8bz6LjfKtWPjUlCrkeYi1wrN7XVsyr6SL5MKiOTB0z0H
         bHk98tHa+1w0cKM5Ocof6PUx97ne0kwMDrtwt0HShCCMT/Vabdr8PaImU4+4FnGKa0vw
         kQ24hqQSTPyMdS3BZCjCXeV4S4l0VYCqru92QxzhiTfJwtxBVXHZteB8cGt+d05Q/Nsk
         7JlWvCmRphP0ZJQ7TOBfHipnsIi2k9kHD7NxaU3Hx1pFrChmTJKW/iKKJIlXLXM1nkGc
         wKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654340; x=1788259140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zOxGyS7OvO/OsJZNuAy0e1GStWon9PN34Vh5qY3d7Ec=;
        b=eKrRxXs1Je6MXS1qzveEGVckGwkPbFeYpk1egPYrBU8vv9u8RKPFOnitYfHSA1PCbA
         4GWUa3EQidik4vJkxMRaXis51uT02KKXCofhPdCLbOMRfpppd1nKfi85Z0XNP6HTNALW
         JyvAw1yUgc1vUTDKwRYmPP2g0yoxT/qsw2hbZ3AcZ1Lc3gbVS/wKdMY47U7S2fUXgrtN
         liE/KOfqwsmN3hmhEH1M7iULGVvywqGRwR3rJSear0+rR9K9OuedB34cGf7eii240gHG
         fNyecnkPtkqQv8uTJExnxNt/+geh7sef8QLIZPreZVbJvQVF/dAFKgdN7KHRxlncwEMD
         Azyw==
X-Forwarded-Encrypted: i=1; AHgh+RpLBcWRoJDLvloySUl58c3C78K7Zf2+OCi2FztxlV1IU0k5hniNN9+Fks044pZlpBGW3spMDFWUBILDLw==@vger.kernel.org
X-Gm-Message-State: AFuF++mWsHi/s7PoDJflnBvV3EJmIsmJZ8UQhMujwc3u7ZWKkveunYvn
	Lz/X7uamPrSJWXaq3Bl7NFbYSvA+uFcwjoxOiYXhgvEF22xqePpywPST
X-Gm-Gg: AR+sD11WytIwENaTn2DwgvgUT6z4PY6gk3aMvng11AuiCZc5Au1kHPrviMtLqsIoFML
	n+YGOhAwclnIpxcB1/mqvDsJEELfvLqnh+wIiVdjnCun/m5sLxpDsUYDmVs81n05bqiInd4qun9
	KebtLZkttsx9P5WI6fcgnHJvtzspQ7PRFxMsG+IQKpNmDR7WsGpnkxgo9SawZODTXh2LuKEv65z
	fm/6c2kbmyrPU/5KyYimhNX2ph5fXm0uw7fYS0FWpMK+jJd0MZINfTtie7M7DvPb7QEnJmDWKu/
	2hZ0iGX2XdR56dAdGC7hC3+Jz9COEMJ2z2MYZwvxsXNR0HLuvQYpwTmzQWyYiGB3VrB/6P+tcAT
	MT29iwlcwTKGocFk3Yx/Kt18kO/0VFaI+2hnIs0qsk9InVznJoktGlSdnXoq1Q1Hc93F9sE9xo9
	+I+otr0/+TWv3ZFWN0ykVDLve40cRh99CoozSL6MIxUlRn6NhYiyRgdWxOqGAi9Xxp4OU0hJp1H
	4POGdeDBUBX+SnO067an2W4yATLsQWpy6k22s9Jtn8T7HHVebkONjkG4hPiqGVcTMaQV01nXRoS
	fSDHoJfE8DC3Ax5ct4t7Qv+c
X-Received: by 2002:a17:90b:2243:b0:396:6344:3b62 with SMTP id 98e67ed59e1d1-39663446107mr967320a91.12.1787654339704;
        Tue, 25 Aug 2026 03:38:59 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860c6e6dsm30917319c88.1.2026.08.25.03.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:38:59 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: 98lawweijie@gmail.com,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: aduggan@synaptics.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - remove the F34 sysfs group when probe fails
Date: Tue, 25 Aug 2026 18:38:54 +0800
Message-ID: <20260825103854.14189-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824122751.76415-1-98lawweijie@gmail.com>
References: <20260824122751.76415-1-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Jie Law <98lawweijie@gmail.com>

Superseded by v2:
https://lore.kernel.org/linux-input/20260825103134.12278-1-98lawweijie@gmail.com/

Please use that one instead.  The only difference is the Assisted-by
tags that Documentation/process/coding-assistants.rst asks for -- AI
tools were used in finding and fixing this bug and I should have
acknowledged that in the original posting.  The diff is unchanged.

Please mark this one superseded.

Thanks, and sorry for the noise,
Wei Jie
