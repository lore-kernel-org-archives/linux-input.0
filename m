Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB8C233946
	for <linux-input@vger.kernel.org>; Sat, 30 May 2026 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157772; cv=none; b=MxdKHCWr9zEvpubnO2DmUKuXKQLD/Uj72f2FxeMiEmuYoepG4dJJ6+kJUy4Up1SVnNjkkaRKgznLcgm1cSf73TW+j5aJcz/UECz0p9hREIOsumOuT9EIw37GSApRUgZqw3AxIt/JiJKFpXs6A6p/7JGnmBN4VGHG+JeY6gK9DAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157772; c=relaxed/simple;
	bh=fvOV5VeEDqy5mltzTUYho9SRDUaaDAnH3Z6ROmjnLWQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C1bkrB4MeL2KPGEvV4c9He+mLHhwJOXeX0u6cQW+g5L2YXKM/eZK5W6n5eLpSd3To+BZsS2ocZ847T0bEwvsYQ+2VDZCgsBUvw2ZE1jOm88PViIbiY8XMiEPFIdg2Pp7mq0ZATSFlTqf8dH/BS5SNYLcsgXyX2WnQ9YNlPCojiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJUgBkTs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJUgBkTs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225E51F00893;
	Sat, 30 May 2026 16:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780157771;
	bh=sYCjLDhRWqwczhisqhGnIaiZGWJ6kstq7gYvnwYMB2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WJUgBkTs5p6N3HpcZMd/ZvhL9OIisd29WONO5QRPQuK4nLTJV6vPoCRjp194sphLJ
	 WDNRkT3mlgajKoxe2GlYgNRt1JTSDCW63sY/gGWzFIjWkBKnppp4otUAcwyEEqr8H/
	 +hQsml2tm178alI3q2SU+DzHa2pBR43F0dRBHW+WlRapI9amNIPN6USErm/7LQlbV5
	 VzDmxUXZ16fDqXsDGj2BTp5ObTiWTQS/qtUV0Y1IFlMeCLYZCAeomJtXQItuAowIou
	 yzkfGn/PYpp1Z9DqKwf4UMQdu8YbVGwvtMqaWVPiOqX4qcKB4zuDAQc+W8120DRkUg
	 61bknPFvK2kvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: wacom: use GFP_ATOMIC in wacom_wac_queue_flush()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinmo Yang" <jinmo44.yang@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260530155930.128183-1-jinmo44.yang@gmail.com>
References: <20260530155930.128183-1-jinmo44.yang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 16:16:10 +0000
Message-Id: <20260530161611.225E51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] A malicious USB device can trigger a massive heap buffer overf=
low by sending a HID report larger than the wacom pen_fifo capacity (e.g., =
> PAGE_SIZE).
--

commit 2421694466917c461a3ca5695c18542757de2d44
Author: Jinmo Yang <jinmo44.yang@gmail.com>

HID: wacom: use GFP_ATOMIC in wacom_wac_queue_flush()

wacom_wac_queue_flush() is called via the .raw_event callback
(wacom_raw_event =E2=86=92 wacom_wac_pen_serial_enforce =E2=86=92 wacom_wac=
_queue_flush).
For USB HID devices, this callback is invoked from hid_irq_in(), which
is a URB completion handler running in atomic context. Using GFP_KERNEL
in this path can sleep, leading to a "scheduling while atomic" bug.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 2220168bf1164..a25400b3e658d 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -74,7 +74,7 @@ static void wacom_wac_queue_flush(struct hid_device *hd=
ev,
>  		unsigned int count;
>  		int err;
> =20
> -		buf =3D kzalloc(size, GFP_KERNEL);
> +		buf =3D kzalloc(size, GFP_ATOMIC);
>  		if (!buf) {
>  			kfifo_skip(fifo);

[Severity: Critical]
This is a pre-existing issue, but does this usage of kfifo_skip() point to a
similar problem in wacom_wac_queue_insert() in drivers/hid/wacom_sys.c?

If a malicious device spoofs a Wacom device with WACOM_QUIRK_TOOLSERIAL and
sends a report larger than PAGE_SIZE, wouldn't wacom_wac_queue_insert() be
called with size > PAGE_SIZE?

Since pen_fifo capacity is bounded to at most PAGE_SIZE, kfifo_avail(fifo) =
can
never naturally be >=3D size, causing the code to loop and blindly call
kfifo_skip(fifo):

drivers/hid/wacom_sys.c:wacom_wac_queue_insert() {
...
	while (kfifo_avail(fifo) < size) {
		if (!warned)
			hid_warn(hdev, "%s: kfifo has filled, starting to drop events\n", __func=
__);
		warned =3D true;

		kfifo_skip(fifo);
	}

	kfifo_in(fifo, raw_data, size);
...

Doesn't kfifo_skip(fifo) advance fifo->out even when empty, underflowing
fifo->in - fifo->out to a massive unsigned value?

Could this trick kfifo_avail(fifo) into returning a huge number, breaking t=
he
loop and allowing kfifo_in() to write up to 16KB out of bounds into the 4KB
fifo->data buffer via lib/kfifo.c:kfifo_copy_in()?

lib/kfifo.c:kfifo_copy_in() {
...
	memcpy(fifo->data, src + l, len - l);
...

>  			continue;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530155930.1281=
83-1-jinmo44.yang@gmail.com?part=3D1
