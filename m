Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A89335BBB;
	Thu, 13 Aug 2026 23:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786663092; cv=none; b=LM049/ccwtz2VbKEw2pEykf1qM9o7JOwXGSdpACsBhCrTpGoTRFICzN/5AFCgMlFLTLD0R90lVdOywKEFW7apj/+ex4XBKHU0BAPuXBYCLXCrF7joQm0jDreyyhH7qAERXk8DBdDcRS19wI1GwxCrcPgALR+ILzhFk9ely/+Jtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786663092; c=relaxed/simple;
	bh=EFScvARJdwU1yx6l3ptKgJ+leHuScd7Fj5/Ow1D1CwY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b0dzHcNW303HybGOvdQ9B4zHSOW2I62h9315VPqB1VD8Su2Kwu6WylG8opnBrDRKe530GfdBgVRFE7/qKhqaberqSvSTRRXFXV1E+iCbSGSnbJ94zA6z0ZULTc0hYyQ/PddB1O0DrEnmpEK2EqiY3jrrnhQ2BQGJpUNpt5XEhFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBkcxtCm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBkcxtCm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3EA1F000E9;
	Thu, 13 Aug 2026 23:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786663091;
	bh=CTlZ/9g+cFs6Eb3PbHOf2mgNfW6YF1rbqGS3c+ijZ4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RBkcxtCmks1WIIv9HjcvRXBZWv15UcvNOeEUWbNibux07E8/atiEB9Gx3nZEDJXzw
	 YODcvOupQueQDcRMwDANXx7t7kWClbDXxQoWuAP5DuKbFQoMy7hFxPYm8v6IHhma7j
	 25V0LiuhSj+ZqmrFWxNywiq+dGihezWSCuQt3ZsiM48jaOiMkIOPGkRCIyQlSGKYfy
	 YiBLRdAe3Z3cFgVdyKyt+6maoIid3ymaSSrr5lX4zwEsAyFqyzllm28sTIn5VL5kcy
	 41kYJudE9UakQKrbFliDQrPbOu9uEY+7QKgMXS+Q+S3Il3SnwR11YVZsRCRS9oQDKN
	 +pG74LnqJpKDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/11] Documentation: Correction in HID output_report
 callback description.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingyuan Liang" <jingyliang@chromium.org>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260402-send-upstream-v3-1-6091c458d357@chromium.org>
References: <20260402-send-upstream-v3-1-6091c458d357@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 23:18:10 +0000
Message-Id: <20260813231810.AA3EA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit modifies `Documentation/hid/hid-transport.rst` to sta=
te that the `output_report` callback 'might be asynchronous', which directl=
y contradicts the strict HID subsystem architectural rule requiring it to b=
e unconditionally asynchronous.
--

--- Patch [1]: [PATCH v3 01/11] Documentation: Correction in HID output_rep=
ort callback description. ---
commit 5b8559748c059ec63c5c810fdf494efbd38be948
Author: Jarrett Schultz <jaschultz@microsoft.com>

Documentation: Correction in HID output_report callback description.

This commit modifies the HID transport documentation to indicate that the
output_report callback might be asynchronous rather than strictly requiring
it to be asynchronous. It notes that some implementations, like i2c-hid,
do not implement it asynchronously.

> diff --git a/Documentation/hid/hid-transport.rst b/Documentation/hid/hid-=
transport.rst
> index 6f1692da296cf..2008cf432af12 100644
> --- a/Documentation/hid/hid-transport.rst
> +++ b/Documentation/hid/hid-transport.rst

[ ... ]

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
This isn't a bug, but does this documentation change conflict with the
subsystem's architectural guidelines?

The official HID subsystem guidelines explicitly state that the
output_report callback (used for high-throughput data on the interrupt
channel) must be asynchronous and must not trigger synchronous SET_REPORT
calls.

Relaxing this language to "might be asynchronous" contradicts the strict
architectural rule and might encourage future driver implementations that
block or perform synchronous operations. Should the documentation continue
to mandate the asynchronous requirement to prevent synchronous blocking on
the interrupt channel?

> =20
>     ::
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260402-send-upstr=
eam-v3-0-6091c458d357@chromium.org?part=3D1
