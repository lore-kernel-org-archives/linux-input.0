Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.60.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792647906;
	b=q5b6cPaHJ4oLtBS6gDE+ibMBuur8gC8sv/Lkh0eKpeTmGWT23yMjal+g9qriQ29EgY6I
	 tBClAJz4CtgCkf3SpLwRgjhUJFNGc7fkdFp+ZkeSGC8gspPSOZVEOURSSAJjGbKKE+D2j
	 sEgwVaWw74EoZQGzEjVsUaYHb/O0k7GNu0/VBjU4rwtMpGUpXjizrPFtlGA9SjDfypeHG
	 IhS0+yQyHoGx+z6pzvSm0GYiQwmUKuz/0eHquSd9Byrj4MV/U7/Xzmll8NUQblOPd4+B4
	 VfVSUCmab74FEVPCw2intrK/+wVQFRQlAn0kpPdEo+96StMRsU3Cu6z6pOjouypV1tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792647906;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=E3EtUTJnA1yBH8Az0JFVRlvEZI46XGk+9TbZBQFWeW0=;
	b=eYa/PdTVs0pAIi1PSzF9jAa1SLaVFDFmtIy4W/prl3UCqsrU8HZAlbBlolZfadyERB6f
	 714w3rXl0xUZUElx4Ja6Bg/CYsNb4MrXKMXgr7iM1NATPzL+h5316dzrLbCIcwqaIp22N
	 e1BdywG0FuIqWR8xwUHhg8iALag1iu9mZMef0jEQHfPTA9L3a5p7FgBVUZFNV8W3ux/3z
	 9tvCf63p+z4XhEznBZdl1p+VOF2N9i+KZbQk7JZgugyTPQ9E7Io/fc6j8jWyYqcBr7EWG
	 3Ic6DIiHb0cHcjBWE570qolCNlRKaLj8PDF2slvpbeaG3jxmIX+BPI1mDMv2QN/nQqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=CXiaJ2+3;
	arc=none smtp.remote-ip=51.250.60.165
Received: from forward105d.mail.yandex.net (forward105d.mail.yandex.net [51.250.60.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D603606A31D
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 05:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D603606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=CXiaJ2+3
Received: from mail-nwsmtp-smtp-production-main-57.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.yp-c.yandex.net)
	by forward105d.mail.yandex.net (postfix) with ESMTPS id 31F3E100050;
	Thu, 22 Oct 2026 08:44:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57 with ESMTPSA id tiUiduAiC4Y0-P5xFunqH;
	Thu, 22 Oct 2026 08:44:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1792647896; bh=E3EtUTJnA1yBH8Az0JFVRlvEZI46XGk+9TbZBQFWeW0=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=CXiaJ2+3LKXNO783kQg/g8b4o3wiWGzEiJWVEd7UBDzLSBHHtkTuaVEvCWq5Puv1K
	 2UNuS2EdSv8D3RqkpCxp5+Z3q8ekei5kT0dMtH8SJecmaPnWrOInjNb60MbjyaP9Fy
	 4ckIE+KvgNb1UV7G4C29PfchN53dC5ldl/3VxHX4=
Authentication-Results: mail-nwsmtp-smtp-production-main-57; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	linux-input@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v8 0/3] Last remaining Roccat HID fixes
Date: Thu, 22 Oct 2026 08:44:51 +0300
Message-ID: <20261022054454.238343-1-dmantipov@yandex.ru>
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

