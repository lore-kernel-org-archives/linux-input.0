Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F234E3A7598
	for <linux-input@vger.kernel.org>; Wed, 15 Apr 2026 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259866; cv=none; b=I8q715cIkaBnxt8/LIvC5YhJBqrvvO5xeZS8jKvoJE6UkWn2bGb9bJmZtj9NB/m7pHl5LICnui8++atANnwFv3xL2Tdt0UfF7VilRwp7KOHzf8OPGG16dSBnFbPo7Ngy+XkckJIJQtythlOD3OyDCWkmYuxF+0sowK3r9/WpByI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259866; c=relaxed/simple;
	bh=fTjkDp0Z1Hjcc0C44b4TxKYtNPLhb/vV+PSFEyJ4VYQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sEVRx2E86MQUTnG9rBUxp+4nggU5sXADGOL0cXitNyMHvN89eR6WSyGj9p3d+rV9VWnIBy+9+T4Mo9EZ696Cw6BDla2fg/sqDdCPuvAw8S4O6FxFylo4A53wcN8crG10JC9BO8T9ycmW38q0n4WUmTDGW8PdRbzzxL3nHEDfEtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=axnfvue+; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="axnfvue+"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-488c213b485so48215125e9.2
        for <linux-input@vger.kernel.org>; Wed, 15 Apr 2026 06:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776259862; x=1776864662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HNDFVvgUDGXTzqXu6LqB4466F8xaXbUgZDZ5jwpbPs=;
        b=axnfvue+xvcdoVEnlseRHsvwIQ1BO4F0b+E1xL7/z/vO5VoaQvRy5palj2RYJzk/mC
         yIIPaxCr0iwzvhjybqVqdhNYvoWXJEnXBjjutMOd96onUUYctsIkWM8Tfa8TxX8wumfm
         Oi9JHosUziZko0+uJ73fBCIM/yesBAGgUZTAnf5eOHCEIbQ5kbjNptxl0paJxq2ut+oW
         4Ng2KWu1RDhtE/eEaqJQSbK/uZq+dXRl4Y18ypTMJgZgQrF9+uE7ZR/nA7UtSoyBww/B
         e+GBQOOlw/h9b4Wny+DqDfTHA8Oy+hWa3/Jrs1G3V79J91pSOJg1c0IHocLq2qfXzxbD
         luVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776259862; x=1776864662;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7HNDFVvgUDGXTzqXu6LqB4466F8xaXbUgZDZ5jwpbPs=;
        b=ZvDitz5VaMdmx3BYXRy15WIEYUEJo+hiEMUG4McrwzhRc8gwNP40CvaTaQrJbYjL9P
         SL3W5dlePOkIQirpl3ZH5m1Esi0zqE0Cto7d2WMy81adTah2k1/Kn10cBnPr9pU91upy
         HAqoynlvyPcHYbCsYWkAICouuNOR3JFlJgmznA/Wb6AqJ0gs8CK0Lto3ylUScprZ+K2g
         Cx1kkwAbPZZvGaoSxjBV4OJp3Ge3/WqvXL1s2heyaCrEZHyFPGHTrh/JcNw5o4tW3A1z
         tBYN/TuZE71kJMdwo3d9Z4/Ecsu2TYEFox1PCXbuMgDvwFrqJgw46WwkNeOVP06IyxqR
         fZzg==
X-Forwarded-Encrypted: i=1; AFNElJ8Ar75TyRpL0ldx8r2X4FJAPVtLrrJ7UPQWiB6hO6P3Lic/eyoJBT2V1LamXp0XGZ47UKSNJdhHYGLrSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6XSqhfiOa4Bio74DFW4wcL7v5tws26dF8IHryzb4DPcV1RqVj
	eN3cStLQ3RftoESJUMcreF/6fTvFyUFB5o1Pc9daB6Ui8VCudL+CjFGvqiG6xreP5CtiNGazUlX
	APLszQA==
X-Received: from wmow5.prod.google.com ([2002:a05:600c:4745:b0:488:c1c7:501e])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600d:4:b0:480:69b6:dfed
 with SMTP id 5b1f17b1804b1-488d68ab2bfmr247041005e9.24.1776259861869; Wed, 15
 Apr 2026 06:31:01 -0700 (PDT)
Date: Wed, 15 Apr 2026 15:30:52 +0200
In-Reply-To: <20260414143238.1177080-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260414143238.1177080-1-lee@kernel.org>
Message-ID: <ad-S8Riah-f6mEWm@google.com>
Subject: Re: [PATCH 1/1] HID: magicmouse: Prevent out-of-bounds (OOB) read
 during DOUBLE_REPORT_ID
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Lee Jones <lee@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Lee!

On Tue, Apr 14, 2026 at 03:32:38PM +0100, Lee Jones wrote:
> It is currently possible for a malicious or misconfigured USB device to
> cause an out-of-bounds (OOB) read when submitting reports using
> DOUBLE_REPORT_ID by specifying a large report length and providing a
> smaller one.
>=20
> Let's prevent that by comparing the specified report length with the
> actual size of the data read in from userspace.  If the actual data
> length ends up being smaller than specified, we'll politely warn the
> user and prevent any further processing.
>=20
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/hid/hid-magicmouse.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index 91f621ceb924..5f44129e6dcc 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -490,6 +490,14 @@ static int magicmouse_raw_event(struct hid_device *h=
dev,
>  		/* Sometimes the trackpad sends two touch reports in one
>  		 * packet.
>  		 */
> +
> +		if (size < data[1] + 2) {
> +			hid_warn(hdev,
> +				 "received report length (%d) was smaller than specified (%d)",
> +				 size, data[1] + 2);
> +			return 0;
> +		}
> +
>  		magicmouse_raw_event(hdev, report, data + 2, data[1]);
>  		magicmouse_raw_event(hdev, report, data + 2 + data[1],
>  			size - 2 - data[1]);
> --=20
> 2.54.0.rc0.605.g598a273b03-goog

I am afraid this still looks buggy to me.

With your check, size can still be *equal* to data[1] + 2.  In that case, t=
he
second recursive call becomes

  magicmouse_raw_event(hdev, report, data + size, 0);

so this points just after the original "data" buffer with zero size.

But the magicmouse_raw_event() function accesses data[0] directly at the
beginning.  It assumes that size is >=3D 1, but it does not check that befo=
re that
first access.

=E2=80=94G=C3=BCnther
