Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434251;
	b=Bp3000y5+zSphA18vuQ2Q12g8HP9+XNrtcqSuB8FYz1XaJpI66h5L6TXGWPAiQlii30q
	 3iRdv3ySO1ifRTOJ1bS83m5TVNWRvWBFrdRWpVmHxKVJFnDEu5YCVJl9mIaGDWrVYm5Sb
	 83qOPhyY95lUMJOBhL7SPf+Dk2GOONNyQv+Ej789ZKtHJoIUk6AxnIhY9lw1LybmvLxc4
	 Xn89WwSiFYW5RMzD7mCwmJXHKtwu8R6kbnv76r05yWmMPE9B+mBlDcU5yTfzGvOtKt4yb
	 HATLrca6kj1x5USC4uxzin96bYe3eoHrCKahO/yzjQrpSGOVHMIE6Tu4RQ8hVXXPrfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1ggCgsA+NJ3WO/E1t+Aq1JDPeicUUtkRHraZJ7K1wtc=;
	b=p8asOkkvrLbY8f4/F8iUxWI8nFdY+KgMpo9oUQXaDaHIkpSnmBk5iApCKjOf/+lCMLtJ
	 pQ1OrBehVZ1irsvkKKF0IReNjA0yMeMr6LSpxAJ+7ek8jtrPE0bQP32yFWqhqEMHLRHFI
	 Dsqb/xf8+qnU0HGk5yfw5Fnr5hwPNqn1ySFUkltte3sd8AOIbMd2t1bj1gmx5xBA41r6l
	 sVy/OqPlKlLD7sSOmgERq2phgG5ZqCaZsST/Q9lKESyosi0yNz4VVoovnz2edRQ0rnLg6
	 27vB8gWDRhYbWkcWBuCIdyKIP6NSXwg1wuzOO0kMRAPUl9bybtsGm5GLB/w0OSXoYHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dpRqHE6w;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05735606A324
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 21:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05735606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dpRqHE6w
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-37071c0f42aso6201217eec.0
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 13:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794434250; x=1795039050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1ggCgsA+NJ3WO/E1t+Aq1JDPeicUUtkRHraZJ7K1wtc=;
        b=dpRqHE6wmn5/kypQAavyk2ufy8OymjXbdHszRThOGjX0jhpHZE2qgnjwzT3Vy1/b41
         yQ4Gi3hSMKciusY7qlEJ5+14hX1uBKQfaMxw5cA9h2m6f2Am4HkhyTRKppbGkixO96I9
         4xshsjXZE3rQFOSViTCZVmT9vw1xcGdCrxvzRzieFMx4zhtiRLUIObcxOwBbp+LDcplg
         A6OM9KKLpskJGQyuytSPCIf/ZJCEx7YbYp9PX4Rpv6SrtWlfX1tPBRbZKQWvjwWIf2fz
         TQxHreUPkPkn9Z+C4+hQ+743rtYhXfedsICOSLIje0r6hLPhyzp3psTVzDLlw1t16rGn
         EHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794434250; x=1795039050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1ggCgsA+NJ3WO/E1t+Aq1JDPeicUUtkRHraZJ7K1wtc=;
        b=KXkF2+bjYBgZPthuBZs4iysA/i3CxYWM6yIEhxc/HldZBesiUrOxIGxTtGbyo9nFeZ
         +Zcmdr+hl+ZCrhyOMdIcgZn8q9gHQifCk7qKxhtvNHNOPSSd55lxAedYe2SD9KB54QkQ
         IAJe/JiiZPYlhFQBLtnAaoWzNbmIfujpX5EOkd7qEXrMDaLk0Lk2lopHrTLgAytIa+Y8
         sJZeFeAl6ouGWXOPDLrk+GTs1ZIoSre7VVW9KyvKJ1SpJNdID8yjAXwmdX+SJmdm1axs
         N/FmXBPhl2ugXyz2ur0xZZolNaQcEERM1W877uZrs2r5O9TTYNeAFkK4jdvL4z9IFJ8r
         /AmA==
X-Forwarded-Encrypted: i=1; AL+hErH4KbBMpKa5VdI9qFEQqNyx424NFR604BX4QZVjaYiVqxkMc8XB3/QaZuhbOiYW/iFwcSIP3JIZUc5bXg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8IC6vZ7Qk99b7AYtaVL9+xTR+yNzx5fa8++E+zhVKMhSXgU8aR
	3p6vRJTxGdiyWjRn3hqffNAViLHCimP8YAJimxwLKchF8z77MUS/mYrY
X-Gm-Gg: AYBFou1tTuUxc2afOk0q2FVqneiQD5Axe4VIQ1XBsMFuxOo90g/AY/qOFKI5Ntfi3vF
	ab/dlQHtfRk6gpVOi7ckD6H8JCrpNIdc88E940R/Q0Sq6SIWYxNMrl8PfoLriypKEqhxtbt5sCf
	2KU317hksswTY0YjiCs4NArEvzkvK7ZOmXMI1HK0LZBrZ9s/KCGK7UTkEouFKwpbWtl+SV3tMUy
	3qtn73wLPspZ1eTpg/FNIC2V0NRbsr/4PM2U4nGYpMSJQTsbAdHtPMcoybB4LVFtpHh6XP1WIYl
	Y1n+Zi2lF8+EfGemO8vOBXsGp6cBdYoS1ZGwXQjmJa3HoS0CkHowCW/l+3qk9A6tcXiVSgY4Qvc
	UdLeexF7/O56h0RosD01+STWKUBu7qp9uQyhve5Yu0VUH6Y4y4ZXOWFtFB5WwDFw9rBolky4h7P
	WGrUkeoqC/CakjTnqOT5gZfdUtavMru0n+sej83+QhYEe6lY+pqf2D0TjQLg507hn4HQhfocVDW
	CrNJbh1fC5A7NsGKM0GhPtYzscETMNVD9bVepSak64tUS+xL2x4AA852NqBReTgdu3OcKgu9jr+
	6YkSpY0i4ea9ugDoUhJcyQ98mVMVKL1LoJ9YsC1k+4jhx5m/apsViE5zbHfGcUWbXpsT9/HNrWf
	Fmd/I7EUVgfbTZj8kJQ==
X-Received: by 2002:a05:7300:2d2b:b0:36d:2704:6adf with SMTP id 5a478bee46e88-3768579df8bmr5681391eec.11.1794434249909;
        Wed, 11 Nov 2026 13:57:29 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:eb83:637b:7b26:8dfe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751dae6377sm17823523eec.3.2026.11.11.13.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 13:57:27 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Henk Vergonet <Henk.Vergonet@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>,
	Martin Diehl <m-diehl@gmx.de>,
	"Alfred E . Heggestad" <aeh@db.org>,
	Thomas Reitmayr <treitmayr@devbase.at>,
	Slawomir Stepien <sst@poczta.fm>,
	Jie Wang <jie.wang@intel.com>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	usbb2k-api-dev@nongnu.org,
	linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Input: remove obsolete yealink USB phone driver
Date: Wed, 11 Nov 2026 13:57:21 -0800
Message-ID: <20261111215723.3802209-1-dmitry.torokhov@gmail.com>
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

This short series removes the obsolete yealink driver for the mid-2000s
Yealink USB-P1K (0x6993:0xb001) USB 1.1 Skype/VoIP telephone handset
and drops its module selection from ppc6xx_defconfig.

The hardware relied on dedicated userspace bridge utilities (such as
usbb2k-api / kb2kskype for the defunct legacy Skype desktop API, or
yeaphone for liblinphone) to drive its keypad, segmented LCD, and tones
through custom sysfs attributes. That userspace ecosystem has been
unmaintained for over 15 years, and the driver itself has seen no
functional updates, hardware testing, or new device IDs since 2008
while continuing to attract syzbot USB fuzzing reports and drive-by
cleanup patches.

Thanks.

Dmitry Torokhov (2):
  powerpc/configs: drop CONFIG_INPUT_YEALINK from ppc6xx_defconfig
  Input: yealink - remove driver

 Documentation/.renames.txt              |   1 -
 Documentation/input/devices/yealink.rst | 226 ------
 MAINTAINERS                             |   6 -
 arch/powerpc/configs/ppc6xx_defconfig   |   1 -
 drivers/hid/hid-ids.h                   |   3 -
 drivers/hid/hid-quirks.c                |   1 -
 drivers/input/misc/Kconfig              |  15 -
 drivers/input/misc/Makefile             |   1 -
 drivers/input/misc/yealink.c            | 950 ------------------------
 drivers/input/misc/yealink.h            | 206 -----
 10 files changed, 1410 deletions(-)
 delete mode 100644 Documentation/input/devices/yealink.rst
 delete mode 100644 drivers/input/misc/yealink.c
 delete mode 100644 drivers/input/misc/yealink.h

-- 
2.56.0.567.gdb80ae8cd5-goog

