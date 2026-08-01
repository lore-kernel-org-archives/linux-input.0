Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E1B1EFFA1
	for <linux-input@vger.kernel.org>; Sat,  1 Aug 2026 20:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785617323; cv=pass; b=fC5oS4HWc5BhlM0Qtr1fTF8nxXRQ5j4ZxhWXRWUq/3vC1XEJCAaQ8LHWY77v0dAXQvPTzfeub3+oM5MTMvegNDrgRHYncF/K08nN2/FV0heLke2HPYjRddwu2Nzixp0meEgjUf49VXal64Ell5y8MIR278wxrxp6VBTaIB5S/5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785617323; c=relaxed/simple;
	bh=FYVVH9Z6xx2L/TtILXFBLUfy/6UVPix7AnYQEBk8K10=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=r9Ueq9PtXYSAXuuHxHgGAz4L6EN4C5gI7+uqSF1HX/Fk9UOa7GucW6oP35Rt3hQAteaX0gtqtumbgUJyUwvH81D2yj9e8c2OTGamOoZn8zfsrbNJfoLpbb7ZuhuXC6+OAlaZ6xRnORqbYY+CkUv3rxxzOaoBCgiVmvU8zl++shU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n6krdQJ5; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6krdQJ5"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a09ba1ab24so2672947a12.3
        for <linux-input@vger.kernel.org>; Sat, 01 Aug 2026 13:48:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785617320; cv=none;
        d=google.com; s=arc-20260327;
        b=N2hwOW22Aj0D0vREbq+r3tQuxFY/FRwwiFi41DLz1SkmRcdRME0fNi3hPEsJPqrps8
         I6XsTOoOHzh2jDawf8ZwVnvBOYIu4/nXkNJWvjo1dgGPPZfxByEWRXq5JgUJNpsBNq8H
         ZpfkQXVoQI2uqW2PbFTuf36NZQrBsS5f7UMSsE9ttQ95zchCJ8Meu3EcPRcj0CEhg+YH
         4p9OoOvRqYvaQYS/h45nhNvJhaYai3nLGF2rtSRGkxhdkGVmepZEAmAAEXdhhWDbe1Vy
         9itLPtvCwepfmE1L8eFViBa3KF7bs7dlyG5ROjs91PdCHPirVAke/V/d0Vs5gFphWLmC
         jTCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=rTqzz0I3ZH7JaMPTsFfPLtt1Gunb5JyU40Xvqov0VEM=;
        fh=Wl54MOfKHjjYU5HrwdpRMl8tk9fZAsihW5aejgkYy7U=;
        b=Tt5cGllwGoBxzc/yuVbG3B/Eyu7WDtAnfQdB+exjUmkQgep6iDjwzj+lDFXoi+2Ipz
         4uTSATLEEoCCVsInXBdlxM5d/RlFPEYxLk7/Cy9UC74k1PRi3cd/NZkIZ1nm9ahRXQMq
         HNMK73t/kCSackkAbw1jvMThHEJWCW+Lx9NfMaraxHkeRHQlrcXKqEyRSPy3l+QwfOt6
         zLLUFsdg073DnGPbmVNKaRm9+OltiBv8N6ReheNq5IuSKntyqlDe7OMijedCBxGhGeRv
         STFoFH1L0T/RJOp27JZtuSl5NNe7nB1Hq1uDFsRhSWO3lUJdyNkTvRcS9BzB0GDSajUB
         TaLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785617320; x=1786222120; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rTqzz0I3ZH7JaMPTsFfPLtt1Gunb5JyU40Xvqov0VEM=;
        b=n6krdQJ5ag8Hkw7kjuzrG70njEOXSpGivy1STTOI3V0rbSmDqF/i5JDr21OMTtAMSp
         Y+f0QPJEK1guf2I9cyFcJ8rFde3R4M7Slci+3WI7bUILnnTF46PveMxGZcDM6/cSUJxh
         Iz1nxZyp2ZH0c6WnH3+uaMWSSuirtcn9bAht5FYhU10qxH18aoX7dcIZZNl3TSkP2Ehu
         HWkstQQymkS9QRM57xiSfWSuLdvIMH6AeFl7dW3hTM12wwl30B7VglRa5mneIzONjiS/
         jNKris2xYgntJcWfroqUlrFG9G97CImXuHomAXEggyKml5ih8JFFuojPrvQnvO3h0dwb
         wsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785617320; x=1786222120;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rTqzz0I3ZH7JaMPTsFfPLtt1Gunb5JyU40Xvqov0VEM=;
        b=ruRDHhddIm3jZIHJqD5Eb4jqbazo61ZuYZ9RPjYVCuSWrwSyjCO2PlazogkQJ8iir/
         6u39QFIRp+6Kz4WvXlcNhAuHHadtwkKp3KKyJrC1rTbPAGUkNWHjE/9bhOir6UdojU4b
         GcrWA7Fg0BFNwhmgn5OxsWSI/qw9g5LmdFXWvpBPsnf9hUYHW3dWBH2twDJWUYGPiRMl
         drnvTKgs01Wb3P1uL9l4egUb4GjsdA4IUH82WTMHIUSKao6If2dpI9ujA72q1npMRFVo
         rfsHaSer1x8zv66uuhfU0o8CA379yTo3nu8tyJSer+Ti3NDMa04AbArvP7wUz0IGzMEg
         vEqQ==
X-Forwarded-Encrypted: i=1; AHgh+RoAqzMn9l1bacVhD1LgXPmDfibYVNLqQ9PMphgUQupzmGcFCDzhWYVbMo1jxPJe2m4pkmLzqdThzAdNkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsRYE56LO9obZlC0zNpB8E/DJEF5vCWMni0rMvgSvzwgvBc3Pa
	mGF9bVlPW5umqZxbT1PjuwhHVmfouCPT8x1pwq1ZAhSM1EhyQusg5Mjwpqh9y+D1xnq/sTJ9LWP
	gRpDTsIq4XKrdRPP6agjt9T9DWXuDXcYejC6UWeo=
X-Gm-Gg: AR+sD10qdcVbr5VTmCY7WT6OiMTrmnKwWXc3btXwtE9ynS2W2t1Ng4HeJOHrbp+I/0p
	g/03btd9rRU/2Fllinxir6l5HoE0m6EP8ZusFBY+i6DvWo7liEu3pv0C9fddi/m6wU8IElNWxMm
	/lqmsItxgbcox548yf3c9ObzZre+3MSpJ6TZtm9SUOUqewB6z32+fUfwibq7jQkTktr7MjMbq8o
	8QELS3WkodfFAZrLJmYq8/oEeyyk5NEAte8epW0GJIt+8Mn62KXkyZ2yP4epFAq4Pg7epPVv0Ng
	Tj98FJoOF3e5DbhfabYETMz+tp8idtH3bryhLmZwp5DY
X-Received: by 2002:a17:906:1d1a:b0:c17:cf99:6154 with SMTP id
 a640c23a62f3a-c1fe7eec7afmr254094666b.16.1785617320015; Sat, 01 Aug 2026
 13:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ruslan Shevchenko <adefka@gmail.com>
Date: Sat, 1 Aug 2026 23:48:28 +0300
X-Gm-Features: AUfX_my2s8AlyBIKdDRYUS_DETHq44jvEofm2kmjUmv9h_0QqDB3d37c339Bzu8
Message-ID: <CAJB8JAXa7nVzuhbJf-LMcxN08rEmhCkKKSx_UwfN5zd8AP0j3w@mail.gmail.com>
Subject: Re: [PATCH v2] Input: atkbd - skip deactivate for HONOR ZQC-P
To: donglin_lyu@outlook.com
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, Aug 01, 2026 at 03:11:30PM +0000, Donglin Lyu wrote:
> The internal keyboard on the HONOR ZQC-P (HONOR MagicBook Pro 14 2026)
> does not work after boot.

Confirmed on a second, independently sourced ZQC-P unit. Same DMI as
yours, down to the BIOS revision:

  sys_vendor    HONOR
  product_name  ZQC-P
  board_name    ZQC-P-PCB
  bios_version  1.09
  bios_date     03/19/2026

Applied on top of 7.1.5 and booted with no i8042 parameters at all. The
keyboard works, no repeats and no dropped keys, and the Caps Lock LED
works again. The observable difference is that the keyboard input device
gains EV_LED:

  without the quirk, booted with i8042.dumbkbd=1
    B: EV=100013
    H: Handlers=sysrq kbd event2
    no LED class devices

  with the quirk, booted with no i8042 parameters
    B: EV=120013
    H: Handlers=sysrq kbd leds event2
    /sys/class/leds/input2::capslock
    /sys/class/leds/input2::numlock
    /sys/class/leds/input2::scrolllock

Nothing else on the machine changed: the I2C HID touchpad and
touchscreen, HDA and SOF audio, and the platform WMI hotkeys all behave
exactly as before.

Worth noting for the record that atkbd_dmi_quirk_table already carries
HONOR FMB-P and HONOR BCC-N, so ZQC-P is the third machine of the same
family needing this.

Tested-by: Ruslan Shevchenko <adefka@gmail.com>
