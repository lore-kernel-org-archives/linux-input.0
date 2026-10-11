Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C0F15A85A
	for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 02:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791686419; cv=none; b=FUYs18OJS6tC6nfcOOhiZhSY+FCI81q0/NeEFUVlINUP7rMxa3KVJzBrUk/DglO5UhyXGXN0HbSmZkejwU3d2TpVC/Dw8ZeyOrVbAy/evgFSi7gcypgAcWGhPrx7oPHNOqYXxiyIiMSoA1H1EcI4hhtoQUdVzXF1r/HfAcsyTXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791686419; c=relaxed/simple;
	bh=8B/m+tFIl5swqc3QaHR1x/I08ZzDzjGvuWY5IwEIUEc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o0NkpPdKQfO3lHZ3ci6vC0wAV1b0YVNDfg6U92620Vz5b19aDYtim0opHE/saafAL+BUIGWY0XxBmgLYBeYx8n4SNlXXSUEd3fFmEwxte03jwtF8HQp3suFw9ZtQZdvkGTChVJfveuuFMAaG4DfrmDHPpeF4G7fr3RKQ6XLgMO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtZ5FKsH; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtZ5FKsH"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-351767ef18cso3171828eec.1
        for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 19:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791686417; x=1792291217; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H7waTTw4v9ZrLDClx+ykHB4Hqp85xHGsmRCylsMp8dk=;
        b=GtZ5FKsHwJ3qGktr4GyJSATwjW/wJTw5uQnQmG8I7pkntxMqD+CVKI3jHN0xHGHuXQ
         TQyPOB+W8ww4O5ndyXQjoH1cUJM7EPt3vNzrTt7i+pDnfbng+f8rTwqA2S7isdsRkumX
         ypbyYsvbaJOw9FYd8zJchuWeCfmWUHQUCuRRT7gT1b6bf7/udPVWo+dpFjWjmWr0sFao
         yl0uKXeM6teOkcCoh/OnYEi/evbuNA51qQwN+Pt1298Fdu7yIa3slVgOGp3Yu6vy8pzd
         AegUlE1wk4P3NY74KG+e7a3fWyaXU45BbWiln/fp8J2jEIb/QkgDWhnQaK7jPbZeb7VL
         WgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791686417; x=1792291217;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H7waTTw4v9ZrLDClx+ykHB4Hqp85xHGsmRCylsMp8dk=;
        b=f5v+2FjGv8Q99YdthA6Q+Xx/P7czArFhHwqCVAqf9kSlK65eoqrCuq7U9G7ZaXMCLR
         rL8aaXXO+ucyq7bPmu1ByxGXRL5iiBOPPCslv1z3e/BwzZwRDVpYDXTG8UuzXZQNvLxI
         tUVF5jSLwZHtCfr9ymaLnIZeNAEdKuo3VYWJxiD4sklv4FREFoMC1cN/GA4biIXSBItI
         /zrhSDFZ9hTzyPPVYv66MJzD6byq7CDvpc4eQ7fI2KyBWk6dRsMmOacUZ1MqK8gtS0ea
         NUYr7yhZZthGtVW4uhclf50eJfb3yV2xL+5q6QwCbOxocwJzLmID/h2wKW+aveK8km5i
         zYfA==
X-Forwarded-Encrypted: i=1; AKwUvBzuh/ScmUZhC0tnMx0+hmLlQNaA7U3tjNkYu5X+qvA6kAkfU8I0PeXvmf4fCHJ8I74qTfq9KFyL0ivd9A==@vger.kernel.org
X-Gm-Message-State: AFq9FYLmN6M+JdIEM3R9F3lHnB2oajFnFHAtFkDBLDVeN/siJKvhL7Ap
	A8YkeGWyoPMM+K633QjROucVSaUb7otEy8paSfX8l5deKGVkHMHWRFlzPpVkc+jI
X-Gm-Gg: AYBFou30n5c7D4atnBIRxJObe4t9LMuWuSw/ZUSduzbIsjje2fCGhbf/QL7TWgCz+8c
	lL2gLnnZVTxEM+SJyWEMQOIohZ6LMhUnVDN2tKkNhLAviTkfJzN+zOSz+l+P/ppHr3GAg76XT1K
	Q6QZkUcEDgVoDoQ7rMyfIAPj7exNS+g9GJfT/ICoZLDcqLsl02cxz93i9CiKDuHxk4oW1Gy9tWq
	S0gsJGjX9h8xkzhC2y7i8aTWWx6oHo4JwwkzqqPdShGCZxG27SI8gn/lHYY9CUPW7TDBpN7WmUO
	rWhqQQgapT/TFOOJeRneQ/kxXFRPu0QPNB4rf8QzS74sUabWyhOCzhRgqstCutp0S5ZcrEBERqW
	1OI022np93ZXFI8pSiN7IU8z8chR6yyzSZg8Jl+K47MNaQKG9ICDs1/YnHGVokl8ECjc5l3KzH2
	vGjVkbmgJ951aqubU6riMvywQjTXWTXj8saSa+JH56mn94HiYFhlHB3wCIkSfiLlIjtjlExLBXX
	t46yrMP1pAuILBbsfXq+tnfqL6Ak1j84tQWAkVyuXIVyDZKg5I=
X-Received: by 2002:a05:7300:dd49:b0:358:3426:d601 with SMTP id 5a478bee46e88-3583426df44mr4652937eec.2.1791686416856;
        Sat, 10 Oct 2026 19:40:16 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:99d7:6eb1:9874:c6be])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b53dsm18114132eec.6.2026.10.10.19.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 19:40:16 -0700 (PDT)
Date: Sat, 10 Oct 2026 19:40:13 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v7.3-rc6
Message-ID: <asr3A-2qdU6MSCTZ@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.3-rc6

to receive updates for the input subsystem. You will get:

- A fix for the ati_remote2 sysfs attributes handling, resolving
  type confusion after conversion to dev_groups

- Updates to the xpad joystick driver adding support for the Corsair
  Novablade Pro controller (wired and 2.4 GHz wireless) and a newer
  hardware revision of the 8BitDo Pro 2 Wired Controller for Xbox.

Changelog:
---------

Bihaan Sen (1):
      Input: xpad - add support for 8BitDo Pro 2 Wired Controller for Xbox

Haotian Zhang (1):
      Input: ati_remote2 - fix type confusion in device attribute handlers

Krzysztof Furman (1):
      Input: xpad - add support for Corsair Novablade Pro

Diffstat:
--------

 drivers/input/joystick/xpad.c    |  4 ++++
 drivers/input/misc/ati_remote2.c | 12 ++++--------
 2 files changed, 8 insertions(+), 8 deletions(-)

Thanks.

-- 
Dmitry
