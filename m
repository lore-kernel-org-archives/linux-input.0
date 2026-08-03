Received: from mail.mcld.eu (mail.mcld.eu [84.242.69.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306902F7EF2;
	Mon,  3 Aug 2026 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.242.69.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785794932; cv=none; b=maUtTig/L/6P3nXe/GTDRXsl76MdXQr0p7zFSawZEWglJacdtW8FoVutcw5FZgtiawMmxeZlLKxD+ChawETdw6eoLxh0lme4nASMWjTvmrODKPN4r8EVqxG4ta3MynE/nyOccwE3hmDmfygKIBXb+2av+Usu38ytDFyrigKJv+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785794932; c=relaxed/simple;
	bh=BB261IfGQglu+lEWGr2/GghdJzI6uHefzzy/1kI8qKY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=X5dGvDkb7OK8GOZvWeNFdtCApdQ0Ppo5NkYmxNioBtT9pkHagLU13vLGFsLv4h8TqLZg0OdcyRELDNJwrO5cg9NtItAswtRM5M9ve7+6E+oI02DNnXQ9FUcmh+16T/y2BAqJk40D4oTxnz1BJ2F8tvFSzlaBCIPkviJuzJmHqos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcld.eu; spf=pass smtp.mailfrom=mcld.eu; dkim=permerror (0-bit key) header.d=mcld.eu header.i=@mcld.eu header.b=iCrwdJTA; dkim=pass (2048-bit key) header.d=mcld.eu header.i=@mcld.eu header.b=R4GREi3z; arc=none smtp.client-ip=84.242.69.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcld.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mcld.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mcld.eu header.i=@mcld.eu header.b="iCrwdJTA";
	dkim=pass (2048-bit key) header.d=mcld.eu header.i=@mcld.eu header.b="R4GREi3z"
DKIM-Signature: v=1; a=ed25519-sha256; s=202501e; d=mcld.eu; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1785794785; bh=BB261IfGQglu+lEWGr2/Ggh
	dJzI6uHefzzy/1kI8qKY=; b=iCrwdJTAgg/XW8M3ZkrqNDqg3ZWFx03dDPAKgZR6zgttiAp8pe
	VKgwE9Dqv7/M8X4kK+PZ4qGGbtgif3tuSrAg==;
DKIM-Signature: v=1; a=rsa-sha256; s=202501r; d=mcld.eu; c=relaxed/relaxed; r=y;
	h=Message-ID:Subject:To:From:Date; t=1785794785; bh=BB261IfGQglu+lEWGr2/Ggh
	dJzI6uHefzzy/1kI8qKY=; b=R4GREi3zqgZKzJs5pHt4nyl0sGOO1zgOwbl+tN0q0FpggvyA0f
	8tZOxaNUQkEt86g4la6+Rn5yH27d3UebhBjGnW5QteiTSl1DgBoYjkAWcagvTW7lptdHI/39Zyr
	Y9e7mCmDMBBdmBjMEZcf2Knu3XmsMwuUMXIv9l2H4dFqaS6A1FJv1/vSPJsyF+JeXd0dZIGdsDK
	2orIQEAoJLRsSfZ5Jy6KV16Gdz85r93/melZcebMBmVVI0u/VOV9EQRJutxsENEQwXa+6LbHehz
	JqY+v1xNFjqcLyQk08AIZt8kxlpYlP5HI9yjBxHpL+L0pHrrhLcfQYGOGIjplYNXNeA==;
Date: Tue, 04 Aug 2026 00:06:25 +0200
From: =?UTF-8?Q?Kate=C5=99ina_Medv=C4=9Bdov=C3=A1?= <k8ie@mcld.eu>
To: Roderick Colenbrander <thunderbird2k@gmail.com>
CC: Roderick Colenbrander <roderick.colenbrander@sony.com>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_HID=3A_playstation=3A_Support?=
 =?US-ASCII?Q?_DualSense_player_LED_brightness_control?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAEc3jaD8epAdtS-ZGhH2Yk_82A2fp57LUeLzq3vapGVQX5d7eA@mail.gmail.com>
References: <20260714180424.70662-1-k8ie@mcld.eu> <20260714184225.84646-1-k8ie@mcld.eu> <CAEc3jaD8epAdtS-ZGhH2Yk_82A2fp57LUeLzq3vapGVQX5d7eA@mail.gmail.com>
Message-ID: <E1C90FA0-E613-404D-A48B-66348AA53CCF@mcld.eu>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=k8ie@mcld.eu; keydata=
 mDMEZdtdGhYJKwYBBAHaRw8BAQdA8pDTm0x+ycmCkmJX00g58Fn/gLrPIW+DpTR8lVjwr3G0NEth
 dGXFmWluYSBNZWR2xJtkb3bDoSAoTWFpbiBQZXJzb25hbCkgPGs4aWVAbWNsZC5ldT6IkQQTFgoA
 OQIbAwIXgAIZARYhBHlvKqktmAxER0PJsvSrQLRnorm2BQJmBHXLBAsJCAcFFQoJCAsEFgIDAQIe
 BQAKCRD0q0C0Z6K5tksuAQDUhwePcb1WHOJBwbpb43qT2u/JDCAYRrCqInZH/7S9fgEAyipqvsq0
 HF+9pYa4yReYsHjycd8J0nT9FSWmmfyCvwC4OARl210aEgorBgEEAZdVAQUBAQdAiXmCYEDjCR5j
 pXCZp6bsT15OnQdwjirDU1v6UvFzyEIDAQgHiHgEGBYKACAWIQR5byqpLZgMREdDybL0q0C0Z6K5
 tgUCZdtdGgIbDAAKCRD0q0C0Z6K5tjNaAP9C3hba95o2WurhvpSbM6l63IBc0u+oE9slAw6/A4Nz
 HQD/c2+XB0qLk8XVtCtoP7Lia8nt8fwYdSUdpD96m1vHywY=

Hi Roderick!

Thank you for your reply! Yes, this is true unfortunately=2E=2E=2E Applica=
tions would need to look at the max_brightness instead of assuming how the =
LEDs behave=2E

One thing that comes to my mind is that we could add a module parameter (e=
=2Eg=2E player_led_brightness_enabled =3D 0/1) and only expose the brightne=
ss adjustment when the parameter is set=2E The default behavior would stay =
the same as it is now (max_brightness =3D 1)=2E

Unfortunately it doesn't prevent manufacturers from shipping OS images wit=
h the parameter overridden to 1 by default and breaking applications' expec=
tations just the same=2E But I don't see any other way around this=2E

Would the module parameter address your concerns?

Regards,
Kate

