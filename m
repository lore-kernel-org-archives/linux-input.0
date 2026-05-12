Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A373EDE6B
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608473; cv=pass; b=TetVxu+KJERb+JJVX1bo7CSHz7HuBircUwCxMAI6kaz8e44HXOWJm/Er8snDSXFm/pdiiK4hgyINRyZmC8SOP44ZmegjOU1tQRcBiFR4JeTnWEH6wHipSCcCtWorXI54Kj3dwshVuwdSw9MktWqKq94Akb9QAp/3dDHDjas4DgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608473; c=relaxed/simple;
	bh=4pDyMhr5uGS380GtBwgN4Uu4uwMBfmqkDoD0H9P7NHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tx4Dr1Yp9BMGI2qW644xqX1GDHTN3H9kvZQI7MNJQl57eIfs/vupwd+5kxceUFokTj365YSWNM/TxhbokgSVLQrwwKgQGHD9LIa36ewdLs28F0NkfCxGYo3Y2A/W1erd0nKqzJQpMnO962L1gO7+2UgrRCK5/IEfCxz1EO4eD/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o6fJUvPW; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6fJUvPW"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8b59772d441so58129866d6.0
        for <linux-input@vger.kernel.org>; Tue, 12 May 2026 10:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778608471; cv=none;
        d=google.com; s=arc-20240605;
        b=g3Jor7omeYc5/bSWhqy00x3BiRmNvcNKu6dRMgmmNaMkXCXChMut8PDjguJqVuJc5Y
         G78Qq7TjI4A3jSJ4DoDd02xSy5XFmTL7yZH/heoq2h9w9e56ZIuW6em4aBUeSU/kJYlp
         /JrFA8eqRx+3ZUllZ+20Ub/hkqAVqn2YyBzRJMMJQtUrlAfbdLiOe4HJowEMhve4OVr8
         GSPFYER4+l6SBo2SHHxav/HBF03+6I7fOlA+XnKCffnW7JVMU59WgXVjQCpIqE98K7/j
         V3skoRlzxy1L1EbJnqJn7kFb9F66+F3/TgElY4bDvu5X5pBFx1aVjrEFyZmnqfGSVYEr
         L+fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6V/dI7BfU6SQAb6qJiqMnaHDUf532gyHk6REavVdHpE=;
        fh=pSf6W85+lWiqBqa+iiFfb2SH0P2UN1W6zXmK6Gz70eg=;
        b=ZOb4e0Tru/xVKtODKnqmcHoBDG8SOPahec0JOuqgQsbH0n8PjuVhYvEIWuSlEE7EFM
         T+B3MAWEybD8t43VlrDIPS7Vyol/d8JnF9fw/smWzoz/P9qgu/158//CNMCtnE3olrjV
         WEt8KS8Ug43tgxqnmSVwT7qXKV8igNxAH7qCYBbQwfPKSo66viCCuZlozHQ9OdJPAP0q
         TnThB3fgbSGAQNugfxvWlKjCKrRxPY4sTqSaiSfzpbJ1Eew/pRi9O7yY8Q6sRaIx9DKf
         dk0jeo11wXl25X7x1YgWay+EwCGqkdRSd3p5El7vZkKNDn54Mgmm7ffrHpqBXaz7NlGH
         E4kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778608471; x=1779213271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6V/dI7BfU6SQAb6qJiqMnaHDUf532gyHk6REavVdHpE=;
        b=o6fJUvPWHd5vLCIEAN42w9gJlFbV29NfPcwbzbFiihGmzxPA4Ezax9NRR6/GzCDr+F
         utQoZTs5DDWZK/Vf7BwmrW9tBPSjcnITqb0W0QOMCxGY8Z6q0FRpIgASdTuM4bhl07ku
         I/DK+UosAwXfeHiJ4lSfruiGngmr3WdeYTIZ3vR6BdlxPc3uPiuOoWQl3ZZrnQ7a0egv
         EjoZsi86ptZZU3JR/wl8RxCNO7t3ZfSJJjcpFdPw2WqtdE+NPSG8t8M5k2jqpz9yn53N
         t5IlOk46QTHT1+GMFUK6fCn6EjEVq4JeiY6BIVwZAlFcmk28bzLZaWCA9rJkxrEmUmyZ
         xaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608471; x=1779213271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6V/dI7BfU6SQAb6qJiqMnaHDUf532gyHk6REavVdHpE=;
        b=GdewU24DW2azD8tpuI7nbum/ckc3wFI6xzlTAyWvZMmExQ9xja8IQVOqd1JvttZf+C
         mRvekurW106VikJHwjOGhD3dCZYMz+k2tKqxijtKiec8a3U4HFF0WgiVxv8/V2++e17w
         KizhCdsbfZfkcDOvEuAgWW8fIqBg0IYfrhz0aOZrhzBOX9qYgQyuaUR2CEwaoxrXr2bp
         wNZh8xVjqfLfl35oFcu8oQ++Hn1hvQL+REQn81wO9Un+vWF0mAqIDkCl3QJFDNJGXU0J
         Z1izdT4Ffqo2PtoLD9ruUgHdDfXjXVJ7eqn3esc2CHB+pO1en7d3r+U+wL8dzOy9PQfq
         BxlQ==
X-Forwarded-Encrypted: i=1; AFNElJ8v4SB1QiWQvQ+98U2gMEMkUWg0jRllXWvGNUSAJiG4PMrzVWiTm+u4ixLC3CF98c8uPc18tf8O0Dv4iQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg++dtuvNihYEIzJB3Sq9s1H3HWtDwUcratp2k94k+VvJhwHKV
	CzdvjNGtBlxSDMkEkIdUOmQsgi6mCXmaiv5yRO6KSpJV0EzkQ4/F4nQuDnT2BsDsHOQuLhkMWuo
	wh2610vEVb5VlyZKSP9XNCgUbGXIh0p0=
X-Gm-Gg: Acq92OEifnHc6lt1LmGOHrO2+mXtoaEu4SXqns0kur6AODuSzoRW7WfdcllMhAnobxl
	U83HBg7X79VB7D750OoQpuDlqViAnXBuNJRGZyHKn6qbrru79DBCHL79wngZ6DYk4kaBycefTo4
	ktvnmgpyycIxBt8cgHeElee5qF74vQIRflqHpP9+xBzjPgebeol0UkHbTVS6Ybct829bTOQEanZ
	+MOy8S+NSWVfZhW3tAq46jkAIV7t2bcN3QUvSzIqHCn0zqS+BQDvyvmG0F1j0ll3tPmujsZSX21
	W52LjQZB
X-Received: by 2002:a0c:e092:0:b0:8ac:bae5:7477 with SMTP id
 6a1803df08f44-8c6636b53efmr52293406d6.26.1778608471093; Tue, 12 May 2026
 10:54:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510043510.442807-1-derekjohn.clark@gmail.com> <n533qs94-7o4r-p5r0-04p1-68q1398n5785@xreary.bet>
In-Reply-To: <n533qs94-7o4r-p5r0-04p1-68q1398n5785@xreary.bet>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Tue, 12 May 2026 10:54:20 -0700
X-Gm-Features: AVHnY4JgHMJKUiNg2AuyMgiSlUnVtaUfuAB2W9773w7jKTZlo-D2LmWGXSgL24w
Message-ID: <CAFqHKTkkKx_3uJboGSQ3a1ukF5W8Mv0+jneuB+jxVoSUSmpTpQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add MSI Claw HID Configuration Driver
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, 
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, Denis Benato <denis.benato@linux.dev>, 
	Zhouwang Huang <honjow311@gmail.com>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 9:13=E2=80=AFAM Jiri Kosina <jikos@kernel.org> wrot=
e:
>
> On Sun, 10 May 2026, Derek J. Clark wrote:
>
> > This series adds and HID Configuration driver for the MSI Claw line of
> > Handheld Gaming PC's. The MSI Claw HID interface provides multiple
> > features, such as the ability to switch between xinput, dinput, and a
> > desktop mode, RGB control, rumble intensity, and mapping of the rear "M=
"
> > keys. There are additional gamepad modes that are not included in this
> > driver as they appear to be used in assembly line testing or are
> > incomplete in the firmware. During my testing I found them to be unstab=
le.
> >
> > The initial version of this driver was written by Denis Benato, which
> > contained the initial reverse-engineering and implementation for the
> > gamepad mode switching. This work was later expanded by Zhouwang Huang
> > to include more gamepad modes and additional features. Finally, I
> > refactored the entire driver, fixed multiple bugs, and refined the over=
all
> > format to conform to kernel driver best practices and style guide.
> >
> > Claude was used initially by Zhouwang Huang to quickly parse HID captur=
es
> > during the reverse-engineering of some of the features. Since Claude ha=
d
> > already been used, as a test of its capabilities I had it implement the
> > rumble intensity attribute after I had already rewritten most of the
> > driver, which I then manually edited to fix some mistakes. I also used
> > Claude to review the driver and these patches for any mistakes and bugs=
.
> >
> > Assisted-by: Claude:claude-sonnet-4-6
> > Co-developed-by: Denis Benato <denis.benato@linux.dev>
> > Signed-off-by: Denis Benato <denis.benato@linux.dev>
> > Co-developed-by: Zhouwang Huang <honjow311@gmail.com>
> > Signed-off-by: Zhouwang Huang <honjow311@gmail.com>
> > Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> >
> > Derek J. Clark (4):
> >   HID: hid-msi-claw: Add MSI Claw configuration driver
> >   HID: hid-msi-claw: Add M-key mapping attributes
> >   HID: hid-msi-claw: Add RGB control interface
> >   HID: hid-msi-claw: Add Rumble Intensity Attributes
>
> The driver looks reasonable, I'd just like to propose that we name it jus=
t
> hid-msi to follow the usual HID subsystem driver naming standards, so tha=
t
> it can later be extended with supporting other MSI devices.
>

Hi Jiri,
Sounds good. I'll do that when I fix the issues flagged by the bot in
v2 and I'll try to have it out some time this week.

Thanks,
Derek

Thanks
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>
