Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CCD1A6838;
	Thu, 10 Sep 2026 03:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011149; cv=none; b=A4ax3MDuVPoB3agAHLgVOjBS1h/IkE3rgcwdqJm7I3XDpL6KdniempcwEP64q+cKmV9r9/8sXFN5++uLUBAkkUt0nrDdo3HjOe4LGGe3+fHegzUaEeyiPZlpaPq0VHqQuayFF1XUOKBQqe/D/r4ohtDADfo1bIVl6Tp1Zr/IEKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011149; c=relaxed/simple;
	bh=YxZJfsVG8r6xhEVrr7s0Hx4akyowRvvdPD40K+75+J0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RUTARdqgZV680jwis9QsFdv5x/YhOqPihc8rsUZg8QZ1KKOin14PZOesVv3cQFdLNrMGnZ3lDCUTCxRZh0sBVZjuqVzyQuZjjJwDRxCh1+1RC3IG0Y23fQupX/u/dWpHR2nW9f+ohGDMAdLzRZAK3Ep33ibXjsEax9vECIqmRL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=harIwgP3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="harIwgP3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE79F1F00898;
	Thu, 10 Sep 2026 03:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789011147;
	bh=YxZJfsVG8r6xhEVrr7s0Hx4akyowRvvdPD40K+75+J0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=harIwgP3sdPQfhJ6v4sMrT20OKDJ9VLktO4/8dh9ukQarQQvwiPXYyXZh2/sHWQ5S
	 DtAIGsjdgkDQHxpUc08hTiQuIB36NhheIDbOFbBO3giZSXrUw3V+zhXkaRB3UOG38E
	 FHfHWWJIoAW5b+4uypYL9JbhEH3oF8NJdX/ZrbvppiK15Da5KfTBn79R1cgHPJ7ZC1
	 IQtALyqoFfF1gUz9krlnJ/6mETgc08wAu5zvBJd7OshMMelj7x+piBffswq9/kJNuO
	 gxpWsHc4nvwLKM8fPqLyHyjQmeu1LJL/60GRfafKzGAhdXu5lUOYp5njyVH3DSba0x
	 6JXr1Kxeg+esg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/15] HID: hid-oxp: reject invalid Gen2 RGB status
 values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrei Aldea" <andrei1998@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-leds@vger.kernel.org, lee@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260910032115.28669-5-andrei1998@gmail.com>
References: <20260910032115.28669-1-andrei1998@gmail.com>
 <20260910032115.28669-5-andrei1998@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 03:32:26 +0000
Message-Id: <20260910033226.DE79F1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> Do not replace the cached RGB state with a Gen2 status report whose enabl=
e,
> speed or hardware brightness fields are outside the supported ranges.
>=20
> Fixes: 252c4bf1d931 ("HID: hid-oxp: Add Second Generation RGB Control")
> Assisted-by: LLM
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Signed-off-by: Andrei Aldea <andrei1998@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910032115.2866=
9-1-andrei1998@gmail.com?part=3D4

