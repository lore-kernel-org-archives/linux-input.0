Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.60.160
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792647618;
	b=ElYiZv04riNIpV7SxpTN6mBTPkGSxMnPa4nXhsgWmowWPMK9mmTjGe45KlI0LjU1yOk3
	 dNHIcd1YIftSD5S0YVTEQ9E9bsZeemeqzMS+MJRpImLWUKPhPX5SycNAYjSUjgWOegDep
	 TlnptLY1tFV2WWcX6ZxWC166vt1EkSkZ3jV6eYcJxhX4viJMaxthZeIEzdL2ahZi9wkyo
	 HfZudOI2QkuuZSptPusLXwF5mirPGgvutp7ZP4oUX/G7kKQ1Qw6ZhWvX2avHD9Qjq8Ecx
	 7zVNL/ir4n7xU3TJQjoyYm5yfhpUz0tkjASEK/XPxD/m9W328jvhobMdkrgeq5e8Y6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792647618;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=E3EtUTJnA1yBH8Az0JFVRlvEZI46XGk+9TbZBQFWeW0=;
	b=jP7l5poFCvg+QZH/QFAc1AIRTtWOhmxHIcjhMRP6wNoiDgeVr7RUj4omVWzSFO/xJ6oc
	 dHJeRgn7d/CCBu4VGt5Ynbk6rVcwyJtu7v/9M6iqgFh6lmSRoAg/rfkOYXV8d2N3gb9zx
	 nqAL2Thtv5pV8VDVKo7ev5Y4SaCg6ootYxTy344cSAdIDqS7LTEtave80+U1OobordoxF
	 iq19ap0/zXjrw8XbVWUyxlcTZrgWWDrfcvxzNvo9KyoaL8FeNVlfS4FgOEFsPRsm3ZeoR
	 zUE4G8ldNcHynTQjAGiKcnWge53sW/HKgLhucteUCi1A86C2OXL/rDvtC/dJxfy6g2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=h4N0AJpb;
	arc=none smtp.remote-ip=51.250.60.160
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [51.250.60.160])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BBC606A319
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 05:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10BBC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=h4N0AJpb
Received: from mail-nwsmtp-smtp-production-main-80.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-80.yp-c.yandex.net)
	by forward100d.mail.yandex.net (postfix) with ESMTPS id 8D7EFC7CC5;
	Thu, 22 Oct 2026 08:40:07 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80 with ESMTPSA id 5eUKk1BdFCg0-OsQjV4OU;
	Thu, 22 Oct 2026 08:40:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1792647607; bh=E3EtUTJnA1yBH8Az0JFVRlvEZI46XGk+9TbZBQFWeW0=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=h4N0AJpbqNnWwith1+4Tj0hlbMfcc6YIczGNdotlNy7PPcR5VVyS7zMQpFmN3pvCX
	 06vSAsm+Y5wXpq3wpULhdZ1afxUoTEtqSbQFCmpDmbz8wGfs7JK04pZjwubvt/L96j
	 fD3Z2kTWAUslgMrXmZoPigWQhXT+7oYlyHVxXy9U=
Authentication-Results: mail-nwsmtp-smtp-production-main-80; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v8 0/3] Last remaining Roccat HID fixes
Date: Thu, 22 Oct 2026 08:39:57 +0300
Message-ID: <20261022054000.227833-1-dmantipov@yandex.ru>
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

 drivers/hid/hid-roccat.c | 59 +++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 19 deletions(-)

-- 
2.56.0

