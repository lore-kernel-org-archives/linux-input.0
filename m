Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1931391838;
	Mon, 27 Apr 2026 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777273443; cv=none; b=E8sUkT6NO/vTT3fSe6aYUyf2u9Y3cKuJbHH0T2IImjEx4I0Q+SO+QEEn3M29ZG5TMQ8TXC/C0RjS5QrUMFPpUrhUr5NXT2rnb57wH3G98Oj5eA8BswLKptBo+8YU9/z0SIJ8ddXHMEOts/Mx+QMzjFessD5QoMEENhpl3JUy8rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777273443; c=relaxed/simple;
	bh=AuWnDFLXe5LGIcxlK9xq9BRQwT0nlq2IJXrZp5kz6cA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RNbX0+NCZQn80/U8E2gIdrd1LEvJ92U5Agycfub2b0XHPDYEEVsTKUVXEF7sNbySx3I3MjfMrMc2r9sehyPMNVfgRNcSBwBkr7SxagC+kwpb4aLI1AV42QEQgS5BCNysPu9j8dIBOyKrknpy2/B99KldskV83ghQBTAWL7UJ2Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=aw57xL7N; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="aw57xL7N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1777273423; x=1777878223; i=markus.elfring@web.de;
	bh=AuWnDFLXe5LGIcxlK9xq9BRQwT0nlq2IJXrZp5kz6cA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aw57xL7NlQ1eCtGer9QgJmYifsCt4Zjh1PeYZyCDc8zvGa1HWfw9ZiVE09+j8e9u
	 N2sAIOBm2SFR0lnzcO/Ggp1zXfJuRWtnu21klKCm8ALOOOAhaSYsez8HWGadTBu4G
	 IespdTJ6hPPaKD4iQ1lCz9V6uNWh1Nydp8ADNp1hPWmt5JnnBQ7sRbLIgGr9CgkGV
	 b5trw7aThhZqBpQO/JTqpQXFLiPpgUkHwaOXTtYvM9XQisOX1PyJymM0rGR/6Ahvy
	 4B8vk3YytpbwD7YsbyU28eOrYP7X9zbsvewd5D+9W/0FKKzGl3guey75MDpc3xK03
	 tofRbysjDly28rYwZQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Myezp-1vRVQo2OVB-00vAFj; Mon, 27
 Apr 2026 09:03:43 +0200
Message-ID: <105964c3-e929-4655-8e41-ba91a3882deb@web.de>
Date: Mon, 27 Apr 2026 09:03:03 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: HID: pidff: Fix integer overflow in pidff_rescale
To: =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
 linux-input@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Oleg Makarenko <oleg@makarenk.ooo>
References: <20260421194941.1422722-1-tomasz.pakula.oficjalny@gmail.com>
 <dd6e5b2c-700e-444d-a9e5-8794c0ff8e34@web.de>
 <25715cc23884f74a7417ba53ba144cbb7f675293.camel@gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <25715cc23884f74a7417ba53ba144cbb7f675293.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kMmEiIoUCYdgqbnzlcBzO2fR5uJf6F92JYu+f65iRU2+hDvVcvK
 KOY76kDI9CuyedreCHKnTcP7znTztgh95IJwUn8GCADxPyz3FkMTi+a2WfHNGGkrdjkQ5lN
 lIAkWbltp2jMsbnXAjJ0uTK2lmiLf/la4b5To/R2Ts4/JAcG1GN6iA9/9rTNfShoO1DJSVv
 TryEdRxcxkCEGl0xHv/gA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W7Dmu3LmdC8=;BHichCX4XbP/maTeQFGFOPCF0W0
 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

=E2=80=A6
> As far as the other stuff you mentioned, I don't get it. I don't think
> it would make sense to mention the 20 yo commit that added this driver.

I imagine that a Fixes tag can also become helpful here.


=E2=80=A6
> Maybe I'm not seeing something here, please elaborate so I can fix it :D

I indicated another possibility to avoid a typo in the change description.

Regards,
Markus
