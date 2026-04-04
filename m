Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7931A9FBA;
	Sat,  4 Apr 2026 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775297144; cv=none; b=PDggZHAG2Wj6Otnhd11hVHS54ZRbfleNoNGKgTtV0KnrxMc0hLHKRSxMM3KZOmYCYfIwcmv1T4tgwsCbK/NKvVcs9zV2ifdrE7U+kKHaj0BJt8y8WBtgiXwERwVFbX6uKVpCVjWs4YT8Yw+Ow1Phuu8XV35nVmTsRMRZmrx1cKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775297144; c=relaxed/simple;
	bh=hD63WKFtwCohHpogYCn9BGvKpEP+1zIUSKWAHRJBqNE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fhNYJm1vcSJkePvcXe/mBshFCRbDiEZaKUXS8+ETl5vrUhrUvn+srjGm5rMK8OJqmawOexTg27Lip/lmh18r7gp9Toluhkcawq0AWRt8bR1ToPGkbq0VenP/eCmMChTda0AgNtsJQ0ZfJF5PEOc66E2ROlvpCTqOTIOoGm7iCjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=mtvi8aSk; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="mtvi8aSk"
Received: from awak.mobi (unknown [45.81.60.4])
	(Authenticated sender: xavier.bestel@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 49E945FFB4;
	Sat,  4 Apr 2026 12:05:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1775297139;
	bh=hD63WKFtwCohHpogYCn9BGvKpEP+1zIUSKWAHRJBqNE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mtvi8aSk9dKR4CZXFSvNOKYVUz//gLu+S1Gqy5vUTqfWoEOcR78F3NEcOzitsHOXv
	 jcCqFZdRFXiokJnAwelBBcdpj7PwIkLyjzZFPNMt0LqVbhsvtJURCSTUQ5nctO1ZtN
	 YXzKClD0o0WYe0XPDEK5a7DUZRoxfxN1LeVVqlQsPSWqNKe+CShuvSJ0NIH5elyAZL
	 +oiQTi2bivOTEKZD0dGHkQ3A/kCtFe91jE2Y87VFSJY7amRywP1+tD8lWNMJos8luO
	 x4Nmlv9MCP6T95/hIzHHBbM8nPCtYaImOxktsS0m/Va5UnZ8OR5L0L+zEfLRg+zvrP
	 ZeRzv+P78vnCw==
Received: from [192.168.0.3] (unknown [82.224.47.205])
	by awak.mobi (Postfix) with ESMTPSA id BB988361993;
	Sat, 04 Apr 2026 12:05:34 +0200 (CEST)
Message-ID: <f6f46cfe110053208e7dbb4dd3074eab7966e8e7.camel@free.fr>
Subject: Re: [PATCH] HID: lg-g15: Add support for the Logitech G710/G710+
 gaming keyboards
From: Xavier Bestel <xavier.bestel@free.fr>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sat, 04 Apr 2026 12:05:33 +0200
In-Reply-To: <20260402075239.3829699-1-xav@bes.tel>
References: <20260402075239.3829699-1-xav@bes.tel>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le jeudi 02 avril 2026 =C3=A0 09:52 +0200, Xavier Bestel a =C3=A9crit=C2=A0=
:
> Add support for the Logitech G710 and G710+ (USB ID 046d:c24d) gaming
> keyboards to the hid-lg-g15 driver.

Did that mail get through ?

	Xav
