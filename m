Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5D4560ADD
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790098841; cv=none; b=Mx3MzpT0JdzJ8kitS513bgulEednIi2AcMbm++DdVb6oYLQUUWgK1Sv2in0+ezslV/nfanaHiKUfDb6jyIayGXLDz8At1FrDm3qOiOYFpVVRnloeOMzE/YvEVTZXN+OgDUMsjhsmB0KNnkxcol1EeGOtYgFzsGKakXvpExC/Cww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790098841; c=relaxed/simple;
	bh=Tx1KkmYROfO1CWYQM4qI1q9ERT+FuFqrDr4AZWkTke8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jVD+ipLaKSzbDLKG/X7/CRldDCkkr70cyjSSl0+1Y9pCwMOZSM2ziz57DBiyWt1MptqZfLw89bKASKNqzYY/fXJrDzKbyc6mHtnA3L0G0irA1/zCZQiQQmkkCIdMdoXV9Uq19X6TqB7iuVT43r7bmyDJP1nwD2HkAHLTA5ao7s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gg748eu+; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gg748eu+"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f6c7a4aso9641166b.0
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 10:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790098838; x=1790703638; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ul8tZc9iDWhIoFNaZcbsvWj/hjI6Qk9FNQQIlypmcs4=;
        b=Gg748eu+r6u0mH1/UftyJI9i6hpUdNsQWm5YfxPlenTMa9EAHUFdzTZIQhBFfwNQ25
         TGEkkbMfdi+MMhDUNsikxXohrr3RJSakEkYYC5qyZqoUaRTAU763pbR/Zsgwyj38vaNo
         qoomOQBQSej3RhsagH9xO0FIncqD+WW7xwTBu5/XJyjkC5q5ieJa9s2KAa318CsF3pAC
         nUq8SOFKykQyPtYUd3cyFzvIP9kbaBLFiflBe5d8/PimQ/TVy7Lpj+ncm1J6Bdt9oEjX
         S41Ro+EXw4nHC0lIMGTnXR6e7aqVX2rfDYL26/xaN3hyDdeLpp9ozFa8hAKrSyHyTm5y
         XWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790098838; x=1790703638;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ul8tZc9iDWhIoFNaZcbsvWj/hjI6Qk9FNQQIlypmcs4=;
        b=DQ4iuIMmzx5YA+yAhXGTPFJKMeDm6dX1EgByPT5D38+eagZU3+rC7vB+qFWR0Md3Iy
         +IwMcXc/gJcuw+CSR83p1FaVPMPxl7hqbH3HgZheSaQRWUdJnn2qn6arKrJ/aJ0xxHxd
         rmvroGE1ItmEMMwvoY9jOaXbRLi8lDglteBYbezt5MRNirKZhmjJt+UCCh906XxDQr56
         ZqyZftG/zfLbOv7VqS1qL3WWaGQCy4kKc7y4DknsD9cLF7p0w0VbM6oJFKEdh9ZH5qvv
         1Hcc1SMNi9Q6YRlemh3r2TGzeLd2mq1u1FxkatXbwccGgVS6M4bYpLg0rXSMLxgDR/8U
         jOXA==
X-Forwarded-Encrypted: i=1; AKwUvByFdnIqfbEqT0NyaketJHGX4ErBpDATjOrOkSUPuhJ+3mzfIVaR3WozKNxNmQB3x1vliuy8fo+K5YvOxw==@vger.kernel.org
X-Gm-Message-State: AFuF++nmBWuaCuz1bX4BKjf1n3FMw8UaElWu3AN18ROTfkTD/wMGJCQp
	lBA3Wpv40aUp3B7WSjnzCn46mcA2F2D2tP91eVKs2+z+x7NNwfIaqF8f
X-Gm-Gg: AYBFou2kdUvY6Xww/Ptp3G0I1uzWu8FnW1vORAi0/6bIqczA4vh7XGXWZMIxXJ77d8t
	KOCOjRdymxjqvzPPlkDhT4lNOyWIRHZOUlrCaEpEfSBTT4gNfPj/2jtCgjMncRkHn1AWxMW+lxF
	XKpICwRjWm9iTZu5ktyi+Z62XybwY6vn5uYOQcc9isJ2CqGqXKaF7TN8ZRZn5VNxVgIW4o59ARb
	WnR77tk8/9wYV6nVoaAdyxXHmiKz8SPM2Z1KhwXGkI0vwNVpUAwO3bExC5LNjmQ3PUVYBgDP3SG
	sKmi/3HiKwJnJ6SSAJNo5LNrixPpxx4QqoxMh7MNJ2n23sV9wxoS8yUiOOvp37Hg+vMfgX4uPu+
	O4Hq+vTusHjsH/Ge9/VyWsorQxDG43Ol31Kmp4SJWObMK3Wk8XiFIU5eD0AAAmPs0TNL4x7Mzet
	JFGDzT0qiVPoi41+5cycAxdmZHZ1FRUwLMsBQB+/LfVxwDcqwXvMr2iydI/m3WNaiYgFPmOuJ3Y
	m6J1jEZLAiYva8vlbIfqSty8LrgjlGUb+7f+XKysOxWzAL5v0TxcPA=
X-Received: by 2002:a17:907:3e02:b0:c26:1649:47ad with SMTP id a640c23a62f3a-c2a15b4bcdamr1171911966b.35.1790098838000;
        Tue, 22 Sep 2026 10:40:38 -0700 (PDT)
Received: from [192.168.86.89] (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aad5bed0asm2549666b.18.2026.09.22.10.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:40:33 -0700 (PDT)
From: =?utf-8?q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
Subject: [PATCH 0/2] HID: logitech-hidpp: fix Bolt hi-res wheel handling
Date: Tue, 22 Sep 2026 19:40:26 +0200
Message-Id: <20260922-feature-bolt-fix-v1-0-63b0fa8da0d3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAMAzAviI9W3BlDvQr4mFqqwVR2aYI4t8dH
 hNIHogclCO0xQOBL426bxlMWcC4+G1m1CkzUEWuasigsE9nYBz2NaHojbUYcZZs4yaBnB2Bs/6
 XXf++H5bqFPtiAAAA
X-Change-ID: 20260921-feature-bolt-fix-5f1f642496df
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Rafael Passos <rafael@rcpassos.me>, 
 =?utf-8?q?Gr=C3=A9goire_Stein?= <greyxor@protonmail.com>, 
 Alexey Zagorodnikov <xglooom@gmail.com>, 
 Oleksandr Natalenko <oleksandr@natalenko.name>, 
 Roman Stingler <roman.stingler@gmail.com>, 
 Lovekesh Solanki <lovekeshsolanki00@gmail.com>, 
 =?utf-8?q?Kate=C5=99ina_Medv=C4=9Bdov=C3=A1?= <k8ie@mcld.eu>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790098832; l=4338;
 i=erikhakan@gmail.com; s=20260922; h=from:subject:message-id;
 bh=Tx1KkmYROfO1CWYQM4qI1q9ERT+FuFqrDr4AZWkTke8=;
 b=Z6IQPsKCiRhe4UwSYY74dgTL0TJrDDYDgh0fZq5wwNtdk3fvcrezRtAM7jOdBduOCLRhK7det
 pt5odG8kOB9Cs3PxJKRu4sxmcR/FgmSccyCOPYQJHVhTZpbv4pZqgbP
X-Developer-Key: i=erikhakan@gmail.com; a=ed25519;
 pk=brCZX79/H6Z7mPgiNX6TDY45ZjODPth0eXRDUgh1mNI=

This series aims to fix high-resolution wheel handling for Logitech devices
connected through Bolt receivers as well as respect user settings for
scroll behaviour.

Patch 1 is Rafael Passos’s original implementation:

https://lore.kernel.org/linux-input/20260904034843.1340846-1-rafael@rcpassos.me/

His patch routes Bolt wheel movement through the HID++ child, where the
device’s HiRes Wheel multiplier can be applied. Patch 2 builds on
Rafael’s work by 1. supporting both high-resolution and low-resolution
scroll events, and 2. preserving user-selected high-resolution and
inversion settings.

The follow-up patch was developed with reference to the patches and
reported behavior in Magnetar-OS’s `logitech-bolt-hidpp-dkms` repository:

https://github.com/Magnetar-OS/logitech-bolt-hidpp-dkms/tree/main/patches

So my assumption right now is that the reason for the divergent results
people have had with the two different fix approaches (i.e. either passing
interface 0 and 1 as DJ interfaces, or Rafael's approach), where it works
for some, and only sometimes, etc. is that with user settings coming from
Solaar, we may end up in weird states.
For example, in the original patch, high-resolution events would go through
the generic HID which would treat each tick as a full wheel event, thus 
scaling the scroll way too far. That was solved with Rafael's patch but
that would instead fail to handle low-resolution events if high resolution
was turned off in Solaar while use_hidpp remained enabled, so a low-resolution
delta would be treated as high-resolution, which would result instead in a 
too slow scroll. Possibly, when Oleksandr switched devices, Solaar reapplied
some saved user settings, which conflicted with the driver logic.

With this patch, user settings from Solaar (or elsewhere) for high-resolution
mode and scroll inversion will be respected, 
and scrolling should work both in high-resolution and low-resolution mode.
However, if user-space turns off the use_hidpp setting while high_resolution
remains on, this will route high-resolution scroll events to generic HID.
Thus, when high_resolution is on for a Bolt device, the driver will
force use_hidpp to be on during initialisation or reinitialisation, because
otherwise the scaling issue will return.
Solaar may still, after driver initialisation, reapply a saved use_hidpp
setting of off while high_resolution remains on, or the user may change it
to off, which will cause the issue even with this patch.

In theory, it should be possible to look at incoming setWheelMode responses
or notifications and, just like on initialisation, enforce use_hidpp as long
as high_resolution is set on a Bolt device. However, I don't know how Solaar
will behave then. There's a risk it will trigger a back-and-forth if Solaar
reapplies its saved setting after the kernel corrects it. Also, even if that
doesn't happen, we should respect user choice even for use_hidpp. Perhaps
the Solaar team can be informed about the problem so they can add a warning
text.

Note that I don't have a Bolt mouse to test this with, and my theory is 
mostly inferred, so I would appreciate very much if people with various
Bolt mice could test it out. Also great if you try different settings in 
Solaar, but note that use_hidpp must be on if high_resolution is on, so 
either set it to on in Solaar, or to ignore.

Link: https://lore.kernel.org/linux-input/20260712003051.338194-2-erikhakan@gmail.com/
Link: https://lore.kernel.org/linux-input/20260901-bolt-scroll-fix-v1-1-58bca7ae487f@protonmail.com/
Link: https://lore.kernel.org/linux-input/LYMlyJcyQt29e1KlLnEoLw@natalenko.name/
Link: https://lore.kernel.org/linux-input/20260920094508.39682-1-roman.stingler@gmail.com/
Signed-off-by: Erik Håkansson <erikhakan@gmail.com>
---
Erik Håkansson (1):
      HID: logitech-hidpp: fix Bolt wheel mode handling

Rafael Passos (1):
      HID: logitech-hidpp: fix hi-res scroll for Bolt-connected MX Master

 drivers/hid/hid-logitech-hidpp.c | 147 ++++++++++++++++++++++++++++++++-------
 1 file changed, 123 insertions(+), 24 deletions(-)
---
base-commit: 022eb347ff3a48281e7e69c3addcb11bf24afa53
change-id: 20260921-feature-bolt-fix-5f1f642496df

Best regards,
-- 
Erik Håkansson <erikhakan@gmail.com>

