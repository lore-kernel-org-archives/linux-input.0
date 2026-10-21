Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792611623;
	b=UnbxwFO6jCWogcPXnv7kxr21FQv7Jr2ldayf9i2SHQkPkEMv8/WTEHwQ6WqIpuimeGTK
	 qEkJmwqmK6oNZtMonX6RP6t7OjnNf1LdQWcPoeYNSH8ZfqAPF9na1dWoy9gL2nQ0jlDy6
	 D2I/NuVZbabdb226qjgv7l7Q7aCC3kEv9Q+ZO6q4mz/PJBlxWp/uQaJZRHIyR6U86cPlz
	 gdBaW9cGmiPQH2oft11pozWE9zDbjGK3MkV7q6nBw2slY2tn9JDHMYg6hcYr5dEkM1635
	 FECsUh7w2emVrxTVVpPeEcxJDiW/5Z/RzIkylbCGDffTivSues0Y2UCHRmwer0rw3HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792611623;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VYX1UhKmAjV9w6jRLSUBXlUX07jQ9A8j9nmXwWdOln0=;
	b=GMCgee3g6aB1y5LY5jY3Yq8Y9+DjxEJvAKlkWeCpCYLHy5oSZvL40MhWbOclPAFELDEn
	 W5yHH1Nk6qu8BqFIdFUiLY4HmhLJww++5WAuZN0F1lV+KyuCJI3MuzfvJ7iGLaYOqUcCP
	 RQLjg5U5kvjxwQysqV0fb+ZGD7/ZJISZygPLVuF7Uf6zdoXCekoW0lfVDB4CxgpXeBxw7
	 OGXx07+V/oSEN+rlEMLfEJGiV2lBsxpyFPO3nx2peNuxB7SDOXpyZBDQdIyb3Agtyh5/V
	 At1pquqsEkfjerCRDMU8k/NrKTu0fWx1Ultn+MknU7h5//zjPcWD5/mvLgPG5BqF5/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JL0lqrUG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C89606A319
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JL0lqrUG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7B31F000C1;
	Wed, 21 Oct 2026 19:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792611622;
	bh=VYX1UhKmAjV9w6jRLSUBXlUX07jQ9A8j9nmXwWdOln0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JL0lqrUGANcZlZLlA1BYh6FnrzKw6hCHPM9uZ/HTO3ceOZXaYSgH9KPq/e//749jY
	 D8GUjTvxXZhJdx/imitYLXoYnDGcGcjGzyRjDDx9pNSoXnVTU+f4jXLCSmdJPUeP+t
	 6jM+xHcf2CPhvJoKyUUtpF66ZfqNDi//hMR0U3wAiGhfZl7UvGaUXVTciw6CaWhFCn
	 8tJ5jq/uqi4dFlgs25/r0djtbvDWYaQE8bbWUIfQXZkwEAbPWzBt3kutzTekXpmNzi
	 3Utn250Iv661sO1nqv/d0H5EEnry015bo+rqPVnq/A1FvcDvMt+rPTxQbI8CKZ+N8K
	 A64AYTXOve6HQ==
Message-ID: <sashiko-outbox-180592@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: exc3000 - zero-initialize vendor response
 buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Edson Bruno" <cloudflare.ddos21@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261021192803.776-1-cloudflare.ddos21@gmail.com>
References: <20261021192803.776-1-cloudflare.ddos21@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 19:40:20 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Input: exc3000: race on data->buf in exc3000_vendor_data_request()
- [Medium] Input: exc3000 - stale data in fw_version_show() when reusing re=
sponse buffer
- [Medium] Input: exc3000: off-by-4 bounds check in exc3000_vendor_data_req=
uest()
- [Low] Input: exc3000 - Fixes tag references wrong commit for uninitialize=
d buffers
--

commit 390612be535b37b6ded7e34eebf63dafb87943fe
Author: Edson Bruno <cloudflare.ddos21@gmail.com>

Input: exc3000 - zero-initialize vendor response buffers

This commit zero-initializes the stack-allocated vendor response buffers in
fw_version_show(), model_show(), type_show(), and exc3000_probe(). This is
intended to prevent reading uninitialized stack memory when the device retu=
rns
a short or non-null-terminated reply to exc3000_vendor_data_request().

>     Input: exc3000 - zero-initialize vendor response buffers
>    =20
>     exc3000_vendor_data_request() copies up to EXC3000_LEN_FRAME - 1 bytes
>     of device-supplied data into the caller's buffer and returns the leng=
th
>     reported by the device. The callers (the fw_version, model and type
>     sysfs attributes, and probe) pass uninitialized stack buffers and do
>     not check that length.
>    =20
>     If the device returns a short reply, fw_version_show() tests and prin=
ts
>     response[2] and response[3] uninitialized. If the reply is not NUL
>     terminated, the "%s" conversions read past the copied data into
>     uninitialized stack, which is then exposed via the world-readable
>     sysfs attributes.
>    =20
>     Zero-initialize the buffers. At most EXC3000_LEN_FRAME - 1 bytes are
>     ever copied, so the last byte stays zero and the strings are always
>     terminated.
>    =20
>     The problem was found while reviewing the driver with an LLM assistan=
t,
>     which also helped draft this changelog.
>    =20
>     Fixes: d862a3068ea5 ("Input: exc3000 - add support to query model and=
 fw_version")
>     Assisted-by: Claude:claude-sonnet-5-5
>     Signed-off-by: Edson Bruno <cloudflare.ddos21@gmail.com>

[Severity: Low]
Does the Fixes tag reference the right commit for the uninitialized stack
buffers in drivers/input/touchscreen/exc3000.c?

Commit d862a3068ea5 ("Input: exc3000 - add support to query model and
fw_version") stored model and fw_version in devm_kzalloc()-allocated struct
exc3000_data fields and populated them via strlcpy(), which guaranteed null
termination and did not use stack response buffers.

The uninitialized stack buffers and queries touched by this patch were
introduced across later commits:
- Commit 102feb1ddfd00d ("Input: exc3000 - factor out vendor data request")
  removed strlcpy() and introduced exc3000_vendor_data_request() along with
  the uninitialized u8 response[EXC3000_LEN_FRAME] stack buffers in
  fw_version_show(), model_show(), and exc3000_probe().
- Commit c929ac9eb85acf ("Input: exc3000 - fix firmware version query for
  device in bootloader") added the bootloader query reading response[2] and
  response[3] in fw_version_show().
- Commit ad117c558e838f ("Input: exc3000 - add type sysfs attribute") added
  type_show() with its uninitialized u8 response[EXC3000_LEN_FRAME] stack
  buffer.

Should the Fixes tags reference those commits instead so stable backport
tooling does not target kernels down to d862a3068ea5 where the patched code
does not exist?

> diff --git a/drivers/input/touchscreen/exc3000.c b/drivers/input/touchscr=
een/exc3000.c
> index d1f9b44d9d76b..2530b5935fefe 100644
> --- a/drivers/input/touchscreen/exc3000.c
> +++ b/drivers/input/touchscreen/exc3000.c
> @@ -262,7 +262,7 @@ static ssize_t fw_version_show(struct device *dev,
>  {
>  	struct i2c_client *client =3D to_i2c_client(dev);
>  	struct exc3000_data *data =3D i2c_get_clientdata(client);
> -	u8 response[EXC3000_LEN_FRAME];
> +	u8 response[EXC3000_LEN_FRAME] =3D {};
>  	int ret;
> =20
>  	/* query bootloader info */

[Severity: Medium]
In drivers/input/touchscreen/exc3000.c, fw_version_show() zero-initializes
response[EXC3000_LEN_FRAME] once at declaration, but passes response to
exc3000_vendor_data_request() twice when the device is in application mode:

drivers/input/touchscreen/exc3000.c:fw_version_show() {
	u8 response[EXC3000_LEN_FRAME] =3D {};
	int ret;

	/* query bootloader info */
	ret =3D exc3000_vendor_data_request(data,
					  (u8[]){0x39, 0x02}, 2, response, 1);
	if (ret < 0)
		return ret;
...
	if (response[2] || response[3])
		return sprintf(buf, "%d.%d\n", response[2], response[3]);

	ret =3D exc3000_vendor_data_request(data, (u8[]){'D'}, 1, response, 1);
	if (ret < 0)
		return ret;

	return sprintf(buf, "%s\n", &response[1]);
}

In exc3000_vendor_data_request(), memcpy(response, &data->buf[4],
data->buf[3]) only overwrites the first data->buf[3] bytes of response and
does not clear or null-terminate the remainder of the buffer:

drivers/input/touchscreen/exc3000.c:exc3000_vendor_data_request() {
...
	memcpy(response, &data->buf[4], data->buf[3]);
	return data->buf[3];
}

When a user reads the world-readable fw_version sysfs attribute on a device
in application mode, the first exc3000_vendor_data_request() call populates
response[0..ret1-1] (such as response[0] =3D 0x39 and response[1] =3D 0x02,=
 with
response[2] =3D=3D 0 and response[3] =3D=3D 0), and the second call for (u8=
[]){'D'}
reuses that dirty response buffer without clearing it.

If the second reply is short (1 byte or less) or shorter than the first rep=
ly
and not null-terminated, won't sprintf(buf, "%s\n", &response[1]) read stale
non-zero bytes left behind by the bootloader query?

> @@ -292,7 +292,7 @@ static ssize_t model_show(struct device *dev,
>  {
>  	struct i2c_client *client =3D to_i2c_client(dev);
>  	struct exc3000_data *data =3D i2c_get_clientdata(client);
> -	u8 response[EXC3000_LEN_FRAME];
> +	u8 response[EXC3000_LEN_FRAME] =3D {};
>  	int ret;
> =20
>  	ret =3D exc3000_vendor_data_request(data, (u8[]){'E'}, 1, response, 1);

[Severity: Medium]
The commit message notes that exc3000_vendor_data_request() copies up to
EXC3000_LEN_FRAME - 1 bytes of device-supplied data into the caller's
response[] buffer in fw_version_show(), model_show(), type_show(), and
exc3000_probe().

However, in drivers/input/touchscreen/exc3000.c, exc3000_interrupt() ->
exc3000_read_frame() reads only a single EXC3000_LEN_FRAME (66) byte frame
into data->buf[0..65]:

drivers/input/touchscreen/exc3000.c:exc3000_read_frame() {
...
	ret =3D i2c_master_recv(client, buf, EXC3000_LEN_FRAME);
...
}

Because the 4-byte vendor frame header occupies data->buf[0..3] and the
vendor payload starts at &data->buf[4], at most EXC3000_LEN_FRAME - 4 (62)
bytes of vendor payload exist in that received frame:

drivers/input/touchscreen/exc3000.c:exc3000_vendor_data_request() {
...
	if (data->buf[3] >=3D EXC3000_LEN_FRAME)
		return -ENOSPC;

	memcpy(response, &data->buf[4], data->buf[3]);
	return data->buf[3];
}

Since exc3000_vendor_data_request() checks data->buf[3] >=3D EXC3000_LEN_FR=
AME
instead of data->buf[3] > EXC3000_LEN_FRAME - 4, if the device reports
data->buf[3] in 63..65, can memcpy(response, &data->buf[4], data->buf[3])
read up to 3 bytes past the 66-byte vendor frame into data->buf[66..68] (the
second frame slot populated by exc3000_handle_mt_event() when more than 5
touch slots are active) and expose those bytes via the world-readable
fw_version, model, and type sysfs attributes?

> @@ -308,7 +308,7 @@ static ssize_t type_show(struct device *dev,
>  {
>  	struct i2c_client *client =3D to_i2c_client(dev);
>  	struct exc3000_data *data =3D i2c_get_clientdata(client);
> -	u8 response[EXC3000_LEN_FRAME];
> +	u8 response[EXC3000_LEN_FRAME] =3D {};
>  	int ret;
> =20
>  	ret =3D exc3000_vendor_data_request(data, (u8[]){'F'}, 1, response, 1);

[Severity: High]
In drivers/input/touchscreen/exc3000.c, zero-initializing
response[EXC3000_LEN_FRAME] in fw_version_show(), model_show(), type_show(),
and exc3000_probe() relies on exc3000_vendor_data_request() never copying
more than EXC3000_LEN_FRAME - 1 bytes into response[].

However, exc3000_interrupt() reads frames into the shared data->buf without
acquiring data->query_lock, and returns IRQ_HANDLED immediately after calli=
ng
complete(&data->wait_event):

drivers/input/touchscreen/exc3000.c:exc3000_interrupt() {
	ret =3D exc3000_read_frame(data, buf);
	if (ret) {
		/* Schedule a timer to release "stuck" contacts */
		exc3000_schedule_timer(data);
		goto out;
	}

	switch (buf[2]) {
	case EXC3000_VENDOR_EVENT:
		complete(&data->wait_event);
		break;
...
}

Meanwhile, exc3000_vendor_data_request() checks data->buf[3] and copies from
&data->buf[4] without synchronization against exc3000_interrupt():

drivers/input/touchscreen/exc3000.c:exc3000_vendor_data_request() {
...
	if (data->buf[3] >=3D EXC3000_LEN_FRAME)
		return -ENOSPC;

	memcpy(response, &data->buf[4], data->buf[3]);
	return data->buf[3];
}

Once exc3000_interrupt() returns IRQ_HANDLED and unmasks the interrupt line,
a subsequent interrupt (such as a touch event EXC3000_MT1_EVENT or
EXC3000_MT2_EVENT, or another device frame) can invoke
exc3000_read_frame(data, data->buf) and overwrite data->buf[0..65] via
i2c_master_recv() while exc3000_vendor_data_request() is concurrently
evaluating data->buf[3] and copying from &data->buf[4].

If data->buf[3] is overwritten between the bounds check and the memcpy()
with a value >=3D EXC3000_LEN_FRAME, could memcpy(response, &data->buf[4],
data->buf[3]) overflow the caller's 66-byte stack buffer response[] and
overwrite the trailing null terminator?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021192803.776-=
1-cloudflare.ddos21@gmail.com?part=3D1
