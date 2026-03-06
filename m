Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DD4363C4B
	for <linux-input@vger.kernel.org>; Fri,  6 Mar 2026 05:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772776748; cv=pass; b=FyoGwhF13Gj8wAit3UdNFjkW3KRN2WBp8LmIEMcsynyWWKdUzsuZRf1/hwF2ONn+/mniuX2Vc3SH/o8/zClfmeXvq98Ji7Pt1Zo6Ujl1NNTAC0CQT7iWArzRys7/+rpMGbqqWmPbmjGYqedY8qBSOnSJMmNNcJ2lyk6gzIWgBKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772776748; c=relaxed/simple;
	bh=CcEDxGqDMpbWo6l5BCaT9Qo3uSp0KqJg+NPK2Zgqrlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2GKeibUVV6tQk2dNw8skR6srAow9FesCOR3L2E41IV9GrvPLncb5eZFT0lre4nWkovSQQXXMLkIx+PdVPuvLR6MwYoStIOByyYBEs/IUg8NcjW72Gd4gGnG9bsMTf7SIuwdRadg0tQtzlxWb0+bM1F3RTIWaKY1sFcPU4KsMro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTYxSHVo; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTYxSHVo"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5069b3e0c66so131931641cf.1
        for <linux-input@vger.kernel.org>; Thu, 05 Mar 2026 21:59:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772776746; cv=none;
        d=google.com; s=arc-20240605;
        b=cj0FkisjHuE2zCot3Tm72Sxov9ai1GQSO4SCQYBWnxI2chaSWyRUcZlbitIDXPgV9l
         8rdsXcqVeAW0RqkPDHTCGFYk/YdG31OTkfNlvB/iQg1to/wvLHV98HDvPLck2X8kmNsy
         URglpQpRIvZRTQ8Hpg/WS0nSMGyffvAIBiNQQiE1wpLID2DGBretp2QG4shBH/DSy5qG
         zLn2OeWGepzo09868BJzWG5qPKPf5SMfUMwjedfk7fJPq96J5fwnzqaTwIwFAjZsHle0
         D5WAQWWUjxkP2EJInVc3F4sPGD1AKxGeLVkbU/C5iZU3pOujWQQsZxEEI8PqX86Cjk0f
         pHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X47DKiwJOoYZrzCPwcGgH6/m/vZ4rjZ2dvKPx5k6CQU=;
        fh=j+LSZ5WPy3Eh35YU5AIz6W8VndlM2AxX8AvNYnTLiYE=;
        b=TF8wbOckmuEquBZIEGg25FX6zXPog6/U/HM6b237dL1IsQb0vDHyDHLGFgfVpomI8c
         p3/JPDaXmd14MsYthoiea2rmucCTPIDTHAG9GUxht11TlKhCprfpefVARQ2FdqajyOQC
         8ojazDtj+Gqab8Xe4B5BZXbrUfFcI5Sly8XG/7wd3UfB37kd+VJ5ZkGlQh6qdI43G8zO
         komyDxHA4ZKrAtAI8fh3ZNkHZETP/ZQs1IZq15WDPQVQPgVBwJo/0GFCnhch0iiYq040
         N+3sOKkkw/DSjAwwQ6WggdRu2wFiU0FdbwVnbMGkBBgie2tteA5rX8muydUb9yzWZ+nt
         SqOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772776746; x=1773381546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X47DKiwJOoYZrzCPwcGgH6/m/vZ4rjZ2dvKPx5k6CQU=;
        b=jTYxSHVol8wiPp3pQFI/48lcbaeyFLOUrQxuyaYN1UxXH/sagGjmn+v8TCDFzl4xwn
         0/t6UBns1G1G0uottKHExrWah2f+Xxqj2FPT7apYu9FKU2Wrr4ZL8jV6idtlbm+3BTcx
         mnERx1RbbTAW49J4O9ZzeAZEW3H6arDp0EjbNSylqnPYu+uqlQYUMKFIYdzagWWHVjGe
         zWZJpHmpat5iCLZXSM274O/lyT/n0TBN3OKDobiTlj/GQFKej9Zx0lNmev32jQHasISL
         S5AVVYAuq6VE9KEwRLeQq34MF3YVP3ZvcBqCBIKaY0s/SPjIlgBl52lPzn9dQ/yBHfIF
         sX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772776746; x=1773381546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X47DKiwJOoYZrzCPwcGgH6/m/vZ4rjZ2dvKPx5k6CQU=;
        b=EmScH/pVGoL7uIQTgpBLE2vClvmZtkALKtLSoHAetZ0rMVgTqP+2r4+C9YDNeSwJKG
         KsqO30NidBM7RoKvUlDOcY8dEsPyEY4SOi0Je5OBaI2pVWqpiDJxQjdlB4dW/T5H2fjB
         JGxx4HZwoXSQwA/BHfb35dCrHoJquQbzO9C2gxuEZbB3mJ3G+RMs/5Q0rCfxz6ReoH/W
         bwh9hPqWZNs0n9z+iDoE4t/Ao8JTWjxRkKbxb2jHckmX2MTV1UdksG4PmR5+nu41we97
         Pv6AmjmTQM9BafPS10GgxZ497B5J48N7XvxAbP+zsXoNiU0a+tmkb5B6F1dI56hoi5n6
         pQyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR+TyAKQn1q3ooYCF+R6r2jhhx+rMJOGgqe9s0b7SeXDwdCfPbjh0EK+lD4kso3OmdsTxjL/SnAuZDPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfzspL9mF+IohTqQLsAX2aCXBUEWuGuMAxeY2GpN/hHhxtXSFK
	xxFAFEXftxAYF7pjXuxk+VMwJjFAermuxR0T2mEgpcBwNlGtnzUpyx+6L9FZOZTjLAUUYJjMtWX
	BSySn2oN1iM13xhHNdFSRPGgg+S7BGKU=
X-Gm-Gg: ATEYQzzBqHmoZQb8t/si+PDosjUGpw83ltjDqXb3XetwuEA/ZZc3NvjkBl8RDZJMWws
	nu346MPJebX3ojbhEwBwzfFycQ/Bzjyi2v0VKXJmaQJcplErztIvteGqTJwwwzZopUWd5FckTy3
	CvbHtAb8MzuMh3NVFIhzu5h+7fJKPb9au/k3uemPvgqW+3FaARgiKJ4EumxNhhGrJ9/WpIF9eQU
	CAT8hGoyt5baZy0DBBtUCoHTH1e5nmfNFuecM3nOIEbj1hZWntJBjPPoRR0uyLfKdCRmABA3YAf
	54toyyCXkOehdfuAPA==
X-Received: by 2002:a05:622a:34e:b0:502:ec9e:ded6 with SMTP id
 d75a77b69052e-508e69d78f6mr57333591cf.38.1772776745875; Thu, 05 Mar 2026
 21:59:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228034343.286005-1-nichen@iscas.ac.cn>
In-Reply-To: <20260228034343.286005-1-nichen@iscas.ac.cn>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Thu, 5 Mar 2026 21:58:55 -0800
X-Gm-Features: AaiRm51yyTBte02LJmpXF7ExcBIIKb8MiWyWktH1L0FnE9mGKTCbQDBTGAzSJ00
Message-ID: <CAFqHKTmUTiOHq7jyi79sf0NAD7bz5b2VVEXgyBgvN5gu5fonrQ@mail.gmail.com>
Subject: Re: [PATCH] HID: hid-lenovo-go-s: Remove unneeded semicolon
To: Chen Ni <nichen@iscas.ac.cn>
Cc: mpearson-lenovo@squebb.ca, jikos@kernel.org, bentiss@kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 7:44=E2=80=AFPM Chen Ni <nichen@iscas.ac.cn> wrote:
>
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/hid/hid-lenovo-go-s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.=
c
> index cacc5bd5ed2b..d1eb067509f6 100644
> --- a/drivers/hid/hid-lenovo-go-s.c
> +++ b/drivers/hid/hid-lenovo-go-s.c
> @@ -1102,7 +1102,7 @@ static void hid_gos_brightness_set(struct led_class=
dev *led_cdev,
>         default:
>                 dev_err(led_cdev->dev, "Failed to write RGB profile: %i\n=
",
>                         ret);
> -       };
> +       }
>  }
>
>  #define LEGOS_DEVICE_ATTR_RW(_name, _attrname, _rtype, _group)          =
       \
> --
> 2.25.1
>

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
