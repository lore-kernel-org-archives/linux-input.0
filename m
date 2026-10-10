Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8203430D3F4
	for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791654261; cv=none; b=jh52HpZoFbSLL7vR/Czob1owj3QRNwp/BjUX4Mby53AkBmtp3AdDoS3LRhLXCpiZTjIDWnmley4jQfqxmiE1qwiWkz1n1Vw0wSjeQivSATaU4Ezy325c4nM1b/GnLxJA90rxli6xTyheDUCjKtqkbFm2Umg5eb2MEgflJsDO6J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791654261; c=relaxed/simple;
	bh=kDjzN2rtxAiNCvVFbfiN0eN+2thfiFC0pn/TUwrUwrU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kvLQ+RfkjN1oINQVSnev6XkU4KUxeuD6rFnGN0Dt7X9RhST/3uaEBc8XZG2O7BHAskgYKuH2deAbW8nzClinpy4GR0aHKBJGscpM/ghRjoYlTATd9Fm2UEjNuNhz4weETfexrnSLTlRLDYYkimKjNqLL5QFyPCNjMdy7WrqFq0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=MroDw0ed; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="MroDw0ed"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93e7ad9f78dso94847285a.1
        for <linux-input@vger.kernel.org>; Sat, 10 Oct 2026 10:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1791654259; x=1792259059; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CHwKlOvXXIWvCNcLBoKdUP7mR1ynR1XdMkGxFBOX0VI=;
        b=MroDw0ed+Od6OqhiEc3RAmJBBrPGa5Zpx0I2C7qhm8dwbBslJxFsULjlrWr5uT5ynQ
         eslqOf7ub3Xjz3qOT0dqzxFQNxSNDGqJ3QA+Dhuhr8AvqAyaIL5AOIaExAAsPu9s8o8t
         Gkkdu5c8zpeSx9ZTT6sFch9QeI70IZ7RrYk71w8OD8xbY0WgJrX5KguKxML/ueIDvp4Q
         pKTGztRX8jsBqsTK0E2XhqsjGAMtA9K4rYA34SmRvrLBxowuK9DIIgGudiAe2vncQcX4
         qOOfnnBRsvAb2Y3om54qHK+omv49IAGF9pObz8dcKmO2nIerhQmuyMj8ys5YjceWSyXr
         AcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791654259; x=1792259059;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CHwKlOvXXIWvCNcLBoKdUP7mR1ynR1XdMkGxFBOX0VI=;
        b=f/nLL2cGAARYUBYBgYEit5qibbr/um6kS38duX5qpIkh9mHlGrEwdGu5jYrXod5FJH
         BKsRljsIJYDHzf1xaGYwVc2UnjKXcNjK+1GMCkPqcvh7kg8ujjAVb7phy8DLX46l4mMw
         G79hTiCjhb1HUTrD/wSFQkzXN3+/ZMJt9AARVZdBNKyZSl/sZLjpYsUT0gmKSoyJLUQF
         8+in7Xqib+qx93m8XKzfgqzYeP7+yFCHuO/b8jeCv1sb+Mp7kayoRQAAyTrn7iieqhVt
         rTlEzLl4kxtaoD7tYHWGTLoUIEeEB7L7D0HRoKNDN4+CXrBvcDJXj1hi1/Qe+yqaDHY3
         7WjQ==
X-Forwarded-Encrypted: i=1; AKwUvBxs7f1+o7FRvntiuhatMfN7qCLgrOUaUJ7KCpiRTvR5hph9SwAg1+m3WDz4L/fV8fC4QAoE0RGjYiFtrg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLIkFmWRi4++HW35YT38vi8H66ezJghYQc+NIFwsSyThFY/LE9L
	1VRZ2RN/Nad9jaVZ7KqPrNJrGBE0LHm77lMrR+FKQP4hslvrH/i8gB977qjffH88GA==
X-Gm-Gg: AYBFou0M9hFut2lNQM1av8vWFAv4+NZlLZz7qZPNmSSKyxRCrlvOS4WBD0J8su6ZWfP
	a8i4P/bNYd1MhDMEdg5fqDWN3ubaQJu1T6dkPbzAJA4cX/YC6xhgi4MM2MNH51b5s/Obm/osbua
	tg9mo5Bjph6uAHdqwNbwiaadKb/QgUKV0rgrtkQ5vCbVkQJgO2fswS9mY5tjXAgc5LXfbf+XqHp
	qvMKCOuPVrM9GSuHECbgUupzr2/6N0BdD2n9Thi4UT7lJB047I7S6PqTMsX2YK7QaomnjBwYMYd
	SSrNIS++e+CzgjGGzjrQaSzPYHSdNwsqEVPaJh884mylN0oA5En0UTV5SUa2/+mLUOUkJ+TDhn9
	XT1rjEDzBCCJDlTPDnczjGh342SI6jRyEjcgs8bj+uyHhVCjGLX5It/LFTrrt2wKeoouQleyVTU
	DnHW8hJ8xGSmHRkECc+ZZVaAyIOkb2HSX7mViA7nYOejusW0h5i5hlPiDJKGk+zqW8FRquT0M=
X-Received: by 2002:a05:620a:394d:b0:93c:c4da:f46c with SMTP id af79cd13be357-93ebd27e0a0mr859848785a.56.1791654259287;
        Sat, 10 Oct 2026 10:44:19 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::1b7d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb98c818esm471726285a.36.2026.10.10.10.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 10:44:18 -0700 (PDT)
Date: Sat, 10 Oct 2026 13:44:15 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org,
	USB mailing list <linux-usb@vger.kernel.org>,
	syzbot <syzbot+25a1d2907885b2182275@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] HID: core: Fix out-of-bounds left shift by 32 in s32ton()
Message-ID: <dfa0aa1c-e55e-4316-8307-f72a07383634@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Syzbot reported an out-of-bounds shift (32-bit integer shifted left by
32) in the s32ton() routine in the HID core.  This routine converts a
signed 32-bit integer to a signed n-bit integer, and it caps the value
of n at 32.  But when n == 32 there's no need to do anything; it can
simply return the input value.  This will avoid calculating (1 << n)
when n is 32, which was the cause of the invalid shift.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Fixes: 69c02ffde6ed ("HID: core: clamp report_size in s32ton() to avoid undefined shift")
Reported-by: syzbot+25a1d2907885b2182275@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-usb/6ac9cbd8.a150a118.27e199.0025.GAE@google.com/
Tested-by: syzbot+25a1d2907885b2182275@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org

---

 drivers/hid/hid-core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: usb-devel/drivers/hid/hid-core.c
===================================================================
--- usb-devel.orig/drivers/hid/hid-core.c
+++ usb-devel/drivers/hid/hid-core.c
@@ -71,8 +71,8 @@ static u32 s32ton(__s32 value, unsigned
 	if (!value || !n)
 		return 0;
 
-	if (n > 32)
-		n = 32;
+	if (n >= 32)
+		return (u32) value;
 
 	a = value >> (n - 1);
 	if (a && a != -1)
