Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795372377;
	b=HQHek6uNTWb1gKHeZh9M3cVXJxfV4Dvb8Wk4D0kugGQYON7qvzx0mIkfVJJcY48dvc/T
	 sVM+RHirG4HlWpTrHsSxB+i4ZqkLwPws0na+JGkvCRuN4HaElpv58MTwjm2/dVsxxi8QI
	 2GQyT2XAtpgIRSIvvM3JcREeIMd7qCJe05WSvNFt6a4Xfil1Drn+0AaGqHWLveXsVDrOi
	 LCRlhtPdWOfPL+HvqQR8sZBv0Yy5zA/aAej4Cz34AK5JMfUVgIqEVNtS8q0zt4ELziCJE
	 n++7JZz1ZpYrJtU+qEjnD6BGFlfEhdEpI42156kcUvQqts//43MXMf5TrdUwbEMd3MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795372377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=X+meJuHf5F58nCaEDiUBHnNkHw6+quYPT+/xls6VrBc=;
	b=wER5Vcy4mc1lk7nyIM6YFKlFWanpPPORD1NaqEd4p0iN3W0M3XdNqoPYN8FNWR93ljXF
	 HS7AJn/I55sadr1ek0lOGPtSrC4fFcrCyr9XCTGB397UG1P54QeyR1K/7rb+5IdeGAM43
	 8LRMmcXTwIp0uYNHyro2yC12/XelJqDdhS63TyOkuVMmvEG2BFHCMUJ7lKg8iahzIlQK9
	 HCQf5dnUmtAYrFfaHs4NbNgA03VDT3oApa9gX36Qcktl20tMsOQDG6QC5Ig5CS3ohOPqK
	 iLhwBm6cPJnHNhtd1EcbRiHGRTEdtCthIKfsTagVb2jXmuGZ2gQi2tO4rukbJslwgeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R8kVJrqS;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D79606A320
	for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 18:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17D79606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R8kVJrqS
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c516a1623d0so96559566b.2
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 10:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795372375; x=1795977175; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X+meJuHf5F58nCaEDiUBHnNkHw6+quYPT+/xls6VrBc=;
        b=R8kVJrqSbRDhpn7yx0pZTpEl6EXd4sinCjpp76E/qzkiaC9BUywwbAmTz5u8b5+eY3
         zmHldpnpI2a2euf8TO0gPSXPSrCyrnb68+63Xn/okQqwpwdaTy5rYCJogzDkm74wRJal
         1VuTJrvN69o2c0AK0hh8BzVzy2V21x9veiVLYflDcJYxtPhmf8mbO4vZ5BJzRWqHZ2f7
         1TVx/Yavuqr/4Jx3cGyK7LBi4imYQXfx1DxmFkHQwuTpqn1e0ONyM9ubktEnnAcbLlqK
         PxvYXiufXVevwIXcmiTBIdp2pb5g7lzK2T4P0ZumpcoLtthptwAcAxTJlNOtXLg4iedV
         bW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795372375; x=1795977175;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X+meJuHf5F58nCaEDiUBHnNkHw6+quYPT+/xls6VrBc=;
        b=v8vEJdpV57RIOvSZ0qSE4pb5RlBLuCC/LU8eY8nZLpgsIe/8n1y5PgEXxr9ZHZ6DQx
         dbnnvNieMlSGXdOJviK9VSbPqjre3RVb3CQw/G70SkTeScx6CX4eqQK6Gl8V3Mjgtpy4
         sPwBV8trNs2pl9dxsKvrs2XwldaWeO09Ou4pvfyPPiQQXzyfc3j/nVJ3uqJFk1WSP9x7
         dtOUGGbxLS0fjCSGtt3sMEx1A6knnp/MIr97y/LIGgrPY7FjbpUC/+v72FIF4MAQqLYO
         s+8kfx+1TowiZHFb6XkjtMDGCLyObuiwho2fV72e3FCOZL/SjDmG2Us4QpRWsidb/1DH
         T/jA==
X-Gm-Message-State: APuU4Z9/WnwlTSvE/O/CNOPZmf4QtNQW608LcMajpsNaxcHy0meFjQ1r
	X6RW6diKt4j0GGnGk8n9hCpUVyuzU4Ujjqt9a7w51/O3G0Bs3OPC/ULz
X-Gm-Gg: AZFdTZcRgrklZNhFPAw+lLw5FHR3s0YvJVtYP+fWdWvFX1ooofTCTlI17VcouXCqPur
	OlubBUVlB8Aa5aU17kD+Yp32P+MALOfH/S17BIlIJImFQlLsQ8kekA5iRAdvd2Npr2bp5Rge+u5
	4aV8HpxQYUMsJoUCHdVXmI+JTEnw8Fun6XD8Mb194aaTZYyXYGJrL8yYVmeOod3gTLEWviWzEy7
	3nJIIVYSKPbjJl67afSg2Z6OlxjSwoIuwyKBXQtdIkmpdG/9BngIrVCliJTkB6LnYzBNSu6u0n/
	Vw96rUmR1K0Bh6ilrYHzhL/s4+HSo3NZ8BPeUaqCTCk5PgVvpMuSY0FTcpgFZK8mRhH883shzHQ
	kMbvDXOjhXQi4dLOISS351yJONOZl3RKlPB1pEglz3jYwYdlHKHEXU7QyybvLe0nSVhPQq9JOdd
	PIwgANisqFBQui/ZpM2dj178sCkIKoNFcavRTWELhsOzwVSAOr0rvHciCQpILMNpN1KeEgmGGji
	B6NsbzpA2fjGevWz1+ZKWRfuk08+FxpzcUJpN5OPYOiGddkj2vgZZ8zLSessvxcZkOBRXeTWB0b
	ePq8M/+5cW/SMJG/9+sPa7Dg8Tv2ORm+8qlBrBO52P9M9xpZOZNK4VlgLSWIrLETD22V6MBS70S
	1rtFtYUia6qk5X5RYXvU=
X-Received: by 2002:a17:906:7c2:b0:c50:f0fe:438a with SMTP id a640c23a62f3a-c513a5e2526mr651298966b.8.1795372375267;
        Sun, 22 Nov 2026 10:32:55 -0800 (PST)
Received: from fedora.localnet (81-224-151-184-no600.tbcn.telia.com. [81.224.151.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae6841asm342978666b.24.2026.11.22.10.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 10:32:54 -0800 (PST)
From: Erik =?UTF-8?B?SMOla2Fuc3Nvbg==?= <erikhakan@gmail.com>
To: bentiss@kernel.org, jikos@kernel.org,
 Michal Pecio <michal.pecio@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: steelseries: Add support for Arctis 7 (2018)
Date: Sun, 22 Nov 2026 19:32:53 +0100
Message-ID: <Rv7nePC3RfOSidIKv_K-KQ@gmail.com>
In-Reply-To: <20261121121129.2a1d3013.michal.pecio@gmail.com>
References: <20261121121129.2a1d3013.michal.pecio@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi!

> URB status -75 is -EOVERFLOW: URB buffer too small for data returned
> by the device or the device babbled (exceeded wMaxPacketSize).

I can't reproduce this locally, neither with or without USB hub.

But it seems someone else is reporting the same on Bazzite:
https://github.com/ublue-os/bazzite/issues/6344

It seems the hub itself reports that the port is disabled, both in this rep=
ort=20
and in the bazzite report:

"Nov 19 20:47:58 [REDACTED HOSTNAME] kernel: usb 4-1-port4: disabled by hub=
=20
(EMI?), re-enabling..."

"Nov 15 16:05:59 [REDACTED HOSTNAME] kernel: usb usb1-port2: disabled by hu=
b=20
(EMI?), re-enabling..."

I was also contacted by someone privately regarding a completely different=
=20
issue, where the dongle sent incorrect battery responses by reusing the buf=
fer=20
for the connect response, which caused the battery response to look like th=
ere=20
was only 3% left.
After digging around on the internet, I found that someone else had already=
=20
found that on Windows, the Steelseries software waits 10ms between requests=
 so=20
I submitted a fix for that here:
https://lore.kernel.org/all/20261024-feature-arctis7-v1-1-583951aa6583@gmai=
l.com/

That too was on CachyOS. I'm on Fedora.

It seems like we simply sent the second request too fast, triggering a bug =
in=20
the firmware.=20
Anyway, I have a hard time figuring out what might cause this, and why I ca=
n't=20
reproduce it. From logs it seems I have the same firmware version as the bu=
g=20
reporter.
Any suggestions on how to go forward?

Cheers,
Erik

On Saturday, 21 November 2026 12:11:29 Central European Standard Time Micha=
l=20
Pecio wrote:
> > The headset reports connection and battery status on HID interface
> > 5. When the device is disconnected, ignore incoming battery
> > reports as they will incorrectly report battery level 0.
> >=20
> > Clamp overreported battery values to 100% and add USB ID 1038:12ad
> > to the driver's device tables.
> >=20
> > Signed-off-by: Erik H=C3=A5kansson <erikhakan@gmail.com>
> > ---
> > Information available online suggests that at least two other Arctis 7
> > revisions (2017 and 2019) exist, with different device IDs.  Without
> > access to those devices, their protocol compatibility cannot be
> > verified, so this patch only adds support for the 2018 model.
>=20
> Hi,
>=20
> It seems that adding this ID here (or some other change?) has caused
> regression on some hardware, reported in bugzilla:
>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D222298
>=20
> URB status -75 is -EOVERFLOW: URB buffer too small for data returned
> by the device or the device babbled (exceeded wMaxPacketSize).
>=20
> Regards,
> Michal




