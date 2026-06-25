Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC39D3AA1B0;
	Thu, 25 Jun 2026 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406533; cv=none; b=P9ziNTKkBg2EdGv0rZ8MIygqc4TUunpljAyhlDqhSUOzd/vzzjQf9Klr6ioV3KH+OdP9rgGL+/uYLOUf3m3jvJqFpTUp63dipuOGmcc6dCVOn3sKcxjYYYk30S9bHgDe1MHyKqT71QEzeehpfu6z+XW+QhKaM4I2jNYPDsHXfRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406533; c=relaxed/simple;
	bh=FHHGYQXQT1PKs5B2WZMLLUlKrYmF4nfrY/NoIn3shQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNxSFxuPHmwCB+YabnrwHcMrlHVKjYorlX3R1ysDrMkgr7VkdErCyDp+jseQ0JVVPP6nPdT12SqP2V0/UuWJc8Fk1mIUfa4Is7Fivv3AzMTOHhu36WTxbWAcBVLMy4lsIOp0gzs+3H3gX8zKjomLCjBV11A6yZay36B+iqCkW3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=C2N9a/Ob; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="C2N9a/Ob"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1782406523; x=1783011323; i=markus.elfring@web.de;
	bh=+K2RNATNlxo7gLOQ3ng9eBBYAtZI8qC0skGXdt4jsbg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=C2N9a/ObPV/zIBbAXK0h23YDYxXnaj0Eh2l4J2emgUjLg+ZMpH/rCLzRY0k+1wWt
	 Olt+OgFApTOBrEzVBHKXtdLz1k5pTr/fiIgdCC5mQmuO1irkVVfLCqpG8ifUeGmBf
	 h9SOj8lqkVmWfCYbeEihl6QF3u/FIGvsSVJ8Vy0d6/KvaVlQI3J8iV9XWGSx1AD/x
	 RvY3jj8NS5G3gUITeeg/EZ6jPwl2y4nWhB1Ji91xgJ2DbFsh/Lv5fLWkMBfTNqKW3
	 zN/0STLCc6eKF6NHPTyKKQqTXezb+Dw3Zr2Jx4Ts4KfKkl/YurmZzuvrN5B3YQJpJ
	 /4YsV6NfxqJubuemVA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9cLR-1xF69m1j5J-00vpFs; Thu, 25
 Jun 2026 18:55:23 +0200
Message-ID: <393fdf99-e6ac-4cb4-8d82-02c55b9e83a4@web.de>
Date: Thu, 25 Jun 2026 18:55:21 +0200
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
 Steven Rostedt <rostedt@goodmis.org>,
 Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <89e9c672-efee-4ed2-9ef5-637ec9707f0b@web.de>
 <20260625093209.34B6B1F000E9@smtp.kernel.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260625093209.34B6B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4b7Y/G4j3UchnPBDL5vVLRedezB65lLB1RT8wGCvBpBY21sNKyW
 WE8zyCJgwMV8Tghx5zd2qU/qPWdZAp0EjSxJi4Z3kFvYrf/NksV8/hcqCf97VtQeBRDvjwd
 qcXfef83qFj9+Axh9sORSzMXVBM7/l7Mt1XZTKg4yRXMvY60PRloFwZ/TkEf6zqtST++780
 axsB/EXPs9C+zW9osMc1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YmyZGL0qctM=;cOlshYKwWkO47ADFd1LQdlzAa6W
 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
 iZV7HczbR7HRfG9AkZ7aHpc5lXI=

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

I see a need to reconsider such information in more detail.



> Looking at seq_buf_putc(), it only checks if there is room for one byte.
> If the sequence buffer is exactly 128 bytes long

This is the case as such a technical detail can be determined from the mem=
ber =E2=80=9Cname=E2=80=9D
of the data structure =E2=80=9Chid_device=E2=80=9D.
https://elixir.bootlin.com/linux/v7.1.1/source/include/linux/hid.h#L721


>                                                  and already contains 12=
7
> characters from dev->manufacturer plus the null terminator, seq_buf_putc=
()
> will overwrite the null terminator at index 127 with a space character.

Other contributors can add further experiences for corresponding data leng=
th characteristics.


> This leaves hid->name completely unterminated.

I would like to point the comment =E2=80=9CDon't count the trailing null b=
yte against the capacity=E2=80=9D
once more from the implementation of the function =E2=80=9Cseq_buf_puts=E2=
=80=9D.
https://elixir.bootlin.com/linux/v7.1.1/source/lib/seq_buf.c#L193-L194


>                                                When exposed to userspace=
 via
> sysfs or input ioctls, this could lead to an out-of-bounds read into the
> adjacent hid->phys memory field.

If such a data reuse would be attempted, API requirements for sequence buf=
fers
should probably be taken better into account at a concrete place.

Regards,
Markus
