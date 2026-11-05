Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793893982;
	b=X7/iLyQIsr10wZZbdo+/pdLeQjAUum1Dz4zUL15gHbfhJiJKZqbNyAAqQsHvlp6pHI6C
	 wd3unoAdDYVORWmVKO0cpbcGKL3ACgpEovxQsPr/NvUKyD4tJxDuhSoXL3Q/zZuVDkHLS
	 J+ci8puR2z3tKwvnHuMX9PSeHT2MNvoHyC4Bg8qNxSVvQtXyQsCh8xWzufXlqLxf1M5+r
	 qBgVreQEB2EX+egV1pIduuSvOCbSIhX++RSCi5hTJFgsQSdmC6wr1AVVwMz+DKg7jrEMX
	 /RePeCNYhaj8xzu5CwbGMKbeu+Fln91pBiM6ju8m25Ff/S3L5nvsItAa0Sn5NVy9VCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893982;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IbxArz+p2PBxyIB5HgAHxTAmoW2b3BXbPcRB8H/60bo=;
	b=J/o45LBnXlZOpWD+aqg/L1B4BpuPM9n9StXSWz2GjIA4Y0V5G9NMUv75xZDB9ihMagVW
	 DQju7hUt/MLe4fBVlTCxaWSdqbezcuY5Gf60PI/+wsWv60JsOsXE7mt35+1ETH6cP5rT5
	 IZe1wBIaBOWKoKdWlfjKFzuFijGXwfws8cUIBWIMQWUgpPo0dhnA7jNMm+2b9yQdVpvb4
	 x90vRaLtZIrwmALr/qpFgfsmNHtIYzmonMNALUB7hgXAwELCyPxOgcFhMvQ5FzQH4dTOT
	 unLoQ4H821WjsOthYAY0CDAxXwQOKmhC54CTPE4dfEecARdy+FKGmpQa6aiu4WRHrrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jy6poVAU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ACE606A331;
	Thu,  5 Nov 2026 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jy6poVAU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793893981;
	b=crpUabKqGgsLEzJrVAcdhGvOhkuSVtBIn8ZD2hifuc8o+76CpQF0y0Bcos02SBR8M1dN
	 i9OYA9jJI0CYy5snldDIrvQ9q+TJrzOVBExm65XqSurpTRJPDwcOQkumVNVAwSTExo9Uq
	 EXMLjANtvfNfRJ4epAA3GOVOlImDoRh/GqGCC2ot6itT95XoBJuG+o8NX+NbowrVbkmm7
	 HAk7fIobS6EZgxDSR7cx0vBFtxwUvJsKwmlp8TfUW8b16thouPx2uttfzVRtnAv79YddF
	 hRhJBqWGuwDe1T9VG+YpqbTaS6LXjraF5nvXQtKdWJjEKb0RtkyMrP5hBAc1ekIqSFQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793893981;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IbxArz+p2PBxyIB5HgAHxTAmoW2b3BXbPcRB8H/60bo=;
	b=VkkqbTOtO6HbBYZojC26k8SyRzUS3SQFteViYRNHLZvuHTcFil7IXabEa0T5oqmYkq3k
	 6/yWpOjIwuAdIbxnrAQcUoc59BSYC3wTmRGlAkPtqgLUd460upIzimIeFzEDKXTNPhTDJ
	 7FaOEmhavZUOKonynXVVRYPhtQK4lik3GQqKaDv4wRBKWyUfxBl1qlviQMGV3W3o1LPA6
	 UEmAOUqCQzkgXdBekiHE7/HNKt5CSY1cHZlP1NuW+0Kqte0f0Vv+ne4OHAZbHIDtIwyQF
	 C9RBImBm7smZlZKUkYfSckZY2FcDbtpZn3JxhdctKlnZx9Uvw3VFFkqYJLJoLOqrjGQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id CC3E31F00919;
	Thu,  5 Nov 2026 15:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793893981;
	bh=IbxArz+p2PBxyIB5HgAHxTAmoW2b3BXbPcRB8H/60bo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Jy6poVAUxowppKkSYkwE6stFHCTqB5UnLuQVd/ZA/pYv2A9CcyemEmtsda08vNoXi
	 y+gbWoo5q7rz2u+cJVmTrY/WATCRs3wDuciE84xYbMMgKsgNoXkQcSJK36XVlHEaZ9
	 I3tAXmLJHYde77I6d+iMEsK1QbaDBZjOO++3QDKCCIDKbf2Q/zVOUxjpF4K9YcWmzW
	 0zeGPw/cl9W+AGcRQvWDK7uXKAxsTJiSrl8gO+YuXmPYKm2OvK1ZW1I+hi+JbrFULI
	 ZKtsAspyXzjFHxeWelHEPPPGo67GQWt6gu6c0OwrGQWFprvdluG/GHPSG3Y4OO0cEG
	 cYtdZqMyieYPg==
Date: Thu, 5 Nov 2026 16:52:54 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Sanjay Chitroda via B4 Relay
 <devnull+sanjayembeddedse.gmail.com@kernel.org>
Cc: sanjayembeddedse@gmail.com, Jiri Kosina <jikos@kernel.org>, Jonathan
 Cameron <jic23@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: Remove redundant probe error messages for HID
 device drivers
Message-ID: <20261105165254.00000896@kernel.org>
In-Reply-To: <20261105144036.00002e1e@kernel.org>
References: <20261105-19-oct-hid-iio-unified-print-framework-v1-0-0b360d9552d9@gmail.com>
	<20261105-19-oct-hid-iio-unified-print-framework-v1-1-0b360d9552d9@gmail.com>
	<20261105144036.00002e1e@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Nov 2026 14:40:36 +0100
Joshua Crofts <crofts@kernel.org> wrote:

> On Thu, 05 Nov 2026 18:11:43 +0530
> Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org> wrote:
> 
> ...
> 
> > @@ -377,20 +377,16 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
> >  
> >  	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
> >  					    &accel_state->common_attributes);
> > -	if (ret < 0) {
> > -		dev_err(&pdev->dev, "trigger setup failed\n");
> > +	if (ret < 0)
> 
> You could also remove the comparison and just change the checks to `if (ret)`,
> as devm_hid_sensor_setup_trigger() always returns zero on success.

I suppose you could also add a precursor patch that changes `return ret` to
`return 0` in devm_hid_sensor_setup_trigger() on success.

-- 
Kind regards,
Joshua Crofts
