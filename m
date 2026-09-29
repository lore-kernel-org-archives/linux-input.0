Received: from forward203d.mail.yandex.net (forward203d.mail.yandex.net [178.154.239.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0033138AC7C
	for <linux-input@vger.kernel.org>; Tue, 29 Sep 2026 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665577; cv=none; b=n58H2NE+yhdP5GfGpOu+L4mVXU4kJZjgsb4SMKpLMpOcOYi0m7jPoSRAeXnQeKZ7JDzFjKNeLDt4Mvz/kRSOYbBTIVYjBQ9vTfsvnqr7BloQOsSoVZvSpidmPX4nj1L1qDhFQgJOKyNYlYFCD6GDKQZz8en1jbe+hvzG1HTvbN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665577; c=relaxed/simple;
	bh=62AHRfZB+4rNQ7uiOP0imC5A07LSqtHp0bZaF68hgeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rmtNWJ+94t17GITGGlhgbMXi51qssa4T3WBXezCn1aabttzCWHPWpK11PLjnVS/qDnHFy0yhnC1nzoMddJt9ICEPqax9QSmFkUJLRe9XPUNuHvG7nSUgM+Kuzd5MYPXhiAszZTYqMT1CUiWruh8JH/JsKs8NIzo1GCHBkubhw3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ZkfW2tdG; arc=none smtp.client-ip=178.154.239.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ZkfW2tdG"
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
	by forward203d.mail.yandex.net (postfix) with ESMTPS id F0CEA821C8
	for <linux-input@vger.kernel.org>; Tue, 29 Sep 2026 09:58:16 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:1698:0:640:befc:0])
	by forward101d.mail.yandex.net (postfix) with ESMTPS id 5CAEEC00D6;
	Tue, 29 Sep 2026 09:58:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net (smtp) with ESMTPSA id 7wbmo4vdoeA0-eByusMaH;
	Tue, 29 Sep 2026 09:58:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1790665088; bh=QC4EcrprFLUzKXaODhBWWHwWstPbCCQwKRfafqQnupI=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=ZkfW2tdGBG1nT2jwfQOCM2cze0KtPJrIxA1ZkeDypDECFrgfZC/Z68bVuc/V5OZL1
	 RetsROP51dmRn/3kMelBhhWf5r/+F4226SxLcQ33bG+7vSerzWpXrtFqS4m/18MY8I
	 P5YOVbsx0u2iiMDgdKG7/sRblZN/gCkoGgsOQswE=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v5 0/3] Latest Roccat HID fixes
Date: Tue, 29 Sep 2026 09:57:40 +0300
Message-ID: <20260929065743.134635-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now d76994443eed ("HID: roccat: fix locking in roccat_connect() and
roccat_disconnect()") is landed, and these ones are expected to fix
https://syzkaller.appspot.com/bug?extid=d632e93ffcd1452bc61e and
https://syzkaller.appspot.com/bug?extid=c492a9e154f81127551f.

Dmitry Antipov (3):
  HID: roccat: use device_is_registered() to check whether device is available
  HID: roccat: fix device access in roccat_release()
  HID: roccat: use kref to manage device instances

 drivers/hid/hid-roccat.c | 63 +++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 26 deletions(-)

-- 
2.55.0

