Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386835;
	b=atXOZJ4z/9upmyz4OX4eVutSGRKInHOAFT0BiYmSSM6NqQUC3MFQICK7Cd0N3+s0DYts
	 o6KqcM0vGOrsUDt3KyLB4/VWh7Cj4oKrPUPOGh67s9XB2mD9oiY/RDRz8LaNaZOrmkFKh
	 U9DeJh38oNL2hYghjUnbboK7cJRue4ziesk5OTynHzd7+Y8GWyuPBBdWdi42WwT8mbmkR
	 ZmnhRFGO8cHkN3Fh7JsGXmmAOCrlsGA7fWwufX10Di7IxmZJKOB0BQrHflCFlA/mS6RZw
	 LnB45FCDvvb+SXWxUD8yG523PlorYpqrwm1FjTnrEJxoUW2Na0Gipt7ZVdFX0rfQMJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386835;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XgjFi5NyYDKdzzYleB/j7pH/vWJqQEYwqmYBTHyzssI=;
	b=Tz8UO0huyhMZ2Klchn7PdkqX7f0zTdBE6LMMxlxLzhm4mKDzHK9zLVsYkGMpa9y7v7pa
	 pOmakt9GUimyBJpCfJxiWoEEGhKmWSfE/ffl55YGcd1cU6e9JtnsYKckXQp+S+NBmU0Xr
	 CjNeosr6FdeblatmFhF+xv+yaeNkFNJ4ptzqj1QMZW7j+fY/CFr5onpIRPy0b95flCBq3
	 0BwGKQmWnq9quY56ezXDuhsiU+83KkU5jxj5dzaNoQ4KoKY+fVPEZbdHwoG6ohUO0ISDS
	 mXFY1m+J+srY3H4Y9zf96NNLzWdYH0RND1RSefWwyAntu1E+MbSySFbEduHk8zIUzbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PgsmMO4I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BBF606A31C
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 08:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PgsmMO4I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FE51F00A05;
	Wed, 11 Nov 2026 08:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794386835;
	bh=XgjFi5NyYDKdzzYleB/j7pH/vWJqQEYwqmYBTHyzssI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PgsmMO4IQRPJlxdCG2uziAHVSaNkgafk04z7TS2K3DtF8gFVf9ZMRerVr/BeQIhBf
	 hq9KNUwAE6vqO67UhYi5m4Qu/m5/YegT19Jx2vxnWzyHszd8Focc+mZp/GAyQf0/ud
	 1/Hs1rw2CpE/5WZ9a2ot3cdYcq7ypjv//WPusD9bHDqvGyeS9z887nITe4DW3COPEA
	 bqbIqTlDnoGXt6EmyQi/P6+mhvEUSMHv+LcKeEu2GyDA5OnOxN/iTbQegN72szJNkW
	 w1h6meyivfyL3bUvxfyRCxTIFDM57O2tdNvo5uRi+n7Hu/jm2f2wqVapsmCAq2FBei
	 nMhsr9vVjb19g==
Message-ID: <sashiko-outbox-208632@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/33] HID: logitech-hidpp: preserve transport error
 codes in __hidpp_send_report()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
In-Reply-To: <20261110-hid-logitech-hidpp-v2-16-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
 <20261110-hid-logitech-hidpp-v2-16-30743e91d83b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 08:47:14 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] HID: logitech-hidpp: missing Fixes trailer for
  __hidpp_send_report() fix
--

commit 09dff290053556bbf3aafa52b368f79dec907401
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> HID: logitech-hidpp: preserve transport error codes in __hidpp_send_repor=
t()
>
> __hidpp_send_report() returns -1 (-EPERM) whenever the underlying HID
> transport write does not match the expected report length. This discards
> genuine negative error codes returned by hid_hw_output_report() and
> hid_hw_raw_request() (such as -ENODEV, -ESHUTDOWN, or -EPIPE), masking
> device disconnection and transport failure from callers.
>
> Preserve negative error codes from the transport call, and return -EIO
> instead of -1 when a short write occurs.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[Severity: Low]
Since this fixes the return value logic in __hidpp_send_report(), should
the commit message include a Fixes tag:

  Fixes: 2f31c5252910 ("HID: Introduce hidpp, a module to handle Logitech h=
id++ devices")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-hid-logite=
ch-hidpp-v2-0-30743e91d83b@gmail.com?part=3D16
