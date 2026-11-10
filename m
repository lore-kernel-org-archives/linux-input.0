Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794342854;
	b=EnNYnPp4A4ZCWa21b0PCpq5QJiQ1KiWSb5cKC740ZjVUsFm/EAVqImX6s3X4cY4FWZv+
	 qGrtjXcRmiDuWOCsY8Pgfn5WsbyRC7/eMlbo+abq5Jwlq+vw+2yGHTpOIGrJXbSlsLtxU
	 LgnYFnfXGQMg6t4yaYhXVRhUwLwnPRGazMSQIoUtIs+nS/b7RNvSgoOFpUAOPP1YypzjZ
	 mqk5y3KWpcpovLtq6XlAU5DhczVO0N1OcOIv2dH1TRK9xGHtofkZnO1jHVS6VO4Q+CZf6
	 0W8wLRbfI30svn4bi9r/HLpI2qjJwruNnsv6RjMpgpoePDeahJMD1kPiPo+Fmw4v9Cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=S3yevQWR0QP2Mx5vcqLjpBrtJN6Cj5pb6mimG15JBzw=;
	b=bEtyoncga96dqGTMh2rThARx/pM/ObPusPOrmg5qSk7Gh16qT6SbVBG8CVAhQnQGJmn7
	 dAC9p1NmTBtylnKRSEr1kNFopRKil+wNvX1zK8bQfT1QkveTW1T+vhMLAzLu9XCP8bmT2
	 Xzr524YJ16s6zUfx8uFhgwZlTcnYPjn8gFjfwUSleCrj8d0FQ0aHQj9VZG+AMUmRanLu0
	 YMtR25y2vks9Qiv7rx6bDVINuJKqlo7XjHm4tpi+J9cWOexLhnvxcCx19vTxNaDZFYZCD
	 OHENDHaC7B2p9Qa4xNA3SZZFvk8Uc+zGb6x1uRoKb6KuRukWOAEYg7rP5EBDSqlxFnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rh+jOjak;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10360606A31C
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 20:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10360606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rh+jOjak
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a3c08d6928so4260298c88.0
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 12:34:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794342853; cv=none;
        d=google.com; s=arc-20260327;
        b=dr4Iw5ID3ugFgrieuI5Ekte+SSBz7Qh1jArdG4aXggTndVIBBjpgd9Lsa2h74LO8Zy
         6yi4GRh8cNYNclLU9kwXyx2otw01Isz2g35SXFhkkoKrXZ6RMBz7Jnw/24gjmWWF7byb
         Yl7kA0rWfDvIdB+7T3kmiR62twRapqd1ljsvIlZddai9+a76RIAWynxxSqJaNG7XLAPo
         6WcW3gO2RHEeByy2Upg+7m2ssLINlMl/UptauxSjXNW+E1BqkDHJgd1B62Blb0Z/45Rj
         EFYFgSGgxkpwcFaiEi3o9YyPoomq9Re9z5Vyg6YWJhZE0ITlKZXQBVmnihKYXSp+f2eW
         aELQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=S3yevQWR0QP2Mx5vcqLjpBrtJN6Cj5pb6mimG15JBzw=;
        fh=+pNml4h+nFc/6cKhMwMVQU71mby9qxEpeIlX3II+WR0=;
        b=I4lASdaZJEbQarSw/KUitNTO6mrAmAT/cP2Sx3tQ5FC00+CV54IzJxJuGn+BzADifr
         3luX0xfvR0gIU75MVkWblLecpGcLUGpyvXvuEEPlEMHQ22I6ZTliCERRe8zxZkJDs48t
         ZU0TEId2THZdjWT8HLW/YGEym8UsHU2+gmb8SYRqKgO+1WHPw/MU6LXspBHkqE3A2pAL
         jax2JdNBBADyts8tmZfi/Y7sSTZkGt0+WQBlF/u7lcTYizLDQG274kOuPpZAxlOmUolt
         zPdqeLPl+Yydul5PzGYt37az/i8GtsfxPXT+OnmGkYJIDk/kAXcorWleClbZqTJ6vem+
         Szxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794342853; x=1794947653; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S3yevQWR0QP2Mx5vcqLjpBrtJN6Cj5pb6mimG15JBzw=;
        b=rh+jOjakz1G2mhKn7qUhYjA2f/PgbfhMztkjhsL7VKNEErg7iKclTlsgl3qQW1kwfh
         /3vViQlVc3y9xHIaX1bp4vH3xLFW1sZXtLNWciRXBfBPAsuqPLVc7XfnHyPD47R0wk+3
         HCkYrHGw53UOuL5i1hpGyVEL3qLps5eKTGbiSNulzmeW5/64EaZt1cjbas3YaO/IqkcB
         +mhUjHTZJKbLu22kIFMrIT4rCmLI8v283sXOh2zhWVeYqQz/z7X3UedPxvVsCzmb562f
         eBbM4JymaUo/ibQGFrYZAdEA0Ia+yWq2D3wQdzg3Do0MMnl3btYVVi7cp+2Rf8VL49ze
         E70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794342853; x=1794947653;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S3yevQWR0QP2Mx5vcqLjpBrtJN6Cj5pb6mimG15JBzw=;
        b=na4PU+amPAnZQMKJWE1c9/hq/Ip7FHKXuKKo2Y/UC9dI2FaiMN+0z3WPNHCLcxevoe
         4u+IrlqO1kv13G7b4u1Z69CjlY7T3klagrtK+tNgJH6597R9udVtLKmTvKDJI2Z9gK9u
         jHxf2EETwjSybso51ldWfGadcS6UCbsiH+S4ddRXCkxwbHZIm//Gpqo74iiwsGbCo6DT
         edTZv9i+83EQNcQwC1cQYxy3NSykttSr2iOU3kzzd1mazet5+iSj0TNtiBQvIToTTMG+
         BKKQy2eLTlV+HbgDp8cveVNlyP2WVDJCyvRGen0mDhzquUqumrlSncvN4EG9XehPeLS5
         Wblw==
X-Forwarded-Encrypted: i=1; AL+hErHdihKaWnNBp6qlJmPsQlGgrdS/9SWKOLRVIDTqWBUaRL9BZjll+ZSmScZNHeXvyaNfQVNMGLsTo8WKzA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9oOZ6sbuz3c35luH2b0qoaslj8+I6sZnVs9qVqzHi/2drcCOEp
	gpBZjVTgxg4QtfWqJ9Cl+6683qLZxtP6pvZbA17wSZDboZpN9cDJPQknkZ8KjlDlIwfZtTiD+//
	8W3McSbtCfG8UMsCH7ZdhLrnYqTsXl4k=
X-Gm-Gg: AYBFou3pJ3vRS3xYUzqxLDWgH/Xa69LY/JdQYrlDKBeIHk9WliSD3buJxfuwec7MHie
	yvdShgtAuM/hvwqUq97XW7ud1C8HJLPM+hs/eJbDflYrduuWJDAxsL2XpU4LLu1ylzZwgM3zKXj
	57zEj/NYcaS5A/TmszbiQP9b8Q7+iViaU6EGWpipq6NDi5F20WE06r+dKv29DMYTapToTc5q9TF
	sL62YKuN9hD1OKTMRvfXP915Ll7EW1ct0q3m7uJZzmjxR6o4UUHad/WO/8AVSyKvXmvKl2M43OU
	prJsYT98e7zvebbRWkdjPE4ltyC6fDXkTXB6aPXh7UZbCiRq+q4nJik7KieYA4JTiSreKnYUR26
	DtWr6cSuAHx5eD/AUw/+Kxw==
X-Received: by 2002:a05:701b:4354:b0:1b2:4b42:1870 with SMTP id
 a92af1059eb24-1b3b60122e6mr5192830c88.31.1794342852985; Tue, 10 Nov 2026
 12:34:12 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109-legion-lighting-rfc-v1-0-a87e1db8c5e3@gmail.com> <71ecff766a91670d509b1286efd995b71efc21f4.camel@rong.moe>
In-Reply-To: <71ecff766a91670d509b1286efd995b71efc21f4.camel@rong.moe>
From: Ciro Pedrini <ciro.pedrini@gmail.com>
Date: Tue, 10 Nov 2026 17:34:01 -0300
X-Gm-Features: AclHuK-300J_C-DWjExk6OeF5Jmrb_TP8ZwYUDbSNJSRs61knDywMdBKoecE0iQ
Message-ID: <CAPKD0HduW_atYsz47Nv-9A_88K1B33xENUnZgQAKcH4VHqV9PA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] Keyboard lighting for the Lenovo Legion Pro 7 Gen 10
To: Rong Zhang <i@rong.moe>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Ike Panhc <ikepanhc@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Werner Sembach <wse@tuxedocomputers.com>, Aaron Erhardt <aer@tuxedocomputers.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Rong,

On Tue, 2026-11-10 at 22:56 +0800, Rong Zhang wrote:
> Thanks for working on this.

Thanks for looking at it (and for the clear direction, it helped a lot).

[...]

> Let's take it step by step, and submit a driver for 048d:c197 first. As
> far as I understood, the driver should be able to handle "hardware
> brightness (0..9, stored), the controller's own effects (stored
> profiles)," and "Fn+Up/Down/Space" by its own. (Please correct me if I
> misunderstood your words.)

Makes sense. v2 only does c197, and it doesn't depend on any LampArray
work:
https://lore.kernel.org/r/20261110-legion-lighting-rfc-v2-0-845726afb71c@gmail.com

About your question: yes, the firmware does all of that by itself.
Fn+Up/Down change the brightness (in steps of 3, and it's stored) and
the controller sends the new level on a vendor input report. The driver
only exposes the brightness as kbd_backlight and forwards the hotkey
changes as brightness_hw_changed. Fn+Space switches between the stored
effects (6 states counting off). The controller can also read and set
the active effect, but I left that out of v2.

> I am also working on a independent hid-lamparray implementation that is
> far more generic than Aaron and Werner's series.

Something you may want to know for your driver: on this laptop c193
doesn't show anything on its own. c197 has to hand the LEDs over first,
with its vendor command 0xAA (07 AA 02 00 00 00 gives them to the
LampArray, 07 AA 02 00 01 00 gives them back). The controller remembers
it after power-off, but it only matters while the LampArray is in host
mode. In autonomous mode you see the controller's effects anyway. So a
generic driver on c193 alone would register lamps that do nothing until
c197 is switched.

v2 doesn't touch 0xAA. How would you like to handle it with your
driver? A sysfs attribute on c197, something with your autonomous mode
trigger, the component framework? Once your series is out I'm happy to
write that part and test it here.

> Please use the component framework (not in your next revision, it should
> only add support for 048d:c197).

OK, noted.

Thanks,
Ciro
