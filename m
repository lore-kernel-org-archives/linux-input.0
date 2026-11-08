Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794153320;
	b=inEgdRSZua8H4RsyH3d19V+dQYER3KC9rkLpNm14R5gBjgnyezG/insLYPYkSXpbZ4Ul
	 ESo5NGxUPnRLCLeBTNVuqGH3KNfU8cnEDHn9W2/HFxDzbNzCffiagEDWKXzN6+JCD0YPQ
	 20Ys7JvttTxFuWRcd75pAOy4Tqb8lJSFbR6I6VGUReOINokon3D63IGaoHcY0R3+zjc4Y
	 +zVlXYGvOWOohkuVLGq2ivXtw9OGUb5MBdLx3qb5GTGT6PylcRortEL05uUWG3ECgT2jF
	 n8ICQ/AjugemdyusW6t7mRL/Xdb3hBCV98TTUqWBjmK9QGBHPjjvno0vroKDkVkd7EA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794153320;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=LvMIPwXGFg1XneApC90M26IpMbrU8r6YTUanv8t5q+0=;
	b=xsX22ACel5NAo4x6npsfgZrsOC5tDRnuaMuFw/2R+CpnNF7K0RWTGPhmRW1XSiTYS22T
	 PS7E31HB+vJVc5BURx5LlcKjJ+RtxUTp1fRH3HWuDAfWhv+8kWM/njKbq3cz+f+w3IesZ
	 5W5HHHEpWgUlWGt4KEux2nxKQfSEGAkGVE6a9fuzTMl5cDHABJbb3V1afxXarn6HN8Lqd
	 JK4cxqtTHOk5wIEo8YCW5rpH0GjTQQBM3KuHrdzo+l+2AgEdVeVdz4/cc8TG4MfbpLyyw
	 3CI2LduEIincMtuoklCjbqDYl9Yh9WoAwRXMevwBGSC1xh/j4q++PZ4nA0lExKTEt8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VyoaD/PO";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA5F606A31C;
	Sun,  8 Nov 2026 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VyoaD/PO
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794153319;
	b=UgPTXuzxM0EamG7V5mXllRelS1Vkl52LIBsuyXaE/852hABo5juryRcgIh2WPkZ5sww2
	 YQxhJdXNpYbPMWAx8XaA1EUNfihErAbGUH9j5iRbL4Cxz8QwpmvvaFIZYG/gVrxMfDFen
	 ECDjFlx74kn/hh5VruafmLE8hreYXaCQjyz7AqQZgWBR9rL39UfAMJCglSM9OOnerR7j9
	 9XtTTUJLBMa4Rpw2bBHWv3jlO7sv8vsNRrnYgF4gepNO26CMqFItlmuLavTmNsnOtZlsN
	 wlpDl4JAEp1ztxtmgtZnZuEpGmQbR+OLAenwegwFsRj9VhEx3Gh9iWUjLRGYQAPqhdg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794153319;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=LvMIPwXGFg1XneApC90M26IpMbrU8r6YTUanv8t5q+0=;
	b=ehCa/9G6OCLgR2cZ8StdUkqkkV1dtVSdACIsv3LQ4IoPOD/RJIjxrLXuIhb6+mgG37Ng
	 XCHqShSJITdI7dRaGJD2F+7LPfVqrw2VTeXj6GDPGbCKQwYZL8UQi9RHw9SqPJnfI2WXR
	 RIVCAfdLr6XTMsN1zbZV9EphnR5SOy4QgmDkGvgEby+7CWRe0FgV6SCeZpdY9TyNpc2K9
	 236gbhEYEuNvZ50RU3UIr7Q906EvsNorzJ9JnsEE0xd5UZCu9vJpP0H+tlOVpJZBNQTg/
	 RG2tkE81/IWi2EPSgbcHeSssY0FkNfK/UY4V6yY0DEPGZ8kEaKM/nSLbCsHUMXA7sTA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C79971F0089F;
	Sun,  8 Nov 2026 15:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794153319;
	bh=LvMIPwXGFg1XneApC90M26IpMbrU8r6YTUanv8t5q+0=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=VyoaD/POHW+DgfUvpVNhXEvJ92V7vS3AjqT/ZAfbfVy6PQUQ2Iq91kjq81d46WWHs
	 Dv0G/srGdrCBl/h1/MZREhioHDiRQNJvPN3/7lQqz1YDP1arwJjA66Nmm3QLiQraTM
	 nJuuT0m6TEaLQybozjpQsbwq+BZXkLN0znsggtJz4+dK+AtvxsUngKLurYc1uz/tDF
	 a0UTVqL6qAzR2Mg2GaWWqE4LtRQhfAlUR5+TyMb/16dlJGl3tIMqoU6xVzKDtqIDKY
	 ObbuvxHZA9PBmkTegNOy5zLuyWFkDG4/pktX+254T7BCRbDWL69RmNNBjQYwfnsC0d
	 u8tgr6Tbn3wXQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3F6B347FE4;
	Sun,  8 Nov 2026 15:55:18 +0000 (UTC)
From: Nizat Mikayilli via B4 Relay <devnull+nacht.dxdmail.cc@kernel.org>
Subject: [PATCH 0/2] Input: wacom_w9000 - add support for Wacom WEZ01
Date: Sun, 08 Nov 2026 16:55:16 +0100
Message-Id: <20261108-b4-wacom-w9000-wez01-v1-0-c2b5e3466187@dxdmail.cc>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQrDIBBA0auEWWdgRoq0uUrIwtgxnUU1KMTQ4
 N0rWb7F/xcUySoFpuGCLIcWTbGDxwH8x8VNUN/dYMhYZnri+sDqfPpifRERVvkR4xpMEG+d42C
 hp3uWoOe9nZfW/vK+tM5mAAAA
X-Change-ID: 20261108-b4-wacom-w9000-wez01-bf2fec6aa1f6
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hendrik Noack <hendrik-noack@gmx.de>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nizat Mikayilli <nacht@dxdmail.cc>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794153317; l=1082;
 i=nacht@dxdmail.cc; s=20261004; h=from:subject:message-id;
 bh=8XkiUPix4eRLdqxcZAiV0Titd2an3O/18ecr23mOFlE=;
 b=0V0q+sHIVc9jvjTC76iCBVo2+++7cuTURsWSlDAmS7xlYDHvBH72lt4A6hKdUPReWmzTRnD7y
 5TwdDJCnC1GA1CeapkWYaS7MgPAukdmd9FAWVLyjtPyrr+tHBYu9AD9
X-Developer-Key: i=nacht@dxdmail.cc; a=ed25519;
 pk=Kay3P3pOJq5klUD+0/I8QX8JGOh0CeQXEwRVv7CMm4k=
X-Endpoint-Received: by B4 Relay for nacht@dxdmail.cc/20261004 with
 auth_id=1111
X-Original-From: Nizat Mikayilli <nacht@dxdmail.cc>
Reply-To: nacht@dxdmail.cc

The Samsung Galaxy Tab S9 Wi-Fi uses a Wacom WEZ01 for its S Pen. It
has the same query and coordinate layout as the W9000 series, so these
patches add it to wacom_w9000.

The digitizer node for the tablet will be sent with its board series:
https://lore.kernel.org/r/20261022-gts9wifi-dts-v4-0-a361428fe59c@dxdmail.cc

I tested it on the tablet. I don't have a device with a W9002 or W9007A,
so for those it is only compile-tested.

Signed-off-by: Nizat Mikayilli <nacht@dxdmail.cc>
---
Nizat Mikayilli (2):
      dt-bindings: input: touchscreen: wacom,w9007a-lt03: Add Wacom WEZ01
      Input: wacom_w9000 - add support for Wacom WEZ01

 .../input/touchscreen/wacom,w9007a-lt03.yaml       |  1 +
 drivers/input/touchscreen/Kconfig                  |  2 +-
 drivers/input/touchscreen/wacom_w9000.c            | 53 ++++++++++++++++++----
 3 files changed, 47 insertions(+), 9 deletions(-)
---
base-commit: f7a8b89bc067fa1cbcd3312539bc0d61810d3280
change-id: 20261108-b4-wacom-w9000-wez01-bf2fec6aa1f6

Best regards,
-- 
Nizat Mikayilli <nacht@dxdmail.cc>


