Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661405;
	b=N6nWrPcf9Aj5uet5gSNMXnC2Nxnc3MV25IyDosCSlE9yiOx+PP5RV99XuQYT3kZSHzx7
	 CQ2yXh3+vCJgHs9hMDuEw47XepyINF8S17NpyojDLAzfapE5eJVarhKDv52zNxbkyRQ24
	 Vj0wqrA0/nlj7ny3nNg881yZu5/8/aQ0fLe07jcT0VHdg9iLjPy7mGWB2rodTJ4Q+pC8K
	 TNvpB6gG8DrO2hUoxG2r1rdGKEII/p5fayZlKsBAYXcgYSo7ZV7N6qx/F6y0FZ6wMlkB0
	 MLb+hbpCijCzIuM5gDSx1sERj8CSOLEYWn1IItUNqWcXz4OZ9kNcm3d9izMsDo+b0GA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BmeVPwr9SKwxZECZZ/qpqnmowyCWmqTyCjMYX/8OCrk=;
	b=o5Jm2Y2p9aUcALIq/4N/tB+w9uS+ePXdYgLLlWQfUT+/TAmdNJWsUFYaFAJGoJ1kc590
	 7wuqrccrsLbfLvYTxYG7Nbzzey4SO7jerEz7HZxUPETml0bxsL9Bb/KMdyFnNp0RXD/C0
	 0YBsnq4Fr+fF9jzRfGv0d8FCUL8+ley0YCzlyiBHFoTr6m3+fDuDfZdK71RRC4AUiqNG9
	 HAKAlxb6a2XSHuY2/Hp+sBeNf+GRfYmUurA3l3vOHgWJaeSYh3uL5O0uPorebdiLNwJdW
	 hVOJv+o7sS4PcUdpKfXOfy5ZZ1WyIwUXMtjare3ieSTzDu//+yHUGQE90ygIKzWqrbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=epBmNt2L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558C0606A323
	for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 02:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 558C0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=epBmNt2L
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5c0a520df2eso6557235e87.0
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 18:50:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661403; cv=none;
        d=google.com; s=arc-20260327;
        b=BUZQvaG1P2WaO8KPVN5Y8m8Akc3z44TW9DMkWUSLwoQABJyoEfxRDnSAZAkmxc1+hf
         /NUw2udVJWALO1P3M3fmKgMe07AJZKO9h0CWjMcmaA0dWKo4VBft0/WajjSh9Rer4aH4
         sHPtSHBJXFj2zk7Uhzl5b00kh18wrSTAvSXIk7Slvee1TnrGX13KXkB83wqHLilWwlIM
         rOSbkxicTFejB1miAoOSUxEXk1EVbqrDEAOyCuq8jtzdAj/E/PBSnbGrUZ4lPF0WxZ8N
         2il+n2gjvTce8h7wCOgWdivc2rLvb3R9WCtLi8ylM3sms8Sw1BeZj0xe4TVb28/hhmqh
         RaNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BmeVPwr9SKwxZECZZ/qpqnmowyCWmqTyCjMYX/8OCrk=;
        fh=Z5Msa1409krvrU7Hx/IaBDM56oKu1cKfg8rUDUYCsU0=;
        b=lL/SoagK2+QGW/dWNFiXCwUXbTyGkaqTNg8+8mKFEPZwGYOJxmKtjLGFznMEvlhdWq
         quM9B8Vp/FN33AavyxswVEyHEpa3ZhoqSyzeflpey0yy+2eBgqM6PB6OQZ6EUG+af6J6
         tREOh2qdy3WyzAXMBT+GFZUGhhoaCD3qyF0LUDORF0+y/2JW8iEu//e5KT84D1CRFBLW
         RvPZIRDcNyIEzgByQ9An+AKndocwtVXb47UWArz1WwUCXXUrnGS5y+jXtdM30PGdFsLF
         oSKDol1fU+xE4pb7DOzUhd+Xu76oyIRclQTiIxEhhISuG+oXsOUPs7NAGKEf+5X+NECa
         xHVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795661403; x=1796266203; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BmeVPwr9SKwxZECZZ/qpqnmowyCWmqTyCjMYX/8OCrk=;
        b=epBmNt2Lv7Dcu8bzZ4iBr1H6rQ82whFFTrCChG8DCgR1ptCnX78/BbmIpTwF8a7L3T
         eIPXH3FwV2Ahe+Ar796UlHkbFTMIfk6SUNGp7L68LZ4MBNU0clJ1pPuiegK5QlB44jdi
         XeuaJXP4HWpl033aBhoIISlJlOjGvc2OAxZoVeXxAxvPW9IW2PHJc3iil1phHrn3Qmow
         tp5LPWh7gceHx8x8+yaJbZCAaRS+Z/AXpVEVZ6ed8qMJh0n9XCgavhUR49jhSJi6wUd0
         91dLuVfikSCiKeUStFiicmpr8uIEOM1nUNOS25HxhleNe5g1sSWCjIUv8bha7OoZrHM8
         yDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661403; x=1796266203;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BmeVPwr9SKwxZECZZ/qpqnmowyCWmqTyCjMYX/8OCrk=;
        b=svxxDhw1Q0r/LVBH5nFnExopgT9X2i02+0bqL6KQxDhnW9MpcRCPVf+vRi0pc9QAkG
         hAjZY6hb3nwex5tXUbijrcRWrEwLbMe7OwgCFI6xPdVKztT8Oo2/yxJ5HdkeMDSxb5ee
         fjrIWr4jokqw3yc82RPco+R8jcjdlBGEk0y4E5ab9RwZQRnJTJaBln2XtlWMC7acF7T+
         T7DkCR8t3FshLmn64kyKRe+xpfU28wCYzhcwoi/IxthjSHzmwKVtYHGMmCFRSkQNwh2X
         WVpsP+m82LhbwFzueIaqC69gCFLYSWM16AkJbDA4Go/Ax18zE3fUk94emNnOcIKP6Xzu
         mvXQ==
X-Forwarded-Encrypted: i=1; AL+hErE5oDKwY7dayaAVY5IchLRNxW1azdu5CfhioKYDprMWNnYQEvsvi4O7nkHrG1Zxsw6sIDwMFc3eHlSKfg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/8lkiQzPoryb8hJDIPf493l0dJADwt4vFobH+oQB82AZpFoNF3
	BSU7fuWGW6kEkn3PqpUwV6wmIIDXhwLNLuYCeLGVTWUnxhYJl+VHmkG8+330+qnZpTdf4UHp8q7
	pDpRIaAk53vZNDqhQEv6HIHidUR7P/jTkGNp4iJcb
X-Gm-Gg: AZFdTZcdi8SVOac0am/sFOkwi/E0Btaw5xg6HvRpM5cKT3Fjv2RWin6W2/oqhnerKKm
	50NpllXa65sHBuF4K2LAAs3v6V8gd0mZBanLJweeagqLnoN9hqPZLKGfzYBcFVKjzJA496EMPW4
	YVR23vyxuSTTAHMpchbjxa+VVkZtatpWkGV0Ss0n561z2Ajxe3BDZlS+kHN24ahFEbClDiJAK1u
	0aC8EzOxZPhCnehyYCePPQMGZdHfn+TAHekoSBm3L1IH6gPDOkl2yhhQOc1Q5P9YWVIa6X8cO/2
	pej4VRWjHejEU40SdvRnR3o7Q26Bg4+L6ajuYtJne7cwN211sbqi+TXX523tVRLcqVw4tQ2Kp1a
	o9RQkTg7tvo/e57CVwgWEeH6SujgjM4moxSz5hN5/567KwS55GPxZO++Rl5etAOUzuJs=
X-Received: by 2002:a05:6512:1318:b0:5bf:b8f1:80cd with SMTP id
 2adb3069b0e04-5c1bc8c2613mr5298026e87.49.1795661403093; Wed, 25 Nov 2026
 18:50:03 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110020632.4003499-1-svv@google.com> <avKAaJxlxE8gOYVV@google.com>
 <CAKF84v00nJ_+2Tf8m66LhGEKvqnHb26YD6p+FRUXK5juYEPQZA@mail.gmail.com> <awNosbiWPFdsbUN5@google.com>
In-Reply-To: <awNosbiWPFdsbUN5@google.com>
From: Siarhei Vishniakou <svv@google.com>
Date: Wed, 25 Nov 2026 18:49:45 -0800
X-Gm-Features: Aa3M54r6fq9UxV6r7ZXlZATug1kAneGhSH_0CFFee4KvRhKktEz0ou5Sv9ToIW8
Message-ID: <CAKF84v1B6bu_YAAcdKkOxC-BKY8f72tWQMz2s5D3Mg-pMnEH5A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Input: add ABS_TWIST and support it in HID and Wacom
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Jonathan Corbet <corbet@lwn.net>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=81, 22 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3. =D0=B2 14:1=
3, Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>
> On Tue, Nov 10, 2026 at 10:57:31AM -0800, Siarhei Vishniakou wrote:
> > =D0=BF=D0=BD, 9 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3. =D0=B2 1=
8:25, Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > >
> > > Hi Siarhei,
> > >
> > > On Mon, Nov 09, 2026 at 06:06:29PM -0800, Siarhei Vishniakou wrote:
> > > > Some styli can report rotation along their long ("barrel") axis,
> > > > commonly referred to as "twist". While the HID specification define=
s
> > > > this usage as HID_DG_TWIST (0x000d0041) in the Digitizers page, the=
re is
> > > > currently no corresponding evdev axis code to expose it to userspac=
e.
> > > >
> > > > Because evdev has no MSC_SCAN equivalent for axes, drivers and OEMs
> > > > currently work around this by mapping stylus twist onto unrelated a=
xes
> > > > such as ABS_Z or ABS_RZ. As a result, userspace input stacks must
> > > > maintain device-specific workarounds to know which axis carries twi=
st.
> > >
> > > How is it different from orientation?
> > >
> > > Thanks.
> > >
> > > --
> > > Dmitry
> >
> > ABS_MT_ORIENTATION describes the 2D angle of the contact ellipse (or
> > tool projection) on the surface of the touchscreen. Looking strictly at=
 that
> > initial sentence in multi-touch-protocol.rst, it sounds promising:
> >
> > > ABS_MT_ORIENTATION ... The value should describe a signed quarter of =
a
> > > revolution clockwise around the touch center.
> >
> > However, the rest of the section clarifies that this is the alignment o=
f
> > the contact ellipse with the X/Y axes, not the "twist" of the finger
> > itself. In fact, the docs note that orientation can be omitted if the
> > contact area is circular - even though a circular finger or stylus tip
> > could still spin in place, and that rotation would not be conveyed.
> >
> > For a stylus, orientation is equivalent to the tilt
> > projected onto the touchscreen plane (which single-tool stylus drivers =
already
> > capture via ABS_TILT_X / ABS_TILT_Y).
> > By contrast, the proposed ABS_TWIST can be thought of as keeping the
> > stylus at a fixed position and tilt angle, and using two fingers to rol=
l
> > it in place like a pencil.
> >
> > This also matches the HID Digitizers specification, which defines
> > Azimuth (0x3f, rotation of the tool projection around the surface Z
> > axis) separately from Twist (0x41, clockwise rotation of the tool aroun=
d
> > its own major axis), and hid-multitouch already maps HID_DG_AZIMUTH to
> > ABS_MT_ORIENTATION. Since styli can report tilt/azimuth and twist at th=
e
> > same time (and single-tool pen devices don't use ABS_MT_* events), twis=
t
> > needs a dedicated axis.
>
> OK, let's add it then. But we need a more precise definition of what the
> values mean (i.e. is rotation clock- or counterclockwise, only positive
> or negative, what 0 means).
>
> Can we also move it below ABS_SND_PROFILE in the doc?
>

Great! I've now expanded the docs and defined 0 to be in the North
direction. I re-sent a v2 series with these changes.

Cheers!
