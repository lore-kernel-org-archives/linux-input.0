Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716AC417365;
	Wed,  5 Aug 2026 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923803; cv=none; b=Cc/BbkMfyOBEyWHNzbGPMmCW1tXdvIs824uDKp2T9jxQdw7BZGERhl+ae54FAYGE6OmCUqTP7/+76DehQX3f1GtvoSU4glSM3bMaZ+jYM1WTOwWtmv/zu7pbSf/dt3B58ARwVDMsMFdFWGGWGcKdeNKme/omo2KQpbaUTqFscNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923803; c=relaxed/simple;
	bh=1v6a/g9PNsWehtO7qhGh3X0Iz2aiPbGMlxJ0mPgN5No=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SMQ/0KURJsaUYLO4LcWs34WgzpSmw0377UbB6Mb0ePWkHqfTMz2tbFwazZTRZacGGRjrvBaPnDxWjKYALexweiQ+DK22AQTKRretc2kw0rnXm0ncoBb6t6wTvPW4EwefHxrph/6/3Er3m1Z9gvOTPromqFKA61Y1bwmymLO2VP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=M9H0veJ2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=is6tmf/N; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="M9H0veJ2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="is6tmf/N"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 7DF231D0012F;
	Wed,  5 Aug 2026 05:56:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 05 Aug 2026 05:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1785923800; x=1786010200; bh=Cy
	6sWLYxU/NA36a5+ExhXn4nFo/odEp+xCMw/QjTGvI=; b=M9H0veJ2x2r8KIQRhK
	IcMwUoCf+BVSGK9MlpxItmZZjsjfvyci46QxT0pELd9+W4jWHm2G+AKaDVb9BdoG
	7PGYhKzoSaDWSlftHGBFcA3sPLFfAWlaySOr7fhhZirvERZ7f+cgEYItwdjpPZBR
	/ZeKSG/DDSQKjHTNFScJUeAy/Wx2TySBo+IvVwmrnMm/gqZTppz47H/BSLNOufQC
	kOq7UVecDRj+xwWImHRltvEQZMfUbbxCdODNA+pYMJIwH00xRYMAgAL4W7/340Ei
	T5zKX6oGaoDbNByrPzpyeF5GYgGozX2T0jb41DRlsU4K1I4Bg7+7k/XmQJnHvqG3
	J7fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1785923800; x=1786010200; bh=Cy6sWLYxU/NA36a5+ExhXn4nFo/o
	dEp+xCMw/QjTGvI=; b=is6tmf/ND9+nmf0W761dtvgJQwFOqUStcoCZqJ7idVrd
	l151ErsqjbzfgGJLhEtZws8C6cDo18jDLxAO/FKZ6Tj8m0hOkLs6wCR/zFRRyPAH
	KREthEuxRBQxnuUEAfKmYWjixCaHPi9Dgch58alv5shIbiPtYmNysvQMeIym23lt
	F/F75RuCN2I/CC63HqdD6oQWbHD0Co5DoQ9txLjqZNhClG2aUKhzROX+MDJza77l
	hhhQJrOq90ZopjNqptpudRNWfRv3uO84gNcTSbO14nL7hsPmGDqxM5qOcLSdo0aq
	8UGLhXxaUB1KQGTjDIr4VVVARewxp9nW0zY2obXIQQ==
X-ME-Sender: <xms:2Ahzaj6vTqVxYO9s7CnA-5WB2JxRYhMvdGg6QLVyHcdbAbPbm0hxfg>
    <xme:2AhzamtfOj7d_d-d8-ctjKkfQzBpWp9JsNkMee9rUVP9EAh_9SiOrmbtSQ2ISA1Pi
    -vjZDIfqDT543DeWAcPU3WZ_vCh99zngK7kJcHQqMDjBNSYTg>
X-ME-Received: <xmr:2Ahzak74eV5kAUcmZZAPldwnt23km9gK-82SA8D0AQLDJFj3dq12EH-uIaXLI_bzkYuyTZTUoGK9J71rdqoqhLRnXavRc-JOvM8cHL0j0v-9cImJeu0>
X-ME-Proxy-Cause: dmFkZTGy/4wrm6fd8gljwhMvXoGfsOmy7/s+pfnxZo6fYuhhpLk2o7zpREM8hNTjeNCTVe
    yigXOt1bnDaNbmo4cI0xX9x9eA3ob8om1E2ZAJGdIOpCgNutGXO4PBVRQ/9JSgaxkJAG5j
    i5sy/iKH+8/GYEDdZ8enafmabCqETXNcZcig+yRzXdvXTRi12ExQd34WvL20b3IpqBXq3I
    nA83n3Gm5V2QBVpJvDoIlSRWHzrupFYwaof0D6UKWx27ktIV2Y6xGdYgkU9m3Iqt372nOg
    RyfjlNnTvrUU/lc6HiKvb0z9aLRA1OQFyds2uhl3vwPciSt7DlvPTFQ3V08c4tTrpIOtXX
    SQ2ZVpOrSXXEOVE44jVFA8a95/o85lhXzX9ukZ0omlwUL/5pcgEPSRSrhvcLq3mtKhkvgX
    kgQobagZj8ABJK9yLePaMeptQO/T8uQ/e77uQIwCalTLJfZm0/T0wHeYHPM+YgKV+y5tTL
    t12l/5zRWRDZfeFy4V2bE3g3F/yMIbPw+G6jHXGX7JIYiEN/BWFkFNFV9Oz5o4nC4vpq+7
    ILjRkWNa9KjSvYq+mzhxq4rUrGQyeuMAh5ERlZ1AZ/VUA+jjvrLpYIuPt7vw8drs78td1y
    vlbSqTByMeE/IsSSV1p0stl4MP0sp1uoMGEOuSuSPrUVVnWHs214fOw/sdog
X-ME-Proxy: <xmx:2AhzahUbg6laKIJ9jxbIVo8IjaVoCCbG3aa3GQcLLH9Uf1ppcSmqxg>
    <xmx:2Ahzam95bqyHLQVtH_aRKS3xjS1GDjD2cco3Tyuc8qIUU7uum_uxYw>
    <xmx:2AhzatlUpPsmMa3j7SSz-4Dj3yTBWbKyjILvHzD0qsp9x5IuxWSMEw>
    <xmx:2AhzakWpUdIBFkeyh7ETNkR-1kUllfQEZgAO1J5lT2CLew-5cV15mQ>
    <xmx:2AhzaiTsnxxdsNFlgXQDMitv_IMRI3GDuqJJWqL3zmnK46IItqsl7PaN>
Feedback-ID: i1d2843be:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 05:56:39 -0400 (EDT)
From: Griffin Kroah-Hartman <griffin@kroah.com>
Subject: [PATCH v2 0/3] xpad packet size checks
Date: Wed, 05 Aug 2026 11:56:34 +0200
Message-Id: <20260805-xpadone_length_checks-v2-0-f3e925e0280b@kroah.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6DIBREr2L+ujSAjWhXvUdjDOJXqC0YoMbGe
 PeiPUAzq5fMzFshoDcY4Jqt4HE2wTibgJ8yUFraAYnpEgOnvKCCC7JMsnMWmyfaIepGaVRjILR
 knLaVEMWlh7SdPPZmOX7v9Y/Du32givvZ3tAmROc/h3hme++fY2YkpZKyynOGJe9uo3dSn5V7Q
 b1t2xcMar/LzAAAAA==
X-Change-ID: 20260727-xpadone_length_checks-08120b97764f
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin@kroah.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785923798; l=1021;
 i=griffin@kroah.com; s=20260706; h=from:subject:message-id;
 bh=1v6a/g9PNsWehtO7qhGh3X0Iz2aiPbGMlxJ0mPgN5No=;
 b=YCxZq8feT6Zse/8QU8W/sh9dPasFRH6A+xfCTCl+eji9DJkk40ydnHDYdhYAO0yEQ309WB8Vj
 DJvYlkr0gc/AW0CKeirdi13NGRYDUbwr8GFpL/6k4M4rb0/Oa9KgmZt
X-Developer-Key: i=griffin@kroah.com; a=ed25519;
 pk=Hy1TuVHERdQhLAWwjmxLFNtGj7eEEjaZWPXehAlic5M=

Small patchset to add size checks to the process_packet() functions in
xpad, ensuring that OOB data is not accessed.

Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
---
Changes in v2:
- Now a patchset, covering all process_packet functions
- Link to v1: https://patch.msgid.link/20260727-xpadone_length_checks-v1-1-19aa9331e82d@kroah.com

To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Griffin Kroah-Hartman (3):
      Input: xpad - add out-of-bounds checks for xpadone
      Input: xpad - add packet length check for xpad_process_packet()
      Input: xpad - add size checks to xpad360 packet processing

 drivers/input/joystick/xpad.c | 49 +++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 11 deletions(-)
---
base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
change-id: 20260727-xpadone_length_checks-08120b97764f

Best regards,
--  
Griffin Kroah-Hartman <griffin@kroah.com>

