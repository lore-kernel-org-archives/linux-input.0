Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623272;
	b=JwLDbsQ5X9/3E3n6tbturz+MWGYYoVAZDjX6iKgwRLFV2p0Bs/6/aDmGua4Iwb49Zb2k
	 13oalbrbnOynZDrZ+vbJt6vGuquQh4QRItWPpdIdA6tFfHZYIEoialXMcrC6QMHi9q5uz
	 J5s5o2bJbykcNvI4qRYCJzN68xRFhKNjo9mwgjJs+4cVgGJoas1PHHGUfaFhnrLbDeCxz
	 EhKfe3GSaAyG3Gvpg2Un/PjxDBT4MinlxesJOrB/5cbo5GscNAYRNXSRw9PJ041p6EMtv
	 pDSRCWdgumyrmwyOB9RHvY78nwxTxEZTYiVqBjdeeUZSFLJo9wYzP61EYrzZY02oSaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=3y/yQ7bOSsnHyylDSSSE8FXmnqPmwJGFAWCe0iH8E60=;
	b=UqAIwgkKk29rp8RxTFCU4h6N82SmCmB3cKC0XiyU4aK1hdJrsWKbB5IjXz8UAuRCW5nO
	 iXnSCOV9GXYPFHaWBk0wSQ0FWxmZ909q2Y0AJBXRPuhbMntmxsuAJqXGKcOsUCJF1/QJt
	 RbLgbtgsh519ftbRXbtq+VaYmUlkJ/k9tppgqAjX6dbsPj6G2z1mpr5a/pKaamNFTdf8t
	 ytRLylZMVBj8CG0Svh9dOf4fOPPWsuCV3d1vU9ppJzZ4J3XvMCxnNBc7Zlv6Ib+J0mUd/
	 6oHbGGMPk1+88nOOqseCqX5Tj/w7AK1ZYe8tXJ9cTaZLCPzAokq3Ck1xoi887m41K8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OZ7kANyX;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFF7606A331
	for <linux-input@vger.kernel.org>; Mon,  2 Nov 2026 12:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CFF7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OZ7kANyX
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e5378b281aso16846935ad.2
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 04:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793623271; x=1794228071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3y/yQ7bOSsnHyylDSSSE8FXmnqPmwJGFAWCe0iH8E60=;
        b=OZ7kANyX+gh+ZCIjQsgnhe7nx3gX9Fh3lyOa7ONLFUUfV8lyszPtzgNuMOLH2GCL26
         XOfLEQyMwSWT77lFZDeVyc3pQlQVwLSE6T2l79ZLouxgzoNHEG+CXGp60d7DYZJNJFH2
         svbBZ3goM0LJbd++DgAY7TKHnp9VMJ27p0QNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623271; x=1794228071;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3y/yQ7bOSsnHyylDSSSE8FXmnqPmwJGFAWCe0iH8E60=;
        b=UGH9axAYib7/Ef2MCjuVgHM91ZyHpuqm45GaoT6ooVH5qscTzcjaBRHtCne/CHCEcO
         palm8AcBC5xFz/jiwqxtMNOvNmkwjNaxIrxg4+mSQIqFtVDaP+DhiqNz4sIj5MSeEQtQ
         9WR8QdLzycG7zFkiKOL6TOSNBPJwc2+mNO6p675zXZrgQY3nKkWwEMIPRtuEq8YQiwEm
         gPOBXuwAFXURQ4C60v7Bl+VgC4ZMs6+fn5lQlI37ELZxdKPJO/m+w3HLVgQPSpjIc6lN
         Ou8l+Fc7nQ6p6is2ZQLqUjNDNiKmh7HUXTvRl63GcAOj/h9lc2+2Swz5j6Wjp79p7XvR
         c8wg==
X-Gm-Message-State: APuU4Z84PP3CJuLc2J2zWtIl/zkJ000xKhvbbZE2CFQRWOKBcsIxJKur
	OCv4H/xCgaeA+E4+rt84WGUHyDRBNgKXHHK0m9NyuqilXGYwuN0T0Rshi7xJpxgIds5byckhoZl
	4oqNEdQ==
X-Gm-Gg: AYBFou1lvgdscRMNO5hk93+Z2t2k4wKZ9Zpm/b19bnFAy1o4fQQAPDtHLMtN9ovspPb
	DBIu/bo91wauOgIKF3rBiZOoZwJ4C/2qOSbPFWxEWxjrkr3/R3gcZpB5PWTe+0ICOECZ4GQYW2B
	/Ql03sHm19BKibZb6rbud0u8lKAlfgt4Q0cj1jS8y8IiOJAq63y9GkBPWi1P/RZ7K25aX+cZWNw
	7ZTiwK6C5J9AhH7iShG5vsfX5xklOH8SpuaqmtF6y3mMVtN9Leubprx1piPBK3NblrvsSgF7E5D
	Mu5yd/+KM4DZqbA38R2UkxmGnn/AlvkmZRHb/l4MgBDwDtlIBT8HuggIKka1ef/X4bZbe8jnkxL
	6DA2AnXWFLGtrTCG23BGQQgeNp9ST4Yxh0zlGZymO6apF86GwBK0x/WfDXxgLlyzaO0aqSyHNSS
	SdL6hwGgxHdfULkeOifWelyVkjPGWcmU31mSKcMTMFTV6laAOdQTt8484cNI8EGm5ONZ0YU/2kV
	iPXzIG/InGWopSzr8/1bEAhi0fjGB0ybfP7xf04y6LnkJC4ahFIPxRw9/OLC0oGWpoRwDXAS9sr
	KK9zGnKGsxl3MYSVVdAJgBZzb80PimqaAy1mh1uA3fyZx42VSCZTdJWS0DFXEWBkPNRvwl4XlmY
	qwYIElUsdQw==
X-Received: by 2002:a17:903:1aa5:b0:2eb:162e:37 with SMTP id d9443c01a7336-2eb3649bbd3mr96565885ad.16.1793623271316;
        Mon, 02 Nov 2026 04:41:11 -0800 (PST)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com. [74.125.82.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052effsm27055575ad.3.2026.11.02.04.41.10
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 04:41:11 -0800 (PST)
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1ae18eb9b69so1879266c88.0
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 04:41:10 -0800 (PST)
X-Received: by 2002:a05:701a:c907:b0:16a:1fa:58cb with SMTP id
 a92af1059eb24-1ac56d95460mr14461485c88.1.1793623268480; Mon, 02 Nov 2026
 04:41:08 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260831-lenovo-go-v1-1-e9526e88ee09@chromium.org>
In-Reply-To: <20260831-lenovo-go-v1-1-e9526e88ee09@chromium.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 2 Nov 2026 13:40:53 +0100
X-Gmail-Original-Message-ID: <CANiDSCs1qyOpv=W-F-94skQm4o-Aj9d0PbL7xr5qtdtLjWQ7vg@mail.gmail.com>
X-Gm-Features: AclHuK_jasd6nzcnp46dLaPaUwH7gcY2wdNBwqnJpio47XI4ra-_IDB-wFb6mZo
Message-ID: <CANiDSCs1qyOpv=W-F-94skQm4o-Aj9d0PbL7xr5qtdtLjWQ7vg@mail.gmail.com>
Subject: Re: [PATCH] HID: Merge duplicated documentation for Lenovo Legion
To: "Derek J. Clark" <derekjohn.clark@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Friendly ping...

On Mon, 31 Aug 2026 at 13:12, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Lenovo Legion Go and Lenovo Legion Go S share some definitions. Merge the=
m in
> sysfs-driver-hid-lenovo-go to avoid this warning:
>
> WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface n=
um>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode is defined 2 times: ./=
Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:364; ./Documentation/A=
BI/testing/sysfs-driver-hid-lenovo-go-s:234
> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface =
num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index is defined 2 ti=
mes: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:373; ./Document=
ation/ABI/testing/sysfs-driver-hid-lenovo-go-s:243
> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface =
num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled is defined 2=
 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:636; ./Docum=
entation/ABI/testing/sysfs-driver-hid-lenovo-go-s:252
> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface =
num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index is def=
ined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:645; .=
/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:261
>
> Cc: stable@vger.kernel.org
> Fixes: 168c91839139 ("HID: Add documentation for Lenovo Legion Go drivers=
")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  .../ABI/testing/sysfs-driver-hid-lenovo-go         | 11 +++----
>  .../ABI/testing/sysfs-driver-hid-lenovo-go-s       | 35 ----------------=
------
>  2 files changed, 6 insertions(+), 40 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go b/Docum=
entation/ABI/testing/sysfs-driver-hid-lenovo-go
> index c8221373ef76..f3ba3504939d 100644
> --- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
> +++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
> @@ -364,11 +364,12 @@ Description:      This displays the available optio=
ns for the mode attribute.
>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<inte=
rface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode
>  Date:          April 2026
>  Contact:       linux-input@vger.kernel.org
> -Description:   This controls the behavior of built in chord combinations=
.
> +Description:   This controls the behavior of built-in chord combinations=
.
> +               For the Legion Go S, this controls the touchpad's operati=
ng mode.
>
>                 Values are windows or linux.
>
> -               Applies to Lenovo Legion Go and Go 2 line of handheld dev=
ices.
> +               Applies to Lenovo Legion Go, Go 2, and Go S line of handh=
eld devices.
>
>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<inte=
rface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index
>  Date:          April 2026
> @@ -377,7 +378,7 @@ Description:        This displays the available optio=
ns for the os_mode attribute.
>
>                 Values are windows or linux.
>
> -               Applies to Lenovo Legion Go and Go 2 line of handheld dev=
ices.
> +               Applies to Lenovo Legion Go, Go 2, and Go S line of handh=
eld devices.
>
>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<inte=
rface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/product_version
>  Date:          April 2026
> @@ -640,7 +641,7 @@ Description:        This controls enabling or disabli=
ng the touchpad.
>
>                 Values are true, false.
>
> -               Applies to Lenovo Legion Go and Go 2 line of handheld dev=
ices.
> +               Applies to Lenovo Legion Go, Go 2, and Go S line of handh=
eld devices.
>
>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<inte=
rface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index
>  Date:          April 2026
> @@ -649,7 +650,7 @@ Description:        This displays the available optio=
ns for the touchpad/enabled attrib
>
>                 Values are true, false.
>
> -               Applies to Lenovo Legion Go and Go 2 line of handheld dev=
ices.
> +               Applies to Lenovo Legion Go, Go 2, and Go S line of handh=
eld devices.
>
>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<inte=
rface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/vibration_enab=
led
>  Date:          April 2026
> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s b/Doc=
umentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
> index 4d317074bb7e..218164cfe544 100644
> --- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
> +++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
> @@ -231,41 +231,6 @@ Description:       This displays the available optio=
ns for the mouse/step attribute.
>
>                 Applies to Lenovo Legion Go S line of handheld devices.
>
> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<inte=
rface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode
> -Date:          April 2026
> -Contact:       linux-input@vger.kernel.org
> -Description:   This controls which value is used for the touchpads opera=
ting mode.
> -
> -               Values are windows or linux.
> -
> -               Applies to Lenovo Legion Go S line of handheld devices.
> -
> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<inte=
rface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index
> -Date:          April 2026
> -Contact:       linux-input@vger.kernel.org
> -Description:   This displays the available options for the os_mode attri=
bute.
> -
> -               Values are windows or linux.
> -
> -               Applies to Lenovo Legion Go S line of handheld devices.
> -
> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<inte=
rface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled
> -Date:          April 2026
> -Contact:       linux-input@vger.kernel.org
> -Description:   This controls enabling or disabling the built-in touchpad=
.
> -
> -               Values are true or false.
> -
> -               Applies to Lenovo Legion Go S line of handheld devices.
> -
> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<inte=
rface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index
> -Date:          April 2026
> -Contact:       linux-input@vger.kernel.org
> -Description:   This displays the available options for the touchpad/enab=
led attribute.
> -
> -               Values are true or false.
> -
> -               Applies to Lenovo Legion Go S line of handheld devices.
>
>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<inte=
rface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/linux_mode
>  Date:          April 2026
>
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20260831-lenovo-go-7b4ec4bf0cd5
>
> Best regards,
> --
> Ricardo Ribalda <ribalda@chromium.org>
>


--=20
Ricardo Ribalda
