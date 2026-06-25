Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBA22253EB;
	Thu, 25 Jun 2026 08:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375818; cv=none; b=Z/1oLqyID+Vq+DJAe5yE2OhTZfdz5/fqQooy6ytKrcY2FpJTrK7X+OBS/Jn95ymjAgjq+ASe0IOMYaGg06ZhxUTTq9tPmpWnCRGsTOvBwicR+AWWB82JBt2Lrp2jU6MkumZP039SGOkruXqgylkGo4gn6XrgBpfMPI27VY9+smY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375818; c=relaxed/simple;
	bh=eXk9wotiYSlgv9dbFl/AWc4G+D07IniZ4g65k+BeJd8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=foLNEpqA7Ok0d04QtbJlRGEH0OO2RWAjsayXS/C1DnL9C0LLpZ5Ms1tUT+wBgpYnZpCbU+4hyc+YM5vNku5qIxn0/mqsMZMIokDhXcKkqQTrQ+1Eq3+zc2uH7/maLmDYGXvxOZqo5hlIWUNusRwSQyXA5LjdudFwm340mvfB4GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRpsRs3P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRpsRs3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08BF1F000E9;
	Thu, 25 Jun 2026 08:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782375817;
	bh=eXk9wotiYSlgv9dbFl/AWc4G+D07IniZ4g65k+BeJd8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FRpsRs3P1chBdzhAMiFFHwFxr+sGs25D5iBwBAkqfpUqP0YoUyfhvgWrib6MJHG/s
	 K8T6wE3Wu1M6M90JOgBoUjwzvxnTPq3TvNkueOxmI2sPyOMFY6A6yYc4bCNUQZF43t
	 iiBDJdq9HQDaMg5RRhlSdWoeNKz2QKyg4iDXqK6SsEtY7zk3T6IN8ntEyD+4ZihqVA
	 /cKDHGfJmAIJvt1uaCFrOh9AqWaLSrsEcc6UV3nVmCUWmjHw/1VC+9jrCQiJmtjvYO
	 67zPYsNl93ZNRDIeoSO9D2KZ5iZAo9YQYYtj2flRDqLSUhCIZNIDM+izHDQvDyRzmy
	 Q20BN5ajDyEdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/6 RESEND] mfd: motorola-cpcap: add support for Mot
 CPCAP composition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: robh@kernel.org, linux-leds@vger.kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260625081812.33474-7-clamor95@gmail.com>
References: <20260625081812.33474-1-clamor95@gmail.com>
 <20260625081812.33474-7-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 08:23:36 +0000
Message-Id: <20260625082336.F08BF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> Add a MFD subdevice composition used in Tegra20 based Mot board
> (Motorola Atrix 4G and Droid X2).
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625081812.3347=
4-1-clamor95@gmail.com?part=3D6

