Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6A541A571
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065658; cv=none; b=QOGqVF1Ja3hoQkMUglhXh0ohOh8pSPv9qZCFhHR4HXUnOjCkbIM6HwU0tYBshNTqImwIIWrE1NBCTeJRwfVncPgCZqMNSg+tIuD/euAMlSWUrp9D0bmNcHWezx4u0df78x+66VvaMAGhTnBaBaw8mZfRFMQB27oYg3t7idUjUlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065658; c=relaxed/simple;
	bh=UobC/aIZPjsxdwIuVy256radJmyOQxArj+4NbZYVR2Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cv8E4++OisSh+p1U1x5oECRf7r/Qy/98bYsecGtdZ+iV+CwLUzlDZuVYEYlwF5vPzJTL/N5cC76nPuBUDdTVAth9Sf4VluqUknTcSOr1peeSZAqg7tobwx5VnIpGLZZ1War/MWXEX58NnZz6WLceMo1Rz+OrCOBhKUyOK78VB0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggkGNVsA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggkGNVsA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CB91F00898;
	Tue, 22 Sep 2026 08:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790065657;
	bh=pzJhu5nWoGUwt5excZ4u/UhHcf/h5/Pnek2heygZBpU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ggkGNVsAZ6THyzh+8jXcXfVJY3pBknUhriZUme6TdCus5VokPGdQ8f4PPS/awTlg/
	 TZ0c364xDZQ5BO5jUdgosfgGfSpqzeOzqq5ibxd2A+5IDQIXmW0486OzYqjo2o+OB5
	 KsKZv4655Yy8aY1RS/xYhVzUijpJ6FfOAM3HEI73mDKJBh/nKUT5biSs+OZSfugMMU
	 iP7DNT087D25XoUEQR1s/9yxtOdMcE3Y3QbORkiAA4PIOoSwPVmqSC20/O/GHm8Gi5
	 4vGj/R6UaJOrbhRm5dGp1q2JVlgHWB0F1pcemRMhCht2mv7xu5E6EywpQiHed5Y/dd
	 bc+E/W7bq2z1A==
From: sashiko-bot@kernel.org
Subject: Re: [STABLE v6.1-v5.10 1/1] HID: logitech-hidpp: fix race condition
 when accessing stale stack pointer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260922081615.821827-1-lee@kernel.org>
References: <20260922081615.821827-1-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:27:36 +0000
Message-Id: <20260922082737.33CB91F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid-logitech-hidpp: data race in hidpp_raw_hidpp_event() allows NU=
LL pointer deref
--

commit d3703221a099da6d388bec38af269fe1cd97ac2c
Author: Beno=C3=AEt Sevens <bsevens@google.com>

    HID: logitech-hidpp: fix race condition when accessing stale stack poin=
ter

    The driver uses a stack-allocated buffer in the synchronous command pat=
h but
    does not clear the pointer when returning. This patch clears the pointe=
r and
    checks for NULL in the event handler to prevent out-of-bounds access.

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 8a2aac18dcc51..f584c1007169c 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -322,6 +322,7 @@ static int hidpp_send_message_sync(struct hidpp_devic=
e *hidpp,
>  	}
> =20
>  exit:
> +	hidpp->send_receive_buf =3D NULL;
>  	mutex_unlock(&hidpp->send_mutex);
>  	return ret;
> =20

[ ... ]

> @@ -3590,6 +3590,12 @@ static int hidpp_raw_hidpp_event(struct hidpp_devi=
ce *hidpp, u8 *data,
>  	 * previously sent command.
>  	 */
>  	if (unlikely(mutex_is_locked(&hidpp->send_mutex))) {
> +		question =3D hidpp->send_receive_buf;
> +		answer =3D hidpp->send_receive_buf;

[Severity: High]
Can these sequential lockless reads of hidpp->send_receive_buf allow a data
race?

Because hidpp_raw_hidpp_event() does not hold send_mutex when checking
mutex_is_locked(), another thread running hidpp_send_message_sync() could
modify hidpp->send_receive_buf concurrently.

If hidpp_send_message_sync() executes:

    hidpp->send_receive_buf =3D NULL;

exactly between the assignments to question and answer, could question
receive a non-NULL pointer while answer receives NULL?

> +
> +		if (!question)
> +			return 0;
> +

If the second read yields NULL for answer, the question check will pass.
Then, if the report matches, the handler will execute:

    *answer =3D *report;

Could this result in a NULL pointer dereference and panic the kernel?
Would it be safer to read hidpp->send_receive_buf exactly once,
perhaps with READ_ONCE(), and assign the result to both question and
answer?

>  		/*
>  		 * Check for a correct hidpp20 answer or the corresponding
>  		 * error

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922081615.8218=
27-1-lee@kernel.org?part=3D1
