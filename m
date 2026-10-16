Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DA64C9E0C
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158641; cv=none; b=mmkLRVrIyrOuiogP7NxHI2O5dbF7wBefMwN9UTe/vBvuC10XlYPujIh75DT0f6Kk6qS1vKCBvODSkI7abCyzPki9ia+7hbrw1K6YKndJx8WGwl/Q6n9QPFMnTDFGOHcTGxDOGVcM7Px5GbxTTIITv44fgE3Zt7OYQBgZYMV1Zso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158641; c=relaxed/simple;
	bh=JtWUgmwXdpydz6sojSijM7nIyyfqJH8FXKjubNi9ZEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cumWLv7YuERkc9jDA7mWX8lkGBaY19wLjSxJz5zQT9LkqTEW7T0T4LQ9uwTfdP628SvgeGihNu5vzWwd0AbuvuLnCGdg6fKJkUKMiXDTcMXVrJmUdYjsYh4eLIlqB0CTvpx0K+J3aUCGtBbhreHpCSUOUZbzCD3m96RO7OT1Z+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qCFQOcdM; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCFQOcdM"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3a4b9732d5aso1281a91.3
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 06:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792158639; x=1792763439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JtWUgmwXdpydz6sojSijM7nIyyfqJH8FXKjubNi9ZEI=;
        b=qCFQOcdM/OUIM2ay1ToK1u5QDmNQfJS/ac0n1pwTIORQbPiLUpQZkknOdiQ2SuQlie
         fAHqWh+JVHxcHC2aDJO4/EoaTrmXm/ooOBiyRKS1uaCTG/c1snR9FlEJXgOC4IvDrQOc
         wgT9GW9x8oTS9UBosl2TKDjU6b9mjS0MR9CUTIBZAprPVinBP8TE6ngaUIkVZREcuE1m
         MzS3V0ghJ+AsvQFmIvvfPevh/Pajla8nsqwoAQbXEbO2g/VY3SXbLP2iwZQanft0VCfs
         sZI2Ncjph9i/GZLAZr6I1w0+nkBt6B1ogVx2ykeLk+PZA1Oolo8gXKPlYLEmFA4j9C8w
         t4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792158639; x=1792763439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JtWUgmwXdpydz6sojSijM7nIyyfqJH8FXKjubNi9ZEI=;
        b=ZIj7/BT9i8kA+mnijwTYU233nFHvIrAaCj1ttVHbSdpppK4ONSiUQt2axN//y/OaQb
         vkUBmp6azupZC3QulUiAaoxIuNXTmOcHoAGUts5mFHbOv1QsHsiP+SVPUnOIb32RI6DO
         4CwiTOmvRcBDOPC2fnwToObW8ZL6fLjF9tQqx6gBy7mxZs/C421Pisx6oCC+g/oyUJL6
         kG4Tj/iJOtFw1qoCRkJ40JTNGMYQWhlWZvCVnXQavlu4iCXIvAQfNdl94vSxCaLTFDZW
         S/C0PKHrGEgUGKWI2HHPPJvZjFmwe3ufWbfU8dP+I/fJ0eYQh9N956DlUML9gCwyex5B
         k/4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzZVP0SZr2KkKxKPGfjVOJbhO13+jtB91si7cJ4MdkBOCaNzcjrUqAff3bVKAxU/n/fv9eX3m3yQRfv7Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYISgt4qEP9SqCdFGqhKDlWJLQy/kwUZSTUZe9fk0whfCZaLgUei
	S0IymrnLFc6gilWGiWdcSBEkWaKbPAPu0tH9q1CNgrx2z0BbILZVH1QJ
X-Gm-Gg: AYBFou3xzaB2ExwEnuJ1FdF/qtfYGZu6NKAlByQfCAB3c9I3dMUfJ78M21UmZov55U6
	Dlt2fvseFGlQ1t+bCDTuSV5pI6bTForZGp9bastUEuL8u1/4CZMM60iYyO3irhUeS51RcLm7uWg
	wilcaV/Fbw7ZbOGnbM/fhIJ8l0vw3r3GvH+xwmXFeE3gGED/WJKnONx9j2DrEdmCYAIC92BVCC4
	ADhbn+qEbhlhQFlrNT+tEg5t5DycZzUtSv4qcSvFn8nTqMvIbbg4Sk9p36Wy8wVU8xeaTxpkqJw
	Yfs8MM0sPSdv9Cyna4jv+3IxzQC3My2Po1n+FC7etvFaBmnKots7/9d5D8y8bcQEmlgsxXko5zB
	tU8MWx++ZdjBYCAmSNFgC9IqxJFf1eCeCywXw5zJ5oFxbDw1GLy1TxDV171VoNKA+nc+MOSyCMM
	nZ042IKumQbEQDSl+igI0oYMz24C7Obe4e3Napz0Bhv7L+XmNkKIM13odbo4yB9npxtWkVJbTA/
	o7ruwWW1UgiuYsc6E6zh1j8GjEUQS7meGwGhKgzHU0bYAehYi2jL/MA6m3ps77edpl5semqBw==
X-Received: by 2002:a17:90a:1101:b0:3ab:884b:65a8 with SMTP id 98e67ed59e1d1-3ab884b6b4bmr12069979a91.26.1792158639135;
        Fri, 16 Oct 2026 06:50:39 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:301c:f8cd:1467:1666:71b7:b993])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc487e509sm4348279a91.9.2026.10.16.06.50.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 06:50:38 -0700 (PDT)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hid-msi: Use str_true_false() helper
Date: Fri, 16 Oct 2026 19:20:11 +0530
Message-ID: <20261016135031.36131-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20261016101506.14084-1-sinha.aryan03@gmail.com>
References: <20261016101506.14084-1-sinha.aryan03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an accidental resend of a patch I already posted on 12 Oct, with
nothing changed between the two:

https://lore.kernel.org/all/20261012154537.42113-1-sinha.aryan03@gmail.com/

Please drop this copy and use the original. Sorry for the duplication.

Aryan
