Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1D1301486;
	Sun, 26 Apr 2026 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777200542; cv=none; b=gD2Y1VIpQUyJvsvMEKvDLDDdK9IcE2oDS8UVKl3Cz3sv/njl4/KzNYZOIm8lDjSvu04m8e+4lUq/KUZUjnS9JgqXoT7In2Yc4Jks/YEwvTY3+ojV62UzzZ5aSc2HWeTUyF40e7M/EuTf7KZFHc1oJL3Tc1MqIb++NX3gLVsyoMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777200542; c=relaxed/simple;
	bh=8m7oMnQzIecduLzUdamXW+Tf8taYs3eg3qQJHgQ4h0k=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=swAPHR/aq7UXdQXqQroiGMC4uhPd6r/RFry6qhlv8+NfG5+36cdE/N8Nfep2s8nRtuGbqSueVDDZ5WgCIpqBq/Zr+f5Q21AukD7C6c1qBjmDiulFpWxZLreuCs8mB+vXcHN0ih9xs6bc5VZaemvAtZbMwWXTO5qsz04tm6SVyGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KcILLTXp; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KcILLTXp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1777200529; x=1777805329; i=markus.elfring@web.de;
	bh=9ICKQpd7wV7R2n5EvF5/kshjm/18czUEfYvPI33KKa4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KcILLTXpG7VURcI6Z8GNFRr0w683mgq9b/T95tpALrECJoxGXx5ZRGgNOdfaeqgm
	 Avt/0FSIVqBaEz2CF8zWn73GbVnoFaOEG5i1Y+77dr5JsXnvXD192I9yBVdwSXmz4
	 hJ+OX3chbGpXp4XWE84+1agYwfvfmcUKCIgmFRF7AG1KXDPbJsGkApgpsazszhsx1
	 /+aLOxk7KNqxlXfF0IgX4ERFmoW5FDjsCSv0aWKHWfG2lF4vaEx2DsAtSPdndwFHS
	 R5wv8zAEztPyim+8DwtD6Rig58qwyj0ZmMB/xCCzVjRTJ9m0tyb8UDj9/zLK+4sJD
	 QqH2gPXxb3gkkbesPg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mhnvw-1vm24H0Hom-00cuXx; Sun, 26
 Apr 2026 12:48:49 +0200
Message-ID: <dd6e5b2c-700e-444d-a9e5-8794c0ff8e34@web.de>
Date: Sun, 26 Apr 2026 12:48:40 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
 linux-input@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Oleg Makarenko <oleg@makarenk.ooo>
References: <20260421194941.1422722-1-tomasz.pakula.oficjalny@gmail.com>
Subject: Re: [PATCH] HID: pidff: Fix integer overflow in pidff_rescale
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260421194941.1422722-1-tomasz.pakula.oficjalny@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:drx3i/msAvM/6xWukqtATpxNVz6Cjt88Xy3Om7siKt22jwk11eo
 w+sReIjBqVJtfEycXFuu9qNW/6G/zdyOhDUcataIFvZlNLaRqd+uAnLPPEYDvAzAfiyVfm0
 uwQIruLEJAfR3PjeTx7fuXI9VhDXUSJwH+E9Z+VfISe5ou3ShJ5sZJi+UtNtxiK/1+0gp2I
 G7z6YVFsX6b+V6qTr/UpA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kzCyLOVdf3o=;OuNzGX9bhiLKsKnhQlYsdqykZQZ
 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
 85s7uS6WqZzQ13w==

> Rescaling values close to the max (U16_MAX) temporairly creates values
=E2=80=A6
                                              temporarily?


See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.0#n145

Regards,
Markus
