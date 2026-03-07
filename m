Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D478E1EA7F4
	for <linux-input@vger.kernel.org>; Sat,  7 Mar 2026 02:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772852022; cv=none; b=oBbELVu9ZBIs7uT8abIqL6NHl8JA9ETxgMWompGF8wy9XPLsXOOVjvdlQ30htQFsnG2Adz7rzx/sqMXESguTQD/1swU6/ZmKvupeDfW7koWnAs/lKvT7FVRHMinGMe5urhyH0fY5poS5nnppBAxsKxtMtUWdXZSFNnl0aQtzJ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772852022; c=relaxed/simple;
	bh=Vco7MCJ15Eb1qsmLNHaRLNzt184+FcP2M9jgKlhN0p4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jcSEjEN7n7iQ12qbbEHEf5ahiU9obag1vscNNTSp5nXr8ijuEUkr5uxSOosGH1njsOuZdCXtN8NAa0YKH01PthFNDw7bBWKyEDrVKTScmELaX8sNKVIRCxohIJaWSDMOODkhGzDUUY3EZOIIF41Pm5KMQRynM+DXDJcx6hKanwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bi7yN71A; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi7yN71A"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c7388fb61adso1149457a12.3
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2026 18:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772852020; x=1773456820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=193j15XFage9v8e5Pr/9GKmDx9DMdhLg6v6zvLBCC/Q=;
        b=bi7yN71A8TSHS6TpgcDYwNcsXLL1VXB22LAdR7VksENPzPfkIu9KeSl5ahYZ3q5Lj7
         iW4hCq+FSARdr1tGdDkZ4U4yxELnZIF7K6fTFeU9poo4E2bOTCw4In6zoTStFgzr+ywo
         67dFHcAS8wYbs0gQ8hpGm+HYAUtW58T9/Ur4AjtUMpw0PAh7cz4iRQSO6M6UM7jQ9OJJ
         Vpc3tSO4Wz9VzWIzkDdItI8agL71V157vWBgRsHwZb/DAsN7F2bFmmRcdbld/xERrbMX
         Y/bgJIlW41GI3ypFzbZOUIGRNfVCkZdJ2V1tFdvpZWwRd760BylHU2jMIRHltz8Rrdh9
         fqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772852020; x=1773456820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=193j15XFage9v8e5Pr/9GKmDx9DMdhLg6v6zvLBCC/Q=;
        b=SV67lpnlMOkmnNdTFbf3Kgdwl4tIcqt1Ti6UeZM/CEGhfcX3n3CRjOLUihF9wYu5R7
         qRPp6IHLpxC56v0CvI5rDRZ8uRC5Dmwxe3Vb+33yx249La/9vmXsmM98SpPnlF+nAzdK
         6V4vtrTJWk4bl6ndOS2raGdxH8A3YLDZrnGm5npZ9BEP7z8GWa7r5BiF3LgzO8sDY09t
         JUTDdQYdzCpGbEof3g1Pm0X2kSN2jZKf3tsKHFhRriJNqQ7RYJGlL3HDsZKuzoNgB8cE
         eNgc6fV669jutAtBePw35vIHoNEjbb+6WQFaEnn0VN4xp90SmIfR2DoIw+q0bpipewcJ
         eOjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9u+eOVEQiYGLJe8p1mksMiB0Lli6YQaPJ36JtpdxGpoD/+Vc87jY/BMOqi3U0lZClCTgNUhQLgcfOLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvIN7yCREryOYbxGGPvlh07lWKxaTb0Zrr3ry+AjKMjBLdr/dT
	eOZ5eQNJosBA8Rp/dsLNZVmNclkRmww+ATqTpjMuuYjnXoNCc/8GVS+6
X-Gm-Gg: ATEYQzyx4wJFJTcUxcHKacKzXjuIz213lhhi+tkY97wp0aP5Rdpwy4yM2PjPVLp32If
	0n/NbC52qxqSv9ylYWfAQCUOF1EtJzorj5jycjOcnSkHWzuoDfuwsZ5/AlO5QYdBtruZLJlTdXd
	GMmBFXxFHgyqE5Jz6Y/ialUsJztFxRAzdm4mVtwjtGqPUhpODj9c/ngHNJuPC5raD2K0No9FxNx
	fInArss01bRtfDrJ1D9UQ6L6IXU4ZGpEfOlXHH66CXW1VxVVV6zzpggcvFH7dY8ool9T4n61Vc6
	J70YaucCTWQhTyg6AotJwi7bHjaYf+GkMZlAMxEJ3vdNQ1uq+QgYxxAR8tZwFphP9LTsd6qnn46
	z5OgJlPdixw7KRlPb2E23AxISE/k3DN6xlDAQIb3ee+g1LasfCKrqbdXraterQNpt1o8LXG9RVm
	hVB3WnlganFIA1iomSYskd32eZcLmUPV7tenkrQsDEb2Ph3M9wS7FU+gdzksXkj/UcmkkTu0dCy
	Bnz1jBKcHRYm6qDuw==
X-Received: by 2002:a17:903:2308:b0:2ae:606b:bd98 with SMTP id d9443c01a7336-2ae824dd28amr46174205ad.26.1772852020288;
        Fri, 06 Mar 2026 18:53:40 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:8207:3134:c1c0:ef7d:b1c8:1597])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840ccb6csm45528445ad.92.2026.03.06.18.53.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Mar 2026 18:53:39 -0800 (PST)
From: phucduc.bui@gmail.com
To: wsa+renesas@sang-engineering.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	geert+renesas@glider.be,
	hechtb@gmail.com,
	javier.carrasco@wolfvision.net,
	jeff@labundy.com,
	krzk+dt@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	magnus.damm@gmail.com,
	phucduc.bui@gmail.com,
	robh@kernel.org
Subject: Re: [PATCH v3 0/3] Input: st1232 - add system wakeup support
Date: Sat,  7 Mar 2026 09:53:33 +0700
Message-Id: <20260307025333.1594-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <aaq_Rft0gvVqxmMD@shikoro>
References: <aaq_Rft0gvVqxmMD@shikoro>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Wolfram,

> Krzysztof already adviced you to not attach new series to old threads.
> Please follow this suggestion:
> 
> Do not attach (thread) your patchsets to some other threads (unrelated
> or older versions). This buries them deep in the mailbox and might
> interfere with applying entire sets. See also:
> 
> https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/submitting-patches.rst#L830
>

You are right, and I apologize for the duplication of the mistake.

I missed Krzysztof's earlier reply while I was preparing v3, which led to 
this incorrect threading again. I have already replied to Krzysztof's 
thread to acknowledge the error.

I will follow the proper process by starting a fresh, un-threaded series 
for v4.

Thank you for the reminder.

Best regards,
Phuc
