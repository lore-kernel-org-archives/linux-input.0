Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BB6396591
	for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661779; cv=none; b=kUe/aoM1W3mlJzqSUALkuwChJueLy0VASaUaUOuHBa9mqOcelQddaVfFuHRsTEhFREGzxQGy/JONfqqwG3r4YqwqTfCQ2xLw0kL8TrVJ8ryMS6b4+AmEbumiR2f9PVq5JYIvtlyb4htpX9UfG2rkZ1YfXJQ6yMejX/VK1rLITBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661779; c=relaxed/simple;
	bh=I9Byoa/RcErBE9KLtYg+a/BM72PXGSc8237uO+eUrts=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W564w20yj2QjfpuT8To/nM6rPrzkvnpiBhnVJgUa9kZsjF3A3I46CnmwysHnoYQ2DCOtVFTPKkRreT9xiVdCCRnvU8/fksDhIj9I7XPrmAYfjIErpIKR6RNl4P+4pVhZnmRS7UnoahLKA0IXMvTQbJ19ctNHlm09a9sjOxJGGr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkqibkOI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkqibkOI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3A31F00893;
	Thu, 17 Sep 2026 16:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661777;
	bh=Mubvi4Vs0LEWZySuHNrqaOWtm5PQy4oFlpUq0LKSRpo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KkqibkOIzdRbf4xJ18gEUfpu/a8aYXSSLkbVkliDY0NM7fb5BSPLdSSuVniaGO0B7
	 2dj7LD0SVXMQ8S8nguRxrW3crSCeOWxDWIayOyZrw2lRkDytL4i4GNnQffkoPIqC/k
	 bGEQdzJQKeqidC4JRdMwiaKh3cKpHJWRYQSsWEawImZlADwM/T/+iAv+J5yYlZDa7s
	 JGfupPySJdGlvQ2/rs/2Wb9LE26ZbuKBZYbv6LDCtHqVe/QgnEmDqJxWx/8KbZ5vJf
	 T1hGvyNx4/86Jxgv9wpxEy7N69xXyTyM9a4GH7gBlxSrO4W/4DB66ZgT68cdMJfmnP
	 EqwvLl/b2qsAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] HID: ayaneo: Add AYANEO 3 detachable controller
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0w61hcyBNYXJ0w61uZXo=?= <hello@matias.me>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260917160722.89391-1-hello@matias.me>
References: <20260824223103.93947-1-hello@matias.me>
 <20260917160722.89391-1-hello@matias.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:16:16 +0000
Message-Id: <20260917161617.7B3A31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] hid: ayaneo: data race on completion state in ayaneo_cmd()
--

commit c219d53cacc831077bc77b38a3e4bceead638885
Author: Mati=CC=81as Marti=CC=81nez <hello@matias.me>
HID: ayaneo: Add AYANEO 3 detachable controller driver

This commit adds a HID driver for the AYANEO 3 detachable controller's
vendor interface. It provides support for module identification, software
eject, and RGB control of the joystick rings via the multicolor LED class.
The driver communicates with the device using a custom 65-byte command
protocol.

> diff --git a/drivers/hid/hid-ayaneo.c b/drivers/hid/hid-ayaneo.c
> new file mode 100644
> index 0000000000000..3a7af5918ee1e
> --- /dev/null
> +++ b/drivers/hid/hid-ayaneo.c

[ ... ]

> +static int ayaneo_cmd(struct ayaneo *aya, struct aya3_resp *resp)
> +{
> +	int attempt, ret;
> +
> +	lockdep_assert_held(&aya->lock);
> +
> +	for (attempt =3D 0; attempt < AYA3_CMD_ATTEMPTS; attempt++) {
> +		reinit_completion(&aya->resp_done);

[Severity: Medium]
Could this trigger a data race if a late hardware response arrives right as
the loop restarts?

If wait_for_completion_timeout() times out, the code loops back and calls
reinit_completion() while aya->resp_pending is still true. If the hardware
sends a late reply at this exact moment, ayaneo_raw_event() can read
aya->resp_pending as true and call complete() concurrently.

Since reinit_completion() modifies the completion locklessly while complete=
()
modifies it under a lock, this could corrupt the completion state and lead
to lost or phantom wakeups. Should aya->resp_pending be cleared before
reinitializing the completion, or perhaps cleared at the end of the timeout
path?

> +		aya->resp_expect =3D aya->xfer[4];
> +		WRITE_ONCE(aya->resp_pending, true);
> +
> +		ret =3D ayaneo_send(aya);
> +		if (ret) {
> +			WRITE_ONCE(aya->resp_pending, false);
> +			return ret;
> +		}
> +
> +		if (wait_for_completion_timeout(&aya->resp_done,
> +						msecs_to_jiffies(AYA3_CMD_TIMEOUT_MS))) {
> +			if (resp)
> +				memcpy(resp, &aya->resp, sizeof(*resp));
> +			return 0;
> +		}
> +	}
> +	WRITE_ONCE(aya->resp_pending, false);
> +	return -ETIMEDOUT;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917160722.8939=
1-1-hello@matias.me?part=3D1
