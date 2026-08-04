Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D4F423E95;
	Tue,  4 Aug 2026 07:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827027; cv=none; b=k3Uxp9kmtMz8RdlxtWYqQOSRtgO3kFZMzE1B9R1qacd/14aD8/hG8LTTCQa4711va5d6PxzDLqTgN4mx7RueezGfXGhNuylua0SU8Kzjms6Rh0q6ukBDnTu9E0TtgZfNMVh8mex3Q/O3mqYFdYoDUJGBQ7wX303MjtEb7cRQnZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827027; c=relaxed/simple;
	bh=IYKD7opQBvJmLhZ0yqmL4441KAl2vip0XvYsyzjqSis=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HB3aCyCH7ie5b0O28pkiVaVAHfySI5o6/P/lUIgi8VYPAqQjG4g0YcOri9qS4G8x3tIlZyAhaswebYF4VMSk/A371nqsCzQapvueOYzzBl3ayatw+VeDEfnaOYkRbYTrsqxVrc8W35gE2A1mz07lYeoOVX2OcTx5iFU6/wD+fZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DgXEJ7bz; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DgXEJ7bz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=xp3rlcljmbcg7ej3rrctgjk6lm.protonmail; t=1785827016; x=1786086216;
	bh=IYKD7opQBvJmLhZ0yqmL4441KAl2vip0XvYsyzjqSis=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DgXEJ7bz2SrsbvGS2I+IzxfUn8pVwMjqJgWfSm9qWJBNUHHZtGxFtt3qlEZI/PBTv
	 dcM3h0aR9wQ2ECQbXy3oxfjsfn8ywfMZeqooc91rTuqdPueOilc0UMgtNmScM3Hwo7
	 JzwMCIPY4PTAdiiAN49NaKedxon02VcpLr9logTMyULKLfsUuP6uc9Skkj9Mt0lN0R
	 1YK9+7pN8NLCgoG7xwcJPdwMlSxTf7T7PX5cPyISC2cEVBSyOiTeH5g22CvAHtsxIR
	 oQSzu9rRfT39WctgkKMQ0AEv4YXa3huWoL5/+y4iAs8gbvpEl1ZgeMj7ElP6EaWMLg
	 cs50+b7NhTuEg==
Date: Tue, 04 Aug 2026 07:03:30 +0000
To: Jiri Kosina <jikos@kernel.org>
From: Aditya Garg <gargaditya08@proton.me>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Linux Input Mailing List <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 RESEND] HID: appletb-kbd: add option to switch default layer on double pressing fn key
Message-ID: <rKFHe81HLys0NhKZIqBt-2A1ZE_iORqxXFQ4QYL2V8H4RKXfmzmYkCkYDnWOjnguSRXthoa6rewZW-MsgPtWXy5IoZw5xJzJC3JkWGmbPjE=@proton.me>
In-Reply-To: <3LY97dj4t_38C5heLymdMO_2Hgu7htkZuZf99ifQpLemEFQU80GOyb2HE85V78h8dT9LyPAWqTYEoTe4iJncvoiT752ACJm-XLF_jd7OMPo=@proton.me>
References: <20260620112635.17246-1-gargaditya08@proton.me> <1qq5363o-p24p-5p8n-op02-1q85prsq320s@xreary.bet> <3LY97dj4t_38C5heLymdMO_2Hgu7htkZuZf99ifQpLemEFQU80GOyb2HE85V78h8dT9LyPAWqTYEoTe4iJncvoiT752ACJm-XLF_jd7OMPo=@proton.me>
Feedback-ID: 145777226:user:proton
X-Pm-Message-ID: 470c33a61ceddda6089f83c3f854c434fc235d56
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





Sent with Proton Mail secure email.

On Tuesday, 4 August 2026 at 12:32 PM, Aditya Garg <gargaditya08@proton.me>=
 wrote:

>=20
>=20
>=20
>=20
> Sent with Proton Mail secure email.
>=20
> On Monday, 3 August 2026 at 11:07 PM, Jiri Kosina <jikos@kernel.org> wrot=
e:
>=20
> > On Sat, 20 Jun 2026, Aditya Garg wrote:
> >
> > > From: Aditya Garg <gargaditya08@proton.me>
> > >
> > > This patch enables a user to switch the default layer from media to f=
n
> > > keys and vice-versa upon double pressing the fn key. This behaviour c=
an
> > > be configured using the double_press_switch_time module parameter who=
se
> > > value depicts the time in milliseconds within which the fn key must b=
e
> > > pressed again to switch the default layer. If set to 0, it simply
> > > disables this behaviour.
> >
> > I know that historically the apple driver had all this kind of tuning a=
s
> > kernel module parameters, but wouldn't it make more sense to start usin=
g
> > sysfs attributes for these?
>=20
> Having sysfs attributes for some, and module parameters for other tweaks =
seems more confusing to be tbh.

Also, please review the latest version: https://lore.kernel.org/all/2026072=
2141221.13844-1-dev@deq.rocks/
