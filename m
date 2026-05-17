Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DF53002AB
	for <linux-input@vger.kernel.org>; Sun, 17 May 2026 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779030113; cv=none; b=Q4UP6oDU4qLSvHDYva/X5OJdfy3lu7GSOuDyr2pkWdxdaGaZFFtYr9YxKwsCXRyr+rXkWeWl+d/60qWZ9pZnnj7sL1Gd6TQTgQNtl01U4Rfkv0Qxweo2JSknoBE3md2gZZeSjZhCBpCc4/+szoNyD/Cmdox0NW5sJUjMurmOUqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779030113; c=relaxed/simple;
	bh=3tVRLn66CQLWPGHk0HB7YRkxiRLePw6FcswXEhPfn9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=az0uR8+0OdWUNfiybruro3rwgvylqw4BQSXubWoZ38fBs/j+AaeXg/1vx1XcuEbTvwk7mUaQEQNKcttiiqQkqQvLceq13Vzkq/TYauE4A+W7Pjq6TXv3Yg+w1T5f3uxXdeQqM9u1no7YsuI2hzHYGP7pprlquf3bhv/0LAttyD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNVkBIfd; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNVkBIfd"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-911488599e3so193595385a.3
        for <linux-input@vger.kernel.org>; Sun, 17 May 2026 08:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779030110; x=1779634910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EK+VSF3JZCAeCybQSER+gxppum8GDBbjmWVjYwFbu20=;
        b=aNVkBIfdk8ulODvXrZhXYtmDZPMiv5alqToktSAoMXpCZHNPnqZx78tCFTjLERe1fS
         wjVamrvvF9ekja5OH/Fmg/qCDOFYUnmsz7bslSHPWBdflLr729+fo0y3ccIEqBtLHjK5
         jf+TYP+8iRaQrWnF7dYJy77qw0Lqhuwk9UKN0fntPqUNEzuVti8slB8xi4bm5fjVn5hK
         kesKtRgFsv9dT+kOVmbZ9yzHsLa9bkbjbom4T/dCsyjg6AOtdUzi9Myipfq+tv/c2nfn
         Ksf6vXfDOIZjx6yRWqSPRSGJZQea53j//ejhQtTLqq9aACuLXP/c4HMUhYXs0G8pXU9I
         j2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779030110; x=1779634910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EK+VSF3JZCAeCybQSER+gxppum8GDBbjmWVjYwFbu20=;
        b=eTsWig4FnWqJWf9JC6Uz0PtzRYVDngkXFTDxDvedRpWXzyMclvibq4uHI7FfBWeETw
         z9+NzZZcrC4EKRC7Pv7Ckdq+tjX2mjap3Y9vLgjGaLVw5XbLmu1ibunBhx0iVB3HTNup
         bzY9U87jCh7VXcWKS+cWzEI2k/e8rci+u3FavipPM0Y4A6nCWyX16p69bRdN6aNCAAH5
         j6nfGAasL4pUa54X6DOrJIa0C5/ab4mPeIR5ZwBBxNEjhVBXYmwiQbI++3usqHxTRVGy
         zKRYCbeNIrTQwS0tarjewjdSXGO2S4U5O6eQ6As2aLfyO+CZpRrZdKPqFhi6kN3pEMgW
         9D8g==
X-Forwarded-Encrypted: i=1; AFNElJ9qaOcQh4Ebghw0oihWdZXLm7NTdj6xUyQSHYLZWgXbttcMwxmf+/e7FzzaMhIVmGHqhx+PDRJWS93CTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVAuKKHf23cEejHmlNVhQ6ICOrwU1WMptIHhyT0MgkyOE1YuxM
	11fNvxBVPyv2jGSjexctiL7rdTI619utdg1b7L/zHdosjV7KRu317wxX
X-Gm-Gg: Acq92OFzb8/41Hlgr+UmJJ07oRb2iZ325W0sdGnU28OZCHnWzCbOkC5uqjZB9lup6GY
	DnhKvKZeKwOZWVv2luO4SoYjLxpZ8ooZhcmGvmAGbyovqknKB6l3q7cSMpIXMyX1e0rjOpb2q47
	TjDP5h87++2a8xI/0wEW0/LeQwsADK3mVuAfraaOy0K+PqlfftH0PjXoitrv9shm6SZe42SNYtU
	7s/GdveU4azlTw2M76p8IrbKvdfwudIlvTGATgjuQ8rBwNM/MVR2qNvc+BIYkOeV6Vko3QjD2zs
	TgWEpCLT3FcHBS/epsphQaBXgHMyyqvCWCxbd0Ht6cddF1hIq3N0r5qywy5eeOCLld/PJQLv4tn
	5BEULGZ9bZpFdvs9rXjkOOeIqOhG57txL6ZYCGKP91Fw6K42EkypsrA2yQRrSneIaYqoFU7Ay24
	KE0UfywlRkaL1nLqZjVvDhZYEZjeVDAcARXtD9fCIJ3xtsyuFac0UwsAzqdAZiQSc6Pq6S
X-Received: by 2002:a05:620a:7081:b0:8f4:e8ce:8e3 with SMTP id af79cd13be357-911cf2fe11bmr1763234985a.41.1779030110182;
        Sun, 17 May 2026 08:01:50 -0700 (PDT)
Received: from fedora (pool-100-11-178-145.phlapa.fios.verizon.net. [100.11.178.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bd620fbcsm1223943685a.42.2026.05.17.08.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 08:01:49 -0700 (PDT)
From: Dave Carey <carvsdriver@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: hdegoede@redhat.com,
	pithenrich2d@googlemail.com,
	mpearson-lenovo@squebb.ca,
	derekjohn.clark@gmail.com,
	W_Armin@gmx.de,
	platform-driver-x86@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Carey <carvsdriver@gmail.com>
Subject: Re: [PATCH] platform/x86/lenovo: Add Yoga Book 9 keyboard dock detection driver
Date: Sun, 17 May 2026 11:01:42 -0400
Message-ID: <20260517150143.50058-1-carvsdriver@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <9459f535-d140-a431-3f76-a5d8623f3e2d@linux.intel.com>
References: <20260425132323.82809-1-carvsdriver@gmail.com> <9459f535-d140-a431-3f76-a5d8623f3e2d@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 28 Apr 2026 17:39:17 +0300, Ilpo Järvinen wrote:
> On Sat, 25 Apr 2026, Dave Carey wrote:

Thank you for the review. All points addressed in v2 below.

> Please put this in depth explanation in own paragraph.
> This seems mostly duplicate of what was said previously.
> These two can be combined with the in depth explanation paragraph.
> Please write this without bullet points.

Commit message rewritten as prose. The hardware description, WMI
mechanism, and BKBD encoding are now combined into a single explanatory
paragraph. The functional summary (what the driver does) follows in a
second paragraph without bullet points.

> I don't think the functional description on this level is warranted in
> the top comment.

Top-of-file block comment trimmed to hardware context only. The
functional description (query on probe, SW_TABLET_MODE mapping, sysfs
attribute) has been removed from there; the comment now covers only the
two WMI GUIDs and the BKBD encoding table, which are non-obvious from
the code alone.

> This interface has been deprecated.

Done. v2 uses wmidev_block_query() with two arguments, returning
union acpi_object * directly. This required registering both the event
and query GUIDs in the id_table with context pointers (enum
yb9_guid_type) so the query wdev is reachable from probe and the notify
path. The event-device probe defers with -EPROBE_DEFER until the query
device arrives.

> Please use __free() instead of duplicating kfree()s.
> When converting to __free(), don't use ... = NULL; pattern, instead place
> the variable declaration mid-function as instructed in cleanup.h.

Done. The obj declaration now uses __free(kfree) placed mid-function
after the early-exit checks, per the cleanup.h guidance. Added
linux/cleanup.h to the includes.

> Can this literal be named with a define? Should it use FIELD_GET()?
> (don't forget the header if you start to use FIELD_GET())

Done. BKBD_MASK is now GENMASK(1, 0) and both extraction sites use
FIELD_GET(BKBD_MASK, bkbd). Added linux/bitfield.h to the includes.

> Unnecessary cast. And your types are a major mess between int and
> unsigned types.

Fixed. The query function returns int throughout (0-2 on success,
-errno on error); the cast is gone. Local variables in yb9_kbdock_update
are consistently int.

> Please use reverse-xmas tree order.

Fixed in yb9_kbdock_update(): tablet_mode is now declared before bkbd.

> WARN_ON_ONCE() instead of just WARN_ON() in the sysfs show function.

Done.

> You didn't document unknown but return it (maybe it should return some
> -Exx code instead?).

The "unknown" fourth entry has been removed entirely. BKBD value 3 is
now caught in yb9_kbdock_query() and returned as -EINVAL so it never
reaches the sysfs show function or priv->bkbd. The show function uses
WARN_ON_ONCE(bkbd >= ARRAY_SIZE(names)) and returns -EINVAL as
suggested — this can only fire if there is a driver bug.

> Missing include.

Added linux/bitfield.h (FIELD_GET) and linux/cleanup.h (__free).

> Normally these [DMI table] appear towards the end of the file.

Moved to just before yb9_kbdock_probe().

> Put the last two lines to one line.

Done.

> I wonder if this is similar physically to what is being added here:
> https://lore.kernel.org/all/20260419102724.91451-1-pithenrich2d@gmail.com/
> If yes, we may have to take another look at how to create the interface
> for this.

Pit Henrich's patch targets the ThinkPad X1 Fold 16 Gen 1 — also a
Lenovo device with a magnetically-attached keyboard that docks to the
display and changes between tablet and laptop mode, so the concept is
physically similar.

However, the two drivers differ in several meaningful ways:

  * Different hardware families and kernel paths: the X1 Fold patch
    extends thinkpad_acpi using an ACPI method (\\_SB.DEVD.GDST) and
    the existing TP_HKEY_EV_TABLET_CHANGED hotkey path. The Yoga Book 9
    driver is a standalone WMI driver using two separate WMI GUIDs.

  * Different state cardinality: the X1 Fold has a binary
    keyboard_attached_on_screen attribute because the keyboard is either
    present or not. The Yoga Book 9 needs three states — detached,
    docked on the top half of the bottom screen, or docked on the bottom
    half — because the two docked positions select different screen
    layouts that userspace needs to distinguish. A binary attribute
    would lose that information.

  * SW_TABLET_MODE: both drivers emit SW_TABLET_MODE=1 when the
    keyboard is absent and SW_TABLET_MODE=0 when docked, consistent
    with existing drivers in this subsystem.

Given these differences the sysfs attribute semantics do not clash, but
if a preferred naming convention is being established for keyboard-dock
attributes across these devices I am happy to align with whatever is
decided for the X1 Fold patch.

Dave
