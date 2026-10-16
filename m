Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [51.250.60.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CC91C5499
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.60.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792150422; cv=none; b=Y1KqfClTURkcjPILjxXrGbLfdxnGW7sUiBmFv2/E6UMo2Eye2qUrKUcYmM4nwKGlkl5uatv7nqCyM7wgMP6hRrb/1jZZhUacLt+I9Xj1h8br4y8QxPSkj5gYdKYhhmGkt95YQtxxTGJfg22Y41/mUHmi2uRoItpwaMrkMwiHE84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792150422; c=relaxed/simple;
	bh=VdUfBub32ma4O2SGvg1DYckvYf+V3+RzCe5pZoUpLQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+UxlkQ4DZ5B1HtMZ7vNhlCOSU0JVdIoAwDAQ1kEBwKlm90kW/+sLIfUW4dT1UkltHtQwdz3R6rVYB/9YoddTNMIkHPoEWn4Sj/tQHZzBiYwAF0++VgosYutM1dvGwlgluPUFUtrT4ib+Uf768wNf8kJAtApnq0dW1TCrmZCsxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=bLbzgx/7; arc=none smtp.client-ip=51.250.60.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="bLbzgx/7"
Received: from mail-nwsmtp-smtp-production-main-84.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.yp-c.yandex.net)
	by forward101d.mail.yandex.net (postfix) with ESMTPS id 8C077C00BF;
	Fri, 16 Oct 2026 14:33:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net (smtp) with ESMTPSA id QXUF1q7enuQ0-snwT2kd8;
	Fri, 16 Oct 2026 14:33:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1792150407; bh=4bR+eDjnTGjUm8RVsOecsO7p6hk8hjnvEZ1AfJdF1fk=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=bLbzgx/7heRgO2JPIaeRxdyoy4S77i/oU3AutDYDDkhmlzd73gGo38jMfxdS4wZW2
	 t9i6awgVal3EN3kaDVnJvaq0XRMQ6JKtqNTI7LHTM+oZsRay/CDnQjMme9w3NgVUaV
	 2ZlB0zGu7Ln0KGToDPNkDJ4o7aHkhWX7Mimd1/Tg=
Authentication-Results: mail-nwsmtp-smtp-production-main-84; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v6 0/2] Last remaining Roccat HID fixes
Date: Fri, 16 Oct 2026 14:33:19 +0300
Message-ID: <20261016113321.892452-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <atECwbWrAQFpbELS@beelink>
References: <atECwbWrAQFpbELS@beelink>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjusted to and basically tested with for-7.4/roccat branch of
https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git;
https://syzkaller.appspot.com/bug?extid=d632e93ffcd1452bc61e and
https://syzkaller.appspot.com/bug?extid=c492a9e154f81127551f looks
passed as well.

I'm still thinking that roccat_device_available() is worth trying.
Anyway, let's make Sashiko to do one more round. In particular,

device_destroy(device->dev->class, MKDEV(roccat_major, minor));
WRITE_ONCE(device->dev, NULL);

was wrong because it opens tiny race window when the destroying
device may be examined with device_is_registered() called from
roccat_device_available(). This is expected to be fixed with:

struct device *dev = xchg(&device->dev, NULL);
device_destroy(dev->class, MKDEV(roccat_major, minor));

Dmitry Antipov (2):
  HID: roccat: use device_is_registered() to check whether device is available
  HID: roccat: use kref to manage device instances

 drivers/hid/hid-roccat.c | 49 +++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 16 deletions(-)

-- 
2.56.0

