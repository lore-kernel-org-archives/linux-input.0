Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D122313534
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781595795; cv=none; b=CWyDTJCOynxe9HQ/JosGaRW4wBYVU9dGefTA2vC0xdJPjlWcJBi7mlfLO5650du3s0y8Dc63FrjH68atk9BoFKNjSzgazn+/iKBqJj2k7+gq/gtMOz1ZNLQl7us2UQ67OSPFdsw68l46FzDPB7O/K5Qr9rjQUQIynxwFKoR4/jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781595795; c=relaxed/simple;
	bh=TlMHkVuXvMkE5l3RxjoqZosQSVobhfw9IEhSIQzWANY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+Vleo0bl7UbLOvhV4/zb80sfdlBAcy8BMCS2HBuqD1RxDvZRza5YJjbjcT9Q88FtcUK91TIbtprvz6VjNIJg9dVyNQN1A6vETeqcv9J4CUyISFueZzp/qcGX69bA6KN0xyRTs6tLbBpzChBIH68KOaAjBx5d76mqGWcmdmdyrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dOaq9P+a; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dOaq9P+a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781595783; x=1781854983;
	bh=j23gK3Ku6imN7Lhx2v5uAkGVwMV9RzbEfvG1x5gJmyQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dOaq9P+aWXYXcBd82+JHwWVXqOA7NMW3pG/e2C+T3XRMztXACostudo6VaazR1+ZI
	 zHHq1G8wEurl9bNE3BArIzh7M8vTSbvpzl18gnTWYy5ak9O0GuePOLYeRcyppKtzuU
	 gUDV3sgQlhVSdT50Ld9jhzdSYNy788cIRGBkYaHMfMqUb+ttK9JrU1SfkgTzfybrir
	 fNnz5cQXzUTjut1seiKqOvaJtOBZ+SATVDjrCET2NnZv4bnWDNtq3k66ox52muI/N0
	 xJqX2g8QNA+1n2ndUEWzm99QFe9g8dF5aeQiaW9kMnOHe/u7t1KlxTa8S2BX/ZnS3h
	 SobGOHzqMBTBQ==
Date: Tue, 16 Jun 2026 07:42:57 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-input@vger.kernel.org, Linus Walleij <linusw@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] Input: mms114 - refactor chip variant handling using descriptors
Message-ID: <20260616074253.162977-1-hexlabsecurity@proton.me>
In-Reply-To: <20260616050912.1531241-6-dmitry.torokhov@gmail.com>
References: <20260616050912.1531241-1-dmitry.torokhov@gmail.com> <20260616050912.1531241-6-dmitry.torokhov@gmail.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 75690f7a946249b71af858fc687a087e2f4f66c9
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

The descriptor refactor looks good -- it preserves the per-variant behaviou=
r
(event size, config-reg gating, get_version, fuzz handling) for all five ch=
ips.

One user-visible side effect worth a line in the changelog though: switchin=
g
input_dev->name from "MELFAS MMS%d" (the enum value) to "MELFAS %s" (chip->=
name)
changes the reported name for the two variants whose part number carries a
non-numeric suffix:

  MMS134S:  "MELFAS MMS134 Touchscreen"  ->  "MELFAS MMS134S Touchscreen"
  MMS345L:  "MELFAS MMS345 Touchscreen"  ->  "MELFAS MMS345L Touchscreen"

(MMS114/136/152 are byte-identical.) The old "%d" on the enum silently drop=
ped
the S/L. That string is userspace-visible via EVIOCGNAME, /sys/class/input/=
*/name
and /proc/bus/input/devices, so any udev/hwdb/libinput rule keyed on the ol=
d name
would stop matching. The in-tree boards affected are ste-ux500-samsung-kyle
(melfas,mms134s) and msm8916-samsung-a5u-eur / msm8916-samsung-e5 (melfas,m=
ms345l).

The new names are more correct, so this is just worth a heads-up in the com=
mit
message rather than a code change -- in case an out-of-tree quirk keys on t=
he old
truncated strings.

Thanks,
Bryam

