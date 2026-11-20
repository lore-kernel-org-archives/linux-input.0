Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164563;
	b=IkBZMe/6hr++SowX/LLaB9K2dn1bUQGNNNYWo5rvVx4hUsrCUv1vPAP5iVASS5uZk+XR
	 ZdflvpcpBRsSd848Sbk8Lp8Wq6/Z7wv4YSjJAUDp1EMwpHnC8se5w6Nt9aHg/wUWiV7FU
	 GzseIHEkhYTgseovSr45TxtG0NdlbpQSj4xfUNgF6UeTDygX5QCfU2hjlbU9xHSXhIZ6w
	 G/dhA/fGkMnVqiGHN24ooC8RyZzbBT0Eq+Cqb1VdelQ2DxEgAN6aC3c63K4d1i6mfhzF8
	 w+SybNaIplSfCsmwImdpdnrbekTcl6irXhTEgbgfy03OZi9SbEDli4mUAFmKR8esk6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164563;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oV/Z/RRfCD0KsWkT/2X84v5O5zL4Cd/5aKjhD3f7HRQ=;
	b=kAySYISVKt0a5yws0q5aKMwYmE9443Co2002vaalRK2f+rLc716g45XG/XEqO9AD4JQu
	 RbiPOhATuzHE8vb7KtN/b/xi8U5NAKCOZN1rGrXW693dkk8LM/dyAgKbzzn3/z9q+P8be
	 7zKPw/xQ4XvsZL+PN5hVtos/ve7tbtkVEpv7fOIbVG78tp5c1MMyktSy9vinQ7riy5v74
	 /Qlc579Mh2ouPM0EGbtIQPAbbPobMvvH90eLl0jxlCON0oKk1kSiCBPQ5EzC91obg9ZmF
	 jg5/UpurtRpFfjzfFGWjQ+zH+y6Gu4kunlQFpY1EiTVxSOrxXqpJx8emiyeS/UfMthQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ExFuil9u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9E4606A320
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ExFuil9u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB77D1F000CA;
	Fri, 20 Nov 2026 08:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795164563;
	bh=oV/Z/RRfCD0KsWkT/2X84v5O5zL4Cd/5aKjhD3f7HRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ExFuil9ubsGlYLn5w/akM2raWn87ePiVZt5ysfs5t5tpG6GIW0Uc2lU0T371FA7eT
	 ZIlHjgEir53C0bqhZg7pg2AWxH59RBjBFOP7ursI2wUOFULkkvUuP1zxSXZH85Cjyy
	 f7Y2x2EEy2Yx2U8BLRYmIM6BTZW3vX/2wA9tsXLgoEwOy19EuTw9bw8+6tCIasTEkX
	 S2qidOGALiK/Pxqg68DzYHmn7YosVn+k3MaswjgNcX/WYCUrH8nE7MijbteHqLidFb
	 guGBOfSPEXzrevDOrXqHugrdpxSU+0W3yT9ZQiP9eE5oCOfF8omvFkssVye5H5D846
	 UoZyNmS0iguZg==
Message-ID: <sashiko-outbox-224775@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/18] HID: logitech-hidpp: preserve transport error
 codes in __hidpp_send_report()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
In-Reply-To: <20261120-hid-logitech-hidpp-next-v3-2-ba39242d4336@gmail.com>
References: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
 <20261120-hid-logitech-hidpp-next-v3-2-ba39242d4336@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 08:49:22 +0000
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
  __hidpp_send_report()
--

commit 7944005fb20b5526c4f3747a01d20ce6a7124554
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
> Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[Severity: Low]
Since this fixes the hardcoded -1 return in __hidpp_send_report(), should
the commit message include:

  Fixes: 2f31c5252910 ("HID: Introduce hidpp, a module to handle Logitech h=
id++ devices")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-hid-logite=
ch-hidpp-next-v3-0-ba39242d4336@gmail.com?part=3D2
