Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D0C3C0625
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053068; cv=none; b=LOTgQdlXoY0EIgrJdhwWQ+PfT7H10TTiPY3wPI+2IeC9YZTSJ2Uh8xhM1UsNVvJfI1H73m3yyTuhx8krHlmGwnKz/PHugazlOGWtmhy+FaCIW7L5N1mRyK6YiPxxEnQFXaIAuE+HJNsxj0Op/TsuJJArCLg+561NUC+/6FLWh8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053068; c=relaxed/simple;
	bh=0IwZ3Y1WwFrucPlKuvYGPUYBTW50SSA6+yQ0+IBChx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nuOeUTbFwlM1Ko7ufZZJhQDvhcLnAZhgYJXnzhL4avBhDPrzgQ5aQsSwvbk0QmnMtzfYsKu94eVjOiCYe3wfYIjRbvIdsr7YOiJjujlPGzwu/DR48F89Ff7PjzkGwbdkhesHFpjffMBk35KmnpUuOExC0soNmPuxF5qcPsyBg0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=antnArkB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="antnArkB"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49b96837ca3so55718035e9.3
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 08:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789053062; x=1789657862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yv1xn+5CR2S+k3dv2u6er/HbqF0X0NfGBoB7jTRkQS0=;
        b=antnArkBErCt9ftbNXqRR9h0AOZZWlC0gllMd5qla+UPjSkh14wbO4tLvFbN8uVh2Z
         Iso2NPvG0ewT1p5uoJXRikyBLg+3MgpLmagfaq0mBK7jIWipx3Uj6vGFAA4xGnSpYR0C
         /bDrefOAI3IOqecKzkURHCZMswmwRfJp7ErrqsOhXLRAlA8LxdXA71B/e28tNgxlQDPC
         sFYczMVLiX1WVSclGWQI/KGncipT/IENHSEKFCnbSdRKqsK+du7Ho2rzhmoq9XhygE5k
         VZlhiWxLOGyYduk1f6BWVqz2wM3yiaonYuH2panANQBpvU7GmWvWXdr+V50JhucgraIN
         7X0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789053062; x=1789657862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yv1xn+5CR2S+k3dv2u6er/HbqF0X0NfGBoB7jTRkQS0=;
        b=jAkWMch6es2swav1W6Xd+Lxo97KCquizC/WcRVtt31Ls/a1KhPK6Y0CE/hJMCtdsL3
         8CBUIZCBO9eVWHrTw4l5jdMusTK1/Xoik07YdT+QMlfILGWhTC+5g8oXjyCheFGGvHNm
         TKh+Sd4WAB7WSRd4V5FB1sGJYL1X0Qd/cnd4TnDrDzUoAMevEnGeahhqxmYr4oH+Fm9T
         EwttWb5WMRse1kSaEpsrbiS+7Jl/wU7LDZ9i0HBs+hl9gxwiB6Fbh2kV9eD5UU10ruYb
         mQ7+1o2Bb5Mndr2eMim5XH3rlAXsvzcHJz9363DPeCtP47dA6Kbyt7Kx5EF2OpUbc6Pz
         nlog==
X-Gm-Message-State: AFuF++lYT2JS6MFD6I0b5o9Qj5nbxjsvXKmIhmxXLRBvu6uMfRu4Uf4g
	H82VWXQ23ylykztcYv+x0MBWKfqRMv4C8LgJ/BwZWR5D6trSCi19fwSy
X-Gm-Gg: AYBFou3GHcIbJ2w8Eh4+qZaQzpFwMrQ5gjYcCo19DMskOjPL6/rjTlHVAXo9+spwixf
	VpljqUidpUjTPuZL3nOHeQI8CA+JdnIKhYIAvxpwB57sg218n7tPLFWwB+AAQxSKpmzVkB5arKJ
	wP41oTTo8+/emN1wCmw/mF+O1qVoNJx3434pOjhhvPG2WGD5VD2xjjnssCCvzSyASNsWM0mro89
	tOaZjfs8Mn/HdD5z41hRjky+xHtbM+e+c2zOx0GxgC4fOHcA3sGzGHiC1LmVKL8V8XBDkibdWFg
	bidL8xZn7TFJbG9VnI5ZksOZFWGJU6q2hCvRJk0rmw/TmCUCbLDiq3STXFKl6UfegjwkND+/oob
	/0sdw+hdcAk+U1tsgrapAai7HEw1wPKx7Ss3m4eoBXkq0AJCXgTrgQQUJzfp0W/a6Ys7kBAb6mq
	UlPH5kPLKAk/7r0MKOtR2Zd+aHgXsRvYvUs+D2Tx4GyVbWWtibdG7DEGZH3/oMvjtr7k+zQNfsR
	bp9NMPwFux8rvP4+hQwMELOjz1vrSuj2ELbjr0=
X-Received: by 2002:a05:600c:474a:b0:49c:e42b:a4ac with SMTP id 5b1f17b1804b1-49cf823f60amr379250595e9.11.1789053061780;
        Thu, 10 Sep 2026 08:11:01 -0700 (PDT)
Received: from localhost.localdomain (mob-31-26-70-91.net.vodafone.it. [31.26.70.91])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49d1fd532dcsm123568545e9.1.2026.09.10.08.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 08:11:01 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Bernhard Seibold <mail@bernhard-seibold.de>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] HID: lenovo: two ordering fixes in remove() and tpkbd probe
Date: Thu, 10 Sep 2026 17:10:49 +0200
Message-ID: <20260910151051.12975-1-okerixx@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two long-standing ordering bugs in hid-lenovo, both pointed out by the
Sashiko review of an unrelated patch of mine [1].  Neither is specific to
any recent change; the first dates from 2020, the second from the original
2012 trackpoint keyboard driver.

Patch 1: lenovo_remove() cancels the tablet keyboards' fn_lock_sync_work
while the hardware is still delivering the events that re-queue it, so a
key press in that window leaves the work pending across the devres free
of its data.  Stop the hardware before the per-model teardown.

Patch 2: lenovo_probe_tpkbd() exposes sysfs attributes before allocating
the drvdata they dereference.  Allocate first.

Compile-tested only: I have neither a ThinkPad 10 Ultrabook Keyboard nor a
ThinkPad USB Keyboard with TrackPoint.  Both changes are pure reorderings
of existing calls.

[1] https://lore.kernel.org/all/20260910064345.9BF1E1F000FF@smtp.kernel.org/

Oleg Keri (2):
  HID: lenovo: stop the hardware before the per-model teardown
  HID: lenovo: allocate the trackpoint drvdata before exposing its sysfs
    attributes

 drivers/hid/hid-lenovo.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

-- 
2.55.0


base-commit: df2908090cda368b01ff43709f51890076c56157
