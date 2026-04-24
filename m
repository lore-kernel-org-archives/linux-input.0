Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E006E21CFEF
	for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 04:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777005407; cv=none; b=VQzkPDZd27UFGlA/oVfnpTFPoYNOkSlDChInaJqPDSLDdp4QowUk0yM4lX0KDDjhkmbkKTRKO/NImWcTC5hBrm/vaijTSvUp61GEqI/NSV7lqE++/AXIytKO4BaLKfqzI+7MpfkWTZaUilsuOpYwrM1JVfgpHYQZwjTXNeDaDuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777005407; c=relaxed/simple;
	bh=bGdOnsN/F+0Okgytog7KGdP9qeRx4CBhxs57Xtm2Ftk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N67Tu7S4pTNXCVlUgH1z9d03r4g+v7eGcLqTHA40PnVprqivrynqTwVGBs74dMWlgEmNo7I4rDHoDyPXf755aZFclEK/UzRl3r/TnL21Eyx1fXG5Qai1zMfkPGS+CizPG2jwHvrK6ezyV5qTPxVmPUWhCZfYEyX8MZllLxbNdjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=QzXJT7xh; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="QzXJT7xh"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id EBABE240027
	for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 06:27:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1777004867; bh=VL0cqMt8WKHnQfFbtjvOG7Pc840E5lhvoZKWULzY2UA=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From;
	b=QzXJT7xhuIqibJ56XWh8EBI3nvRczLAbgC8N9PWng2W+6wFzCvrF9RatpdbeajM+n
	 tnRwsNKURCVPiK7VCg0JeC/kWUv8XWW2Vg+a79HIIfZBTGCbD77noRCz9tsVv4ImUn
	 ocAKr/RiXx3BDJmDos0ArsvPblsTxHOgJxGCarUjGjaFvv21qdRxYlrJe2ACT+rMXL
	 jCfkTYi1ntqCGL/I5LmGhJH4/uuPDQJua4CcnUhSFwP3XPDxh/arWXf4zI5L+BQlRK
	 fkmv5mIzVkoAMKdw+s7Q70uF/aT9c5XfIJarGrtr/jGP8hstyujhrWSlMOlQffNt2V
	 5ZqJKm4p2fkow==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4g20LW12vHz9rxF;
	Fri, 24 Apr 2026 06:27:47 +0200 (CEST)
Message-ID: <b080e8b032753dcc1065c0f83ab6f0aa6e806dc8.camel@posteo.de>
Subject: Re: regarding runtime PM in pegasus_notetaker
From: Martin Kepplinger <martink@posteo.de>
To: Oliver Neukum <oneukum@suse.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, USB list
	 <linux-usb@vger.kernel.org>
Date: Fri, 24 Apr 2026 04:27:47 +0000
In-Reply-To: <59b2c482-06b4-48e6-addc-ba585b580006@suse.com>
References: <59b2c482-06b4-48e6-addc-ba585b580006@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Am Mittwoch, dem 25.03.2026 um 15:00 +0100 schrieb Oliver Neukum:
> Hi,
>=20
> the driver takes a PM reference in open(), yet it marks
> the device busy in pegasus_irq(). These approaches contradict
> each other. There is no point in marking a device as busy
> while its PM count is elevated. It will not be runtime suspended
> anyway.
>=20
> Did you mean for the device to be subjected to runtime PM
> while in use? If so, could you test the attached patch?
>=20
> 	Regards
> 		Oliver

hi Oliver,

sorry I haven't replied in a month. I saw your patch and have the
device. I plan to look at it and get back to you eventuelly but haven't
done so yet.

thank you,

                              martin
