Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E036A2F290A
	for <linux-input@vger.kernel.org>; Thu,  9 Apr 2026 05:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775711590; cv=none; b=Cqn9V/hyOlAyL6N1dMasiWvTevMaOJ5zuaDrtW4o6BK2uZYsDWHn0cwY3J4fJ03n47hcKbj7Jr++7VrZu1vB2rC5NlMojl4lgmC3fEwM8fl7IOluolW8r477XHo8gdJMAEsSP00VntvryOfGcywh+GFxEvq7uVQy5nxFCC+xjpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775711590; c=relaxed/simple;
	bh=mo7H/Ue2aNd43LV7YrdyqQaEJa53CcqxsYs8acg+2fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxgbY1S6tuwl0sPOK+4K29L1qnwJixdCZqPKdEyuh91CDZcv/UX38imZKNYJ8Pd/daNQN6JXX9/Me2B7o3Rb64juntCTLQFXpgxRYRKMF2CjOptfysAUsVmUTeo2swimVqIhodOR3qBPpirUGp1XPFnmYFawwrdvb3BgbCXiqjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNVWdl5E; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNVWdl5E"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so484071a91.1
        for <linux-input@vger.kernel.org>; Wed, 08 Apr 2026 22:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775711588; x=1776316388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mo7H/Ue2aNd43LV7YrdyqQaEJa53CcqxsYs8acg+2fI=;
        b=GNVWdl5EJh6TdWFWIMkES052i07nza2KqxkqimekFbYJVSIH+wAYzoXmLMleTGKExD
         FdZe0lMwx6K9ANeyFf7D6PpZgovJbm/RFye04Kz8yjR3Xq6B/c1kvs2WOhLNqVcp81yr
         YqV5TtR8yp1Tb1x5ELyPLdvumUN9b2nM9lnd/avNWfGLh4IvHsi5Q9Kv7y3r8vkW6nvJ
         Ga2h9LIdQPze2+S6INPM7axAdyq1t71PZ9TpaTInyYKd8nHbKn9qPzqsc5Tu/uBsuVn0
         6ujaCWWvuv5gSTp0/BNC2kbDzY8zHrH/d2EhgbS7IFMq0saQVOxj8OLy4zHcLwharoR5
         bieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775711588; x=1776316388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mo7H/Ue2aNd43LV7YrdyqQaEJa53CcqxsYs8acg+2fI=;
        b=TbL+MQVceo/e8o9MpJttmuLcJ7U0wCd6BK8huNBLYbaneJkuL1ExEuxlHWO1R49sEX
         ozqiVVBfaGqzBhKblXJaJGjarfXCWu2ivXjPWphWTJwAl0E6bkytZBnFCi6eSDcVHQka
         ukxgYLIVnEBqnEU9cJimGBYIqhs55EysAtTQd5LZBaGfWfNouNWOM7y3ruCFVkwdFnN+
         1l9FCnRhP0DbPhnHNd6LmOW0RBTpQljfd80Rl/vXTuKG4Jg1dssC19uZmBV/+fMq9Kl3
         doqtG3JJbw0GphMb1f+IvY/iTJgtVA+LzTsDnszOpbAVjYySOd7sLTCY4RvXZ/ly1LMu
         dZwA==
X-Forwarded-Encrypted: i=1; AJvYcCWYflRlEHMxCGWeuXsUcHsp/vheThmfiAcWaX+ILGZ5MutJzRaSx71YD/PKS1ouhSM8QvI+YRRBtU+qlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuR2Ylexd/pgpg0E8HsuLf2aQGhRYm/yZbb6D8NeUS+5VrxaBV
	CMCVIT79kLhQfiLyglf2QzBsvMrKUXjipyKiJVDlzYGWoHzZ+LXB00wzkik00IWxeJjO0w==
X-Gm-Gg: AeBDietDDAbsmQsNYJlhtbkjPCOQLxSp3VXuRbo7P0W19YGfVWbxFq9f3G6kXcv33w8
	F62X7/1APKX/t/o4FxMxeimv0c13sZ87aTRN/SIMfSxKL67rRElnE0HaXqHQPtOIZN3o6oUutfz
	aTjThZTVtrdA2p/cQQPeuAE7OBClWJYS2e3cYKayHSt9hXsq5qSFToafkbVIyKm+241APL/6V9Q
	uRoQWvrkPYFEoZuGcmV1Xgc6bN8OxdLEbI0v186zb2x3Xrp01GCZxTYK7DLG0AAF4F9VcMDRCy9
	I0liRSf5I4gtz6ONgc2kTloHg021PrP4ZhaTY8W0Dwbw+J+vJF1UbFQBGezugDelO9Q1SDpkgN1
	pCghB5poVnFo+ml7uozOLACRJ9K026RjNWDqno20j6G0QAok0m/TBeN82MBdDlAFzc/XQMeDLBG
	/HpW2txSHbzsSnQR1rmp7wg0k=
X-Received: by 2002:a17:90b:52c3:b0:35d:a861:36de with SMTP id 98e67ed59e1d1-35de691b394mr24236672a91.24.1775711588082;
        Wed, 08 Apr 2026 22:13:08 -0700 (PDT)
Received: from gmail.com ([2001:ee0:4386:f1a0:2279:18ff:fec7:5f79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e34d0c5ebsm752290a91.2.2026.04.08.22.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 22:13:07 -0700 (PDT)
From: buingoc67@gmail.com
To: jikos@kernel.org
Cc: bentiss@kernel.org,
	buingoc67@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: multitouch: Add support for Dell Pro Rugged 12 Tablet RA02260
Date: Thu,  9 Apr 2026 12:13:00 +0700
Message-ID: <20260409051300.7054-1-buingoc67@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <4op5533p-s086-55sr-oso5-30qsnqpq407n@xreary.bet>
References: <4op5533p-s086-55sr-oso5-30qsnqpq407n@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi, I don't understand why it take my email "buingoc67" instead =0D
of the git user.name that I set as "hmtheboy154". Is there any way =0D
that I can change this ? Or else I'll submit the changes under my =0D
org email (hmtheboy154@blisslabs.org) if that's ok.
