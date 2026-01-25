Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF793126B9
	for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 06:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769320807; cv=none; b=hmiz2HgmDbX3Hmou3b9SA2dmz22gdm34+9T/8/f2xJzujB8qPzmVJHyFrn+UgvJsbldCvzL8NTfc9CX82txyP+bWEP7A238xE3RgsuTyyfRLpCIBn0gCET0CmujizTy/62RGZ6CB7b/25FznF4wvJPWJQecMtV9WNwYQdNL3UbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769320807; c=relaxed/simple;
	bh=IwtfCq1ZehwGGhLK1Pq4ZTxJEe4BEUQYhH6OsvU/z/E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XXGSrscbTkAgB2gL2RiwP8ybHIB//hAsh7x9OmFFLQz7yKKvibFIyFWeostA/6wUn06yRiIEF2fJ7FPHUaoQyLBMSFvbree/r43FdSF0oH5IFyT51wYcacdgEGGqO+xkOL5Con71VrFacEkKT8Tn2rauyP/gMRkkYhqOnJNd0yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUaVc+a9; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUaVc+a9"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12331482b8fso5861905c88.1
        for <linux-input@vger.kernel.org>; Sat, 24 Jan 2026 22:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769320805; x=1769925605; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UUkb1ES7r+84rfBN766AzTWfOMByQPVulSLLtc2CYMA=;
        b=MUaVc+a90x9qPBTB4Dyg12989OBFX9StSSemNOzDS0IPXVjGpo3VHMQi2RTplu4jo/
         IJZOjWXTPRZ3aY6knVnl7ZMJrUo/otwsUq35QrVfnWyBfn9T9ahmd2tvgq4NTEB1OtYu
         LHWEVEKvB9a1+2u2BrdPUHAd5MHHxlyG2JwsngEWSdGHhMkgPa2aAXPtj7OBqfAEUPRQ
         pIoAS8JGlZoB6jlui6Yu/iJSrKce3wS5tOTDDOcGCfuxz3UPfwZYq4QT+SDK4/bmqoU4
         zjAU3ecFjPRHjvx9Zoeb1UC/4MBQcOeyLJiOv062Qy8uhrDjzvOBk5EjEpwG93XlseNR
         +OVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769320805; x=1769925605;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UUkb1ES7r+84rfBN766AzTWfOMByQPVulSLLtc2CYMA=;
        b=YDCXaJMwvD0l7cwdJr66qFCK/JsvwKZSLvRddZEJYsIrAB+5y8jmXJ7k8Zysa8ZeMS
         p5JG0AcbXKH0Q4gCG0GmI9JmoH+ztfgvEbTY2TmEhnkOgwVWzeN/iRjalpeF/mId9sFE
         GPPMFk7B1libucrBthTwyNvmSSYrw1hC03sCpTOuApGnDd8PdaDFzFcStiomuA0Qk1rC
         xUmF6Qs0SpQ+RC1XhDBOiShKl+kd/h/FRZKw3O+XO/avCTkEF3i/+pC+xaqLdw8NNfN/
         69MIrHUWuH5886TyWCVlF9l0fH/8aJJHSgb8qUMD2IwbhxEO0GtQRSLFL44Z9kJxD7HZ
         MHzA==
X-Forwarded-Encrypted: i=1; AJvYcCUD2C1EwaML1P2vX59rkOpxjqVnWCzwEoJbzuUt8OPZV+9lUqmoxD1g9kvlV8F8NScu4V/nRbkjZPEP3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqejxNg9XBuQ3myg2JmMLwz00s1dNX8pI0HtMI4eTkWRiyactS
	80XjJ7vGK4Ak6DwNL9/B8I/YNsEgmpHuyMMPRPcbtszy+jt1QCEc/oaf
X-Gm-Gg: AZuq6aLb3M+lCM7RW3fODNg4j6xASAi8j/T0M0B/3MlfuFd6MtVZEtBMuq+lYKUxhT4
	t5l5D1Jzs5U2ZBBlQx1pxYh9iMIdAdHnKUJozEzRzeRfa/9FXX6GMAZCRLH8go3Bss6A0NPQ7SM
	DniCfdfWP2LK0tghDwEETbN70wLHtFdo1/DD18/VJ0xqZ5LM8vBhGQTSGmAe8Y/cx4Ub4Olqd6t
	3MAqpDZHb0o6nrSzwMdMvoEPD08iKawSh0xrXR1MPSzm2C5DxjC/rlwp72HHlvO8A8rWwXN+drE
	xbMgOZ5Tb25Z0c/RH74QdNPPjuEoc21M2VX4pgHfxLDAsu1acAfqO1VOComDU2FutUOyAjzo0lB
	jV/wlKnKDgakRyWS1HkjJrhoBV277Gk2g2WsIdvXn3+1RLNrnoXjMFtFmnRoEpKmeo+QMKoUw9/
	Xt0cPy+Vo9vVKxTKObzOcseJpxii/1wl0oR8rv0HQYXfBwRZJ7Fno6
X-Received: by 2002:a05:7022:396:b0:123:2ee7:7dc8 with SMTP id a92af1059eb24-1248ec5980fmr432164c88.30.1769320805232;
        Sat, 24 Jan 2026 22:00:05 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:106d:a8a0:84b7:2d62])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d9a4698sm12037387c88.16.2026.01.24.22.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 22:00:04 -0800 (PST)
Date: Sat, 24 Jan 2026 22:00:02 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.19-rc6
Message-ID: <kj4hg5eeu5pab5tmxoc7465s2pgoqh5pm4iedjmfd73j4vmzxk@77eh6hgaxlra>
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

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.19-rc6

to receive updates for the input subsystem. You will get:

- a couple quirks to i8042 to enable keyboard on a Asus and MECHREVO
  laptops.

Changelog:
---------

feng (1):
      Input: i8042 - add quirk for ASUS Zenbook UX425QA_UM425QA

gongqi (1):
      Input: i8042 - add quirks for MECHREVO Wujie 15X Pro

Diffstat:
--------

 drivers/input/serio/i8042-acpipnpio.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

Thanks.

-- 
Dmitry
