Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B20918AFE
	for <linux-input@vger.kernel.org>; Sat,  4 Apr 2026 06:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775282538; cv=none; b=Fes6xMLafvzq9uyurkVz59D6IJkv+ncsNT9vVWtO7ZpuFzS1tsjP/fstVU2FZJwNDJ+q0+xnkOrx/QuToNE98h6bhKSkB6pvzkq8jgdZUgkFpcWW6lD9pGRVh0tSMJ+h6gN6PHG1zLWynLHnrx+rYm3/bWNOLoynb47Wp2/9nTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775282538; c=relaxed/simple;
	bh=2sQ+YTIFrOmgcVUpPJ3pmmxuh1GbpJU3WoDq909YeGA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VLDfZ8ZdT3DG0aIrHd1y041GD3I++SsnQ0sCDpOtNssOadm4sV5ZGyFzh3vv2zQA52vGPpkvyH0YxW+c9YmAaZnoA8Rg6/xnX+AWfytpPLluG24EImR03v2fWhfZhz2tW0iLONq0mg4br9WRMV1bvIjf72yxDxCcygdJ1kzgfEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZ8Tnjmi; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ8Tnjmi"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c1632faeb9so4776992eec.0
        for <linux-input@vger.kernel.org>; Fri, 03 Apr 2026 23:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775282537; x=1775887337; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1E2eZc0jwkmIlJxkGYRNMBZasOtrF33EURwo2fuo+HA=;
        b=TZ8TnjmiQf8UcRw8t7DoXGk/iZ3xgMzBJ7wvgKNhJf9j7WMtI6dhsk7eYx6EhjrVpi
         JeVPLlB+txnfRLRTmdCIPIgmddun+pc6XvSPYX8GukTGo06jBulDPh+zaUmo50o0Thn6
         WBFkcaVl1hpIUHe8meE3LH4YLgIn77hkXEZkEiI98PICfie1GNGOMUJcOxrLf37qj2jI
         n/Kn1ogZGtci2T8gsjHkpfoUYTMTqY1j/eZnJLNqJJSiwdaCUKkH2o+3MsHFSb6r1trP
         TBxXMFLUae6mTf24SCiQ7CsPwZNeWCMPYr2hz3Pr8ogeJhdIrwxdMatgl0dGbyDB6rbq
         dvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775282537; x=1775887337;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1E2eZc0jwkmIlJxkGYRNMBZasOtrF33EURwo2fuo+HA=;
        b=H9xfpSPwVDVCJgi6Tx+wf9WKbsJdjTE+XDZHitqU3Q+H4pZ5qhdVUzPSzA808OBkJQ
         wZGGAJCtM43dcntv5C8N5tZrPX8dRutz6ieZ2hZ477bwuOdSirn9JEJgJGbdGlM9nSKj
         jnBI6jqHviplhcwjuYSgTy8PwpivvIknrisf+dslaWITTpA2rnQBXHrMbjb+uoRTrdlX
         SZRjMxpCBaSdo5k9wc6oBdiOucJUryBKuq/XW+LINMw2R17DAWs0fh5O4Rk6EGLqtobj
         Jc0CRApkR5iDWBGTQlZ/eFd8me5sZA+xTgQz1lk2MUwk7xZ6Tlov2frqHumWIngMWvrV
         huaA==
X-Forwarded-Encrypted: i=1; AJvYcCVg7WuSxj2OBjWdxS831ecIbqVpg33hVxKbs+wXAXaTg7u2e1Nl/v3EjYSwSDL1VUv1MrImupAgoAngyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyENfUySbSPYBkLrW2tCoArjUfWU06Bfo/7W2VyCi6LtrgsI0Cl
	cC8UdwwKvCzDe6oQMzeBZU/OPqM9fRo9CPS79dnezoh//ZWuljOn5f5f
X-Gm-Gg: AeBDiescYYDtoej3BqUiMcLhx+wqatKBY3udC/Ep/LmgDDpGVFfJBVEvICqSBWeAAnA
	WlAJvZnSnpu78ja9pjWzP7uFzfJNcutBuoPMYuiakxJhd7J3DB+4TZPnz62vaYT9DqBbmnjlHjb
	fNZAY8MFFOtFfk89eKPCX3E6sL12naHZEXlKrRxwHwleGL4AVXqNLWeWIFvcchc6JuGeae8r+bx
	+y4PhkMlTEbLOk4sb/V6kUDDbDHaF5PKAkp0fnPies+u0fA3tTn5raygQ8HCfP+AtJ7j0bab0e/
	TARZ4a37XW34mAwJ2RosjFMXtMYs99/Mjpo1u5kEgVChjRMmgiBM+fqQiwVscv3gXxtON6GaU+g
	Vc4P7c4mOEeLZkgoRg6xjXvxrE3/DJBGSuxX1wfffKh0Z5Cu9rEr5sreqs9ILFdVMmPmz+f0/r4
	01A9h599R1HPbHu6Ck52R0e5BrbSkzwgjXJVJ7fSNGf6beoGLjjUieSjc/6fQqSmWg
X-Received: by 2002:a05:7301:1688:b0:2c6:cdb3:bd5e with SMTP id 5a478bee46e88-2cbfc365473mr2745111eec.28.1775282536552;
        Fri, 03 Apr 2026 23:02:16 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2357:9278:e4dd:85f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cc63960a56sm3348615eec.13.2026.04.03.23.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 23:02:14 -0700 (PDT)
Date: Fri, 3 Apr 2026 23:02:12 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v7.0-rc6
Message-ID: <adCpWQOyfvE6E6k0@google.com>
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

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.0-rc6

to receive updates for the input subsystem. You will get:

- new IDs for BETOP BTP-KP50B/C and Razer Wolverine V3 Pro added to
  xpad controller driver

- another quirk for new TUXEDO InfinityBook added to i8042

- a small fixup for Synaptics RMI4 driver to properly unlock mutex when
  encountering an error in F54

- an update to bcm5974 touch controller driver to reliably switch into
  wellspring mode.

Changelog:
---------

Bart Van Assche (1):
      Input: synaptics-rmi4 - fix a locking bug in an error path

Christoffer Sandberg (1):
      Input: i8042 - add TUXEDO InfinityBook Max 16 Gen10 AMD to i8042 quirk table

Liam Mitchell (1):
      Input: bcm5974 - recover from failed mode switch

Shengyu Qu (1):
      Input: xpad - add support for BETOP BTP-KP50B/C controller's wireless mode

Zoltan Illes (1):
      Input: xpad - add support for Razer Wolverine V3 Pro

Diffstat:
--------

 drivers/input/joystick/xpad.c         |  5 +++++
 drivers/input/mouse/bcm5974.c         | 42 ++++++++++++++++++++++++++++++++++-
 drivers/input/rmi4/rmi_f54.c          |  4 ++--
 drivers/input/serio/i8042-acpipnpio.h |  7 ++++++
 4 files changed, 55 insertions(+), 3 deletions(-)

Thanks.


-- 
Dmitry
