Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794126838;
	b=aGA2hhv47gKFZArks+DKCgDck2Bf081v+LUQSfDnevO6iLNkL42FYxgCJoU0jf7PmSV0
	 7i9QbnNTarz0tgARyJqcCG2/qf/uTWPhnlcYLrCPVSSc3Ywo0U6EoiRldUowAI+A8vFGN
	 UbMrJX5ZYPiXx5POdrBwmNODP61TAQpaBHBNFWsq2Y/+Eqbv7ChJv0JFfhKYm4ONSdkTh
	 Gwhfxn39CDLxa6zqEpUkIlbGLehDd4kSrdIul6boM2KlWL377jNEne1jpnVod8zxU45Jp
	 2Gxjm5ChIOe93N3u4KoYZ/OtY+bBfzieLv7xlqpdD+845vHU7IlRDnW51mJQapgHkkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794126838;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=bBfIN7UhycgPP74Zu6a7lWnkmEhlqvAvE5xvh+CScsw=;
	b=xayFgoyMCjgvd4DDCxW4JOHW9O5HbeMmA9R3J9TPAz64FmTDTnZNlZt80wD4rgfsniI5
	 PRzAX9EcVcT6zNn3x+7O5TIgacLfoIkzLm3emnjeLqnXtDeSRqI8PkFasltWpVLPDVgT1
	 +S+p2qBtqPPR329UlxtKmJlA/RPnJVNGrFugtHUJeOQ6KefOUxqzrRxm1Pyac5EHkIP+7
	 fHcnGkyuiB74C0JeASmO/y/XMPH/F1ELfxN5yYjKntfxaYB/pIlUUQxGjdsliJxyjvKtj
	 GsUk6j1WYguSlg1+f9MecSeGBVnbCFJLYe33TDLs4S4OW6fWGc3Gd8+fGnVMz30GeUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOtRfV8o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338A8606A31C;
	Sun,  8 Nov 2026 08:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SOtRfV8o
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794126836;
	b=YRX5s77DqGB3EqP0bZCXlfh4TlsMiWLU5WGvDYEGSNSzL4nIXkeX5tQ1KrmYkz+iHaOr
	 KK/w+4T1WX1WvQIiUNMQT11JSbV6BS7jvGXVQfqDBiW5AhSPTUKWROc6Hyo1/zeyJZxYL
	 UO2Oimtr8qpjCUGQmth7bzKpzc1YGaFFpb8I3A1WofGEwwskmzcpNTyTbKtpYpya/3WK/
	 4pB1Ia0R2Dj19fqv/aaav08G6VM0XSW1ohSgFf6a2IVEHXVe45bbRkw8bkm2vePBebJcU
	 xVwnTxgUgwayao6e1yOGn9h4svUfO2YcwchMhnkODI2knmplk1hulh9TvujnxkkA4Hg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794126836;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=bBfIN7UhycgPP74Zu6a7lWnkmEhlqvAvE5xvh+CScsw=;
	b=K24Q0AGZbSP3Ysq/DcakN2lhvh0z/lh7bNcPuXiIJZMrgpUe4TNm99IFQ7avUaBOYmS2
	 fjzIH5K+5LzmLpik/BzVVDANdtFekO+uR+N30VT8fGvn4XsJXn2NJEQVbhn8eFB47h8SG
	 QZ2tHDN8yfnFTdcghU62mpd2bUF50yoqIrDy0vkO+KezAH6IZHTJmduvy43muuZsfRBGg
	 +Jua1a7LXhPZS1Bxjooro1G7ERjwrm+BP8VqxBFKgX1h7+oSjkWscP6zQkojeJYC81s+K
	 dT9Imv/0Ros1d4vi4Oi/v4FUoSac2nfjJdBTTNktKnUq2H0tOksUtfAPMkycTxaoJNg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3A4FD1F0089F;
	Sun,  8 Nov 2026 08:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794126836;
	bh=bBfIN7UhycgPP74Zu6a7lWnkmEhlqvAvE5xvh+CScsw=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=SOtRfV8oUFVGujaiMUjD59+9c6wnUWicZxSlgcP1k8TznOnvIzYOCLcy2CeyBNS7c
	 VwS1Y/GbYKC3vkkg5T58FhL0eMNwWRUvSyR8zTB69fVioZaABCHWfpZxKqiE0mhvuE
	 9jRr6CFZr3iGCmOdboRJ2KRgYhACw6RIx0YPPIJHKXTDfuQJgGb62JI74QH2io8JtO
	 /TmAkAm7bYtmPYBW4fYcaJcllqnr/RuONQ3yLrQH2Xx5UMDEiiZkmWxYIiI2P8mPL/
	 2vbqbpb3Jb22gO4qFL5aHaTDS4WIm7+jFS8JKDdrbQ40hw7lLD06H81zfAa/kzmbMD
	 68DiT3t08ti+Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A892047E8C;
	Sun,  8 Nov 2026 08:33:55 +0000 (UTC)
From: Nizat Mikayilli via B4 Relay <devnull+nacht.dxdmail.cc@kernel.org>
Subject: [PATCH 0/5] Input: s6sy761 - add support for ST FTS1BA90A
Date: Sun, 08 Nov 2026 09:33:52 +0100
Message-Id: <20261108-b4-s6sy761-fts1ba90a-v1-0-999b3cfaf82d@dxdmail.cc>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqEMAxA4atI1gaaovXnKuIiapzJRqURcSjef
 YrLb/FeApOoYtAXCaJcarpvGVQWMH95+wjqkg3e+UDkWpwqtGC/JhCup9HEnWP0PHcVN+0ivoa
 cHlFWvd/tMD7PH0YeALRmAAAA
X-Change-ID: 20261108-b4-s6sy761-fts1ba90a-2ac94a78de25
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Henrik Rydberg <rydberg@bitmath.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, David Heidelberg <david@ixit.cz>, 
 Nizat Mikayilli <nacht@dxdmail.cc>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794126835; l=1250;
 i=nacht@dxdmail.cc; s=20261004; h=from:subject:message-id;
 bh=83BF4liHZfdBCSQ5dI7Z0ukjQe4jgkXlwnqUiFvL+jU=;
 b=bJaQIWdyyKYPeJTZwI5B/qd0c7K3R1yWORECZLNFSXHrSl8V6tQ+18NGeUBA9qHAGLmj4O03w
 IGDq9tF6IrODjmrHkErFOj9mxPvCks+ZyfYy6hTbO17vGCp1odnkOgM
X-Developer-Key: i=nacht@dxdmail.cc; a=ed25519;
 pk=Kay3P3pOJq5klUD+0/I8QX8JGOh0CeQXEwRVv7CMm4k=
X-Endpoint-Received: by B4 Relay for nacht@dxdmail.cc/20261004 with
 auth_id=1111
X-Original-From: Nizat Mikayilli <nacht@dxdmail.cc>
Reply-To: nacht@dxdmail.cc

The ST FTS1BA90A in the Samsung Galaxy Tab S9 Wi-Fi speaks the S6SY761
protocol, so this series adds it to s6sy761. Patches 1 and 2 are
standalone fixes.

The touchscreen node for the tablet will be sent with its board series:
https://lore.kernel.org/r/20261022-gts9wifi-dts-v4-0-a361428fe59c@dxdmail.cc

I tested it on the tablet. I don't have a device with an S6SY761, so
for that chip it is only compile-tested.

Signed-off-by: Nizat Mikayilli <nacht@dxdmail.cc>
---
Nizat Mikayilli (5):
      Input: s6sy761 - apply the touchscreen inversion and swap properties
      Input: s6sy761 - check the multitouch axis ranges
      dt-bindings: input: samsung,s6sy761: Add ST FTS1BA90A
      Input: s6sy761 - move chip differences into per-chip data
      Input: s6sy761 - add support for ST FTS1BA90A

 .../input/touchscreen/samsung,s6sy761.yaml         |   6 +-
 drivers/input/touchscreen/Kconfig                  |   3 +-
 drivers/input/touchscreen/s6sy761.c                | 190 ++++++++++++++++-----
 3 files changed, 156 insertions(+), 43 deletions(-)
---
base-commit: f7a8b89bc067fa1cbcd3312539bc0d61810d3280
change-id: 20261108-b4-s6sy761-fts1ba90a-2ac94a78de25

Best regards,
-- 
Nizat Mikayilli <nacht@dxdmail.cc>


