Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch [109.224.244.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658A2344DB1;
	Tue, 23 Jun 2026 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782199800; cv=none; b=FnM+6Bb2ng4dzgKHitYAqfv47NaRojongMaE+S5Rm1jPp0DPIp9F+gM6OwTY8VowZ7ouHzNWV6T0ZaF2quDFwLabOmIS8l1K/mNbNtqxochDQkkSFFOGbqLJbqwg675AVhgLxcJnBNEqjwIkpE4yhghwXs16ZpajVwC+ghQT7SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782199800; c=relaxed/simple;
	bh=KMk4+UpY1tucOrd3M1WYKBaRhOiNERTxzQP+PYfa13g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f811pMgWgbPHB1tj7l7BYg2YM+9oNEWLLhh81qxlh2VygO5ivllOECASm5nINtPHwqbRODiE/hjFQsniP2OR5XtKiGd/5sS/usC574u8ug5t2Ohif+SjdqC9I5MPmR2dzt/UjASs7wB7AV7KBWAet/IqMhyOnsxL6aB8nKVHjdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GlUgLY1J; arc=none smtp.client-ip=109.224.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GlUgLY1J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1782199793; x=1782458993;
	bh=DPX3vJ6VjtVf13lVpQIdZ7MpYcPAWNqpPi38FLSMhxc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GlUgLY1JLFMOdzxhwst9nJJ5C/nPrOUTQtLuCBHiQwV/C736sahcQ6pudqOeAw90n
	 Lbrw0v7iHbQlAv9EGLAENkllJo/UDtqCmyjcB8U4Tx9JLuBeqSBpt/al6wWgBhNijv
	 0YsT4RZ0K6nDiZUZV2DalawU6lDBplBirbODls3DcBtlj1MYvU8PNtpVr3JkSMLFeu
	 EhF/k3nIu6h3xSYicvl5IXOhpAQc+iZ3RzmF2bTnDIw/1iCicBdiBivBUjLS8enEhH
	 R/f9SXzl/MquofTZ0nKmg7ln6Ze1fVquWvcs4HsjXulMU219G1z7tkU3MUd1aMsMnM
	 jSlM59ow6+9Cw==
Date: Tue, 23 Jun 2026 07:29:45 +0000
To: Andi Shyti <andi.shyti@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Wolfram Sang <wsa@kernel.org>, itewqq <shipeiqu@sjtu.edu.cn>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - bound the SMBus block read to the caller buffer
Message-ID: <20260623072935.276387-1-hexlabsecurity@proton.me>
In-Reply-To: <ajoXuK4DrgSriiww@google.com>
References: <20260613-b4-disp-2e033955-v1-1-43ab7281667a@proton.me> <ajoXuK4DrgSriiww@google.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 6ead51569519df1a2340ff22c977903736019706
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2026-06-23, Dmitry Torokhov wrote:
> Wolfram, any chance we could get this in? I am getting patches for OOB

Andi, looping you in -- MAINTAINERS hands I2C to you as of v7.1, and this i=
s
Dmitry's 2024 i2c-core safety patch, which I just retested against current
mainline.

Dmitry, it works. You asked me to try it on the rmi_smbus stack overflow I
reported. On current mainline (master 502d801f0ab0) the patch applies with =
no
change after ~20 months. i2c-core-smbus.o builds, and so do the unchanged 3=
-arg
callers (ipmi_ssif, pmbus_core) and the 4-arg form. Nothing takes the addre=
ss
of i2c_smbus_read_block_data(), so the transition macro compiles for every
caller -- each of the ~82 is a plain 3- or 4-arg call.

The concrete user that was missing in 2024: rmi_read_pdt_entry() reads a PD=
T
entry into an on-stack u8 buf[6], and smb_block_read() hands that buffer to
i2c_smbus_read_block_data() with no size, so a device reporting a block cou=
nt
of 7..32 smashes the stack. The 4-arg form bounds it to 6:

    -=09retval =3D i2c_smbus_read_block_data(client, commandcode, buf);
    +=09retval =3D i2c_smbus_read_block_data(client, commandcode, len, buf)=
;

Why 4-arg specifically: the 3-arg default (length =3D I2C_SMBUS_BLOCK_MAX) =
is
byte-identical to today's code, so the core patch alone doesn't fix an
undersized caller -- the safety comes from moving each such caller to 4-arg=
,
which the rmi_smbus conversion above demonstrates.

rmi_smbus is the undersized caller here; the other block-data callers I che=
cked
size to I2C_SMBUS_BLOCK_MAX, so this is the one live conversion for now and=
 the
macro mainly guards the next small buffer.

I build-tested the above on mainline and A/B-verified the bound with a
userspace ASan mirror (-m64 and -m32; the unbounded value is device payload=
,
not bus timing, so no RMI hardware is needed): 3-arg/today faults for a cou=
nt
of 7..32 into buf[6], 4-arg is clean for every count. I didn't boot-test a
patched kernel, so I'm not sending a Tested-by tag -- but happy to add one =
if
you want a specific config exercised.

I can post the rmi_smbus conversion as a formal patch on top of yours (it's
ready, checkpatch-clean), or you can fold it -- whichever you prefer.

Thanks,
Bryam

