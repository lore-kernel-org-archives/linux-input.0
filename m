Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794840849;
	b=T8FHwU0Cvq7M2LcDnp2RgiiBGAyIwGVK00DsAVfeD2lHeTx4xe+YAF/pQga7YCNfYYKL
	 O6gdy+SsPi+Mci3+XRB7yf64HzZ3tPp5lKSAY9hqSrATPe2ikCqnRZwGXnTC1RPopTnOc
	 ugI2nBAgFkEgoPwB42jl+8glmAdYv7HTOq9NLdCwkN7PWjkcWjDBzxx08qyeiO8Mr1mJk
	 egAdRffNIzmnCHZmMDmVc+jdZeC8iWMjbQPh2jrl50+aEPz/wAIAD9HsUupn4t4n9jn6E
	 zvl8mEJhq+ByWZT3ii/seGXHBziyTGhjyt6M/PpJr4I5lXaCH5NDE9zIiJij5DENATg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=WIApOm7lPIj6q7bZuws0uGQ6LAfOH5frDdzHGgC6ryg=;
	b=lZ/no8QPkYeLi+cCgBSMXJIy5XSpVcYaN7PS6MlXHi5QgUfNoRfZNpoZligIxMMK5qWP
	 8A5VAMLHEeFDofzBIJlGbwzaWnsIkOC7l/X0vKxpaW7kP3mkiQYZQMnMmlSEFZEinwaBy
	 Wq6dgxY7lTrDoCnbPkDabtx/Atc/nwyj0s24DLpJuZ8TzfOi28cwKWtXCSLxKldPvmX2z
	 ypUENTDXnW/T62uxcsiI2t8yo3540Fq4uxCRdZXhr5lucN8O0RCQxP9aHAkiCoqWwnph8
	 6lMDoRBy8Y1bdGbluNWg5oNz986yub3y9yNQEm7d+Sa2OuviTvHyU0PQgkdmU9WZaXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q7fewveR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABE7606A32F
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 14:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BABE7606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q7fewveR
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so5019909e87.1
        for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 06:54:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794840847; cv=none;
        d=google.com; s=arc-20260327;
        b=f80YBJhJy8NRBPd7ShyavaEvxHjGQh2iw+RjuaJivFeKSMzELvvYkGgLR4bgqGg49W
         zNujcMf04MbdFc6KMPC49QfKc9aWdN7kX3xc/xKQ2seo9VaBFt7qK5ULFs69PbS4p86u
         TsbhmN6Lqb6ixYkHC8MhZV3xArKRq4k3teT7jcKQECvGA8gIPCU5L6y0yXs4UGT43qxG
         2h+wS3/OO2cDBINbkZJSexAbVjSkCqgT6ADiqFWypMkW9RnthhseG5sNT/ogi+RREZxv
         z0I3cpEmL+ZQWv8adXAV9rZhKL5rTaOnW5uiWuOL+I32hQAgGg2U1fkakvyOc+728q2k
         S0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=WIApOm7lPIj6q7bZuws0uGQ6LAfOH5frDdzHGgC6ryg=;
        fh=QBRj4p4k3geAuvF2WSiVLGKXZmHqCuQAf/1wieg5t1c=;
        b=cU1FnoG/vL1rir5LW9WEB0XpSzLxMfEz7Mf+vuhpWDBPVCPbMrjoplZrCq3C2ZcGyV
         5hgzNh5M58ZU7KQ2T8E3IdFIzCFIPn12AMhzNogl8POJoRiKAsvqT9xNaEdRFP35OD1u
         AyJRrqcvjucd845Tidmp/qh6H5V+RWL4ds3LuWF4vs7IIUtvGtgU2esS/xWYO8rmrBn7
         5JrW8qqgVQRD7BhtY6BhbRPjufveYSg4M4UKZJ7bNxJrnShWc2PXyUT5jG2TrGzO3KG0
         maNXyyYpeKijYm9gwuXsT+nI04DHlj1Verrga/seEDJ2vVL75eF42oEodFNn8Qd7r2od
         SWyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794840847; x=1795445647; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WIApOm7lPIj6q7bZuws0uGQ6LAfOH5frDdzHGgC6ryg=;
        b=Q7fewveRrehEjRutx/AQAP9nGicOInWay2N1Y2BadIW+YkSHjhD41nWZPNZcVJDjxB
         C2ccC8ZxqkAsjNjgz3gQOgTU7kUIdYN0u7ZssRxHdFp+lPYKDE/ChehptDrukAryrHbx
         8zyuLBsjdAQQuvJG/OuTAawdcAiQiyU9HctzAQjjAInYwJt+QaPO8WAUdsFHcx+i24Bh
         xwZyi5HXMKBuOLGKgYe0IaqAa8UTNgaf79FEvGlU9Mn/JhkPNrGOSdnyBFqZ6jA4LdTd
         uSC36/mx0U4dvBQqo3ZqSOtqXNhd0gLB/F6aVebDDWyv/goFQwbDpeWrmH/4pI83Swx9
         Q2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794840847; x=1795445647;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WIApOm7lPIj6q7bZuws0uGQ6LAfOH5frDdzHGgC6ryg=;
        b=tR6M2CCDMAHfN/+akuoIBvsF2kLigGKvAKA3qhauL1c7I2p8pp6z+SwsYYjObzajXc
         YKG5TYPGSAj/imCbU/RKOH27//DVfDO7J2iCHd9knyEvw1jxba5mf72h7zCwu6VUxjYy
         MScOZImknSH7/neet5xSblCb0oR0PrGfCGROcQaKa0UlaEiHLd41MhYuItP9YeRF0zGk
         T0ZbzPvKIScXaA+RPY1PXBTWa5XX8/6E8RQm78G26eyl4N3OQhgwuNY4dvKppKunbay1
         uRKzpyYoDthRlaOSTRCxo3/hHvg69fTkoY2qyaY0OEm3mZx+7Eenp4gIzZzNK1oByGoT
         IE+A==
X-Gm-Message-State: APuU4Z/GPYXhbPGwD+QQrzQXkUB0AZ2i4QPndydZuei9SBF8lnHSGnhA
	94czeBQILQeXxyawB3l9YIu9kvD8yQEYWAHb6lMheJnW1D6iN0yqL2TFaKXZj8gAmKgdC+jqtrM
	gtT8bTCQVCSmSXAaTuTnZ6aJHohMd3lLZACG1
X-Gm-Gg: AYBFou3yyWBg/Y8RexYGJvz1qxKOTAitBZMqaRTtQPBG5e6iAnEbZi3NQP7e0DNOmZY
	9NJ6RMwZrzQggrNdBQL9m2vCTNEFimI8CM8TPrmWfrv5l1wuAZqzGkHCsQy1f0t6O+YJ4OJsy3U
	yLY4gAgMyW1dTDgga5xbpjge7V3O6AlWGp890JiG9SBRoXasBGcMbU69MeQiJDuKnIVYHESdQke
	z2nczM8z45e9tKri0RIcM5fid/lZZODnzVg7ztMqiAXPHil+TXe0B5tti0h122VPLUygXQlJ5eQ
	GazT+9Y8mw2l3c1WiE7ps6gwswWtBkFDa4vFMI93RzY0srdFWQ86EQQJx5qhvszT5j3OlNFPST9
	stv6CYTwf5jXqr/x13dV5bsRz41yvtjFbSjwNU5/AXP8UV3OCVcU7WBy2f+MzlTHTeU9P
X-Received: by 2002:a05:6512:a84:b0:5c1:57b6:5ffd with SMTP id
 2adb3069b0e04-5c17043606emr4019894e87.0.1794840846748; Mon, 16 Nov 2026
 06:54:06 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Jakob Golasowski <j.golasowski@gmail.com>
Date: Mon, 16 Nov 2026 15:53:55 +0100
X-Gm-Features: Aa3M54rhwFZ1ChA4CYIg-DW5eYt5lhHOO3m9Nofa20nPZhXmAH0Uodd-oP1P96E
Message-ID: <CA+5f=NYJA0BtUMtRs6ZpLxgngjd1FWjma1UvpB_9cv7zwHV3qQ@mail.gmail.com>
Subject: Input: synaptics - Dynabook/Toshiba Portege X30-D (PNP TOS0214):
 AccuPoint and buttons not working
To: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

On my Toshiba Portege X30-D (PNP ID TOS0214, not TOS0213 as in the
existing InterTouch quirk) the AccuPoint and the two physical buttons
above the touchpad do not work on Linux (Mint, kernel 7.0.0-43-generic).
Both work fine under Windows. In the BIOS setup the buttons work, the
stick does not. The touchpad itself works.

Touchpad (dmesg):
  psmouse serio1: synaptics: Your touchpad (PNP: TOS0214 PNP0f03) says
  it can support a different bus. ...
  Touchpad model: 1, fw: 8.2, id: 0x1e2a1,
  caps: 0xf00123/0x840300/0x12e800/0x200000,
  board id: 3323, fw id: 2553465

With psmouse.synaptics_intertouch=1 the touchpad is bound via
rmi4_smbus (product TM3323-001). RMI functions present: fn01, fn12,
fn17, fn30, fn34, fn54, fn55 (no fn03). No stick or button events
appear in libinput debug-events. rmi_f34 probe fails with
"Unrecognized bootloader version: 13" (probably unrelated).

Without the parameter (plain PS/2), i8042.debug shows:
- pressing the two buttons sends packets like "84 0a 00 c4 00 00"
  (second byte 08/09/0a/0b for none/left/right/both), which are not
  turned into events, and no extra input device is created;
- moving the stick produces no packets at all.

So the buttons arrive over the touchpad's PS/2 stream, but the stick
seems to need to be enabled first. The patch for TM3322 / TOS0213
does not fix this variant (TM3323 / TOS0214).

I can test patches and provide more logs on request.

Thanks,
Jakob Golasowski
