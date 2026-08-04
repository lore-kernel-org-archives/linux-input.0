Received: from mail-24431.protonmail.ch (mail-24431.protonmail.ch [109.224.244.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F19C1A5B8C;
	Tue,  4 Aug 2026 07:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826937; cv=none; b=CQqfs2PodXeUvoAlSiI8v83ZakbMY6zftgr5FybQ6jAJ20qCVTWZdMn2cR66pywThpeBuBHl0U1pPnUfozwpXOBaEh5IrzVOKZiNov+KBu/Ix0xjlK1bJYfJ42dWtIWMQMDhWLZTJkik97AbRXTpT8C+duG6FRPj2D9w3XtV5CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826937; c=relaxed/simple;
	bh=706OdIzROb2R5LqusDx24vSsUJYdon7RZ0Ggo/T8mA4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChuIfTBhOdEUIaa3QDNcmvYG3+uXPb4PBkbaBdK0oK3CDzmOJ3gPIQHGPNUyfO9yC88706PQ063+5r7v+TZcZaa5kq0iiL3MLmja57mZ9ggZrIOWi0BoPar6GvlebJCtyk/bhJBqy4VFApQcz+21+qo50Xpu4ag6+pYG3XnYqQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=b09qB1im; arc=none smtp.client-ip=109.224.244.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="b09qB1im"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=fcjcovdxhbdrrb2gkehjh5e2ha.protonmail; t=1785826928; x=1786086128;
	bh=706OdIzROb2R5LqusDx24vSsUJYdon7RZ0Ggo/T8mA4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=b09qB1imlxyXX2G4oTYAXtRVeAkVfnSkUJsRE5ODitSLWa1+KeBurI7r3Pi/8zhAS
	 lE03tEwqEZv6WjQSvochBPI8Wrj5RZ6CPW3+99Ac6E/P6g+jO3izH43CAAmJTp5VJk
	 Szv10v3+LVmwv0B5pKfsuHs+ug0eZ8CmW0+j1zHopsIv/za35ONr/qPbGdUhppYw45
	 KyDR8Vy0OVo+CRrL+Kw9TsXYixUga/zFTEnZUJIyMMzm+Xq/9JXxpFUK2SO31fBIC4
	 jyMiekj5Xg8uSkizLaukksafv6cJ/B0pfPQ9TQB/WJ0pUPYGbG96186Ps3zd3fAJ7C
	 dLBXvS074fA/w==
Date: Tue, 04 Aug 2026 07:02:04 +0000
To: Jiri Kosina <jikos@kernel.org>
From: Aditya Garg <gargaditya08@proton.me>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Linux Input Mailing List <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 RESEND] HID: appletb-kbd: add option to switch default layer on double pressing fn key
Message-ID: <3LY97dj4t_38C5heLymdMO_2Hgu7htkZuZf99ifQpLemEFQU80GOyb2HE85V78h8dT9LyPAWqTYEoTe4iJncvoiT752ACJm-XLF_jd7OMPo=@proton.me>
In-Reply-To: <1qq5363o-p24p-5p8n-op02-1q85prsq320s@xreary.bet>
References: <20260620112635.17246-1-gargaditya08@proton.me> <1qq5363o-p24p-5p8n-op02-1q85prsq320s@xreary.bet>
Feedback-ID: 145777226:user:proton
X-Pm-Message-ID: bab1ef03568467bf90d61e9870f59e7e7ccda02e
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable





Sent with Proton Mail secure email.

On Monday, 3 August 2026 at 11:07 PM, Jiri Kosina <jikos@kernel.org> wrote:

> On Sat, 20 Jun 2026, Aditya Garg wrote:
>=20
> > From: Aditya Garg <gargaditya08@proton.me>
> >
> > This patch enables a user to switch the default layer from media to fn
> > keys and vice-versa upon double pressing the fn key. This behaviour can
> > be configured using the double_press_switch_time module parameter whose
> > value depicts the time in milliseconds within which the fn key must be
> > pressed again to switch the default layer. If set to 0, it simply
> > disables this behaviour.
>=20
> I know that historically the apple driver had all this kind of tuning as
> kernel module parameters, but wouldn't it make more sense to start using
> sysfs attributes for these?

Having sysfs attributes for some, and module parameters for other tweaks se=
ems more confusing to be tbh.
