Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0934213D51E
	for <linux-input@vger.kernel.org>; Sat, 19 Sep 2026 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789811550; cv=none; b=mqjlEXTm2b29KWJ2vQ+NQfP78NCdujl96oSHKet/9aGUxCPy6FCtKRjwxkYUrzRmQhCByaiB5vyDKu9kmJB6BYMYHoZyg3PZHRTt0udP7SwIIHhBYLnP0jYSAvz636M1sKaPpud4JwD/1zTYK6NX8VcUCGVyAfIAn6YoWr+00+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789811550; c=relaxed/simple;
	bh=70rXZjmRA3rZicRBHOJsT7SLbRVTQ9ISPyenQLrwVls=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=FCZrKddLp3mCR7O+n6GCFWUXxXJkVFy/DFVNz7+4zrCNgv6TpCcn46QD/6a7xoByXDVCJnjAGkMfbBPcXshab7Z6jJOYSQN2LNrYbq6bJeGKAsXP3CxZB4ChSBqzodPos+l3k12XV55xwm2xRrhZJqj4N7H+hYEGr0rBni+C+hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=cico0815@gmx.de header.b=qDAbPooY; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=cico0815@gmx.de header.b="qDAbPooY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789811545; x=1790416345; i=cico0815@gmx.de;
	bh=Suy0PGz6/gNfhOmSHI7H3s4umr3mod58tb4NxNEh3TY=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:Reply-To:To:Date:
	 Content-Type:MIME-Version:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qDAbPooY271ZSYXXGkpk8byYmcRH3i+u4rA5AhswhhjogKco721ND5mHV1ms6uaE
	 3xJM2Wu96Wb5DAdhJkNmIybRBMnWGE+8bieWjUlbMLL+JL1Z0Yl9ztEaAGCXx5Si/
	 WXTnblvJUbKcrIjYi6IVv+O2mUXmx75Zclb6u+BrA6chF0MUV9mleIaoASXzHSWMD
	 VvKea7qtKFJi3ol0RAIYMTzFtMpPtVNebHysvMRVpLn2vF3fdVMhFnkP0SLieVABp
	 uwDfVSpDduDUv/4Y2HPtVzTYjC/nGEEJBRuCJpjHII+Bdnq5CRvMfNWHDqkLgiQ14
	 8up9G0Rq9oEjzjF1Hw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGQnF-1x0S9s38LV-009Vgo for
 <linux-input@vger.kernel.org>; Sat, 19 Sep 2026 11:52:25 +0200
Message-ID: <89f36f3f5e4c2d07b9ff72bc0b355875c336e498.camel@gmx.de>
Subject: i8042: Fujitsu LIFEBOOK U7410 needs i8042.nomux (keyboard and
 touchpad dead)
From: Heiko Brey <cico0815@gmx.de>
Reply-To: heiko.brey@gmx.de
To: linux-input@vger.kernel.org
Date: Sat, 19 Sep 2026 11:52:19 +0200
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
	protocol="application/pgp-signature"; boundary="=-IT5tNuLHeXwXOQKiE7an"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:UM1XbWP1FbH5QSFIUhZAP269OKkNWtr3i/1GBFe3F/iA9oRuUTt
 u2FQpG0NdJH9R1fAWMmVKwDvDRskRTcOG481HLwesv3PrYE8QGKrWV3OWTAOT+NwDmr+1bU
 3W6MJ2IghWqsZnsLOh9MMjeR3VGI+Z65hRf1vAJDaBGSh8lSrJUc3WEKFztqTphDsqh7+w4
 AbuVD/xEP1VKRpWdck+Lw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xIYSTHEkPrM=;SaIfRmwtlNT58dhqQ3WTON8qtx5
 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
 CARQ4DSuAuH5bi1+KbynluE4Lg==


--=-IT5tNuLHeXwXOQKiE7an
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On a Fujitsu LIFEBOOK U7410 the internal keyboard and touchpad are dead
after boot with the default i8042 settings. Both work in BIOS and GRUB.
The kernel registers the devices (AT Translated Set 2 keyboard, and the
Elan touchpad 04F3:3092 via I2C-HID), but evtest shows no events on
either.

System:
  Kernel:          7.0.0-31-generic (Linux Mint 22.3)
  sys_vendor:      FUJITSU CLIENT COMPUTING LIMITED
  product_name:    LIFEBOOK U7410
  board_name:      FJNB2D4
  BIOS:            Version 2.12, 06/23/2020

With default parameters, dmesg reports:

  i8042: Detected active multiplexing controller, rev 1.1
  atkbd serio0: Spurious ACK on isa0060/serio0 (repeated)
  atkbd serio0: Unknown key pressed (translated set 2, code 0x0)

What I tried:
  - i8042.nopnp i8042.reset: no change
  - i8042.nomux=3D1 i8042.reset: keyboard and touchpad work, on warm and
    cold boot. The multiplexing message and the Spurious ACK messages
    no longer appear.
  (I have not tested i8042.nomux=3D1 without i8042.reset.)

Could a DMI quirk with nomux be added for this model?

Thanks,

Heiko
--=20
Heiko Brey

GPG-Fingerprint: C8A4 ABA2 B404 407D 83F1 46FC 0A66 455F CA5A 1277
Info zu verschl=C3=BCsselten Emails: https://emailselfdefense.fsf.org/de/

--=-IT5tNuLHeXwXOQKiE7an
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEyKSrorQEQH2D8Ub8CmZFX8paEncFAmquW1MACgkQCmZFX8pa
EndiVRAAo3e1h3mBKCWNIZtTLrhBt8xLekQege102Z4lbkxJt+CJhh+MnMzXbONm
LaZ4UCcRj41XOiZpAbpVIV2wfiQbBUpwCbLNSVttJhs1BPX9decijD+5pvHK1Lkb
vxjk7rb4aHXt4qLXughGmp4gIfyNmRHr5WKfBmruEXVU1Omvj1SqpW4KWZUdPNRF
qThnb3OGmMXSEstAq65iNSyoEHuWseVJ02pZk27bxivqZOMgdX6pLQaJ77uf4x/9
h3TlR8T7zOqAhsKj66gF0Zw4+QAwDN8rb+dDbwL5l6DISrzuUhQLf8nC/ipf0idJ
rkhekDg1fIfQPeUM1EZswk+8CNzeUzRWuJoqvG9hgFK82p8Ork1BqrEGI5GgkDsG
QYV2jyCfBtUqbns92D/9n00KosmHl+C7nqsMUAN6xP6VfB9Q5eD2l2fPPdA8damj
nbncC8Z9S9fEZEod62Ix6EvbuPGiRQioj93PxevIcK99k8PSCIihIEpQJ/tzZ2SS
3W2quM4B9EjOwJ0/ub5eqpC1j+fP7ttEoi4ei/1pysaEDRet9nGipp9aDcZsVOCU
ps0ekLj7S/kv+G/zaRgMxtTdim2l4xCFoI4McpamK6lbY4j2wdlyFK6n/UbQ5R+B
w/2zGQF6L/jWFw4qSkaRGXYZyJY5HELIsVkUE78ov+el7/jZOBU=
=SyKp
-----END PGP SIGNATURE-----

--=-IT5tNuLHeXwXOQKiE7an--
