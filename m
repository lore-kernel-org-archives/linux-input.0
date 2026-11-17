Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794949483;
	b=lq97P3h3YKXbCju9L+PMbFal4g09DqV/dPLAlBPKbt6KLSx8D8OuSuwfSApWCcSSSafE
	 wbpwIEWzbJbgUkc9HtVw7ULydbJh38Qanj90XlKof9TgKiTaOnnbqx4UA4k25bJ8I4lEt
	 LknGy/FKK2i2kS9XMGuDVjs7x2JTGH5H/+CluxQ2kVVAPislwkR5z1j6Mb9oersUpIhNe
	 Q+rkhwg9+wZl/sqieHVhy+BKSnlU4/iXpUU8+lcVkRHBwlSMi4dz8dTYpKrnM+GIznt2L
	 WFn3nL/VjqnSNTfr6OOXhrZpm/CN/T6jrNASOeOW/ve3umBiZv5P7De84rJnbBKlvkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794949483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UYXMpCZr40JhLgjGFCs7B67ao93hJVuGowdVTlsw5RA=;
	b=lZFkFdk4CeHalHCmob8HXpyVw9t73CXjSKRzkhlXZnVgwrvN/0Yvl0CUIWsyaHAZ+AkR
	 O1yYv370Y9tuiVP4OqH4SAXZm3zmb+i2RNC6LQPXpJn0ciTwuhTWLN4VDMVJKc/oqV6Dp
	 ylPEV7aVa7t6tgzFywZRdCN37FXKnp/dHzGxx7vDz4p8WbVFMPcJ2PgIC/T+DUtM1POvh
	 aUL9yf6xbfRTV4LYoTl6UGE8jbln/zlGvqznQvQCMUSS/icV7XU0O1fyoQdIvonvS/GYu
	 KMAt4yEUOTi9EoKRW+4ku6bpdDa/1bOs4mo7CLF2pMV+bd9aCtYhZRMuVmmF1FmIUPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jG74IsKA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAAD606A32A
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 21:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EAAD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jG74IsKA
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5c08539c827so163556e87.2
        for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 13:04:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794949481; cv=none;
        d=google.com; s=arc-20260327;
        b=OFrXmfSkQc3nbvYdG7CRmA1rwa0vangnj7n2iSfegUblBSgBZFXgdypzNWU5Lpn1rz
         CpaMHRKgrl3+Wzkqdb4aUJX5+IvAR9oU07R4w66JrcAWLHtHkM2uE/K+vTV6Aikyjb1x
         InU4qP5foSbCLYNO58S5qV0IljcrN4Uu5+fX8HCCvhIVuRjDuBw2tuA/anW9kFlBBtSG
         XZzD/F4fPsd1w4E4UZiAXkoDPXHWXWALHWRmzWDiL93yZ6zMwvW5lmh17ldU9FlOGq/O
         OJzymK9EEikpAO4c3R5OOwmd+KtyrsRfPXu+kE0rMeWGtHOLRh5AlQ2iCxGyaV2Wai25
         YPlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UYXMpCZr40JhLgjGFCs7B67ao93hJVuGowdVTlsw5RA=;
        fh=X8TQUL5NaiCNryiNxzTzAl822FOz3Uvh8Jy/tPavqYY=;
        b=oJx1uLSsqGcgQs+V3kZuQtZO19aIRghkDYs+snn6OQJD9RFGkGrs2w0M3rdiobqHNv
         Zy5xOk17IoPuqjNMKQ9x+EOK2J7PGnz0AcyYcvPHIy/I0szCfPXCm6vLsRatBggVRUzT
         PE4V4brlVQs0NcahTVv0dU+2hPg4mw4seoM4nmAA8ilrcJX+ppsEmVrhXCqLZ6Hy8Sqk
         WurjCWWUTKuXgfqz9hYBSYY1GVlqhDW2m426KR3hqyc3ubImzsTU6y4sdg/Qi97oGHjr
         zad8YSnMEc0cCkTmabA0kkO1DmM+UgpHQ6GbrJpz8yyoKKnzRdgLG1r3aq4ty2Qtq5AB
         xcPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794949481; x=1795554281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UYXMpCZr40JhLgjGFCs7B67ao93hJVuGowdVTlsw5RA=;
        b=jG74IsKAU0/3eUBXAExrzTbZvexpgkxvKHo6Fjnf0wyk7akctPyR2gZXYVMnu2GnMz
         5TBfqjm4aezdPWBFwye1vWmJ4+3xsoNVwagS0VDPuWuq99TKGpKVmIlfbPHUoy9DAeV4
         Jdy7tg4yMsosDy1QIJTYmSsgy514vTL87phXr0fHhjGRo16NeuzVXOmbPz/+oX792gcZ
         Yt57jmcHPlk/SDRbvnBefMbC+q4YmKOUdekUWlQVkOYRViFMPvuYKNmiF0A3WfV2TALu
         32UmsMB5Kl1r+gvtxnRnkQYRybV067vsf2kbE9Y/wjY8KCgao7i8b6kyxDNO/jMzEDVg
         HNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794949481; x=1795554281;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UYXMpCZr40JhLgjGFCs7B67ao93hJVuGowdVTlsw5RA=;
        b=idr7pWPAvD/QHQFRm6QYrXBI+ahhoLASuEzZpqci3IcXkb6VaNouEY3xsDP+wrGjjA
         +Zy35vVggSKwW6h4VsfxTt48y2E9Zhn9IbJkyZ3Rndj7idMUTlaV1RifLoMye7AXsW1H
         PydyQBxEDnwWsK3FF2zsk4v30nhg1uJndpDc9b/GUrNsPCwimgB+XVfEV73pPWqJZfMo
         1fujgWWoaTBv8dFORn80xPk3tluGDAqYbZJpwDNoWWgKoUY5/vMG8B5hyv6f5D3XEivp
         OLLMoBujwSGnOMyZmbdtJ6Mke6R6rWMwA6vsotY3X5kjXTnwIfulhLiY/yWgTRnqxMxb
         UAHw==
X-Forwarded-Encrypted: i=1; AL+hErGybxHlgXCYaMo58o8QzzIjEmnP60f35inXWFyoCfTPdzOmH0Qxj82ejmtYQzXCQoBh0A8p4LKRujN+9g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/1D1z+9Nr3XiNaNPbMP3YUGN28gSU2qftpPHh65vWTyzs/1722
	bwLKsJKjsoKQ8vwwiuQZLCvAOgqRP3N2zp3hlMwICE1hefyIJJODdE0WwMDBk8+PJSkFzPFXFCM
	hnYPuNun5Lpn5o/EiJe/hkrJjXOgjybc=
X-Gm-Gg: AYBFou0xLBqPdohoNJ9OGHVC6qO+wHsEV2qOYJsTEPoJtMmPhHjeLGZ3H5T+Nu4PzE8
	OT40VzFwvMGM20uolyYNOtOeGm8oJ2YaXF15pYrg8LL87XMFPpeEpOmmTOA8JLd12I/isfQsaMw
	ZFw3H+kWw6F1wY9+pGtw68OzRDY4EBev0GHwtw/7GNeVdNoDKNArvthmsTwsvAM6jViyYGShEds
	+OlOTbmer1TluQRkydX4ZDlGuxxiUo7jIMFmDaujb2bdhcYBF1yh0aJwiuJ1loj9ToiO/j5oqQ5
	WtOhHrv/uabBPGuvx/zF5WYO1iez1bNuhMpa898DOgKlTRnxFZSJBUrTVN9A+mn6Ey04qrCvMJZ
	OoNX2VhIzUISxEzO8ImJJ5wtOw/1DnTv3ShsjRr3ApGW808i+73XeI8zzYDPVAOmI8Lj0TtUi1W
	wqjITfHzpg8QlAbYwxNSCN1BjbT5Ht1C5j72NmW0o=
X-Received: by 2002:a05:6512:118c:b0:5bf:d004:a84d with SMTP id
 2adb3069b0e04-5c1a9b70550mr122321e87.5.1794949480966; Tue, 17 Nov 2026
 13:04:40 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115015219.476559-3-sanjay.govind9@gmail.com>
In-Reply-To: <20261115015219.476559-3-sanjay.govind9@gmail.com>
From: Sanjay Govind <sanjay.govind9@gmail.com>
Date: Wed, 18 Nov 2026 10:04:29 +1300
X-Gm-Features: AclHuK-YeRKPckIXAFZH6ie39-_0ZDn6-uOE1PNiW6KEE5xGGdUAdQd0J3K3qEk
Message-ID: <CALQgdA1_1CuP2nYfCbt0Vzyn1ve-ekCWm8U3YQy6eRBXMr0m-A@mail.gmail.com>
Subject: Re: [PATCH v13] Input: xpad - overhaul device data for wireless devices
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sanjay Govind <sanjay.govind9@gmail.com>, 
	Roberts Kursitis <roberts.kursitis@azeron.eu>, Krzysztof Furman <krisfur@proton.me>, 
	Dmitriy Zharov <contact@zharov.dev>, Qbeliw Tanaka <q.tanaka@gmx.com>, Shengyu Qu <wiagn233@outlook.com>, 
	Erich Sartison <byt.es@mailbox.org>, Kees Cook <kees@kernel.org>, 
	Elliot Tester <elliotctester@gmail.com>
Cc: Zoltan Illes <zoliviragh@gmail.com>, Bihaan Sen <stevewholikesthings@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 3:04=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> [Severity: Low]
> Does returning 0 when packet->pending is true mask a failed submission in
> xpad_try_sending_next_out_packet()?

I will fix this in v14 in a few days.

While digging into the XUSB drivers, I realized that wireless flags
are reported differently than wired ones. Therefore, I will also
remove pulling the FFB flag out of the capabilities report, as for
wireless devices the only place that flag is reported is in the
subtype. I'll include that fix with v14 as well.
