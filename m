Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FE63BD65A;
	Thu, 25 Jun 2026 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782381348; cv=none; b=XLETWvU78KeF2YtAPOZXRHvUO7auFMcgIZ5WoP8HN/zuSMmZgiLIN77DwYyQ5KaWHTuAHBsLhdshGd4JqOe5WMcOWj4YJ0m1VXJ99T/Ell62RpUBo929GRI4S5IotH5t0GwUosAX7hOOKMnBKwXdEv3eqQdpsqRpSD07jYyrTjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782381348; c=relaxed/simple;
	bh=kpJgSxvhGo0izYZQkVdGDnGKFuHe+M3KXpfjLacOz6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SWZCEGGgefx8xyJMTQdR0WUBmVaHT0E/M80d1yQbQ7cUWDRq2yCJCJi0TkB7DpoYo62QZ1n4Q4a8AH2RXy6I0knzkQmgbotVoXnJ1rQs6+poDyKv73kacc5flTX6iexIWi6RgZN7Iju6ss/n2ahTmhJUFGYphJh0iaZNjD3gk7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MIHYlRW2; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MIHYlRW2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1782381340; x=1782986140; i=markus.elfring@web.de;
	bh=rIlsUluoQmyHUIt3gZQ78i5AXuhPeW4k8XhrZmvdC0w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MIHYlRW2ybuYOoJ73eY8oJ91NNynb6aLDqV9fCnaHNlIHM/3HQFTBKQPtJJR744A
	 ZLbFHYkJ41bA84cMOCgXmXn7BtMvreKRVcL5Hfmq3lcHPIEGq/PY15Te+Hu6ArAVE
	 0VdC5h2/OoZEi+TfucKPgDE6V+G0b6XIxsicU8lTBovv5vqdv0/M5jKs6WcXc8d3d
	 SJnbANFWGqKhBzT6sf8cZdzgaLChwPkxrVAEe2NtX2V7LbTcyIMImq8E7IRP9jOrP
	 3GrZGpTJKNnmYD/4pBYKVfU0+W+ppr4sNAJg5D5hasJx0dj9RM+u9EXO9aO6ARKMz
	 gTky0rR4/YSppMB91Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVJRb-1wl71Q3ezP-00HmI6; Thu, 25
 Jun 2026 11:55:39 +0200
Message-ID: <b7ba4486-6c67-4557-9bf5-4ca4eca8d405@web.de>
Date: Thu, 25 Jun 2026 11:55:37 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: usbhid: Use seq_buf_putc() in three functions
To: sashiko-reviews@lists.linux.dev, linux-input@vger.kernel.org,
 linux-usb@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Mahad Ibrahim <mahad.ibrahim.dev@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <89e9c672-efee-4ed2-9ef5-637ec9707f0b@web.de>
 <20260625093209.34B6B1F000E9@smtp.kernel.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260625093209.34B6B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m+jT6KF0AwsZJIS1rAJK7/fTg162MCnJ5WZ9KmTc9K+vSPb6T9Q
 jfEuY3v5wQM4ieJI6ZNsrDqc1a3kPiDJ/Po4bRXm9MLbOE+qt/EyweTPfJUqK7E+kJrzUYY
 F+MOma4mO5h+dQvXy8knRyuV9zPyzYgEYRFqdoRerxryH0XzxPTH5iX4ISuX3MyK6Ro1sv/
 PMtzQknwQlYZWDiLMENrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BZUbsO8gJB4=;JV4uAgH6IYBHrUw+6MibvyisMNk
 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

> Thank you for your contribution! Sashiko AI review found 1 potential iss=
ue(s) to consider:
> - [Medium] Replacing `seq_buf_puts()` with `seq_buf_putc()` introduces a=
 NUL-termination bug when the manufacturer string is exactly 127 bytes lon=
g, leading to an out-of-bounds read.

These functions were used without error detection so far.


> --
>=20
> commit c41669030bdd8635988fc175a1caf4183a28344a
> Author: Markus Elfring <elfring@users.sourceforge.net>
>=20
> HID: usbhid: Use seq_buf_putc() in three functions
>=20
> This patch updates three probe functions to use seq_buf_putc() instead
> of seq_buf_puts() when inserting a single space character into sequence
> buffers.
>=20
>> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-cor=
e.c
>> --- a/drivers/hid/usbhid/hid-core.c
>> +++ b/drivers/hid/usbhid/hid-core.c
>> @@ -1412,7 +1412,7 @@ static int usbhid_probe(struct usb_interface *int=
f, const struct usb_device_id *
>> =20
>>  	if (dev->product) {
>>  		if (dev->manufacturer)
>> -			seq_buf_puts(&hid_name, " ");
>> +			seq_buf_putc(&hid_name, ' ');
>=20
> [Severity: Medium]
> Does this change introduce a missing null termination bug in usbhid_prob=
e()
> if the manufacturer string is exactly 127 bytes long?
>=20
> The previous code using seq_buf_puts() requires two bytes of available
> capacity (one for the space, one for the trailing null byte) and safely =
fails
> if there isn't enough room.

Can descriptions be extended for possible failure conditions?
https://elixir.bootlin.com/linux/v7.1.1/source/lib/seq_buf.c#L203-L221


> Looking at seq_buf_putc(), it only checks if there is room for one byte.
> If the sequence buffer is exactly 128 bytes long and already contains 12=
7
> characters from dev->manufacturer plus the null terminator, seq_buf_putc=
()
> will overwrite the null terminator at index 127 with a space character.
>=20
> This leaves hid->name completely unterminated. When exposed to userspace=
 via
> sysfs or input ioctls, this could lead to an out-of-bounds read into the
> adjacent hid->phys memory field.
>=20
>>  		seq_buf_puts(&hid_name, dev->product);

How likely is it that such product information will be appended as expecte=
d
at mentioned source code places?

Regards,
Markus
