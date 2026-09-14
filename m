Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0863CCFCC;
	Mon, 14 Sep 2026 23:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429638; cv=none; b=cBPEJQ/hTWbZfvQMvZVr8m4FZk27dnJIw10dE0lgTfu6TaNryiMfbeos6Hi8PKdMJH/HdZWUTgBqVDA2iFk6d34YOfNj2c6ND71eyQgCxItlajuIp05B0ZhETARU9ugKMpLv3I0U4P11bmY89ynmNxUqwSDkNyx1l3fhMT+fE4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429638; c=relaxed/simple;
	bh=SxVUUOovjw8BninXsW2ikCNHhDcuTAb2THGuJiIfG0w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SCVBcHAqqZBMkThzta9ZZGy27jOUSORr8pvrQFhTX1f1WzSce39Kg++aolr1e/9syMsySmZgaxRCB9h1epoGzFsrfHvolah8c1PJRG5/e4IxCgqj26qMnfhDPxnfrPUzXTDZRkWDkJSLjyPsaUraiZAyDr2s8ia/GBxKdOWZ+4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/yteARa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/yteARa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24AC21F000FF;
	Mon, 14 Sep 2026 23:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789429636;
	bh=SxVUUOovjw8BninXsW2ikCNHhDcuTAb2THGuJiIfG0w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k/yteARaGA0AdlJGy3mzagMpRa0xTiL9v1QwBQWk1LVJMA1D58eZtw+67aJXb51j5
	 mehXSuH/dAm37gcIDjOc8Q9AqRXzAygWLHLsq47EAR9KM5jBKGb6YI8QYfhu/N7pyK
	 GMjgbCewJ1ppu4HnW1iPDPY+4JulgXaqT0B6Yf5gkIuLL6GWvQJD6+fC8on4BbvBIV
	 QPBD+VEhRobbR1vOaoLAeyU6O0dfyQ8GsxBTrzm5mei0cJv3byVxY+Hbe80OGhNHGq
	 g3HhAjo7KukZcM2L+/ZB37ixtW/YLk1ffLTYP+2A2pW6MiSXkPpJvXUPoqB1r/G9Dx
	 du3Tp01yGQ8AQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] hwmon: (aquacomputer_d5next) Add AMPINEL support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vas Zayarskiy" <contact@vasily.cc>
Cc: linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260914233728.22725-5-contact@vasily.cc>
References: <20260914233728.22725-1-contact@vasily.cc>
 <20260914233728.22725-5-contact@vasily.cc>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 23:47:15 +0000
Message-Id: <20260914234716.24AC21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> Add read-only total power, total current, input voltage, hotspot
> temperature and six channel currents for the Aquacomputer AMPINEL.
>=20
> Decode its 544-byte input report through the existing serial-number,
> temperature and update path, with power, current and voltage handled in
> the device-specific switch. Store all readings in hwmon units.
>=20
> Match only the USB telemetry interface, leaving the separate keyboard
> interface to hid-generic. Validate the telemetry collection and report
> size before opening the device. Channel labels follow report order;
> configuration and alarms are not supported.
>=20
> Assisted-by: LLM sparse
> Signed-off-by: Vas Zayarskiy <contact@vasily.cc>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914233728.2272=
5-1-contact@vasily.cc?part=3D4

