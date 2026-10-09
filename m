Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAED33B975
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 03:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791514923; cv=none; b=XnQqNPkyKrbY6nInAcp6Z1WiKPqJE9rtPIBsc9ZbCdDBVkjnR7hPm+j3Zqh63vtx3ynAojs0lKqmP4dJZDLzDQt1o3B8UDBTzmU7iCpG9ySyvO8b4+gIbieSwXoTYdLshH4KFT/l+OM7Sw0GYAmg/LPaq6KPPD91jMJ/1wxp5tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791514923; c=relaxed/simple;
	bh=5asG3VC5w3TUvVixdyxfgI8KzY7Moi5gyJxCI4+fNbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEwDnsZeIZTmmltPSr0gkEmzi4NqEVOvw4GtJJ3iyggjp06OTA6gXjvCtPjl3UMAXWjrL7P0bspSsMwNtiZzWIPo1r/1KjD50RPvVyazJjzdXe/6dwpkyHTRgEd6LE7HVoXFI+0KUl4+Fpzc3D69ZGuwq8xYHhR7d0xU1PgodAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXy1wbMl; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXy1wbMl"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5e6b5794d26so1314989e0c.1
        for <linux-input@vger.kernel.org>; Thu, 08 Oct 2026 20:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791514921; x=1792119721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=raXHB8sKIbJTbaXcJKAPo87IpoS6XFLm7UNctFzOohQ=;
        b=MXy1wbMlPUz51dcJWgy5xHwsL4IXcG76mmcFdKJY4PVrhwWEFUp4JUI9XaW9zrdMDc
         DImz/pdndOp6dJS/dUTSFYMTjfMJeaBt/w4PZvhH2Zva8M9VUo/411zUYo8wXl+/QZED
         fFjGjzhJqAl7VdyFBE4dMZARU9/emo3yePOapjXpPb89GfSRTcYIAHxbgBGl5OyNIVEi
         7fgUl9Taiazg9lMUwV/wYO4xQr/Xws2mSVcwdsuD7X065Byqo3Rh806RhHkQPW0MlpyO
         beJwAt/AE/hkaPDsDisJD7BgC2EQ3VhVnJ+7QbcsRqPnKLHOWllJOeu44NbGcdjQ4Ga/
         dwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791514921; x=1792119721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=raXHB8sKIbJTbaXcJKAPo87IpoS6XFLm7UNctFzOohQ=;
        b=dzi/sM604SOn86bZRlJn3ChCikO/Avi6ikhPSVIb/VR1AQG+Tj0CQysJQikP1z+jtx
         msRIRiwJUkwyQbN6TM4JjthxVJM9T616V8ThUI4PechFr5cyaxYFqcvNkiqxHXK0LCqD
         fZ3HM7EV0BznRXcEpg/ufAIeKh6Bo+LliZaFE5iKW21rxV99DJLzs1giMArzsq7bbCN1
         5F6O4gdbRc8kRvDP4qiPSHk81rx2wj3QJQVdJQIS2WjWCXxSUnGe/W39Wn7uLmkq3w9v
         ikbCn26Kpuspsz6nTyYxw1Pi1FDHyPU6UD61Iejl8kKe4TqN/wUqsrtnn8ffWa6WSS9T
         VNOg==
X-Forwarded-Encrypted: i=1; AKwUvByvBibONbMBlPTcNMOYJkUEZc6MEj3kfyDs36LQPksQBwUK4RebNrquNKEse097zjKEtQKDHcvqFZlyJA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKIG09QHyGEGUXduRHKImj33dSvuITtLIT5IversKW+mmXF6BHv
	F7wh8PrWAqkp0Y5hWdIfoC7R9fhKHMoQ/TQC2V6fyGM4nTC8QZOqEwsy3DI1QB8QfMbIvQ==
X-Gm-Gg: AYBFou2Chp5vjt6TPNDqXqE2djGdppFe1OWvNRcM/30PCQp91XpQdS7/Np6FrYEl5PG
	UuMU6mcnoHXoRobP14HP4ilh9vK0nVXZGuGHBTAi915yQx3QbSlw5w49K46eNMPnUIPrf5HWVaz
	/EcaiBfvSiAVJakSgLV2zg0HE0ynpDaqX2r7i8YJG5EAsW6ElkL6U73Frdes4cr2Wl/CYXZP4bu
	ReL5N8fk8zrS9qFcBE/kMG+aEE87/gq/3bqsPKUEiEQkAJwztAeGsBYkvquKIQvXGoZFIBH94Md
	qeplOxCHtkZCTWZ7U5e82ApfYpyHAdiy4bk1nH8Wvg2Yy6XZPkuYeWUN9dOzp7reyp+SAxE4gzF
	qp+VQQVNFeSi7YF3LhBbwXWAIwnbizco3nZ4y09snQFOUlOch+SGo40lPRccryVUF78B5bKzV1z
	ZJREMqpL4zXYDiOKzjmfH7XHHEApVAI79ExtlPpAVcyFgO+IYrNebkJVdDdfpHdbg=
X-Received: by 2002:ac5:ccd2:0:b0:5d4:3376:f42b with SMTP id 71dfb90a1353d-5e91e5b3fadmr135336e0c.4.1791514921229;
        Thu, 08 Oct 2026 20:02:01 -0700 (PDT)
Received: from beelink.. ([187.13.210.57])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e91cab8c40sm802352e0c.3.2026.10.08.20.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 20:02:00 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	linux-input@vger.kernel.org
Subject: Re: [PATCH v3] HID: wacom: avoid overflows in sequence number tracking
Date: Fri,  9 Oct 2026 00:01:50 -0300
Message-ID: <20261009030152.3050239-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915145229.3069117-1-qwe.aldo@gmail.com>
References: <20260915145229.3069117-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jiri, Benjamin,

Friendly ping on these three HID patches, all sent September 15:

  - [PATCH v3] HID: wacom: avoid overflows in sequence number tracking
    (v3 fixes the __moddi3 link failure on hexagon/arm32 reported by
    lkp on v2, using div64_s64 for the remainder)

  - [PATCH v2] HID: wacom: validate battery range before scaling
    (v2 clamps to [0,100] instead of rejecting, per Sashiko review)

  - [PATCH] HID: core: avoid signed overflow in multiplier calculation

All three target stable.  Let me know if any need changes.

Thanks,
Aldo
