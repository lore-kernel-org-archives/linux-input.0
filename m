Received: from outbound.mr.icloud.com (mr-2002f-snip4-1.eps.apple.com [57.103.68.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777313563EB
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678520; cv=none; b=GCM97RV8mBj79dZjsuUYbPzGPuM/hULyF3RIj7NpoeKzId0lRp0zLb0X6TljOd8f1ltGQJq1VroHY2FXX86/7pWMUzQu1LSG7dsQwob6+v6C9eIZ/BNvz21yaTE2NjffDQPS6Q5UCP92vzRMGO9jtMeuBTuzjoVdcHOv5erJm1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678520; c=relaxed/simple;
	bh=NXjvvJHKmmdlPtLEj4dWK8Hv6WJBEYSjgZMHvgG19a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6yn5zQRezQLeoMv+1Q1ZdZnGmh2RPK21CvSQqwNqp2lpnT4B5IKP8gJDItUkez6mRNg6uNh0T/uTWW0fzcsrRYHfz1BWBlm67lKJA1ScaQsDDH84E10QrKbvKxcIV0JQ/aXFmX8DlybjIsC/4Snv0tYUrhU2FRgRp6v0xsxyko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=matias.me; spf=pass smtp.mailfrom=matias.me; dkim=pass (2048-bit key) header.d=matias.me header.i=@matias.me header.b=yNrcGPkx; arc=none smtp.client-ip=57.103.68.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=matias.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matias.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matias.me header.i=@matias.me header.b="yNrcGPkx"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-10-percent-2 (Postfix) with ESMTPS id 608811800F65;
	Tue, 25 Aug 2026 17:21:56 +0000 (UTC)
X-ICL-RepId: 01a039f1-643a-74ff-95bd-1888d4ac139d
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQhAAkMDWBxCCE0dXgdLVxQEEFYBWwRyHVgMWgxERV8VGR5XUFoKRhlYCx0AUktAEwROEwVSB11NVg1HD1geXBQXFUFDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FXgxDAlMDFxVWTVoCVk0FSgNfAVsKQgxJBF8GXgJeD0sEXxpaHxhcFF8CdwZTBFAZQENaDgxQTQFDCAoIRwNNF14yUwRfEVAW
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matias.me; s=sig1; t=1787678517; x=1790270517; bh=NXjvvJHKmmdlPtLEj4dWK8Hv6WJBEYSjgZMHvgG19a4=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=yNrcGPkxfquzAgm/tQ0VJyganAwo3MJsHxIxDLw8aUICGY3/QQnUnpN411WOyNpQrxulhLsexeu354+KsNmyYPkMxFMR3aFhexdIRXbeRwLmnbGUS1Rf+Hjx9/TBgb70Q7X/0M/cOHg+BHwCRYH/Z+09hYMr8JZ75M/+32lrTe1oYpfO7bP9B08OXXZNr6TQPyRGZoVU8lPGi6q96c9UICn/LcMyjmSOZMYudOTWcKUHtRgYUMNFbiOv0neAkqqaf7QYcpC0AnDnTy1WCakpJz+Ta1sVyNwBvuoiZaC/+eYGVcuE75s9l4rhg1W1gI2M5q4vHlzMpTkzi8jBbswkzA==
mail-alias-created-date: 1705102286191
Received: from localhost.localdomain (unknown [17.156.200.36])
	by p00-icloudmta-asmtp-us-west-2a-10-percent-2 (Postfix) with ESMTPSA id 26F891800BD5;
	Tue, 25 Aug 2026 17:21:53 +0000 (UTC)
From: =?UTF-8?q?Mat=C3=ADas=20Mart=C3=ADnez?= <hello@matias.me>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Benato <denis.benato@linux.dev>
Subject: Re: [PATCH] HID: ayaneo: Add AYANEO 3 detachable controller driver
Date: Tue, 25 Aug 2026 13:21:50 -0400
Message-ID: <20260825172150.6372-1-hello@matias.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CAGwozwFdyATn5ZE+ACKqcLvsBTkRsiJ2xF4D+AoEtgpoBVOk9w@mail.gmail.com>
References: <CAGwozwFdyATn5ZE+ACKqcLvsBTkRsiJ2xF4D+AoEtgpoBVOk9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE0OCBTYWx0ZWRfX2CniFIh9Mjbc
 HamUJhaDhA+8c2kQUI6X9DvIFM4gAfbexWFh5F1ePdyh1dCMqFqrqmKwvJiS01J4aFlgkNk2pir
 GoHk/JsoLpZP/2zU5PdR2hInQuezkEBpmty7YBxVOQQERJFcShdc22qsztvRFd8qnfO4hYbuZGP
 880wskV+vRfVFubauZHWKhFIyjmkoO3I2CsLVNtbJZFTZGzO15jcZuNbRNhIMw6I0/T93cjUUF+
 vlonSb7jVvbuEBV1QOPPP7bBTef48VInvIZFGddFX2k9krwpTacR94IA8USCANDrjNdxS6B6wQ2
 UJR+NS0tWVh6sEbGlr2TqyLND75Xumgw7MIRSj2NNUyuaQViaaKRD6xTV9aC/Q=
X-Authority-Info-Out: v=2.4 cv=dvjWylg4 c=1 sm=1 tr=0 ts=6a8dcf35
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10
 a=1oJP67jkp3AA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jz3wGu71lD9LvUY0QJIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xA0KNopvTdmZtFpdJMwNwkKUtNHwZRKw
X-Proofpoint-GUID: xA0KNopvTdmZtFpdJMwNwkKUtNHwZRKw
X-JNJ: AAAAAAABpQRvp0Lj2n4iwKXJPIBgN8zcLanKiSaZa/cjObVmHpQxzfB8GC6R9MeXSb/qRafR2HwQsZadzq0mZcukJ3IM3/hL79WWe8hrG8pZBtYmalOCvZoWNx62CG+l3FNAms2hTLybGRqViM1w95ttrr0ov+b7r/Xbfa/gHOed0XABNSw0JiYjjp9pNQZyfv5ARG8YrAwG11N3JIAOUaGR+XZp4zUChaGDs40uFra55snqNKJbIJONgRoDv88k91pjzvQJppyYk2eEoAR7cTT9ix6Mxb9JLlX+JrUEkB7J2jNjeAj7nXtK8Ip2oHYgvaQa8wYvn7fxyG5k6Ogyg2Y3geI39pQVqDpcHwCunIqSmQXlo3J+1RO2GsJp8Dg0jqEbv+9RU347w3GjQd3X59yFx/u7uKzNmbo+mUzGy9WtVo0F+l4h2uWa2sYHlkB/wuMCPZmuC5E/mvVd8KTuOrJ4vlRenOLWYIoWAD8SHc5JOVUyVNQyCqMopmnoJOEycMurD+HQqZg98gzhP3pnqzUD4Z5uZdWy92xLNBuBxnTg+K5bu69dqgmtL76Vxf/G+xXhpolTF37/W6RUDjWKubjlqB7Z3HzutPPORE1FlaL3sY8fu7BLronoxdasHfI7hcn8Jxpsjv4cw5bP9usWJBbb/PoLEnZOZx9WUFPBQrHQWdKF6Q/djK+cMQQJ92jz16fML4Jr7Y324l9eWgkrJnCl1+a6y9TRqqfG3JNxvj3duAtO4NECeNvZcVw+XNQMs4/+50MZTqm8YVO/j92aN2+YX+ct/+mK/3QG4mV2mr5r94Ohfz0hTgry+VMrWzAv/YOL6EDnuYgN44Of3AtF9/SpRNulrQfOtgw94xDPAjxtKt4xgRf5cdqnMlmXMVNqYMLD7XlHWeHcB/RJSS3kD1qFrv/+MRYzdyjoG9mFz4qUNzurAykPOfzXdwyUPbrJ9ywGrBgIykmB5cgFrCqV/3ZR2ipuMZf
 OB9XLZzvYsUMKkYeKF4/Xr5Jd6TpEpgi1eqg1s//9U2pPrdbTIPc0JooFh2cPovfTfr4GyNxwvzuYqsbjbD+h1wGYUDsz/kcD9slIwuUSKbFzQOpcQVcs4kJPjXKE1xi06T96nfPVUmOnOKLiVNGAg99KsO2ZCte1TsahCl2AKfogn1vinTD1k0RBB8AEqlTvp+KTBiK56HoYNzXoIZja2rRAU1JGtIRgwc+/EdgIfrpHUXm504twD1Hobw6JcRj+gTtKZw0ErpHjrW8IJEA7F/xA2IV3cPFaTGWcoiV/t4pgQkVeQ0kZnTT58+ep0bKG+qg5SVk=

> They are eyeballed timings that worked during my testing. Because I
> operate in userspace I have the freedom to choose whatever timings I
> want and change them whenever I want. Carrying them to the kernel
> freezes them for the vendor device and there is a higher level of
> scrutiny required before they are merged.

To be precise about what would actually be frozen: the ABI is
"writing 'left' to eject returns once the firmware confirms the
release". The poll cadence and the timeout behind that are
implementation details, so they can be retuned in-kernel later
without breaking userspace. Your larger point stands though: they are
eyeballed numbers, they now sit under kernel scrutiny, and I am the
one signing up to maintain them.

> You also only carry part of the policy. Userspace still has to
> coordinate between the calls to the EC so that is left to userspace.
> I am pretty sure I have a lot of timing quirks there as well. So now
> you have a split policy

The split I ended up with is a bit cleaner than that: the kernel
absorbed the timed parts of the protocol (reply matching, retries,
the eject handshake polling), and what remains in userspace is
ordered rather than timed -- wait for the blocking eject write to
return, then cut controller_power. The UI I tested against has no
timing loops left in its eject path. Whether that split carries its
weight for a niche device is exactly the scope question, and I am
happy to follow the HID maintainers' call on it -- including trimming
the driver to the LED plus module identification and leaving
eject/reset to userspace over hidraw, if that is where they land.

> I did not disagree on the RGB part, that's a decent addition barring
> timing quirks being needed and it should be relatively easy to
> upstream.

Good to hear. No timing quirks on that path: the config command is a
single write with a reply echo, and solid/breathing/off all worked
first try on hardware without settle delays.

> I would advise some caution, because e.g., I noticed hid-oxp got
> upstreamed using a global drvdata table even though it is a HID
> driver and there are actually multiple OneXPlayer models that carry
> both hid devices and now they will potentially have their kernel
> memory corrupted.

Thanks for the pointer -- I went and checked. hid-ayaneo keeps all
state in a per-device struct (devm-allocated, reached through
hid_get_drvdata); the only file-scope objects are const tables, so
multiple bound instances each get their own state.

> Give it a few days before sending a V3, others should leave feedback
> as well. You sent V2 a bit too fast.

That is fair -- v3 will wait until the thread has settled and the
maintainers have had a chance to weigh in.

Thanks, this was a useful mail.

Matías
