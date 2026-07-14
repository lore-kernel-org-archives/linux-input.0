Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0822FD7C3
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 00:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783990500; cv=none; b=fzu40Hm12PDdsdvDMnnoPs0QQDXDO7YjvLg/SzN+JolMoZt4CtKDuNvTa5kQs0wrHs/PbjbAjqxFCoZdK6SvG2w5S7O7wEHVPe1Uqj1ai7yJm2oI9HJvQUDS9O6/ajccC0AO+i72IFNBbCoYOoXWM+R9AbUoUM+eSOHwDWniZXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783990500; c=relaxed/simple;
	bh=Hgoq9E2dGymCPC+4kYT+Jr+F9/SSZoUKevyEEL5BN+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SI4q2UyRCQE+3J878kFJM4jeRCmrSzCl4iYqPsVqRjgMrNDT9UVmk1o8zPaL8ArOrbNrk1x0T6p1A/u9//2XbxO6p+IpLp/dkGL89dCWgFXAP66D1cJwvGDr+YJ74SLVkhZwYQE9nXST/WkTYS/jh/cPU/jXTI8xbTysr5QDTlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcl6LrH8; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcl6LrH8"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c7ac9b8c3so4661651fa.0
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 17:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783990485; x=1784595285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=euoijuPmyMJKoASYwFNTMrOT1PJTsAZgU+CktHmPjCA=;
        b=lcl6LrH8r3CaSTVKsm1250KLbP6mc6VCRPdrG1NYAKCYm0YLr4RdXOPp5q6/ry9ZHs
         UGUPIT9qnkK0Z6iE1PwiYFkh4eQLd6L0CxyI1IdK7InFSI54peoa0Y7VgMgi8jHtUCbV
         Q2Hq4S6jR28aIZpA0Q2J/sQ24+vIbBryZhwmV+NUlJNBXYHb9aIEUsLQ/tetI1L/og3X
         0RP0+VcPryXGbPbsTxmEvOmstnjfYkN4y9IH45AMIhdz9x4IOiiwkcT2XadsUmiTOMzZ
         xoKCXJjwhOf61bwc1+gkkdokTenkdVPk4TOreGoQLA+AWzuOwpFC1ILmPDgHnmH789Pu
         5sxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783990485; x=1784595285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=euoijuPmyMJKoASYwFNTMrOT1PJTsAZgU+CktHmPjCA=;
        b=YKRyVbeoVDLZMZz3L/++M4VywLpM05w4TE0EHUB69VR9m8htluXqWgqc1+dwzE7rtB
         AEoR6Mu6cS3UpQf1r32i61vEM7so0klan8gDDUPjb0Hc4B5OWcIGGPUoYbgwFzQjQCIR
         LkS2s56x+F2uMz5pk4xkO3I6E689ilLY95892/sSppNXHCqnlwqBhUw9RMre9+Rv8Y76
         OFLEoyvJUSL5yIUBoyduXBwhudyVK+IBc26FXfamgAeTPewOIF4s317h4WuR1xC05Sdm
         Ck7U8w8SAz3eORBFTCP5/NRp1sWxHRElMQNHFTSGZNceBltNKOYfJFT3zd+yCFO/IY7s
         fOUg==
X-Forwarded-Encrypted: i=1; AHgh+RrlYA/+Je9Og+Sa7kHYXTfO+bD9gS7pSqvgr+e6bOf+9Ri5oB4ZMtbaT8ZweWAdGHAek7ralcXz7eNyYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YydMMNa38Vqy67F7c4hN7WcLUUk3VuJabwRmc7PhJFEj1IGn8wN
	9JnZ1nfp6cigfM8fDnCbYQL4UCIlQi/bKQM+Rjqpv2b7BTUdNfukP2U+PSmujLo5
X-Gm-Gg: AfdE7cmkxxEvie/+5PW7yYMgtAQuUYKvyMt6FIBcTxDNdU+2JbGQcfqccYzcpsXrvYJ
	xrHuUXUWdi9782t81KQNGL6nJiUSYAUJkOLKFISbxZPuCIeiREfKC/IoyZ6ecxA0/QUaN6M+ao9
	qFpAVOPnadiGYm9GBUxGXJ1XFoScuVIXgEEQ6xsYvT07/op9m3jFT86XjDdCuFl5otBDoD2luh2
	T5e0PiD5ASaphswUYg+zHF9onK9wKjAbLCJegfbd6wWZi+LBJI7Oz38DJkFoYHjawePeGsZpPj4
	eghicZ01RZNyZTd9xZKVXjeOXXLtOYo7UTkVa++iG+X1tQg2exDz4fYzXDmJJWc7Wd3p9JQRDKD
	l8HwgCDy4jzKaSfP2v6tZjCqFhtp5XigalBEd9NMsJ6A/DJphAiY8GlJ7ccRgWmJeMg6syvCe6x
	Lhbd1XJ+D2dZqzJEosDBqZLV0yINim4XwBoXYvGc7dB3fx
X-Received: by 2002:a2e:9859:0:b0:39b:d04:b783 with SMTP id 38308e7fff4ca-39caa8540aamr17936281fa.20.1783990485005;
        Mon, 13 Jul 2026 17:54:45 -0700 (PDT)
Received: from fedora (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c84bb0dafsm29648881fa.40.2026.07.13.17.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 17:54:43 -0700 (PDT)
From: =?UTF-8?q?Erik=20H=C3=A5kansson?= <erikhakan@gmail.com>
To: k8ie@mcld.eu
Cc: bentiss@kernel.org,
	hadess@hadess.net,
	jikos@kernel.org,
	lains@riseup.net,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] HID: logitech: add Bolt receiver support for Logitech HID++ devices
Date: Tue, 14 Jul 2026 02:54:41 +0200
Message-ID: <20260714005441.472898-1-erikhakan@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <bcbf28f0-a3da-454d-b05e-a554017fba0e@mcld.eu>
References: <bcbf28f0-a3da-454d-b05e-a554017fba0e@mcld.eu>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Thank you very much for your help.

Unfortunately I don't have a Windows system easily accessible, so I
can't check my firmware version in Options+.
fwupdmgr says:
> Current version:    MPR05.03_B0020
so perhaps that means 5.03.20.

Let me know if anything pops up if you dig some more,
Thanks,
Erik
