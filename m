Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=93.77.172.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428787;
	b=nqU1OJWDnfMqB41o9jZZGZdc4kYPBgd9irThp1AVqWVn1ky/sMBKhzBIucvqs9Ssmq0f
	 uRmOOLGpPZKJU+kiqlYUX/dW6xBc5vmwMl61ebwrDh/LErWM0lbZFi7aqYg4tQW+lIgq2
	 PlJrVzhcKdGw9Y5VBL7PA9KcrH7yduHTrmGTDuAJlSuSsuA+XWIse19lQ+xq+UF/HM+eo
	 HWBooLkHYCkL4T4SeHxTKe/mH5fxRT+n3KBItQWvMjyPyDQiDoG+dX+SRM9cCa40Yt6Do
	 qr/VykUq1hSpsi3w4f5MhkIB2MK4renllaEf/seEo33VIRMLt7g9UOO20TjYshzQM8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428787;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NUoSWVr51yiyfr1cXxduWw1q0pMZf0It1N6bFzoXjWs=;
	b=zwrBWvWolpi8NMBM6ZxpjfLufgfTFSQad9x4yluh1+6wd11RL7PTe8TAQPX361DbVFP2
	 z/3yR7BUwJ2PL2wCMQ8lHAHFC2/3y0L+RkRj0y1xjYSQ8Ijz8CXKjz7GIdf3wfMoV0roc
	 4P1q5OqW1KjwgVxwReTIlWyXO2TUe79wa8DtT//6ODw4X01TKgmvKzTs+/mEYcm0NiG0N
	 BALIMttdGxTAKKcBtDvIDEqmIAIfpH/pO28ULvFgowkcg+hJ4hBlCqMgM0POuONZYT9Kc
	 iom5mS3jTCgWz2XMTW5iKWwoWVekFwYDrCeXnsLaX1xiPWbFFHE3UOGkiDR8aYEfnZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=rklCMsNP;
	arc=none smtp.remote-ip=93.77.172.64
Received: from forward100e.mail.yandex.net (forward100e.mail.yandex.net [93.77.172.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474B5606A31A
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 16:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 474B5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=rklCMsNP
Received: from mail-nwsmtp-smtp-production-main-65.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-65.yp-c.yandex.net)
	by forward100e.mail.yandex.net (postfix) with ESMTPS id C031BC1FD0;
	Mon, 19 Oct 2026 19:52:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-65 with ESMTPSA id qqcpN4YihSw0-RGLt41hn;
	Mon, 19 Oct 2026 19:52:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1792428773; bh=NUoSWVr51yiyfr1cXxduWw1q0pMZf0It1N6bFzoXjWs=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=rklCMsNP1FnhmRXxJS1nrCvbWUjzDeIxwZOMNuzCcAtylK/qycKwt/XKtTUMwShOO
	 98aeHjVzmMuAySh5kEEKeAy6Md/opUHMaC0Meo4jt1h7Vq9I+ytw/0POuidA8bEyhb
	 fOutZR/s0vwz50jrDDchvxnn0rcZ1GoelDbOjQdU=
Authentication-Results: mail-nwsmtp-smtp-production-main-65; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v7 0/3] Last remaining Roccat HID fixes
Date: Mon, 19 Oct 2026 19:52:48 +0300
Message-ID: <20261019165251.280027-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.0
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

Since Sashiko is strongly concerned about possible races, here is
a bit more conservative approach plus one more fix for possible
roccat_poll() race against roccat_read() and roccat_report_event().

Dmitry Antipov (3):
  HID: roccat: use atomic_t for device status flag
  HID: roccat: use kref to manage device instances
  HID: roccat: avoid unlocked report buffer access in roccat_poll()

 drivers/hid/hid-roccat.c | 61 +++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 20 deletions(-)

-- 
2.56.0

