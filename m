Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466264;
	b=Bq+oFeprkPM9fea1jO5O5sBlKefeUh3IbHcMYjMTYEnL8rel69rBh7egkbzvNS1FF5ES
	 5DopfQsoJGaOLF5gZEFObMwzFPtKHkH6NFgIofdEGjuiiX4/nZxSh7uROAKXlOHA3EKVP
	 UXwjdbh1qJB5kgWNkG1c9Eto5nwnl4NGfmIepCxyUj4CRSKD1QB9CIAnjBEtYfxxYAS0y
	 B0j4SVDgNe/8ugzDkGqz4b2lkn2NqBhzEDkLExI+LGS14YCxfNEyoHd1tUyfLwq1mLg04
	 9gLCFzX0nvT9EvlfCE5gWI3cyLrv8Q6Ko90EBtwqO0DPeYJWBso0Je8cFXmpxQGErZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466264;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o7FuU2kplsxoIIrv2lRaqW8tQ/83lB7XG52hnt4k8OA=;
	b=QSaQpgEDVOqz1s7h1+0QeQWktLNRslVZQO/l1hOT0yDn1ezbh+9n6/WVZsfdHp3PadBh
	 NBmlE7Ra3BecdP68Sx+ZSZvg2tHUsh3AI1VHG4SBPfK+EC+I97HplrXmEaEhFbQRJiDQv
	 oP7D2qwIN2ndGhIVKa7tOjpKs7jBLWRhvYfuKXX3tLXsTnLPRIPJ1UaAiUVmdcIF7eHKg
	 dqT1y9c4Rpp9XrSdAXFk/IEk9ZiXjkKDd9YwRlnvcoYE4FpuQ3HQsjuMW/0QIslsKinSC
	 PDRIyzhZoUhgyvpOX0KRU2vklmZhojGA73LgQHTszbFIAZmY7KA6nnL8o5EnnMetR5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="J7/v84aM";
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1797606A88A
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 06:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1797606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J7/v84aM
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36dbde64409so7859257eec.0
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 22:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466263; x=1795071063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o7FuU2kplsxoIIrv2lRaqW8tQ/83lB7XG52hnt4k8OA=;
        b=J7/v84aM4LAIRiQJCL+hVmWW1vPtK51m1N++Rb8wSEBzgbbwrl11S7D6e6pPHSqKs0
         iQ9bcoS9qOrf52PkTUbdaiPlyHay4TJiCrCT9wOHPaxWgWYuhi3ITMxXwRDfl723hYyp
         91Dvsjal8PJGKBd+JYCNEoSMQy829nNsRIJYePvWNMMIAzOilfEqfStA4MCIUs5706p+
         5+isCDY2fqeQk0uNA0GYJ4KiKK7FsJfr8V6UoTq/VC6NEd/y27C9Bdc5GjJd/JzVtqV8
         qKPFUtOmz1Ap/70uTeS8K818YxaBH74iP2wPgIpXzngsTmkb949k1Orbo7wgvVCLiNpc
         qyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466263; x=1795071063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o7FuU2kplsxoIIrv2lRaqW8tQ/83lB7XG52hnt4k8OA=;
        b=ZPiAxjuh2cnJHYImK3z7hXlfhgGNLFxQeHZiRDBZ4CTZSmspYYi2BUPFOsdpo4CEeE
         msrzzhumHNjUgmF7JRS70yJacT4jSYd5uEws+qqUxPNKU/tQ1WSHiBqRvbQ9ETi3a+Wb
         e/ulA7N1jW6/pfk+VDnRMjG4NhixUp/ez1nqfz/nU3VxtB0IHjcslt+vGa5DbH8lZach
         981sAdayxK3YPpJm8opaw8DqLOWmaCwbMs9Qt8s/WNslB17hWOciw4PzkLYXvUEnsUBF
         eUPayHnjzdsOjtUZTXviYj8LMTO/CaInHsF0qucZI7aguLmqst5/Gl8XK3HCNx/HS1nU
         PB/w==
X-Forwarded-Encrypted: i=1; AL+hErEecZ6715oXEy60gP6dp09aI1InoKEBDFFGutULCCs2fNl0CJWAc2r83fdxk0CrwK4GgAR0HJJ+rGgz2Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z/IabqoMtrbRWtd1ALUx55PsDKCSaZoqQ6h7UdTAa2l8kvNwJfa
	oMXIOm+V4YioFuRE4pXbtJdBrMAiwIr7YLDqxcGFOutee+V21Zl1gVMr
X-Gm-Gg: AYBFou0lkITJTipabQt3N4PCI69RyXRSZBs08QHlhbbQ8ZMIrHbz5EjXAUgjKbojFGv
	Bfp9kLDD+INiPalm3/huf/KHASn5M0ZfJJTpC/2SS3BfPctakNT+wnxzR4gBh9ag1g2zwUYYKsh
	7rqJseXhiDNMHwGUi9mFc5e4J5B7tG+zct0L+WDBeR51bSbtAg49B9hik3jWqbQ6owsKuCCuXgQ
	G3XCX1a1k62BTsykmpuO3X2ln2oOaxquCCmtHuYDJ5riEax+9SpI4sx//+JlnsVXxCTbBsy2rZv
	4iY7lcXV9y0UbJCDbLJs9fvOTjBKB0KH76M4hw39t/ohO3XiNjZPQ3kotbDpbe8QfbIPgzelTjq
	xK4XLNh10QWr451+YGcfG6CXsS03biYiUjJZQghEJBnuod0QJTORBCqLF3LYweSU7CspdvV12Mi
	WcF6aqiURySAB6NP8CO6aGpyxSo8h2pLKZc2DlIjv4ZBK89a7yv51jrpepkRABPY6wVFD13udq9
	VQmqNNfu5AXmwDMu0nuVww79HjiFEnOxxzrRgRO0IKNS10FRTW8pBlXTT6YS4YY6kPtJB4v3i38
	0Y3h0PqLms4O/Y4HZ26Si1q6WobaCxOC/Ye3SqnYGvMGRfwhQYRIMD1IJp6ZxgEDrpkF56DsS/T
	8vmC4IoIJGjdbTgMt
X-Received: by 2002:a05:693c:87c4:10b0:36f:9d8:4a33 with SMTP id 5a478bee46e88-376867551b7mr5264981eec.31.1794466262717;
        Wed, 11 Nov 2026 22:51:02 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751fe306casm20788624eec.9.2026.11.11.22.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:51:02 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kim Kyuwon <q1.kim@samsung.com>,
	Evgeniy Dushistov <dushistov@mail.ru>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Input: max7359_keypad - drop platform data support and style fixes
Date: Wed, 11 Nov 2026 22:50:56 -0800
Message-ID: <20261112065059.1802480-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This short series drops unused platform data support from the
max7359_keypad driver so it relies exclusively on device properties via
matrix_keypad_build_keymap(), and cleans up register bit definitions and
argument alignment.

Thanks.

Dmitry Torokhov (2):
  Input: max7359_keypad - drop platform data support
  Input: max7359_keypad - fix coding style issues

 drivers/input/keyboard/max7359_keypad.c | 27 ++++++++++++-------------
 1 file changed, 13 insertions(+), 14 deletions(-)

-- 
2.56.0.567.gdb80ae8cd5-goog

