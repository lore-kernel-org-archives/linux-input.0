Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229F13546CF
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783973433; cv=none; b=CKH0r77QpMkma5ktSqvhfBfwfn3b1f64gkvBOrecNY5B3cOG7H8YiwGdKzVSdXwY/n9kk6moZUSg1yO/4A1QUqKCWXNarHNAly2zbR9zdgI2ovQgdoKZ/EcmgEbMqKiuDsdP8DGa4OwAptaaKoyBzTaOtpg3iNbEn4/C4rsGiro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783973433; c=relaxed/simple;
	bh=EC+oJmzx7AWEzOVzq5vrNpoltngufOweP/qW9556Ibs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eopa+0hT1k4pw+xuZnB+vVfLJu70h45k9Mq/+TaKZPRgWqpkcIle0MQ/AoO3u124d8YCo1Sj7vMaMynF9dhoTm7hVanTuGEqUeaACxy3PqlsrHuIwN5ogqhAM29VRtIr/tL+PsGhGB6QActbQu9j/IGSgsakyXKX96L+br0Ji0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S62U50n2; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S62U50n2"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aebd52488cso3824847e87.2
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 13:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783973430; x=1784578230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EC+oJmzx7AWEzOVzq5vrNpoltngufOweP/qW9556Ibs=;
        b=S62U50n2lIBVyYnd1ekWrvrauQgsfUu1c7whrjaFQWyPbjoJFcewHqqoJ6wbPbgmjZ
         js4EnIbORLiefMbGUMrD2eldMzAL4XYSe6CiYo/dbsHU/hg7g5eKekyrX+oOfw9Hdp1m
         Z2mSOAGhp4T5zJaT0i4/6vFXSWtFGPd4XA84TAhVesFlwCMjKzbVAW2FZG2wfLngYbJm
         qJgDLOwUiehmstm/JR40C6/qKu+sV8mzvWBEwKzOt8vbWKSagQhooMn+PZkdd1zgGi5F
         1fsVsN0iIna3g4NRWOTdOXbRpDFGpEig1r8A4CHJFwtwwOV0Jx9JZKooTXTPjxb4x0qP
         5QKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783973430; x=1784578230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EC+oJmzx7AWEzOVzq5vrNpoltngufOweP/qW9556Ibs=;
        b=OrRZA31Q/yIWv1pUxVUwW+z4LpdEHu0+dLztCzxaVzOrm2PwMz7q9wNJwOeZ4K8F2e
         HNgmuBreynbFvhUvCF3emj3E2sjDPY9upqMW6rBybEhjn4QZB4Voff3GMlWlMliuVkGy
         iY4Y4+x/pwSppvH9Wp30mY9m47ckx5Z1tv0jAKLOu7RttrQpxqo68ascmXXP+1fewnW8
         BWImtRhzdMlvYBPA93UkroA2gfUx/UqEwaJSVcU3wu1gRNnaHtEaf08T0MD8vWSM4QkF
         ruqW4+HbZpILsBG4N3pIGtwlDJNa0f7YTI84m4fx2miv1CQp4VUFISihgxkPs8tv9FAm
         jCcA==
X-Forwarded-Encrypted: i=1; AHgh+RoecYzS0B/9B3vcWbahfGxYosnReD4Rr6Dafqk+U96bkrqYgYNhlxgbZjf1QugeRIQONCYXGO5ZIl6LPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHv9n67gn7PgNRcLBXA8w/Sd1lnetUPdl5N1McxJlBR1sFnjjN
	5VQaamMp1tZDHovr2p9+Ze0EVK5y6nQrAX+a+U2Qf9IwEruv7FG3ExC5
X-Gm-Gg: AfdE7clWDl47bEPJCuUziHWKrBUKoPxsPEl2ZZ69nqs+J38TL4QVLqPB/D8rDzFIF3T
	vGjp0a4+xxNoWHEr3SX5iSwicnfm877vjtWn8jNukvaeRSNI+m6DfOw/RZMv9SwIEWBfoxGXoBz
	7DiQycWgY2Erfqdle7sHxXGRmJFOOEmNDjtedBdrQD1uLChnG56s2y66wGKPyXK+fXyO5rH7/z6
	7By76MKn0YIS3wcurBLCINNm70Tl0Yno7xjQ7iRF5Q/jAr3qexYI0AX1/7dHTTS1dr2f4YdSCEC
	s7n5F0sM9mqVTCX5MFpfxfgVMHJyeaVoOQmczSenn2wWBey1kcJTA5m8zsWukcs+POlEWBmb8qX
	39YU69BxRc1yQOUCCs4fGUcPgv1a1zq0RsrnBKlZzgBkl0FkUkIa0VMFXvN7SAven+bXEkCPygj
	nfvc2gRfLg/cxtJ+Ph7Ihk6c5H+QX1QRpANdkKr2SDV0v1r9cMLYzX7Ss=
X-Received: by 2002:a05:6512:ace:b0:5ae:b584:561c with SMTP id 2adb3069b0e04-5b0236c689dmr2364180e87.62.1783973430091;
        Mon, 13 Jul 2026 13:10:30 -0700 (PDT)
Received: from fedora (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01caa6350sm3076448e87.59.2026.07.13.13.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 13:10:28 -0700 (PDT)
From: =?UTF-8?q?Erik=20H=C3=A5kansson?= <erikhakan@gmail.com>
To: k8ie@mcld.eu
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	lains@riseup.net,
	hadess@hadess.net,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: logitech: add Bolt receiver support for Logitech HID++ devices
Date: Mon, 13 Jul 2026 22:10:26 +0200
Message-ID: <20260713201026.391186-1-erikhakan@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <345f7347-30a8-4568-a7a6-c70f54a52a8d@mcld.eu>
References: <345f7347-30a8-4568-a7a6-c70f54a52a8d@mcld.eu>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Thank you for testing this.

I could not reproduce issue 1 locally with my MX Keys for Business, but
I applied your fix since it also works on my hardware. Either the
different keyboard models behave differently, or something differs
between our setups. I folded it into the existing interface handling to
keep the code smaller.

I also noticed that my older Lightspeed receiver exposes interfaces 0
and 1 as boot keyboard and mouse interfaces too, while only interfaces
>= 3 are treated as generic HID. So Bolt appears to need different
interface handling from the existing Lightspeed receiver path.

Issue 2 was easy to reproduce, and I applied your fix more or less
verbatim.

I will send a v2 patch shortly. I would be very grateful if you could
test it again.

Regards,
Erik
