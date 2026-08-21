Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8699A346A18
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 01:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787277127; cv=pass; b=dVuBzOztO3mdb8VJGCAJb2eW6+bMLEV40k/vqkhcuj5MIjXIf8ULSS1CteIl3i1xMY9Qq1Vah8dCyxUxPABFnM/1gdOkj1jwYqVtyfyz/5ILvFynbWFiGxtIWNhkdMeONRTJgBsqXiflw23tCk+PxrurtzNPUbBLu2xpfQ6nm9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787277127; c=relaxed/simple;
	bh=Vc8S5ztztDYQgsTWtsHiHgN+/QFM5U7wBqOIyKazx0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pu2atgjHGm/gMJ00COgo3NyniBqGunQVGK51t3z16R9bOq8wpL+mKRIZZDxZcnU6GWrA7ffC4SxxLI+rc2J4zkLzOI61jDVqg8yIyXMeckYBE3ACpOLdW5h0i05p/Tz08w9p4kbz72U7YYvdNjakDBvhkzB05peGOgDmXXFrL18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkbp2DtG; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkbp2DtG"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7dbcb505578so7330177b3.3
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 18:52:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787277125; cv=none;
        d=google.com; s=arc-20260327;
        b=JFkw4eVFqWYN++TQ1Gk8gTE6CDuuOMqHBqAqTqPMiDexOkt42+ptfTCqHsmQoSvCQ3
         axLH+I1pnaXTZ0SSMiPvuiQeRdCd/LYZVZSqcBcW33BI/XstbeM4VZShus/T7uj+Nvm/
         KHjXMobB9QkaXeH/bnwVHqN2OSFtrXvbEYSIxsuKYgL4TBEFV/FBbgDnVOaawv1VN68P
         xL3a+tLY+Fl/TCKPLp7dKQJSiEfD9wemGtaZ9TIXAUQeKBbVgQFwPkjS6lvcOV4b138G
         BholQHusv/EFWZ8AWwQeoPMol/U603AAyFnnbX+xslDQfLfTBMlPoNdCst+7p+KVMgPK
         I1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=974hCZQ2f8sZhz3XQtuoSfV2xYlNnFZfC1UVwG68zdA=;
        fh=ZoVVjE6E+GBX2kmmcv4JHK8X671XnPoNuoAm1DxWlg8=;
        b=DolJfXtfDe4MZ9qoOS1sx4tUyHJ1DqJeIYFeSh0N3kYAgXL+TaKXalx7HtBFOWYygL
         93chYbhhImT3FqoP/W1TD9c1wtW0fFvbdHNJ/g+EiAjxyyju8ZStlfFeWI6IPpalnjbM
         NXruq9cUPNak8NGV+2Y2JlA+gHHwy3fTfiWwHviXPtCW0RzTNUvtNonqvZvPREao9Ktz
         r5TL0P9Xsp0TyyClUlcL0ZZDKywxIZsJCpHgvpLZwac6SqSgOHZh/Im5Thp+nDKw78N+
         B22NbYOy9imJaBLJXKj7kpVnPqG1t3wpnYeK8xSMJauKwDQkxJjHUDyW/nzCD+skgn5g
         +wVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787277125; x=1787881925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=974hCZQ2f8sZhz3XQtuoSfV2xYlNnFZfC1UVwG68zdA=;
        b=mkbp2DtGE3lNDtQowGhY1RW2Be1mATZG6sZGbgIikbkgqDU7ZeRFB+p1ciLQt75BJ/
         ZcxzAU1yMCXOrCL2v8pAWLoQ+FIAMG2UqBYmrLeK4xqJTw+TmdbbpDLlETeptHjzMZKD
         cLS+4mT9A+AkJpk+8RgEhHot8KFZWukMV+jJsikcpL/hQEf6gMQsjkPTOwug7H5dLzwI
         m2B07VRgbjG+sd5fjvOCiJrYUw6rQX0AyJPNoJnik4VsbvFAqTg+/rB4/O/gwRKXKh4o
         FrKJ64Of5oVnlcLXAu8rGrQbwC38698lFpnWhefH2AjDhsa8ZPT1gm8dyAXm8moDUhuH
         URUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787277125; x=1787881925;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=974hCZQ2f8sZhz3XQtuoSfV2xYlNnFZfC1UVwG68zdA=;
        b=GGFgO7OvKFgkpClgBsD2AzEYN2+GWrWzT0L9ZTfD7xF1HGQ1DWaLsefGHx7tL9WhMn
         SJjcxDET6Jefsh+q/knLDLZwPaWEhcGm1GpMaN5Esv0iOeTZYONe6mBx8m6EIaCFuhJk
         oGioNRnn/O962PLJLY1GelMLQSuWI8zQjodMZqNawzP0Yriqv+fHQyYRH1V7kRPwEBCS
         W/o1p2uyFXqgFRi7cvSHqDd/MmT0BNajotyx+EfH1f7Jogle2NEbL9AIa8x2bWjQsZH5
         BqhUL49vp+wSIJlsyBu8wACd+MkcRmouKMI4Y+uARz4KzenkA9ew51xl3gld7/u46iVu
         oZvQ==
X-Gm-Message-State: AFuF++kvrZN0/qrhBfDabJmCFO9JkkgI2fbVRWaPl69VU6K+qM86wOKN
	HIGrZeTngj/s8xX5LKjIS+BKPNG6D40SCkU+uU+rPXjjdAYrB6j2+c7nklLNsbwNhle+/oTywM+
	75Dmy0hHhSNNBqsihn92OGdxAPDHxpOM=
X-Gm-Gg: AR+sD10DKlbdSi+BGcDGCtYTeZLIp7FIpiT9VqKLNuxsnWhqll/Uv0i3doQAfe1Oq0F
	Ka4s8ZwU9kM8YzasyaKxmSZHL/2JraubGci35FoiVcbXF02RHuagALkuqa/gSZO0lQ/8BbFM7R7
	3QmGkWXkcPxUEbSP7wDLo6fIGzfTZ/rgjLSpNh2FpoAl/t2ouQHyBf7W5vcyUH7l6JWQntOFoOE
	0D2D4lsAuO5hlz8ay77VlacyRgc66VO36+vJBzdWI2PckWD6kaECbnk7WS0bbV1FhPE49wvPzJK
	wZ6+ml87H3926Js6dhEcM479qnKsOxi9GTpxzAcUTIeR/7Mj0Xjr81/0nLYAPClM9MlW/Qts0Ug
	fBxQY3kD4RXrb5p0BP20z3rptSHZH9sPcpw==
X-Received: by 2002:a05:690e:c8f:b0:669:586a:8673 with SMTP id
 956f58d0204a3-66ce4a86a93mr1130287d50.21.1787277125396; Thu, 20 Aug 2026
 18:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809040629.12666-1-kartikey406@gmail.com>
In-Reply-To: <20260809040629.12666-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Fri, 21 Aug 2026 07:21:53 +0530
X-Gm-Features: AcwNN1UPbzUQnyy5F3quPJGWtaSHJyiGvozZt6rh1zO1nZH6zYg5CujhqGTiTtU
Message-ID: <CADhLXY4_M62zOXOCyk8BcBU924+7_TxZ_GkbE=V5ME3ZbDsVag@mail.gmail.com>
Subject: Re: [PATCH] HID: core: check field offset before dumping input
To: jikos@kernel.org, bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+a942efa43c928a1e3daa@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 9:36=E2=80=AFAM Deepanshu Kartikey <kartikey406@gmai=
l.com> wrote:
>
> hid_set_field() passes field->usage + offset to hid_dump_input() before
> validating offset against field->report_count. field->usage is allocated
> with exactly report_count entries, so a larger offset is read out of
> bounds before the existing check rejects it:
>
>   BUG: KASAN: slab-out-of-bounds in hid_dump_input+0xcb/0xd0
>   Read of size 4 at addr ffff88802ab28fc0 by task kworker/1:2/48
>
> Move the bounds check above the hid_dump_input() call so the function
> returns before the dereference.
>
> Reported-by: syzbot+a942efa43c928a1e3daa@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Da942efa43c928a1e3daa
> Tested-by: syzbot+a942efa43c928a1e3daa@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  drivers/hid/hid-core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index cf123347a2af..7ea1fb62b9d4 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1933,13 +1933,14 @@ int hid_set_field(struct hid_field *field, unsign=
ed offset, __s32 value)
>
>         size =3D field->report_size;
>
> -       hid_dump_input(field->report->device, field->usage + offset, valu=
e);
> -
>         if (offset >=3D field->report_count) {
>                 hid_err(field->report->device, "offset (%d) exceeds repor=
t_count (%d)\n",
>                                 offset, field->report_count);
>                 return -1;
>         }
> +
> +       hid_dump_input(field->report->device, field->usage + offset, valu=
e);
> +
>         if (field->logical_minimum < 0) {
>                 if (value !=3D snto32(s32ton(value, size), size)) {
>                         hid_err(field->report->device, "value %d is out o=
f range\n", value);
> --
> 2.43.0
>

Gentle Reminder. Please let me know the status of this patch

Thanks

Deepanshu
