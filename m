Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793342249;
	b=u5fd4XcbAPNRwtW9jWqooZJT9zdkNtMwLFXROmqgmW9dI50FDIXT5bHHwZkrbKquNsFP
	 rzQN6EUrMwF+cMXlW1qb+trQPZJMvtClPCZABoAb6ngBG+nsDhIcQ2vwV23zM3GLqCraZ
	 K9FBhyQ+UcD55vl28IeiZGuXt6tqWiFsy/3UIyEYKsatNru+D7zy/sqGJqImNX4WpdxJv
	 quj7DmP84rwDM3TSPe6BxsvkdacryH8ZFCzbuTwMyfGHzYOBrC7eVFWi9SutRxQWwSXX1
	 bJF9LUlvdsgUT9/vlxuwRliJbjIp3e973FrwLPZHu0aqebdjQ5R2ecint7+8yL5po4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793342249;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=6B7+vvKJCEkJFZi/VjVcB7bwHCaemhj5enwrXgYutYg=;
	b=1H5j3FqD8yDqvN4c6JfxjQEXLa4WIVBoFOP6PMbaJQ6WVviS5aTGcypx9TGr5omflWS8
	 sGstLhm8VkVzkFs1ve4X/xyULMWzv58DfCkuXXYtO+8UU0BIpvOEcF+WTc1nP4TVBldfW
	 35vOZdkQAau71vDRzYf/z82bgk7Dhh0BMsc2tYQhmjtuUXhdixkkFUhCTqkLIRQSKWeVQ
	 GoYaVJ7TOFY4oyP0vvp2lhcJUkO430GWRvzIQlEeYiPYhxulqCjfZxNdzJFaflwwTsh5c
	 /kTec3+a5wPmyHKD8N16/PHEn99Gx21d1zbSGa4aCdDV4YeDOEJcRa/7Ei8Ps4XxlSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aJJLfBS5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195A8606A31A;
	Fri, 30 Oct 2026 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aJJLfBS5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793342248;
	b=DeghXK7ZNtJpWZj1drRAxUDlQWyJwnXy4sj4R/hIFGH95M0nnaCrvrxgdgaRFyLe6bor
	 EBXM2cNGf/1lSsBiYqUpvC1dznQiBGye9sYnBtd+2J3ye2tyv4Pici62XOd+oTZ2S8UJP
	 Ibn2rOVerEMc+Yh2jXOVZup9vrQSnS3OYx7UU/QGrbOgWaftfE1xwch8hqR3xZqFi2RSp
	 17ybghD6kExkWTuRRuGjOoOI9XPrEPOVFcfViQZm8uSDjcTMNIBWTP9S/DrHrzZQWIMvU
	 lailUbwkXZ54z62FpKWe20Z1O2i8v/Mt6kzmsw8FQDUhWn/GxdrWYz7CtWkoGwC6moQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793342248;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=6B7+vvKJCEkJFZi/VjVcB7bwHCaemhj5enwrXgYutYg=;
	b=y/UH6AjG4pkuU6ZVkVnZMu8FjF1kJl7daKK9qXa3/MlZoUv1qfCExUS7n1kimxE+uF1+
	 Snmj/z32PWfOCR5mu6f6Dr1HeZl0mfVKXTvdXOmwd07j/flWnIU+xPt78XAsc5+GUnrIO
	 vr9RhhjwspO0JczZHYprB8CycROPaG1nuougXFNezupBOks7UZU05rd0ulSqT5qsWri6w
	 int5cNBoSUefZ2nUutnGTKQoRq5ChM/7TWfYKUSSW0PO7dIlSEHClHbspqcUMKkouA011
	 2toCfXEwbFAxFt1NpPvtqvgI+s27PAL7XTgtw4F/mOL0qa/tlH7fUM97SgnBpmINQeg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2411B1F00A02;
	Fri, 30 Oct 2026 06:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793342248;
	bh=6B7+vvKJCEkJFZi/VjVcB7bwHCaemhj5enwrXgYutYg=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=aJJLfBS5JtnvTkBSjwiAfdX63JK8QG78bN4w+RWfU3e6nm5gjde1M3lpoSbOa6Vw2
	 E6e/2vBXNdGnYRQi6xAi6tRVvewzZLxweVSP6vDYa/Gm2lqcKkZn1/Zuu9rCWs7N8Q
	 IDqUgtZw6Am0hxaBD2nbAIm3ooootAa3nybcFv46OiimtFwt4LODqM6zT63zrGZEBQ
	 FconEwnVDZA/qFBOBxmDbSUgbPzD6K3LejlHAk20NgyXIzYmtSGkGiQPoyLPBDiqA8
	 4v261euL8DL/Gc3hkqri6Q1XSsmCw1AG67IP9BQhiQjOPDVb78t1dYvNatK+HWL0Gv
	 QAv9uw90ZfRxw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 74B3843692;
	Fri, 30 Oct 2026 06:37:27 +0000 (UTC)
From: Martin Oberleiter via B4 Relay <devnull+martin.oberleiter.netixx.it@kernel.org>
Subject: [PATCH 0/2] HID: steelseries: Add Rival 3 Wireless battery
 reporting
Date: Fri, 30 Oct 2026 07:37:23 +0100
Message-Id: <20261030-rival3-battery-v1-0-6b1feeaf1f52@netixx.it>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBA0auUWRvIJNBaryIu0mSqI6XKTAxKy
 d1NdfkW/2+gJEwKp24DocLKj7UBDx3EW1ivZDg1g7OuR+utES5h8WYKOZN8TEg4xIQjoTtCi55
 CM79/w/Plb31Nd4p5v0CtX8z5dMRyAAAA
X-Change-ID: 20261030-rival3-battery-ad17cd19e128
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Martin Oberleiter <martin.oberleiter@netixx.it>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793342246; l=1381;
 i=martin.oberleiter@netixx.it; s=20261029; h=from:subject:message-id;
 bh=w2YXVZYcFQtYvcPZlkSrEitR77JlEJPlKV28pnvKM1w=;
 b=r9SKXG0CoTMTJNm2t90BHjbWdY9eaJvXd7sy9opMAHC8ojVWVEuBYTGFyjBtDbjN5GLn9PrmU
 TmNPZa+jKb/AFLQcg4OLDEC5+J5InHrxjCth8frB9mF7woPUA/53odh
X-Developer-Key: i=martin.oberleiter@netixx.it; a=ed25519;
 pk=yZvkAuAsIiJ76LEGGTR3TI7+Xjw7lGN1dK6jcv72XZo=
X-Endpoint-Received: by B4 Relay for martin.oberleiter@netixx.it/20261029
 with auth_id=1358
X-Original-From: Martin Oberleiter <martin.oberleiter@netixx.it>
Reply-To: martin.oberleiter@netixx.it

The SteelSeries Rival 3 Wireless mouse reports its battery level on
request through its 2.4 GHz receiver, using the protocol rivalcfg
implements. This series exposes it as a power supply.

Patch 1 makes HID_STEELSERIES select POWER_SUPPLY, which the Arctis
headset support already needs and which patch 2 relies on as well.

Patch 2 adds the battery reporting. Desktops currently show the mouse's
battery with a keyboard icon: upower picks the kind from the sibling
input devices and prefers the mouse's auxiliary keyboard interface. That
is a upower heuristic and will be reported there separately.

Tested on a Rival 3 Wireless (receiver 1038:1830) over a night with the
mouse switched off and on again.

The series was written with the help of an AI coding assistant (Claude
Code); details are in the changelog of patch 2.

---
Martin Oberleiter (2):
      HID: steelseries: Select POWER_SUPPLY
      HID: steelseries: Add Rival 3 Wireless battery reporting

 drivers/hid/Kconfig           |   5 +-
 drivers/hid/hid-ids.h         |   1 +
 drivers/hid/hid-steelseries.c | 277 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 277 insertions(+), 6 deletions(-)
---
base-commit: 720806515cb6921ab05caaa6f470f7054b56385e
change-id: 20261030-rival3-battery-ad17cd19e128

Best regards,
--  
Martin Oberleiter <martin.oberleiter@netixx.it>


