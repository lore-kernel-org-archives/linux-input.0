Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8967D3D4119
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 22:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784153934; cv=none; b=J7wtzQzeMA2NrczmeR/v8QEhzjoAhW5zRDHN3n1kvOGKhezj6gRRP14yhWnL5XM0KwaAfR47jVEd6mCmDY30hA7QO8TKfYEwWpCiXCFi5R8eXWsKUWcDtRQJM96+RVPhtn48FPua5jrUmf3lpKmZUmM0Bb25I5Gtr+8n2jXqrJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784153934; c=relaxed/simple;
	bh=NziCqKrc157hSlJYPaNb++ltMAq1KP2pbThHesNWW4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pq/Y+Z2MlMkBji8oEcmfpe8Um6neubd4Bb6e/kEwguNw3m7jypOJ8JmY5vOCxY8SAD5ZZ1Nk/ZiZZmdWV+Z306C4OGgLSIrPcszjJQWDVx8+2BeaeoDWXUn8m+00TwoNDIG7DqUfJXZUud0dLUjvZ84Wt0OBan2PKfc8DTz9wpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azC1PNwh; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azC1PNwh"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-902e4af2d9dso8702956d6.0
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 15:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784153932; x=1784758732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NziCqKrc157hSlJYPaNb++ltMAq1KP2pbThHesNWW4I=;
        b=azC1PNwh580xK0CoWnj5pTdbVGKqfhPkrp9qfjlxBmT4mCJ+1Gf3t68HGnUHUW4a1s
         C3mNIdUBobLuZ5FVx+F7IpZDVPCZHwIAC3OOEYu16PRY3LDsWRu3MCjo+P9ecA3GH8xn
         jgdkexLBGzkzThGBrd68EVao/Mq9IfmTsjCcNeQeLz/+vqE81/UaKmoHljkky9pcCsL9
         RTtwSHok7hIUBcrcv/9NbG92MyBHgzW0xgNf1e7zjG7ZJi8Tr1P+jvywhpBu1Zqp2Oqs
         OwdBqk7/aPpysYjhrCI1JN9tkms6Gt8zWiwBcE405+bbmaU/hTX/hN5UGtzuSVSLEjxb
         mSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784153932; x=1784758732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NziCqKrc157hSlJYPaNb++ltMAq1KP2pbThHesNWW4I=;
        b=VftKU/sKwNtfhhCeOkdj/T5SYqywtAXKn/+5+7nmfG0zQed+VHhU/fWkicDfdcwlbU
         iXkQ3iU+lK86Rh6IF0wugWbkZS8sb2VqhYeX2ipc4Oc2mtM1P+wetKqmyl0hA1AT1MM/
         +YvIS5vpIYvW3HSNjZ31AlXmkThN1hxr3kEHXloFTNWEpxBxxGZFDLMoLhkZVPgTSr2m
         iXH4qXPrxZNoZyc3OpYvmhgGocOWcKhO39Y+X3lMT2wCg2/DocdmJVh402k3eTV3zrQo
         o3kOA6MHRc5xCv0dtRubk6SJOybLR9a7VNhwWR99G13FuEU4ij+qg+wHpYlisqAh3yTX
         3RDg==
X-Forwarded-Encrypted: i=1; AHgh+RqdepeqZCsQJzx70rYTPjZJtADGU1g2CaHTu4n1srD0nMZLbO/PwZzFg/WEVTGx++22+wmkXPLlemS+hw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBnjiin8H60FIOrsdDqI8RIdQafuDLucKbd6fcW1+ZdsvCK5Vt
	k0bNEBkKK3mouC2ZC+E6gW/WYnINzTB1QP6LUO57/vqlYpgzeNdxjPBi6HX+DyaKligazg==
X-Gm-Gg: AfdE7cmbgORtYjic8WgbJHS2NVRipm70A+oneeGQwidlJlFKeS6nWGaMTL+NULQ9BmP
	4jBhn0vEg7YLjJXua7XLHnHAEK4DDNyA+28zzAbKWlyXmDCjLFlqTCFsFNp6vksdUuOiOx69znH
	Wki+W4r1UboygQyXsZCzVir+aOYzx484w6o24uyXud56S7V5ksrqfR0WFLXFPKY4HrX6bdeAEU7
	+lf1H/t1MK0Y4c/bhLV2C2MjrFj+h6Y1pa7mgADoclxvhg9seVu2ljjk2yxYnNw7sCKC1u5/Ic8
	eoc/fdTMGko9eIGsRUIxORh+V1WcCCIab3PllIexGKh6g3eFp5peLvEeHs1HHfgHbgME1g4ets7
	iY5MNAZ5PYCfHDnPnSMxqbXBcYB8J3keSu5J/TwtaR8d7QIsmWU2NKFAwHT6WV5vjMT+2BuNZ67
	BVE6YsxhKrJMB2H0GFuRAl5PU=
X-Received: by 2002:a05:6214:226a:b0:8f0:744d:f992 with SMTP id 6a1803df08f44-9076546db96mr15781396d6.24.1784153932377;
        Wed, 15 Jul 2026 15:18:52 -0700 (PDT)
Received: from FairplayBox ([2601:5cf:837e:d920::f9a2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd57baf8dsm206731786d6.20.2026.07.15.15.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:18:52 -0700 (PDT)
From: Alec Hall <signshop.alec@gmail.com>
To: =?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>,
	linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org,
	Alec Hall <signshop.alec@gmail.com>
Subject: Re: [PATCH 3/3] HID: magicmouse: report charge status over Bluetooth
Date: Wed, 15 Jul 2026 18:18:49 -0400
Message-ID: <20260715221849.148886-1-signshop.alec@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715200354.1307250-1-pepemontfort@gmail.com>
References: <20260715200354.1307250-1-pepemontfort@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jose,

Great -- doing it in magicmouse_probe() is the better fix. Moving the
"input not registered" check ahead of the early return rejects the bad
device up front and covers both ->raw_event and ->event, which is cleaner
than a guard in the hot path. No need for me to take it; please keep it.

I'll review both patches and give them a run on my hardware (Magic Keyboard
2021 and Magic Trackpad 2 over Bluetooth) to confirm the normal
enumeration and battery path is unaffected, and follow up with
Reviewed-by/Tested-by on the respective threads.

Agreed on the rebase too -- if yours land first I'll just relocate the 3/3
report-check hunk into the new wrapper.

Thanks for taking both of these,
Alec
