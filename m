Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980962;
	b=hOS6NoCSeKt92f8uFAKyB9ntnlNZy7PTgHnl1L78KiJztokeslMpLqh0drd1Q735SunC
	 EXWeOKe5LMxFehDyXcRcqum5xc0/6fGeqiXHEurwGqnIAzX49VeFSEIOqF+dE2OqNfjj2
	 LE+Z5RacEUeUnByu6E/bEXdzENgdDfOEhswR/UB9Z1YLBL1tkelnxxM70lxb9bObAn7vu
	 zsb8pMdorLX4KR9EnY1L2qGHpkSqwr++KVr6KfCho5B/FomHCKTKcv6oThKClZv3CcoPU
	 pmwV1QEJMUgO0tLjBYbswpCyJwnWPWyNOYLIeCT+iVGdymbndPCZEy6drBa9lcrekwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980962;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=wpRuGom+aQB1p40BqKVMA66QnEAxTCxkfSpTV/U+fQ8=;
	b=JsL2xgDFUChYqKadMphAf9JybppcUGbPi3nmxXNY0+FH4u66QIR9HavL3frZYYGs+l23
	 TNAsCeaxRiiP7awZPar29Hv+OblhJWNp8qt3mLLSv0Gyoc6hoNwMGGO9zfC8VE3wixRNT
	 SJvahmeqLGw6awdEcYol2iKlaBZ8iSaZW3+xxSkWCd/SMia7WJMhdiUMUk+dDXbA6T4Yy
	 dnbf+Uo4aPt+P61ZKnSIZRzH+eF6MbczV7Iu5u5RazFa0VmkpRpMzItBq3anWUDap9A0S
	 /c3K+A6maxdGJnHO2Qg+4gERq4ibGgT8z8m9ZBn0FH0V+jOAM43+B5xTGSzlAUqYKQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=msh.ge;
	spf=pass smtp.mailfrom=msh.ge;
	dkim=pass header.d=msh.ge header.i=@msh.ge header.a=rsa-sha256 header.s=protonmail2 header.b="bRuWAVO/";
	arc=none smtp.remote-ip=109.224.244.119
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch [109.224.244.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D162606A32D
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 16:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D162606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=msh.ge
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msh.ge
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=msh.ge header.i=@msh.ge header.a=rsa-sha256 header.s=protonmail2 header.b=bRuWAVO/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=msh.ge;
	s=protonmail2; t=1793980959; x=1794240159;
	bh=wpRuGom+aQB1p40BqKVMA66QnEAxTCxkfSpTV/U+fQ8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bRuWAVO/NIlDuQ42a1gbM/KpS5JpTIAI3fORBadjf1yq0rZWrruLs7dqCrmY1c56/
	 2hie+AqjK2H1s3gMMgskgI9hiVbtamG39xV3kA65YgkYtI0FpiWPPeXaXSTr73jZew
	 Wlt7lfHfWuitQE1cQcblqz4arXMSyjgtzj7zu1d3EaObTzjKO4js7NxrH75cvp4pQr
	 zBwPIRZOhytr/sMxsZVbwg58hvppPNFt0dq2csEnbYmlwnn1cBIxBpw+Wm2hHOEsXc
	 F8JHrQDUFAVAFFkiDaiJ09/eq4qMuahuEjaGQEz3SFr0igj4YqI0toC/Yd/Erf5dLI
	 ixmUUqRJPFv0w==
Date: Fri, 06 Nov 2026 16:02:34 +0000
To: Denis Benato <denis.benato@linux.dev>, 'Jiri Kosina' <jikos@kernel.org>
From: Mirian Shilakadze <mirian@msh.ge>
Cc: 'Benjamin Tissoires' <bentiss@kernel.org>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Derek J. Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH v5 0/2] HID: flydigi: add support for vader 5 pro
Message-ID: <9231fd80-a35e-45e6-a608-858e60a7faee@msh.ge>
In-Reply-To: <546fd97f-bbd6-4867-b86c-9a4a44ca44c6@linux.dev>
References: <befcd715-ecc8-463d-9617-a269dc7c62cf@msh.ge> <546fd97f-bbd6-4867-b86c-9a4a44ca44c6@linux.dev>
Feedback-ID: 170041685:user:proton
X-Pm-Message-ID: 532db2194371616abd96a0c567165a9b096544b9
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

On 11/6/26 4:03 AM, Denis Benato wrote:
>> Should the driver check the flag and warn or turn it on itself with 0x11=
?
>=20
> I think it should have a sysfs property allowing to change it and also se=
t
> the most reasonable value at probe.


Makes sense to me.

> Since you two have the whole range of hardware and SDL has working
> code why don't you take over? It would surely be better than me making
> the bridge since you do own hardware and care about it.
>=20
> Let me know if you are interested and I will be more than happy to
> make that happen!

Yes, I'm interested. Thanks for the offer!

Could you Cc your friend so we can coordinate? It would also help to
know what the recent firmware update changed.

If it works for both of you, I'm happy to send the next versions of the
series and handle the review.

How would you like the handover to work? If I take it over, I would keep
your authorship on the existing code with Co-developed-by and
Signed-off-by. It would be great if you could stay in Cc and review.

Thanks,
Mirian Shilakadze


