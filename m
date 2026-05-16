Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19A63254BB
	for <linux-input@vger.kernel.org>; Sat, 16 May 2026 18:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778955932; cv=pass; b=g26m0n82oow01neJC4mNt3Ia1CKv5vwO3LDMezGC7O5T1GjiMrGU2B8auxKiGWZBeJYn7INJN9u91tAB6px2/9K5xC/ZsD0QLFwV4X7NobGkTuHiVKhLeNihPQI5Erk37nV5FBla2HbuKni0DSoQGXulzPHcsjP+u/4cshqflLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778955932; c=relaxed/simple;
	bh=rlnP6BSKk3y+57gPpnvq0Nwo15+DtNNEApQU1WzrYAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ohx9YScfPulA86lSg+eKXvTIVEwK5sYOVDcJCiyinXHzwZdw9vMLHXnVe7A9SwkRq9pHE8K0POWpPOXD9+S/Z8YbC4pucOekzkPnl6TIsaUVhxzkJMSokYytkAJZMqG0B0VCw47J/OmAXQSJ+nGmy03VqGx+zYI3Xrnm4JzGMDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ES+fd/9H; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ES+fd/9H"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-57754ec3462so188296e0c.0
        for <linux-input@vger.kernel.org>; Sat, 16 May 2026 11:25:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778955927; cv=none;
        d=google.com; s=arc-20240605;
        b=YnHIb79PgOCf18eI5fdvhVOfeEzaGS2+bNlc3jBFk1kzjdmyOLNEfsh0Ocsos/rwFb
         AsfpWEQsMSLS4VTopuFHgVQuMy/J9HJ+bQtL3wAtPqfSV6ygBz+KtTZyYASraPlMqgdX
         ma/evZtdcXCtD/hSbVY1e21stokYLgCyUj4z086GshY9dehyjKr/Fd5vhxyDMq7XByTR
         RrHBLoagqVarIHvBLb0to1ofblbE7yAYw+D6gIqrWg1XMPPJP63YLWGeSw5DYAbdTIPU
         FTu5UjlHrTW3yE44bHETepiK7N7VgH36vWlknw9hm1t4J9Rjz0QW+LES85Q7Fok+y16j
         y1gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SkG/mV7/+T57gOebLhjBWLUXJSJDsOeED6RV9YmxRq0=;
        fh=511GxFBOZUqqmDqhZNozqFalEm/icnEyfONYtWi35xs=;
        b=itPg2s6kxxzwJ7L8kP3nIBMqnrTK+iKG1PmyccTK+xyyvWavriA0dxLPUb640aQYq6
         jPjwfASMNjhmRJ/T9MxLox5oRr7meqI6rCq0a0qq873TIz64/ogNkf30/oxa/NAKwQeh
         quS2EwoMvMTbjfOdJluE0cnzEveorNqeM7MFcNhyydBagxRhGKpgw3h61/J0qO7gWu5N
         yBmfvevwBAXEhXPNExlVywB4s68S51X/AINuLcht2cxH7eqXjusS2RjrNqwVRck2K1iP
         wRoh1r3jtEp+o66WZoOrC1Gf6SzyW/Sc0Lw8SqwpT4QwXS9vp6rbM4TwAqgg6fxhEIZf
         4Kkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778955927; x=1779560727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkG/mV7/+T57gOebLhjBWLUXJSJDsOeED6RV9YmxRq0=;
        b=ES+fd/9HVUTBK/AFLWTqVNgFscVrwTfDjYH2vxAQ7Yzc68Gc4Qs/67E6evV0QrLa2k
         Fo5IOxOO4kcwPuTsNxempHvhN/DZTwhMRXQgtLrxUhHz966+x40+bxFlBD+Qtf259qLg
         nx2m5OrbtocZJqLBXmPexEwdg5JJy/3Azxux1+CUvmyq9yFrcZDaCIkSQd4UTfwX+Qz5
         jJrO6A5JC/y579nBDV25BUKAIdmS+s48uIY0qchQ5zwcjom1Zt12PvBJOsHiYetUNayi
         Cipahwq4tl2U4uFitIv4cZBDFz/A9JPdbm4L1DQzZijS8W1UaM1FbKWnZ1rmrSrs7O0G
         os+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778955927; x=1779560727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SkG/mV7/+T57gOebLhjBWLUXJSJDsOeED6RV9YmxRq0=;
        b=ZRrfoJurrggrtckl3czlxCoD76/5UPdr0lgNdiP0E/zIgjl5rpeRUrkraJli6aQrco
         U5liiZX+QwOqhtibIHmKFf9WxoEyQZWY8RbMZ7NXXuLVO11NbikWZg9WeaLjx84yx0fN
         J2q+W6BjCpJ6SdvCHpIMsbKc/6t2ZkrUv1/t/QYTlnvie8O2pFPw/JxruYLzPj52PEo7
         EdYtOzrmG+w9+6TOzHWYahAn7hjMwx9mnJR4MUp70/fXxLOcagiJbDEumStwR9mGmMTa
         2BUdV2dP8l6ABBmbpXjxhgY9r//kwaUMQbXYQD1aTJCM3sfYimT4tQypvSik8fXFg/Ok
         Bwcw==
X-Forwarded-Encrypted: i=1; AFNElJ/gDlPMvEwqmDj4tOQEw3anS6I7z7rfcaprRSHEosM0s6Ch32yK5KDxvAMEkincTrQLV5tOo2Z4PLGSiA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz08OQsvFzv4CXJLNF2/kFN4r3k74cKaFcxPAh1gPupKko2lCow
	MjKOAowdptTwlWWT1S4y8mt1abKAs4n3HeFW3Qad+FWTDo4x8FkVP1KuLoF8n8XWj09t7ryIbjp
	mSt3CtrIiFKNPw1RM0PxVSYfE1I/qSg==
X-Gm-Gg: Acq92OGapqmzZUkjyHeNXOmE4NZ1hmiitf/mw4vjY48iQIa9drZM33M6XTPNmibHmTL
	+nTNgvYgVQeuKPWyjSuux1mv1uJYhs8foV4l9STcA/KbqCqKrHf70BKN7PqLJXN2+irLQEngaFH
	vXz72rnYoN5Md8boAPlMoge4rFo20zuVJV/pcyBCG0KEaJzKXNjOFyagH4k434RLs+XWSk9wTC2
	XdNjm0n/w9M1yeetwr95TE5vIQy2MmtjNyh5YXGEG9JvrQ43PBatI687V/1S7KdeEDFM1MOcnTh
	3Wj2XHYd/2/qGeVjA/xXqSDEkjETEUT5HUvSKo2n
X-Received: by 2002:a05:6102:a4a:b0:631:3cbe:24a9 with SMTP id
 ada2fe7eead31-63a403acd61mr5104520137.31.1778955927317; Sat, 16 May 2026
 11:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504-wip-fix-core-v3-0-ce1f11f4968f@kernel.org> <20260504-wip-fix-core-v3-1-ce1f11f4968f@kernel.org>
In-Reply-To: <20260504-wip-fix-core-v3-1-ce1f11f4968f@kernel.org>
From: Brian Gerst <brgerst@gmail.com>
Date: Sat, 16 May 2026 14:25:15 -0400
X-Gm-Features: AVHnY4Ld3uQxrMVDp5dOpfkW5jEH4X-4ObNKlmAwKJn9zSPCBkcMEhByKE4-YXg
Message-ID: <CAMzpN2ijE3vqnh30T0ETQBp6qcVbsxNZZ32h4oEri9nBFUd-UQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] HID: pass the buffer size to hid_report_raw_event
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
	Bastien Nocera <hadess@hadess.net>, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Viresh Kumar <vireshk@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>, 
	Icenowy Zheng <uwu@icenowy.me>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev, 
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 4:48=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.o=
rg> wrote:
>
> commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
> bogus memset()") enforced the provided data to be at least the size of
> the declared buffer in the report descriptor to prevent a buffer
> overflow. However, we can try to be smarter by providing both the buffer
> size and the data size, meaning that hid_report_raw_event() can make
> better decision whether we should plaining reject the buffer (buffer
> overflow attempt) or if we can safely memset it to 0 and pass it to the
> rest of the stack.
>
> Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus=
 memset()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
>  drivers/hid/bpf/hid_bpf_dispatch.c |  6 ++++--
>  drivers/hid/hid-core.c             | 42 +++++++++++++++++++++++++-------=
------
>  drivers/hid/hid-gfrm.c             |  4 ++--
>  drivers/hid/hid-logitech-hidpp.c   |  2 +-
>  drivers/hid/hid-multitouch.c       |  2 +-
>  drivers/hid/hid-primax.c           |  2 +-
>  drivers/hid/hid-vivaldi-common.c   |  2 +-
>  drivers/hid/wacom_sys.c            |  6 +++---
>  drivers/staging/greybus/hid.c      |  2 +-
>  include/linux/hid.h                |  4 ++--
>  include/linux/hid_bpf.h            | 14 ++++++++-----
>  11 files changed, 53 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf=
_dispatch.c
> index 50c7b45c59e3..d0130658091b 100644
> --- a/drivers/hid/bpf/hid_bpf_dispatch.c
> +++ b/drivers/hid/bpf/hid_bpf_dispatch.c
> @@ -24,7 +24,8 @@ EXPORT_SYMBOL(hid_ops);
>
>  u8 *
>  dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_t=
ype type, u8 *data,
> -                             u32 *size, int interrupt, u64 source, bool =
from_bpf)
> +                             size_t *buf_size, u32 *size, int interrupt,=
 u64 source,
> +                             bool from_bpf)
>  {
>         struct hid_bpf_ctx_kern ctx_kern =3D {
>                 .ctx =3D {
> @@ -74,6 +75,7 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev, =
enum hid_report_type type
>                 *size =3D ret;
>         }
>
> +       *buf_size =3D ctx_kern.ctx.allocated_size;
>         return ctx_kern.data;
>  }
>  EXPORT_SYMBOL_GPL(dispatch_hid_bpf_device_event);
> @@ -505,7 +507,7 @@ __hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum =
hid_report_type type, u8 *b
>         if (ret)
>                 return ret;
>
> -       return hid_ops->hid_input_report(ctx->hid, type, buf, size, 0, (u=
64)(long)ctx, true,
> +       return hid_ops->hid_input_report(ctx->hid, type, buf, size, size,=
 0, (u64)(long)ctx, true,
>                                          lock_already_taken);
>  }
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 61afec5915ec..a806820df7e5 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2033,24 +2033,32 @@ int __hid_request(struct hid_device *hid, struct =
hid_report *report,
>  }
>  EXPORT_SYMBOL_GPL(__hid_request);
>
> -int hid_report_raw_event(struct hid_device *hid, enum hid_report_type ty=
pe, u8 *data, u32 size,
> -                        int interrupt)
> +int hid_report_raw_event(struct hid_device *hid, enum hid_report_type ty=
pe, u8 *data,
> +                        size_t bufsize, u32 size, int interrupt)
>  {
>         struct hid_report_enum *report_enum =3D hid->report_enum + type;
>         struct hid_report *report;
>         struct hid_driver *hdrv;
>         int max_buffer_size =3D HID_MAX_BUFFER_SIZE;
>         u32 rsize, csize =3D size;
> +       size_t bsize =3D bufsize;
>         u8 *cdata =3D data;
>         int ret =3D 0;
>
>         report =3D hid_get_report(report_enum, data);
>         if (!report)
> -               goto out;
> +               return 0;
> +
> +       if (unlikely(bsize < csize)) {
> +               hid_warn_ratelimited(hid, "Event data for report %d is in=
correct (%d vs %ld)\n",
> +                                    report->id, csize, bsize);

This fails to build on 32-bit with this error:

In file included from ./include/linux/device.h:15,
                 from ./include/linux/input.h:19,
                 from drivers/hid/hid-core.c:25:
drivers/hid/hid-core.c: In function =E2=80=98hid_report_raw_event=E2=80=99:
drivers/hid/hid-core.c:2053:43: error: format =E2=80=98%ld=E2=80=99 expects=
 argument
of type =E2=80=98long int=E2=80=99, but argument 5 has type =E2=80=98size_t=
=E2=80=99 {aka =E2=80=98unsigned
int=E2=80=99} [-Werror=3Dformat=3D]
 2053 |                 hid_warn_ratelimited(hid, "Event data for
report %d is incorrect (%d vs %ld)\n",
      |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The proper format specifier for size_t is "%zu".

Brian Gerst
