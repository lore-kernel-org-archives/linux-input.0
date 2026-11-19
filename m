Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795122005;
	b=jlpeNxbvG62SelLlrSyrKjGNAUYfYXspqKxy5EStm5hz9tUbx79tcqNx6VphFploYSLc
	 Kbtf0wz7raemQncLexz2/6nps0E/A8vou0+e4KWDQ/q6PqENSIvLUz5F/oVkPj/AVGmIj
	 5gVGNotw4kVz8BUu0Zrhk/5yYGoh5ki602EYPOBXCwL8Ku1RJZV/uZP3nF27usRltusSY
	 u2HhWpE9jw79t0C1Uu62jlDAWKJGOiM8D23lprbmW9k915S6HyCeJbCvmHZv11YFfU47i
	 Kiq+2uGIClUvDQm8m2jtbOkKCv/CCFgx/qOUEw34zPzoahCdvW9MkzuIkJpmLFBwADg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4PRTgK+XBfs6rrQNmcr8U1k3yYcuu2PtqIQvOXHP6y4=;
	b=aMN1qWQnZ3/HO/OrRAF4c480PZ0oBKek+aAcxIsPq1Mh+MrNeoZa1cxIwvZ54sBEtjud
	 wznRaLLTzJG6XjoC7NaUsxvReYXv1Nyx5pR174V3sJEZ2Yg8Vlz/IHXGdciSDZxbW0myo
	 5qc2rqowcqOBz9OtLHQbB+9WYRXARJkEkMx/H7PQJiFuPOocNZDuoynakP0XnANNdi4+Q
	 A+ErlNW59EY8vrel60qON+0DE93TgzXS19NQo5RFWlIY3vlU/RYiBk2HZNQPT9FXLHvZu
	 Ldz7IEPE5eZaxtAwcYVsRij/Cs+Y5iSiT0FLgwCS26tG4HCqIMnyLGz26EcGJEoY3pw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x2JKCAwm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA63606A32A
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 21:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EA63606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x2JKCAwm
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3ae25d9e2fdso1505511fa.0
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 13:00:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795122003; cv=none;
        d=google.com; s=arc-20260327;
        b=knwOdunO50WgUfycdsb8hOdmUA5Uo+fYVqVltXNDUIqP/L8ceZ3H47dex/N0KUrZXR
         YjSR3V3+VjNGYqMwgiMAx9jEi7BvUfltmlntaig4BlJua1MU7NUhT+grhHP+7wJTPXcD
         9T1rG7I8ZEOO2SxoBD4JGrblb8stE74+YeUGgWLHNeMedSLKZob8/pqLLyOrRv6RdWay
         BOqi+A2P1jq45JZYybONGu4uLA7IbOCsBGoItYYimtVVPsGvvZGJx113SHO6oID4m8pY
         LJxb/WEQ7iU9/JskJyEgA1ICkBOp6sr3boZWN3btJprmvEqA/QL6F2F+oa9ubLzNwYVP
         YQfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4PRTgK+XBfs6rrQNmcr8U1k3yYcuu2PtqIQvOXHP6y4=;
        fh=OAD937flk64qyqpHXysb9mpdYKywJTS583OQDi03+jc=;
        b=JKa/4TrZZOom3pbScyUta2flvABINYaa5lA3dGPPTFVlyPeAVr6nVaMNKlXcOmjSBo
         xPpo4YnOjsA4EM+lsbN+NxlqEtnPEdCYXNPo6sK5HYraj+x4lK7p6Hx+CmJx9aYpJF2n
         +SXr7e9HOfdfm80qJEqoeYECfDpEsaoICIEZWlLRkIkp77dz3LWnK7PyZLPwIFkB85gE
         6fwfvntvtkKMXS8+sLS1D08rCGqEL77lSRP0EPPfZ2Jc902ZDfvnnmqFJVY8WKxWIftJ
         qLHG4vJuAVlmUiFTRqkxdyteOE35jO3g+4i4RZsEEPDcSUDzEsxcp0878bBDoAzRJ20P
         yXRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795122003; x=1795726803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4PRTgK+XBfs6rrQNmcr8U1k3yYcuu2PtqIQvOXHP6y4=;
        b=x2JKCAwmL80xMGOzIPzMOYokK1CVXPBlMHtWajnFS5sjwetyyNmTNsMueiFrUOyXnC
         mKsHbzSJj/upHyonpcahL8Ol5KHe+QEZJ2XG5g4aXJ6ioB0ui1G8zMPOBV7Iqz5gM1ga
         +L7teSrxWuP9YqxSG53Fx4imh92cxg954ntc8uvaU3NYMREJsXBIYgyarMs8hGUiKeMA
         6wA1KSBI6hDvYAT/UAYwWDvC1cw/GI8DL9jCz3lI5F/LHf0mThA7aELDlcv9kay5Yayd
         J1m+yYkZpvL2XMOWEYuy1wTg8Ui3ADGo67wKkLhYjswojqwP7lnosWArIQ4B2CR6C/eh
         eiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795122003; x=1795726803;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4PRTgK+XBfs6rrQNmcr8U1k3yYcuu2PtqIQvOXHP6y4=;
        b=hBFF/mMb6SiaL524PTTFJ5BSF/lrx/Qyao8CG0QRZ2RueTEJCdRKu4wMTKVSuAkA/3
         /n6HYS2R6QOLpH+CAc5c1bHWnC7EZZPESRDglZKuMo7U1Ezlep7Fkj4iY4GwZpS0xcod
         CnoaBS75+lwGWsFEuAplthalP0u8pWngHZKeugk7YoBylNWfiJL3hL9clW4jUsZy7diQ
         GfcX/3fC3P6C0fy6IkPrbdkNPSKYPV9PWehmgnCuWkA94RzJI06vJJjPOt8cdxPCCUCS
         ZI0co6E/iQxVGgP28U12Btc0rlCsRbbIZTESSrC8bnczGFiyYUJvswW86TxSJQsVV+fJ
         nCNw==
X-Forwarded-Encrypted: i=1; AL+hErHFHW8Ci79mPJhjEnhVyjS+Ok2I8t4PVfyka+7OOvpiJt2LNvXrvkMlKwGoSLzJtjUxTlOq3BI1rfssEw==@vger.kernel.org
X-Gm-Message-State: APuU4Z88oIIRtx6lg1YY/T9kajb+nWRqkY70z9qMI9VGnzCyPpmGWFL1
	y9IYNj3Su65mr4ShcxH3LVzgzUM4zCrW8MjpqK4k55uRpNqbyg9OED32ShoIPJn5GFCURVhRg1o
	X9OXoYFcyCcOcUbPGVWqSXMKggBps9B4=
X-Gm-Gg: AYBFou0KUj2Rei5y6cWrzQqhnIpS9m9rpgIVwjvCcVX9IuuQLrdxWPzA2jbpeU55IA+
	Ftjnx+rTmzqDombfSjXBquKl1E8BRIQGHdXzy5XUOOIZTzakxAhZ0lv4WbwTsz5+rVzoDj2DDNE
	pzmTajadDR6qSBjlcURO/njYO2PrKWu5wUvighboHmFecEj8TWafXAug79niIqeMcUFgngjk8iU
	c6uS3vyIciacsok4TiF/ZXAU1n7YYvqywZOWYklqgv44Oo6swraU2QgVY+Kba2Jh6RIQ17o0FZp
	QwAwnydpFqQTctPfFpoIMCLl5JSvohUauo8+2ptZdTB1D31vDOWWEqFqLxCX+WLajixMeKNl+2c
	+JiOM8cE6A8P3si9I7SCIRl3RBdo4kLVvyg==
X-Received: by 2002:a2e:a10d:0:b0:3ab:f43:a3ca with SMTP id
 38308e7fff4ca-3ae7fa19f85mr2592521fa.16.1795122002518; Thu, 19 Nov 2026
 13:00:02 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261009190746.803607-1-dmitry.torokhov@gmail.com>
 <20261009190746.803607-2-dmitry.torokhov@gmail.com> <CANRwn3RUdGyEOJEdN1xUjEHwnBX5-UnpZZ+ZBBwY9RBB04FtUQ@mail.gmail.com>
 <as7D7idd-843CJkn@google.com>
In-Reply-To: <as7D7idd-843CJkn@google.com>
From: Ping Cheng <pinglinux@gmail.com>
Date: Thu, 19 Nov 2026 13:59:50 -0700
X-Gm-Features: AclHuK-FKMo9pTUAUuY-_Skl61pGFLfpl8fvgBseTqOHH3PJWBu_ZXGag0K_ky8
Message-ID: <CAF8JNhJjjCqxiZDH4mDEuTL+FP+Ugw6aM8RfhM_p9+zfNuphiA@mail.gmail.com>
Subject: Re: [PATCH 2/3] Input: wacom_w8001 - assign distinct phys paths to
 pen and touch devices
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, 
	Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 4:53=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Tue, Oct 13, 2026 at 03:42:10PM -0700, Jason Gerecke wrote:
> > On Fri, Oct 9, 2026 at 12:28=E2=80=AFPM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > Previously, both pen and touch input devices used the same phys path
> > > "%s/input0", which made it impossible for userspace or udev rules to
> > > distinguish the devices by physical topology.
> > >
> > > Assign distinct phys paths by introducing separate buffers pen_phys
> > > ("%s/input0") and touch_phys ("%s/input1") in struct w8001. Pass the
> > > corresponding phys path to w8001_allocate_device() during pen and tou=
ch
> > > setup, and drop the shared phys buffer from struct w8001.
> > >
> > > Fixes: e0361b70175f ("Input: wacom_w8001 - split the touch and pen de=
vices into two devices")
> >
> > Does this really deserve a "Fixes" tag? This does not seem to be as
> > much of a "bug" as it is a limitation. Userspace and udev rules are
> > (currently) able to reliably distinguish the devices by name.
>
> It is a bug as far as input subsystem is concerned and it was introduced
> in the above referenced commit, so it has this tag.
>
> > Obviously that's not ideal, but I don't see much benefit to this patch
> > getting backported to the stable trees -- especially when /existing/
> > udev rules aren't necessarily going to know what to do with this new
> > "input1" phys.
>
> Right. For input subsystem only commits that are explicitly marked
> as Cc: stable@ will be backported to stable trees, so it should not be
> a concern.

Hi Dmitry,

Did you merge this set? I don't see it in the upstream repo.

Thank you,
Ping
