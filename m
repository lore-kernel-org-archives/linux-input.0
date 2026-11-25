Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795616608;
	b=PJzsBhTCMwz0Ml97aPNlGHR9zBbpc8zAjhag7gYwKgBp6PfmI6TGXu/PifuEzA8h2iFR
	 y2j738JSO2zea2JSTmRPMRUs2IsXQNeB6ygqCs3+57SQiBRD785thwtZUjZAq2pZd1x0m
	 hCmLEeT8X1FO8m98/TgRg4A9mGdqAJpNH5dh4JC//A0fHE+0nCrDfLuNHbMTIR60cEhxN
	 KqBHLPvsFDu47o4xbWMf48xGWLekml650JbOFvE+0Vy86ZbxWkrz1FlEpprD/aaPL/5yi
	 pshYAionz4Y+POCNIniQXL70XiX+SPTpMvIg9TBAf4fVly0JPeS4sysRKt2o05tON3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616608;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=vyzSN8YoEpZHNUT3pPheTzKO6EtKkzWYqov5UdjXwWY=;
	b=iSP1UN5chLw7KOMLzz/JGbaInM8koG2VNOWPOzrL83YcrFwv/sa6HHs/aeGLKvXZMCv0
	 2Wy1+aoMQbrNj+NuTFPqJm3wEMNaEW66ZX9uTpz6U+c3A3fAllJ2WBM4lie0FQLoUyYfg
	 C5nOxY5JY9/t2pq1NuSGDc7NRW3tA5zB3WP8KxBbVFZMbLC4qABekUYXn2y1m1PZplLq1
	 bdCNSO1lUus6V+FKjPTCoKtcA/J8RPgVjRo5m8fEe5qYH+eVYUNmQIeDjVFhb06yhk6Yu
	 2g/9bDwdguDs24qSog6kkpmXwyaa0wYRp8iUQhv7ndudoxQ9BdHi0lteFYV3ypqm1eQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=thegoodpenguin.co.uk;
	spf=pass smtp.mailfrom=thegoodpenguin.co.uk;
	dkim=pass header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VBU80bct;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8599F606A321
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 14:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8599F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20260707.gappssmtp.com header.i=@thegoodpenguin-co-uk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=VBU80bct
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-921367ef6b3so41314006d6.0
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 06:23:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795616607; cv=none;
        d=google.com; s=arc-20260327;
        b=OOt/GD6WyixU/wvc/zeftVfTY3F/z28vnd/FyvqmICfoTD5uL+Hr3X23E4hWQIqjFB
         A8iCOmnx2pp/SSBvKD4pfgy0E1KcLPi/mIf1hexam+272dvk0GnOxQdCDYugXf1cNfIw
         tQeBFIbe1YAk14Eifvp6Dht6+t+2fZMLLqE2U1+jGG9Gup8BUjsAI+xvmXKvRPLh3va2
         1Cr5NBDrXah2ifpzRZYQNgUl5i4G5/X7JyecGaGSDwpF9Ey58+V30hgNMigZIbEzYlPl
         taY+m1PkrorTPMb7oOkcAJfQCo/vPL5lO1gBN3L/nMwYjSWJAR5JlxI3VSXgEH+wK/jx
         aYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vyzSN8YoEpZHNUT3pPheTzKO6EtKkzWYqov5UdjXwWY=;
        fh=JklGMjdYaNx9D8QNu+wRorcCTjZXu1C9+zCHOFm4xxo=;
        b=Gez1JidsmCdY3vd5pwaFJh6s26UCEmoefJllPBsDJufXqZ1tUnHWFFcFYefD/UzbK2
         TOuvThRs9HX76FDg9SpSeMBbBoQGB9yllVQqTqz3YjlL9/GrzZuuYavTXeNyHjR2ms0Z
         cUFKYyrOr0USHlddblOJDnz+VdZIOQeqUurzv2TY7xZnRtpQJ/+d5NQEiTIdr8iQ0eH5
         UV0sAZqlWlN7hYTulX7vDQ1Z2g4r2C1dVdenU9Nb7dD5Dvuu1yvB/CgYDaf/uMupZjog
         9JnhcWZTCP4Q7AbzqPsRBgnkze0Jd7jwBArh/RaoMcQuPujmLSx6OJILfMaqvmQdXrQk
         PvWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20260707.gappssmtp.com; s=20260707; t=1795616607; x=1796221407; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vyzSN8YoEpZHNUT3pPheTzKO6EtKkzWYqov5UdjXwWY=;
        b=VBU80bctXVpMU3NOlcb1DlRe4QrHv2umoc7orUqstYTkfK2oNJPvqhDfEXc+OmlQLp
         tj82uCESe7NUS695UcOtdEsBTuLM69Sq7WELmpiKH1jjZx8z1m646NGhXQZZAK/zm07A
         DF1Jz3tj8gtbadlLyO3TmyT2sVvszop32rWYQ0IHt5QGB6QMsowPhYWjB3gGt3b39J07
         zm014mweRk2RbJ1MBQzI7TzC9FPXW/jKNQEBmt2yxinv3gDPYS3h1DRkaS8HC82qVFWc
         Gb5MTF8l+GxlT5OWm7aiSSNtf9WhEz+vupQiw2ncykdpRLj34UKumuxKxjuZFS8iApnA
         B12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795616607; x=1796221407;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vyzSN8YoEpZHNUT3pPheTzKO6EtKkzWYqov5UdjXwWY=;
        b=DTOBNhM+N5/+O8emVUugDlUdFePq974hE267bYUqgpSlkUBRb77yQAcWhigOoreipb
         FsDOPKYrHxzdwN2OXQ6VGQsSmot2tm7umqnzuN3Z1RwiJ6xKNtLcrsW9chDTD386BBxQ
         zolcEDfUpqNvXLTkykFtj5/b25MUgPqGrAauKPj0m+Ortmwb8NHv0+veuXgKGomuzWXy
         Bbebt73afxv4FW8kKIjQaTzkwAm4LIDJQyTqZqk0VVdSGJqBXlGhKaBs+y52BQ+6Dxjh
         p0KZ4/cCn9pilHgQ6uHgAOo75J8vJcn77oirwKQSeuonMsOBvrEPLoaQ1qc5kNP71GV6
         RGgA==
X-Forwarded-Encrypted: i=1; AL+hErHWrRWlihwTIfjNwi5vWEFL8x5W5dZ8qunP46UM9XqJhWV5fFYiAebHKLOZL6je9k9wuZQLbExy3Gcq1A==@vger.kernel.org
X-Gm-Message-State: APuU4Z9F4c7A78ngE5Xo1rP/9IHJDfViyjDAtkXQ4ypBBYzeiAVeEF5o
	8FrP/uRbSwzjrf495Xyoco1tXuxtwocLSl9dU1B5FXS2RhYMR4SofgR2LyiGd9EPJ69IBKmpJEw
	ofNwZP6xGKaRgPUie2N5+CGIXKdnFy4VrzG5DFaFcTg==
X-Gm-Gg: AZFdTZdkC6qkB+ObScf32zwxAyOJcVmon4UwmIfgUZCvUF60SiviYhXb4VqN4hT6Nj0
	G2o9SUJZcceaNK1oyOZhDkeWz9Uy4jgucIue68tUaOXt2rjlltnGwrRaB/dMNRBFbcb6aIOMZ9q
	AGNb8Wrr5K+fuzykVTlTYl/yENYGUX+vF8FuOYf2SP1RWQv3945/UVVhCZNQLjlOKlI3nd/FCZj
	7HujI/0F5kKYNG7naeZhPUIlsR+4gXtN7Iu0IJ1YSZTujBrMqOTgY3SegK0IUS9trTmBbN5cx6c
	g9gipP0a4AoKwCIfbQmTvGXGAUdXi8mHca1Aejm6vnbISNMfjRrX6KTGeLafl5OLexu73ocjC86
	1b1UpZS3/pVFtBbmCSM8QVznOhYAyk4UeHO8hYcXzuoZhzM0zghpCt7nw04Tw4l3xHJWwK78=
X-Received: by 2002:a05:6214:2125:b0:921:1955:6578 with SMTP id
 6a1803df08f44-92134984b15mr344701626d6.7.1795616607488; Wed, 25 Nov 2026
 06:23:27 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795589119.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <cover.1795589119.git.u.kleine-koenig@baylibre.com>
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Wed, 25 Nov 2026 14:23:16 +0000
X-Gm-Features: Aa3M54rkSOQ0cxLe0SdeL4aNs3UZrcE3Vu7kmO5mBRqygoNs-GqHDcpUGoDVWIo
Message-ID: <CAA6zWZLp998F363tRSwJ1VuS6djfnGqPDDWjXC3o=JvYkCuOAQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] HID: Make driver_data in hid_device_id a union
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, linux-input@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Takashi Sakamoto <o-takashi@sakamocchi.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Aleksa Savic <savicaleksa83@gmail.com>, linux-kernel@vger.kernel.org, 
	Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	linux-hwmon@vger.kernel.org, "Christian A. Ehrhardt" <lk@c--e.de>
Content-Type: text/plain; charset="UTF-8"

For the record I did attempt this in the past [1], this approach was
rejected and a series which changes driver_data to be always an
integer was created instead [2]. However, I personally much prefer the
anonymous union approach, given that it will already be the case in
other subsystems. The HID subsystem doesn't need to go its own way and
the alternative is slightly uglier in practice (as you end up looking
up from tables via an index).

[1] https://lore.kernel.org/linux-input/20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk/
[2] https://lore.kernel.org/linux-input/20260727-mod-devicetable-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk/

Reviewed-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
