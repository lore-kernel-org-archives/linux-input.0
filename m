Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794564528;
	b=cPkPNi7mhCpIaL25gk0ZuZ5mMzN0PVnYPQbMyPk1z9CPxkl20UFrIO+myBWqv6+LU2Fe
	 Ejlh06NAan2bXGpBERUEvWJJxpHPcjlI5rFliZ6FOSIrl6yt+BpJgbAE0yJs+h8ZQIJv2
	 5c609f+tc2ym8QgpX2JVZUEielRdnZbZsgT/wrpfGN3zN+01qpYo1kMtYEu81LiH8fdj7
	 EBzWDvHoU86OFV6qMXpZP1hwo5MxsGaP146c5Fyry0XYdwzRemmBzHRkjZvFMQpoXRjdo
	 nLE9gt9D1H9P44ksGL6so/DBH2PHfZm2WhEcngZDW29NPLwH9Wu7lFUyJJDsOEfKB4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564528;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rKWOW9+LLEImVEGgv+UL91WRNiS03i6s+m/NnnyTegE=;
	b=G0d30EhS/eAWiaKEgCcPi4AVFOyJCzieQO5rpU0bvfGooebq/s1fg6K1D9+Bjn0ACxcB
	 +0dH6E+c07EKNbAI3sO064t44k3nvA7B2uzTPREoJh8kl9oj60hRKt4CVIhGqfZqonzuf
	 q082VVwHNu6kST7yWEBC57FIYdd10YcM4K9eoTKbvkT+XNbLFimaOpEcHNIbflPo0iOvT
	 CTxUD7Cli0+/HUGZBigSqcf4Ysagt3dxa9WSBKDWp5wJJEOVwOqT6YsV+Fz3f8JW7/U98
	 sOdB/STJjG651lrLbgmW4/oglPHx2TLwZpR2IV6AXJlAE+pr/3x8ky8m4os12zxPsBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JOHjHrKw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0258F606A888
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 10:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0258F606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JOHjHrKw
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b31261e8a9so5557407b3.0
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 02:08:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794564527; cv=none;
        d=google.com; s=arc-20260327;
        b=EykH1J15Rx1YlDq/hHmT1iCEKOUQbJHOAZKpWNpfz0p2n00O4Cyz8t4KkPqtoLeDnH
         VrmY5sVsjA/793ScC0Ry7NfMdTxn8DDip10gYnV/j88gJ4ttW5q4g9NuPaD3+G6CIEiF
         4zyenGAG3msKeVVmoIFi4JXBR0sz0ftCt0P/qO9brbXZJ8LrQenGnfF8taShoKH0qStH
         EqadwFC7yZC2I+7/eo7aC/+1fMtZrs0k5lwooSgZuCGvZeuqayMG+DrAeoPH0WUNP8Cr
         t8ltnldZxrDrISss3qEzkfBS8/9sq6bNHhHZCyOPOQz7JgJUUXnS1glD340dZo/cFeGX
         hiiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rKWOW9+LLEImVEGgv+UL91WRNiS03i6s+m/NnnyTegE=;
        fh=RjmqmWZxyOytvK41oiMMuc45FvplhBX+xJ/U2YtIM8w=;
        b=ecclA7ia9H0bOZLbrg4+o206RCh5beESOkzsbXOKIyXsc033Mg5eMmCi6QL4srIIr0
         s7YNBD72wfP2OEbMS43lC9HsfCbkdre1jeDAayf+ZUAjiFxY1pXdilhErAL4jNsyVG3f
         ITgn6TtjBgcVc2K7XNSM50+lBXRGVoSQBHu/PkXV4vzA7fEW6aVxiUou8pXNujy1YdPe
         dTKLSUt4UQQ6mvapWr+OpLIXgxJ+T77s+w1gaq5HKKE2fwHhahHenROuJX1+XNwa61Si
         Y0BhzJFgLcOI483SpFcsvzy1l6jHIxZkDGKHiV8hV1uq+LslkkHAZpOLzsSDaRFXsdNZ
         5MeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794564527; x=1795169327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rKWOW9+LLEImVEGgv+UL91WRNiS03i6s+m/NnnyTegE=;
        b=JOHjHrKwW0jJI5tHFSRlGlzX8vgF5h90RovdHP10mbXC0f3qrowCJW//O8BBklbmGZ
         ytneDq6zTIO6t8z+Dd/cTaDui27l4VySHAZ0TtoxlOq1lY3/hl9tqfQWADCUvyzj8Y9O
         jtyrS7CgL9VoJxXQFlMRXX2TA3qm5CV40l8rLoBq5NcrhVN5F9HYfoaTwS+RP8eylsDh
         lynaOrt1ud2snOnot19Br7JRxY7AZY+6RsOqxTokjJhvaLT0MfQsl/quo7ylCeHy86cy
         39xtGdWxCEmiBq0Gdf/CfuKXncUOs1wF7goPDv+aIZ9cdto1sjoklpl2E2a3d9Tur28Y
         QTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564527; x=1795169327;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rKWOW9+LLEImVEGgv+UL91WRNiS03i6s+m/NnnyTegE=;
        b=m6TeU2qasLA9IwfnvJnQPc9B6x6RZpZlaQXREVFcRfe9g432p5twSlRt2U7QC9EEr5
         MjRuflJQaQxlHqM8UCTiIfO4MqnGtgHi9EMAVF71zzZ1MMs0HnmEwI6zKSFzaiYVB6kb
         ue4Acx10nQC8lmpfQ39BAWdu/7TJpUywtvPVo/Aq2ke2vL4wg0elN9gacKfwrx4yD1x/
         kuNe6bAhCBFqfu/uSN4+5UiHECtz/NBqZYko85KD34u5vIYSZsl+oSZTu3OOh+H05H0B
         7LLPtUJZ3u9RlAddxBDAnG2V5tL7RJLCa6+bLnjTU/VkfgmcFx2vdO0/ClB8QgXqe7z0
         l/nw==
X-Forwarded-Encrypted: i=1; AL+hErHUR76i51bafmCAFQmVRTYbhQtSyZ92HEpkgNc896oarn9b5uYbEZM3F3tk58jpQtP1SUNpbgOXygoroQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+sStiJ5YUAC/sgKDog/A1PW9+08tUmOKJgOAFTNYBgIFH/jhMA
	Km12lqvV3U0rO4qnAStYv3zqvaFst+YpgYg/5aPHXsG/3Ups0h3Y6THP/vu2dA5QU7NhE28OUWp
	OJ3C+n6LZ1CDTlADJKUw7FHmT4CGNTF19oYjS/FaL2Q==
X-Gm-Gg: AYBFou3fjI8OY5cM2yiP/L+A7VkpVvoDneIqqXyAQHXrR8ThIV4KMl8LWt6xq2GeJCr
	2uqdmwdCIbcPcAcymKnINFvnCI+O4QPfPI6dpMVXhVf+kr7LfNanuZiIlqJKK9Ecg/4WI4CP+dN
	n5Kq95LuOWR9iOTdcvsIG5syFHn8JKWA9ov2rkgrLGaDIJYVZ7jXjgKEGU0KZ2FjWYr3d9iX4BL
	8ixKW16e0yJ9imkvi6KqGak5sQKdaM3oBGziZV5Xjz7rtKalxhKJLi3PWHPw2Ulr4RF68z7yqmV
	cpIToEuW9C5ftXRIn4QT+c6h2/ra3XLfgMon7FrL5Pumw/JiS6IwbZZ9MtHbXU9sydJzhoOyoMS
	yCzCU03eA7+kNh8J02/mlb70PUr2vboVkHmx5VpK+MM2e+aqRnLTyIdR7NvmGjMXG9OPnj9l341
	wa+WlHEN9qhcQzWBk5H5XekCzx1a5I+3wbd9/VbUhZ/D0ZHA6OkOuS575d50vi6AISwkpK3xNg8
	OwQ9EGH2m2bhFjAfOVA2SVoixhyjMDLxt7X2OSRfl7KQ7RfJOG2phpVddkwMg==
X-Received: by 2002:a05:690c:e1d3:20b0:8b3:4f53:91c4 with SMTP id
 00721157ae682-8b4aa326b49mr10197467b3.29.1794564526979; Fri, 13 Nov 2026
 02:08:46 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112065037.1800467-1-dmitry.torokhov@gmail.com> <20261112065037.1800467-5-dmitry.torokhov@gmail.com>
In-Reply-To: <20261112065037.1800467-5-dmitry.torokhov@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 13 Nov 2026 12:08:09 +0200
X-Gm-Features: AclHuK8Y20CK-uRfjZMkziALZSmbzxcenVC4HU4NYiah5SSa7aVtNNizdoU07Uc
Message-ID: <CAHp75Vcta1YuUfLkxh96NoeOVGjn=paTHXw8ive=+kS9pvBoDw@mail.gmail.com>
Subject: Re: [PATCH 4/5] Input: tsc2007 - do not register input device without IRQ
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, "H . Nikolaus Schaller" <hns@goldelico.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, Andreas Kemnade <andreas@kemnade.info>, 
	Johannes Kirchmair <johannes.kirchmair@skidata.com>, Yuki Horii <yuuki198708@gmail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-input@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 8:56=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> The driver has no polled input mode and only reports touchscreen input
> events from its threaded interrupt handler. When no interrupt is wired,
> the device is used solely as an IIO ADC, so registering an input device
> serves no purpose and creates a non-functional input node.
>
> Only allocate, configure, and register the input device when an
> interrupt is present. This also allows removing the unnecessary
> ts->irq checks in the open and stop callbacks.

...

>         ts->stopped =3D false;
> -
> -       if (ts->irq)
> -               enable_irq(ts->irq);
> +       enable_irq(ts->irq);


Looking at this makes me think that if "stopped" is tightened to IRQ
enablement, the IRQ framework already has an API which may be used
instead of having a local flag. This can be achieved with
irqd_irq_disabled(irq_get_irq_data(ts->irq)), but this is most likely
for the other day.

...

> -       snprintf(ts->phys, sizeof(ts->phys),
> -                "%s/input0", dev_name(&client->dev));
> +       snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(dev));

Perhaps scnprintf() to avoid compiler warnings?

...

> +       err =3D devm_request_threaded_irq(dev, ts->irq,
> +                                       NULL, tsc2007_soft_irq,
> +                                       IRQF_ONESHOT,
> +                                       dev->driver->name, ts);
> +       if (err) {

> +               dev_err(dev, "Failed to request irq %d: %d\n", ts->irq, e=
rr);

This has to be dropped in a separate patch as dup. The above API
prints the very similar message on error.

> +               return err;
> +       }

--=20
With Best Regards,
Andy Shevchenko
