Received: from mail.venturex.pl (mail.venturex.pl [141.95.86.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E3717BA2
	for <linux-input@vger.kernel.org>; Wed,  4 Feb 2026 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.86.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770193902; cv=none; b=ITQE+Mf7tJNhDSKJ5VPsqjSKw9WPQG9nB256qiejQIdxyW/6gofAiwGHQ+Z6QMOd4StuCSwnwT5FCSRiIOukCyz9tj+mmtcWTMgqgT+O/V2UqERdw6XIIWoQz3KEX8mFLDNlytP3YWA6SLp4xzJhtGMhLxGV8FuDnDB+wETTAdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770193902; c=relaxed/simple;
	bh=86VIaF2unP4vg5OpX+J8tHPXWoQ8hu3kSDMcmnIkxvQ=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=TEJ/FQV34YlWKUAlW2d55bjfDEeDHkYUMbWwea/07sAcNcoZUUOSpJ7uTqX3m+pBkwniFiko1LB3WdmMgDNOywhbvktudtUC43Lb1xZIu9MZaeU8y0BkgMrQoc+1GryqXgFlU44DUzihHLkmS5QLUdGJGecwkYPiWMujnGGsAho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=venturex.pl; spf=pass smtp.mailfrom=venturex.pl; dkim=pass (2048-bit key) header.d=venturex.pl header.i=@venturex.pl header.b=RtqvXQEr; arc=none smtp.client-ip=141.95.86.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=venturex.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=venturex.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=venturex.pl header.i=@venturex.pl header.b="RtqvXQEr"
Received: by mail.venturex.pl (Postfix, from userid 1002)
	id 0532120A3E; Wed,  4 Feb 2026 09:30:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=venturex.pl; s=mail;
	t=1770193900; bh=86VIaF2unP4vg5OpX+J8tHPXWoQ8hu3kSDMcmnIkxvQ=;
	h=Date:From:To:Subject:From;
	b=RtqvXQEra2971LaVhhgNYHn7nhaAdbGs6cpFj9R/Cfh9Ahz3EiK+eq1lk1OiUbWPU
	 A01pkEUll2XdGn+eF88b5AamyndEkLLnZbE/9Hk4vlfKP8MiAiNVUhBxltge0O40Dp
	 p368GbY1KBc90q/+ZwzMerB+05jd/+so+CI9NwKfqjyWPwD9pIySuGUgoaZ3/otBjY
	 O1lPtVM5mypXOBx/l70XUZSZoEIiuNhlF/aP9aKPkd/FYqfPI2Xd/PLfNzLzuGG41P
	 mf4Xo3hLFwSlrJ04RECq4SxoNnSuw34reN7F1WVJSaf2uKJ3lXLx3pZVa68K2X9DYC
	 3EGjKDB0v5Xgg==
Received: by mail.venturex.pl for <linux-input@vger.kernel.org>; Wed,  4 Feb 2026 08:30:38 GMT
Message-ID: <20260204084500-0.1.ch.2is12.0.ip79jc2q2r@venturex.pl>
Date: Wed,  4 Feb 2026 08:30:38 GMT
From: =?UTF-8?Q?"Miko=C5=82aj_Rak"?= <mikolaj.rak@venturex.pl>
To: <linux-input@vger.kernel.org>
Subject: Fundacja Rodzina a optymalizacja podatkowa 
X-Mailer: mail.venturex.pl
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Szanowni Pa=C5=84stwo,

czy byliby Pa=C5=84stwo zainteresowani rozmow=C4=85 o mo=C5=BCliwych rozw=
i=C4=85zaniach dla swojej firmy i rodziny?

Nowelizacja ustawy o Fundacjach Rodzinnych otwiera przed przedsi=C4=99bio=
rcami zupe=C5=82nie nowe mo=C5=BCliwo=C5=9Bci ochrony maj=C4=85tku i plan=
owania sukcesji. Fundacja Rodzinna pozwala oddzieli=C4=87 aktywa od ryzyk=
 biznesowych, prawnych i podatkowych, a jednocze=C5=9Bnie zachowa=C4=87 k=
ontrol=C4=99 nad swoim maj=C4=85tkiem i zadba=C4=87 o jego trwa=C5=82o=C5=
=9B=C4=87 dla kolejnych pokole=C5=84.

Co istotne, po up=C5=82ywie 10 lat od wniesienia aktyw=C3=B3w do fundacji=
, roszczenia o zachowek przestaj=C4=85 obowi=C4=85zywa=C4=87. Ustawodawca=
 przewidzia=C5=82 r=C3=B3wnie=C5=BC liczne zwolnienia podatkowe obejmuj=C4=
=85ce m.in. dochody z dzia=C5=82alno=C5=9Bci gospodarczej czy wynajem nie=
ruchomo=C5=9Bci.

B=C4=99d=C4=99 wdzi=C4=99czny za informacj=C4=99, czy chcieliby Pa=C5=84s=
two pozna=C4=87 mo=C5=BCliwo=C5=9B=C4=87 stworzenia Fundacji Rodzinnej?


Pozdrawiam
Miko=C5=82aj Rak
