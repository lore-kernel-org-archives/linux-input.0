Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA97C370AFC;
	Fri,  9 Oct 2026 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791584969; cv=none; b=ZaRcwZsj2dKYwJWeFla75ESyBMz945ugcGt//6L1TfDjax6Hn5NmfACeSXQKWCfPoEygXOUyZpS1+ERuqChW+OY6s8vW1L/jNoAMLV6xDzdsD0P99TR7UYoxNGC23sc5SdRQB9+Y3Ozd26oIK1Wbd0waWY7Pdl3+cxzDMwQWY5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791584969; c=relaxed/simple;
	bh=909OBO5JYCiY22ecZ5im9VlGdEbfJZuXGsFWc9LtfEQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CJiQUFXgVIzJcdNT0P9Qaqypm2ycmHwddEWal+PHitXPVm4EKzVgGMwZqyJPJKsTgv2kc85Ty2Rt7qsuSTW16dVB894ITHyGRpqBeSGjpp9wLwnobCMVt1zcljV7Mv3+SY7H3MqfH5+bdAP1cQFZD11ODA602ggBo1szUt+01tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L10q3OqE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L10q3OqE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB78A1F000FF;
	Fri,  9 Oct 2026 22:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791584968;
	bh=72efFbPH45tY4RYMllSyI2XpJHChk5GF3zdOjY5IPqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L10q3OqEUlZ13ps9JMWe0cUsvdHXK8Bjoi7nm44ikY++tTcldVqMcMwJrSqH/u8eL
	 WQ3ZrE8nI/m4fzS//JNsjkekM0nTdnz0fpIp3hlN9QoBiu9SilaBx/9Lq8M7Qg8TxF
	 OPS9JHPx+6Gl/prakeMfDCcX7SMJQTUeaLl9ZXxOcuWdK/seMeZY57bifd1BFH6u8l
	 Qndy91oi5JiFCsLaVgmMJTy+/dYy9Ln+qZWWLpmugRXXC61NBUWL23SPUM6qqrHwpE
	 9wMe4NjjXo2GzMndHgfdq8WyxXvhT8PNXg1KJ41Eac0k+vs/2cVozlrZoftx+W1Uuv
	 w5Ha2niY7CKJA==
Message-ID: <sashiko-outbox-166133@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/11] Documentation: Correction in HID output_report
 callback description.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingyuan Liang" <jingyliang@chromium.org>
Cc: conor+dt@kernel.org, linux-input@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-trace-kernel@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261009-send-upstream-v5-1-384af01da3ee@chromium.org>
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-1-384af01da3ee@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 22:29:27 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] hid: documentation incorrectly relaxes asynchronous requirement =
for output_report
--

commit 6d8fa62fc058c7f5630a13cc92c85b7867bc9869
Author: Jarrett Schultz <jaschultz@microsoft.com>

Documentation: Correction in HID output_report callback description.

This commit updates the documentation for the HID output_report callback.
It changes the description to state that the callback might be asynchronous
rather than strictly requiring it, citing i2c-hid as an example.

> diff --git a/Documentation/hid/hid-transport.rst b/Documentation/hid/hid-=
transport.rst
> index 6f1692da296cf..2008cf432af12 100644
> --- a/Documentation/hid/hid-transport.rst
> +++ b/Documentation/hid/hid-transport.rst
> @@ -327,8 +327,8 @@ The available HID callbacks are:
> =20
>     Send raw output report via intr channel. Used by some HID device driv=
ers
>     which require high throughput for outgoing requests on the intr chann=
el. This
> -   must not cause SET_REPORT calls! This must be implemented as asynchro=
nous
> -   output report on the intr channel!
> +   must not cause SET_REPORT calls! This call might be asynchronous, so =
the
> +   caller should not expect an immediate response!

[Severity: Medium]
Does this documentation change contradict the strict architectural guarante=
es
of the HID subsystem?

The HID subsystem design rules mandate that the output_report callback must
be asynchronous to prevent latency spikes, performance degradation, or
deadlocks on the high-throughput interrupt channel.

By stating that the call "might be asynchronous", could this inadvertently
mislead future transport driver authors into implementing blocking,
synchronous callbacks where they are not permitted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-send-upstr=
eam-v5-0-384af01da3ee@chromium.org?part=3D1
