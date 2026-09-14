Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332244611E5
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388816; cv=none; b=LE3vDG/bv6rF3FvwxqkL+6xCl67VJN1+BnvMh2xzqIKRllS3W10Uls+z73HYUbeLXok1u/AwHOC+IOKuKIzubyNXH8mwVckEmwQW/sNAqyP7F2BS3TRxrroO68FJu1Y5gXFzUcwH4VLUXuyb5wRyIYi1Xco2SJKmrX12SKJW5Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388816; c=relaxed/simple;
	bh=KRUAHf2YbSmZ8D5y0i+plZWvi+Jqcwt8c9aTF4TFCAA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nHhUl0gJM47/P3T70ZAxCckle2urdHN12qOLtzbGnhznEPuOlsHl/5sEMwd1FTP3qB1f5OY1UmXPH79PcKbrVwFhz9uq9R32GNEDtfHwAl6d+Q4AqSNhmclNC3mBWIGkcuSiXHNhMqTVRZn1uRuOLIBlqkKp+GszFYz99XiYJ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mul80EL7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mul80EL7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8481F0089E;
	Mon, 14 Sep 2026 12:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789388813;
	bh=ubE4DJzi6FELUNXOyl3Nmdzu6Uwy5UbcQcTmBiojXNw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mul80EL7A7U34N5A+xudpEbyXeuy1+rNN6zmca03cozQWGOwjtiaZzlVm2pwXJpbj
	 3Ay/2jeCeppJZRTT1eCiPWINwhzsy4ZM8o4CW4L7KZFGTSDJ44nA98e2JY7KfcqWRx
	 VrCRhYVF8rhuKnTYAZ//UTLTFll+77vbw/XLEfS3W8ueiPI52N27kKI2KsHP8iRDk7
	 doM0Tvh52snOh5BQffQ+n0lzFIuLA8bFxQSgMCijkCFp1qgT+EqfYxJ97d6Zt2zaW9
	 RlyNBM3PBSFtquIq5Mii+5eI5Dw3kk+7mr5SyNl2QHDvd45jDkGqJy6DGA93loho3O
	 AzP9Cfc2SzBTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] HID: roccat: fix locking in roccat_connect() and
 roccat_disconnect()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260914120240.1625442-1-dmantipov@yandex.ru>
References: <20260914120240.1625442-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 12:26:52 +0000
Message-Id: <20260914122652.ED8481F0089E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `roccat_report_event()` calls `mutex_lock()` while executing in at=
omic context.
--

commit 8cefeedf72bd07a9332b484733a5ce24fa525195
Author: Dmitry Antipov <dmantipov@yandex.ru>

HID: roccat: fix locking in roccat_connect() and roccat_disconnect()

This commit extends the critical section in roccat_connect() to avoid
exposing a partially initialized device in the devices list. It also
updates roccat_disconnect() to prevent racy access against
roccat_release().

> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
> index 4f15eb9510396..5deb6da8d4f74 100644
> --- a/drivers/hid/hid-roccat.c
> +++ b/drivers/hid/hid-roccat.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but does roccat_report_event() call
mutex_lock() while executing in an atomic context?

The roccat_report_event() function is invoked by the driver's raw_event
handler, which is called synchronously by the HID core from the USB URB
completion handler. Since URB completion handlers execute in atomic context,
acquiring sleeping locks here triggers a 'scheduling while atomic' bug.

drivers/hid/hid-roccat.c:roccat_report_event() {
    ...
	mutex_lock(&device->readers_lock);
	mutex_lock(&device->cbuf_lock);
    ...
}

This appears to be reachable whenever a supported Roccat device sends
specific hardware events, such as when a user presses a profile switch
button on the mouse. Should this code use a spinlock or defer the work
instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914120240.1625=
442-1-dmantipov@yandex.ru?part=3D1
