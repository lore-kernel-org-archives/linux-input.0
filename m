Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868C746D2AA
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792153998; cv=none; b=bRV46jaeNGvlFFCGkA8CYc3sGp8B6NC66bdhb297fNBFxYEzZpeLyRgasqHd8kyfZg4t7ZMKQMhYj2qusKg8JoUlvBdBtFVr2Ys+xZbOEP4fCswsLvLePEQuMfZUqpaixExz0YcB7qHFJIyVIsZYgZKgcmjnDImIZs8QMq4IPjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792153998; c=relaxed/simple;
	bh=XWOJ/i1ritxut7H9K0zmW+82TgFIVjw4t5vcoYvkAR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J558bPFwQpnT77Q86FBOWpUe3mwr4hFRtgSroNHl1J9Bnn2kJDg8N8bbcRuu7lPw2I7SA0R/rUkeYoJ2Jl3B6vSWAhcdPPFDpJ0Nko+WEp16o9Vmvs6UaxoI9DS+5QxKTN06rEN9IlWw9DCnmTSxfeoOQDb3fpMHXQAgCzqYPS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSy/hH91; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSy/hH91"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e915887d9dso26870255ad.1
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 05:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792153997; x=1792758797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XWOJ/i1ritxut7H9K0zmW+82TgFIVjw4t5vcoYvkAR8=;
        b=ZSy/hH91lOD8gH7+KU1rvhxFa9B6PiBEpj4CcqRV7mCuw0Z0bmTw7JKRqgngdcM6NW
         1s1LIkD8rccyUkeWjkPxkpTC4KfYpLRKvZp0RsmPc3RbUUc5FxWwuFxvVpOYKtr/AL9q
         sZZq1PK/hBEQm/0BbnGGbCIQNvvh7X+7c8/UeV3SaKsYXFQYG38AHQsoG5rCVDR5CSZh
         zxnIdL3sz2MdF+xnXgOFGGLnJgPkTQsO6a1iFbFWjbQZEz/FsnW16Did0O64TtVxkMtO
         GNmpBAOlS5SEzk0vaLrk3xgfEasWPwGNPxfkZn+T3N6HH5Goj8gUGtd3MIAnpBA6nxi4
         69Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792153997; x=1792758797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XWOJ/i1ritxut7H9K0zmW+82TgFIVjw4t5vcoYvkAR8=;
        b=dA3ZcL4AojOsnB/qnkFfJhY92GV+Bmag9hjSdy5U8F0bXo8epSu23clDyg0anwBAyG
         Rf0vKYtCiCAPMG3EMnueUbIfvcNq6av6lGnBBXrLg4gpwonnBWqTNpGg3YFRwTPuR2P8
         2wFpRwjAaFtuScw18GFMizEPmOZtvSaUVdYjYO71QZ2Lf3KLkgdFXPVBQw6p06hB0MB7
         MBLf6322rUloVJrC2/fuqTTdyh0oKv2tuJue7GUjBNSbMLNKh7BI3fd2IPUFq6yzaDBH
         D1qL2RitYG9UVj9WXIR6kf3k9XJN/xSKgarZyUiMBcmMZ9JWj8FUayNEU+oo6e1/V+Bk
         6V+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxvEfmH3wnene7hkKFDjVq/kywSyfD94sLwtXqVH7Tngxgmo4FiuJWIxUHfDvYNNvI+F7w8Xu4gjXvpqA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKQHktTewVBIWH+doSkjOoWJGJ4k0ubrJEsqYLOXHRnmUKObrsP
	jDcy5pyp/SJ33cfux7hF0hyHz/q/QsQcbRvFhT9H+ORb0XVBg0KHKkQ4
X-Gm-Gg: AYBFou3uY4U+LEk7Kcu3JE+iYqBOWYLrJNViM0AAER0lacuROy53+gqLP035ljd+a5a
	LGZrTiHLcHlI4adXzB+R0LyPts74e9UX0Qpd2eR8ujLP/AAXUEQ9EFsXIOw/m8weZZlM5k07Cvm
	G93AVmlF3ikYq5NMccKtd+K/2nJ3PH2WQ+EAd75I/102mD26PuQy8aVkQZLZqtpO4mOoRJdI318
	GIZNDwmpmXaU0oYtZZcBvWaYdyWtnCDGU7ZBAllMHyzHvp3rdQUfKSY/mbjOYJwknB21Q/XNTNL
	QCt3l51JSNawlSUvT65AAZe0cqd5qHMzTFKWsdh3wMbA5TTnHV3FaJzirdYnDUDxCqEMuFRZTgP
	bFirupBjOueen3Z1ikQa/Eub9qPvLbewMPah12ztFBGsF7CjsWvDat9yaX/HmEMXsm1yesxeHnz
	4mgC9JRhdZ/91kVoMnzptkF+Hj/mhrf/mIdMnQipO5M6s+OOH5AdFFaJD/OxrZs4YCuzBV
X-Received: by 2002:a17:903:476f:b0:2e7:94fb:262 with SMTP id d9443c01a7336-2e842ce2a76mr176597745ad.43.1792153996772;
        Fri, 16 Oct 2026 05:33:16 -0700 (PDT)
Received: from wyb-ms7e59 ([38.55.195.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804d92sm9361255ad.19.2026.10.16.05.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 05:33:16 -0700 (PDT)
From: wyibo6109@gmail.com
To: Rob Herring <robh@kernel.org>
Cc: Yibo Wang <wyibo6109@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: input: add OnePlus pogo-pin keyboard
Date: Fri, 16 Oct 2026 07:32:46 -0500
Message-ID: <20261016123255.1019102-1-wyibo6109@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015201547.GA2868930-robh@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yibo Wang <wyibo6109@gmail.com>

Hi Rob,

thanks for the review.

On 15/10/2026 15:15, Rob Herring wrote:
> Don't need '|'.

Dropped.

> Wrap lines at 80 char.

Rewrapped, everything now stays within 75 columns.

> As this goes under 'serial' nodes:
>
> serial {

Restored.

v5 follows as a reply to the v4 cover letter.

Best regards,
Yibo
