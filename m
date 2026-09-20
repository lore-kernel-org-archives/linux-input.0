Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0AD37A841
	for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789891430; cv=none; b=Ovj2qzRiivHQWYxLS32XPY0oZAItkwQBsAsOZ5I1yrVPYszuQokL9CoLUM5Pm/fztAN+XoexnKQ5CdH23JE6KSeELStQAKUQbtAv2Wz7d6PuxQVSeUrnoX/BLKBjAG9C/sZOcRfQk9NhOy7XWJKqip3VD2G3MpEtkG18+mGwqMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789891430; c=relaxed/simple;
	bh=Z0d4OQuVPxjhNWxXkSShzbKZ+8ilquCHy9CrguP0E1s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rFYbzobU96NjAnFFDHIASfAyFEMjBNesFhMDtRfvtbhH090+VTpitINOtmsZ6qJFaScw2lFwoiaTODVGTLVX3sjpRawuRb/luV4rLVsh+GWTyOhqKwpoJxeViveuu7f/KWciwZQiho8p1CAK5idwfng9V5LdXQUnHy+Vlno+Z0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=cico0815@gmx.de header.b=XuN15I6J; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=cico0815@gmx.de header.b="XuN15I6J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789891426; x=1790496226; i=cico0815@gmx.de;
	bh=vpJrD4xECaK9hZCH0/+9b9ksABBzOtJ7Zo4lp/UYnwI=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:Reply-To:To:Cc:Date:
	 In-Reply-To:References:Content-Type:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XuN15I6JcaGmFcntQ6duyat0r3xuAhfre2Q5HOwHkRRyLJfbmaKdSCaNMmObUagj
	 EkHcmwVMbrkgNKSn5ABv27x97EhgicEMeSce6TqVamrq8IhoaWq6ZK5bO/Srs/oRS
	 CN0N30g1f+/8bcpoeOGb8UP4Nqw0Du/0neu5KEltK9o8n+leGbouOwzrS+LjEw0QB
	 uyRfowEmoOu2kEYWdl9I8LrlaYmtHmMo3Xqw80WpdvIi1VfQwBEuh1Ptq7KfRzX+i
	 x3SOo6SR/h0wInY/GjKJLwegqtbNc8ewkFhbPYgDNibMVJDcNIq1FhBKjXh2KtbUE
	 OOuc7h0souQxohqD4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MaJ3t-1xK78R1bKH-00PSAf; Sun, 20
 Sep 2026 10:03:46 +0200
Message-ID: <d005d3212d7018fda5aa2d2ab29231fd4c573f3a.camel@gmx.de>
Subject: Re: i8042: Fujitsu LIFEBOOK U7410 needs i8042.nomux (keyboard and
 touchpad dead)
From: Heiko Brey <cico0815@gmx.de>
Reply-To: heiko.brey@gmx.de
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>, heiko.brey@gmx.de
Cc: linux-input@vger.kernel.org
Date: Sun, 20 Sep 2026 10:03:39 +0200
In-Reply-To: <aq7SdGsoL82CFBZp@eggarch>
References: <89f36f3f5e4c2d07b9ff72bc0b355875c336e498.camel@gmx.de>
	 <aq7SdGsoL82CFBZp@eggarch>
Autocrypt: addr=cico0815@gmx.de; prefer-encrypt=mutual;
 keydata=mQINBGmJuf4BEAC2mMgTQ6wlxvNtof7lAOqzqRV1h9I97ZWVE9OVvfjLDaotS+M5hUFDz
 eW83A4ZqVwtSCN2wAnxPtJ64EQtlyb3nlK4w1DfjqkckMK7DR9QXSAXb8vcPhbsHntkcVstlwOafq
 tNgT4qFeOfxw7bkJWraXEJqZhF5zARStACd6jmIADGSrkc/PaFudICYjAVK4hZ97XF8G+6YeQ+Qq2
 F+hd4u5uas/hALPzkXhHsSxRR49bP0uCUKlyjpoJUoHZDv6TegVVkEo5yxgxa6j02OSGJQs9kRE73
 ixz9+bwtxCGWy+yG1qK2Oaq40Dztu0PfE49i+sIq6wsUqXlHkNKTcP98uCPY8fyVeMubo6e+YW4Zn
 r2X37PJwTiM4yw+JE+1w6vrl8bhNwZTBhbWiP9C9ih+taaOTaYE63/J6/qlMV9+64Xy7aqR2suzdb
 TWy5ghgb/U/QQeu9OrWiYhtOMGwDKLplPMIe5hfcDRiOcX+LQjyY7WW9dG0C2C6orjuxDlzO/pVWo
 vfvx2GRR2GiDghllSkHkbbxhSQsrCYMSN0hwrHpH/UThxfpKF6CeDtkg3aNDSOkIgRoDv2BD9+YMp
 9wu0idrsFz/5bILA16RcVOkGN3u8lkX+RA6AhT7a186ZhG1di19Y1n6EW/xzSCENt80OC6+mZF+uE
 9DX6qw5UMmO6QARAQABtBxIZWlrbyBCcmV5IDxjaWNvMDgxNUBnbXguZGU+iQJRBBMBCgA7FiEEyK
 SrorQEQH2D8Ub8CmZFX8paEncFAmmJuf4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QCmZFX8paEndxow/8C3sV8waUQOBO9IPJsAHJexHx98Ux4YX4DRPF4ZMv2tIN+AD+Fc5aUf7Ok/+N
 d5Vd6DJBKAdR3cur4x4uMj+o+0uXRuwxEKDE3z8HKF46s1pfgFyBBo4Cj7NoeRnxQCtHxuuz7NHYy
 RKmMbsLmiHWaB50xpMnayZVYSN3C+/8rWUYYQ4lkpQpqQfdt3qK6P/XlFQhQP4xojs03bTU+7di4F
 6M84YyNJMYizhySClrof9muZ2P5dEjpNJFjqI8ip7fttjtPVLk+0mxIYiJN2y2UgoEH6qdR8OQHS1
 F7+wJefBr0pGY5beveWHSCO5HoiZtZyTPL8SUz5rtrBfnY05m+lKRazAH47EDhrwpi2a6+cepGPp9
 Sqy7aNDYh4DqeHStym4THiBJwZWfobSPAjBbISeqjaSGjoNOhFfTBsSQR+Dlc3PS7w5aXHu+GRGYe
 hWWu6uoNPp1LISYkl4+3gmL0dcK5WQOFcohrlaukkLoUkLTVrxKRVM7rFVTGgzLDhJWkK20cF6UDi
 RTNKyH2zHCNEA0ArnlUlotAPqpdYbD6/BUaEazi9uiJHhXVsteJY8+X0xKjX666L9NQ7ydeXuZc+9
 usLd8kAIYn8elib6PbELVfMeLmcwMw47fR6zoZd9+sFCdwRA4PaRYZ7l6kKoF0ZyYcK1LxpBgdFeU
 67uL/fM=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ESkRjFVlX7VBT8A+uF+v"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:smqmrNkFc0J+/MjE2EWf414MPZr/umLT5CHeDc4UFgujsJrA5Ro
 YR9Z1Y7G8ELchtw2rnKZOmIDI9mm6WnNXQTd2qgGt7YlpR92l/J0zj4FZ0XtzguA6uuj1TB
 +wpzhsLqSFGOvXr1OgPav5FisLbr4YBdXbbaFeZN0hDruoOkEdmJvH2nysB61bhUMyId7Ho
 a1HXHoB7VYQd8wXpOstsA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rHZDS0I3jp0=;CyUoAxV8OGVstofN3oryL8Pk+Zd
 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


--=-ESkRjFVlX7VBT8A+uF+v
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Samstag, dem 19.09.2026 um 23:59 +0530 schrieb Lovekesh Solanki:
> Hi thanks for the report,
>=20
> On Sat, Sep 19, 2026 at 11:52:19AM +0200, Heiko Brey wrote:
> > What I tried:
> > =C2=A0=C2=A0 - i8042.nopnp i8042.reset: no change
> > =C2=A0=C2=A0 - i8042.nomux=3D1 i8042.reset: keyboard and touchpad work,=
 on warm
> > and
> > =C2=A0=C2=A0=C2=A0=C2=A0 cold boot. The multiplexing message and the Sp=
urious ACK
> > messages
> > =C2=A0=C2=A0=C2=A0=C2=A0 no longer appear.
> > =C2=A0=C2=A0 (I have not tested i8042.nomux=3D1 without i8042.reset.)
> >=20
> > Could a DMI quirk with nomux be added for this model?
> Yes, but could you first see whether including the reset parameter is
> needed? Or it works just with nomux=3D1 so we won't include unneeded
> quirks in the patch.
>=20
> Thanks,
> Lovekesh

Hi Lovekesh,

thanks for the quick reply.

I tested with only i8042.nomux=3D1 (without i8042.reset). Keyboard and
touchpad work on both a warm reboot and a cold boot, so the reset
parameter is not needed.

/proc/cmdline during the test:
  BOOT_IMAGE=3D/boot/vmlinuz-7.0.0-31-generic ... ro quiet splash
i8042.nomux=3D1

Happy to test a patch on this machine once you have one.

Best regards,
Heiko

--=20
Heiko Brey

GPG-Fingerprint: C8A4 ABA2 B404 407D 83F1 46FC 0A66 455F CA5A 1277
Info zu verschl=C3=BCsselten Emails: https://emailselfdefense.fsf.org/de/

--=-ESkRjFVlX7VBT8A+uF+v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEyKSrorQEQH2D8Ub8CmZFX8paEncFAmqvk1sACgkQCmZFX8pa
EneIqRAAtK7VDtOarDxLnl0ZsDvrpzYdddY/9+5zE50B6r9wkn3uDLduGQga8fRL
H+Wel7VlH4MoOdvxkLnGkvr9svimd6fgi9iRh2NjgmuXdnHno5a+EClNZdWg7rEu
JDNLO4iiBIVQpxdTJyovKJBkl8+5VtQT/xvEhOsVV/ziFuQPLdSJB0cLy27MmiFK
PLVdRzvTKgdLpDprNn7FARvQzUUdH874y5Lc1wmMoRjFMBXDPTH2FHSqPtdkbzfH
XlsmlA5Ve9BXsDE5O2I3mcBgOHd3opzvngp2RFWUFAQxrTq5HT5UU8gc/vUABu1Z
9VR9EMloStTa024LqvEi+W1vZRU361MpdIDL1B05wR29YDo9ie+7Ajt76Uq3jW0T
N8Y+yK1QhSQh6AZ1ylHicWD9tyiccA5A/hZ/7ZvqqIXP0xqztk8wVzAlCgGiwXpt
FbOBomjwiuo5oUVCp8fQod0aKK99dtYKWtv4LCjrZb61DlsXjQZvSG74KVaLCh7r
YUqT//JEjKkS4ekTAb3ZtbYlNCwX1X3CBiJTms9Q6TeQ6jRmqxJW6U7NoAD/25YH
atEIE5exDZaP2iU8/Kvjv/S3AMEbyfMhnFWSaYrohXGszuwZg8phKzVDKWE/AvDL
yqV2gShMqCFwsJXaf9mtyhF0BdxMlpcz6SvkPm2qKynCVm13Pkg=
=jc20
-----END PGP SIGNATURE-----

--=-ESkRjFVlX7VBT8A+uF+v--
