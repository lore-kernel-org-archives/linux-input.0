Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985605;
	b=LjcTLdF7CSHxVJolyPeJWAgtrOfWtQINkaPL2F1vzymMRs5eBdoo0ujm9ndbdqVvTbvK
	 75PDFvVq1xoqrPX0w0bYQ8GkIxCVPil+4kb0iGyBtjZ6BWwDENws/l03kyn+zKZyDJj/h
	 ROo22j6ZKWTCZZ4giX9hgliwm2zU7KGy6k4e7Pp+7Mbq/rjeZn9wvU294V0FtC0ynf8x5
	 d27XSaJoq+KW9xFFLzeiQBxKg0GHoCJMnDiFCvg7LmzIJL5M9m5kdfn4KUD3foUTPQSeY
	 elSeVSTPy9CNneyBnQKGK/HATPetqwzeVPRYEcztPK38pkMqdwaW+tqFVBfxkN2tbbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985605;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ACeSaby4ZJ/wanGmyynffXqjsOoMsFpWH9kzoGynS3I=;
	b=3YII6/J1UkiWQ35qv2OAIMI3PkBHDQ3hDI5/qejLThfo28YJU781kTY+2Km42vq6rGoF
	 SePsIVW2KtgHCSXTtUUtVv1q8SXHupHvhELuVKLkYA+eFJ2rxouzHLTamfFAd77CAPgyY
	 CVZs7Fj9/5XIbIL5eoMX/o3nQvhoZnPtPCxLOn/5X+x5Pso0zETGVsymnUfPJlP3cLkJo
	 HiMauEPoyTcBv8PoPKB1AjG6qmpzOh99M1ed3Nanmrb4lkNPuBVwENHP00GAep3phwc+O
	 HrAsZ1yU4rhoZt186w6+JkCwYBTk76tInecn6EUIuJ0AJUl+X1oieEWY8Bjcu/nUtYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=msh.ge;
	spf=pass smtp.mailfrom=msh.ge;
	dkim=pass header.d=msh.ge header.i=@msh.ge header.a=rsa-sha256 header.s=protonmail2 header.b=JR9vOdk7;
	arc=none smtp.remote-ip=79.135.106.27
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch [79.135.106.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B194B606D804
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 17:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B194B606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=msh.ge
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msh.ge
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=msh.ge header.i=@msh.ge header.a=rsa-sha256 header.s=protonmail2 header.b=JR9vOdk7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=msh.ge;
	s=protonmail2; t=1793985602; x=1794244802;
	bh=ACeSaby4ZJ/wanGmyynffXqjsOoMsFpWH9kzoGynS3I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=JR9vOdk7g2Kkvf7OPpe4rfypREo6QkwI0n30lnQ393UnBmiqzK298NchK6sa94wai
	 Ui/qOnJHCYmwOS0SSMXfnlJkWhc8eaDq9UvESzCggVvZmUHqBDCfntEkeDcqMMJzR6
	 1sSrhGaKL5+IT7ImGsAPbI3BhotVNLvYqmY3B8D6sID/VOROJuUwtl+EeK7OHotJz0
	 iDzdKg7J+3+i2gli3cVHXO9ulDCBLoNvDlHq17BaNIMRUJ9sPEnAhWlmCJH5bt8FgE
	 FBj5jUK9dhkvh6U2A33xo8Ajwi1qxplUNl4cuXe6zAfUGNHL82qvfoQRSP/hg5VuzA
	 pxE36jHTD/uMQ==
Date: Fri, 06 Nov 2026 17:19:56 +0000
To: Denis Benato <denis.benato@linux.dev>, 'Jiri Kosina' <jikos@kernel.org>
From: Mirian Shilakadze <mirian@msh.ge>
Cc: 'Benjamin Tissoires' <bentiss@kernel.org>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Derek J. Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v5 0/2] HID: flydigi: add support for vader 5 pro
Message-ID: <500ab61c-d6b9-4d31-8797-5118e9c331b9@msh.ge>
In-Reply-To: <1a79cc1d-1c47-4a87-82bd-304c63deabd7@linux.dev>
References: <befcd715-ecc8-463d-9617-a269dc7c62cf@msh.ge> <546fd97f-bbd6-4867-b86c-9a4a44ca44c6@linux.dev> <9231fd80-a35e-45e6-a608-858e60a7faee@msh.ge> <1a79cc1d-1c47-4a87-82bd-304c63deabd7@linux.dev>
Feedback-ID: 170041685:user:proton
X-Pm-Message-ID: 883de3037141f8161415c935f3f8ff0aeb15befe
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/6/26 8:46 PM, Denis Benato wrote:
> I have requested him to contact you via email.

Thanks, Adolfo got in touch.

> Sure, I also have another driver version to be cleaned up with apex 6
> support.

Could you share it? A git branch or the patches would both work. I'd
like to start from your latest code.

> As per rules you will need to keep my signed-off-by and git send email
> will automatically include me due to that.
>=20
> I don't promise timely reviews as I have quite a few things to take care =
of
> (asus, mostly) but I will surely try.

Understood, thanks!

Best regards,
Mirian Shilakadze


