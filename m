Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515633B102F
	for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 05:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789279119; cv=pass; b=YRITkosG0BADH3YWlY2ncB1GtZBbZT1L0eg3oAhxoF7q4euAJe6hK4mJnIImQQs2XRX8+Y7UQIQIHLxnZSdpbArSMB4MJdhOyES5HA0s7IArTfLL2Hm8358H5vxPsf4O4sCj5AspIeAMiO7wv07GgABAgb243vg17oo1NyS1adE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789279119; c=relaxed/simple;
	bh=XL2BqdaDbBQGl2le1+e15CvxQeIuTY32niH1hZcA9BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lt9rw6N0R9FeuZPnAIbLizt8D3RTGSg32M/GCWOVQqZefQ6nLhvfAEEDpJV9RCTk930SiyefoCxTuW3NUacTOGoM44jdwk5kT6/Fy9rHPYNHRkwil3jwkNKN4JiWsOqLUs8uu8W0EkGkD8Eyzd8DX0t2AYtiy61U0qT/Omor1vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBuD8yye; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBuD8yye"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c25ef7a3ce9so105251466b.3
        for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 22:58:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789279116; cv=none;
        d=google.com; s=arc-20260327;
        b=diy/bl3qJ7PIbjU+qfmH2RXMnYrmxnq7obeCRStK1psKTM7XJuDWGeQepb5jryQ3PM
         7GFX+TJTzT8jcjXWpyskbXayQtr81kISAGYO/FeX1qZze/RKzdI61TN77oDvzVhz90gG
         r1AopclP08sfWzWgvoewxL1lwVEyhyUs8i0LLKA8Z8zomlX4JT6OwvcceFZvk5yYRvZe
         oOLHoegABExLvOqS0zJpHQRjOuVhYElXPBo8Y8MM80IMoEU33KZAODzS/vLUUIygPvtw
         V64KAdj3G1B/9+6WjvHfifsOk/aIzApVgWB0J73v9WPPHJKOeZ4R0k4a0nrIh3qbZZGj
         hvfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IUEiueZZV2yqlkScy30M7jIekL7G0zJhj9udl2hgLjA=;
        fh=cPync94sb0FQGYyQo6TpG/2c/zoPpgzhLfYqQoiv140=;
        b=kPNcx7E5aDo/xhsEqkN6BwS5hAb4UJ5YsrruhFDQggHY8AJE6l6SR8hkRnWkBk1kvh
         h1GYnW6o/ssEzZlDpd7MdvabhtqMWn75leaXykXdttPXxLD63qvVmP373aU2ySxZ+0CB
         qShhv4SaJ8zGhK1D2y4b1yAW8thycT7J0kj3Dk4AS8Tvz2ABW+QEY8dGQMogpCLqKuOO
         nX6gqd3sjcg5bZBnem3PFkQ5Ao+TUs0sATByskf8vxMM5kXFCucfQGD0GgAJwZcJwg74
         vAUTYKBhgcG7w0/330YQCaonQk3e23mD/3vDBeplAMvOJeNWVzyBdmOQgmWthsD82t76
         muCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789279116; x=1789883916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IUEiueZZV2yqlkScy30M7jIekL7G0zJhj9udl2hgLjA=;
        b=RBuD8yyeGqJZW6JT2zXOEdjG709cS90bvQPawkony/4PHo31VpQBXplb/XzfihFiMT
         sf3joOUpOWsqZk68cgVD0pfoDowMHFVHZK2DyrB7lyZn8oOWZgOycO8FYpZRQvQDfbsf
         UvGY0eQ3iMSasHWbPtczfK89PQpMqa5MQWkJPf8GvG559F5KDEREe2GQ5/hyFNmHOEas
         JOl4OOp7CLIF8ktKpsKXAi9nL48Lk1zy7tQT+f8m8Rs2dE+AGme59El+XEHNBbsyZ9YX
         zKMJJfLk3dK7zat+niAAZh6Lx5nCsI9jo/557tOVqA0RSPcKq771BoIuYBwmQ58WoyAB
         M7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789279116; x=1789883916;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IUEiueZZV2yqlkScy30M7jIekL7G0zJhj9udl2hgLjA=;
        b=b6SKa4Re8yDGiOmneWmR8hBpH9kgIx3JrKuzHo5SzS0UPdH2u1drinKolLRRTbnHsU
         10NnNa80Y1le0G3yYK0MyRyTxhksUmSRlRLhlmid4w/iludk4yE6bn2vUt+Gy5mEnt1s
         wuyfNc773sGpnH5HQLONI4EKO3ehDsHjz6x5Z2HL7a8PcZeUPVz5LgCXp+mtKk4MtDtn
         usBj5RF/Osnx032J9tm8S5HzgH5hxqX9UbbGz6MAjFLeRx/YOh8hrwdkTfNc8GwrJfDk
         CdtleUQ/AzA9ODV8/4e6flgJIOqW1Ibbgfxpgap54DCzDQitB7hFsBwdRHWX1enwR5GV
         NoXA==
X-Forwarded-Encrypted: i=1; AKwUvBy2C3BSwfPPuPRRsq13VdPbHCdu10GxyewBXIhL4+ne7unK6YrWAeIizhliMaRNYkZm65V2qIBBChgk7Q==@vger.kernel.org
X-Gm-Message-State: AFuF++meyT5+3puYZ6VN9IaTFSx2HmjYth2qjKxKEF7s9fsJ7ywwjfHL
	p96inamQ776gbFU6adnAmyrigDD0Kv7jFf8m8aF7xTLKUeJAxCb810MH0OTMUxpELwGTiJ2+Fd9
	ZyhCGbP0GBe/M2RplA8TMPXXmwHQOuLE=
X-Gm-Gg: AYBFou3O8nRq0fLu/JnXBb7hMD64mIuDMt6cTJwpFDzezOz5W00JGsYfP8CKgsIqaDr
	ZTr2Puo2RyJX/wG/rUTiCFNxDUJAF7BIti7gm/AG/2s9InmV2bPNLgsdf0rXrjgSaJIWtc1j8q+
	7s0RLIi7hRKohTm4/0Kp6HGNVDkYhjP11QTmTf4hXAnhFEY4P5vr/3+N/bs1+l40A9TlM3N10OB
	AuHb/+WB83X97IapNiTi4CS6xhbJraAO8m6qwJio9+6Wb77llhBS9wmOP4PoD1pjkvOb9G5RJ2C
	oMvUUK5LhpCjoXM0GV59NYkzOdAZRpiD9VeIBuA5x/nbWvFJvcVFXLYnOanRVXXd/QPZzXs/hk2
	4DksnzeYvCNGbIw==
X-Received: by 2002:a17:907:1c8c:b0:c29:5340:182e with SMTP id
 a640c23a62f3a-c2985725e75mr277141166b.2.1789279116193; Sat, 12 Sep 2026
 22:58:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c8efa35aeff7b6ee4f66f1d48d4392976dbde128.1783329551.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <c8efa35aeff7b6ee4f66f1d48d4392976dbde128.1783329551.git.u.kleine-koenig@baylibre.com>
From: Ping Cheng <pinglinux@gmail.com>
Date: Sat, 12 Sep 2026 22:57:15 -0700
X-Gm-Features: AcwNN1VGFA-W-o06oLsLxlJUvDoT8ZSEjCsjMCAPFTIzYsU6qr0WR_WS1UZO_W4
Message-ID: <CAF8JNhKhL3pC2yvMxg87R9TKJ4-b1vQ8Y7J8hWmKOLHCp0on8g@mail.gmail.com>
Subject: Re: [PATCH v1] HID: wacom: #include <linux/device-id/hid.h> instead
 of <linux/mod_devicetable.h>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 4:39=E2=80=AFAM Uwe Kleine-K=C3=B6nig (The Capable H=
ub)
<u.kleine-koenig@baylibre.com> wrote:
>
> The single device-id structure that is used by drivers/hid/wacom.h and
> its users (drivers/hid/wacom_sys.c + drivers/hid/wacom_wac.c) is struct
> hid_device_id. So #include the much more lightweight
> <linux/device-id/hid.h> instead the full <linux/mod_devicetable.h>.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Acked-by: Ping Cheng <ping.cheng@wacom.com>
Tested-by: Ping Cheng <ping.cheng@wacom.com>

Cheers,
Ping

> ---
> Hello,
>
> there is no coordination needed, just make sure to apply it to v7.2-rc2 o=
r
> later. So please take it via the hid tree for the next merge window.
>
> Best regards
> Uwe
>
>  drivers/hid/wacom.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/wacom.h b/drivers/hid/wacom.h
> index 1deacb4568cb..d2398b1cdbb2 100644
> --- a/drivers/hid/wacom.h
> +++ b/drivers/hid/wacom.h
> @@ -82,7 +82,7 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> -#include <linux/mod_devicetable.h>
> +#include <linux/device-id/hid.h>
>  #include <linux/hid.h>
>  #include <linux/kfifo.h>
>  #include <linux/leds.h>
>
> base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
> --
> 2.55.0.11.g153666a7d9bb
>
>
