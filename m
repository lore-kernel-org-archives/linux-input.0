Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E79523D7E6
	for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781429777; cv=pass; b=BqP/Nd2srgoH0yBO8IgVe2esTvyzr6duzcWmavABmKnvQBdO9FNZPZNdMsgtjaBOwTBC2sjZJGBhRFRiXg2gk3r+0yxnndxXp8+e3R+zkK0e4QB1yoHtCR4x/hmOSCZdKwWMUyo4YCqOs1eJXevi6zbJ3BWriSSfuiaMBF2VSpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781429777; c=relaxed/simple;
	bh=KxG8FW2t1Y5M+en6j+orfhigu10djlUwEeeCbQF3vLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCsGty67u9OJDLN3HRz2m+Xv+UW6BHoSFgVWaAMGprvH1IQfdAgguWYKNGOlpAq/VYCWlWYlUyqbSDMxYS/VTWLzuoHdvga7QMo8PwtgqEdNdrvS/UlNDvbKOEK9M3BsUeW056pSBG0mAmJ24APiyFma2EpGBi563OmcTRrYIpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GF4Vb6V3; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GF4Vb6V3"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-69e1eae4eb4so1836792eaf.2
        for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 02:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781429775; cv=none;
        d=google.com; s=arc-20240605;
        b=HahPKkMRNUFxPYp44MI6Puy5LHAtcnK1xh+dGyTpJ0PhsThyBnLbzQHvTK4PVd/vzb
         LW7tPv9R0L+7oUa22Egx5g3ZejkW0tap2WDf8jhTr9vgtuZa3yiJYN9KB5qi9rSHyzVR
         w+SletLQLAJOpbUkU3uvp39W1eltoQBmZoJ8vOkkJAh2T12LHKJiRvTYuzAYh+yIcz7D
         HEbAG1Tjq8aFDNA8et8wy+qJBZUBXoh669JwfpLc9HLJ6tOTIsONUSVkbS1/eydndfUn
         HVFQvDrPIQt7hq0/N6cZ+CNPpQFIRxUBsO0DHd/9DpqMfyNhsp9im6tiHrSZAASKVosQ
         cAiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6uhzggcYBf9ZojUJZXYZOedKy8TL71m8+1uHUmTjSGs=;
        fh=rTG08LOyyIKhMz6cxMCeQlwbu9/OH1PgX0pB51z1wMQ=;
        b=XlPbXYIAfHJ996zb2Jfjiuye2GVErQmWymeVB0UFjQDfGG8KfXTw3Lp4JP9L4PbVZ3
         wXqVPgKXhcNyiO9TUICfHCL1ctxvhB15aRtqiKB8vaPV4n2UNTrKtbUxP988m/Z0tWUY
         LqoxfVMdtWwBTKjYPvsDYbiBKsfax3HlZp6BqwfZh+782P3JGAo5x1OKGSqoXU7jxbEz
         GX9c88F3iUk6SPJoTAyS+oSsh+ErToaUGbYs83XO5ETfCud+gnuwZ4eD9qaB09TOuALU
         m3IkYbyq08m1cVIKsH9Af+R/V3gvKzQP+leBIiz5F3amyOOFluEm+XBPoooLBeRPcnF9
         wnRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781429775; x=1782034575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uhzggcYBf9ZojUJZXYZOedKy8TL71m8+1uHUmTjSGs=;
        b=GF4Vb6V3CbrmfUzqqBOs+OXaTmV0CwyiTs0PZPsTq1+xb5m5Bq/QSwmZFPMukFzYP2
         S1AsT2LDgnQLfdattQsoZes/qsW+2ljpCNCbhLyMKja4DpUnhCoFc1q0XGWo9Q0Tavh/
         FkMUyHT7NdPVrIb0AtN7gDigmcXhAfC4KAotxBLGQemXu4VaYcDmClWIbzx9698mesdy
         dv9P7EfNtL2Eujtst8Uo3F54ZgCRbvyXbDV3XQIAtXxQqXYnN6ccs0EVSVbNY1ZQNVFK
         YeZlN1lolxCAnBPSIo8klNHP0gNYSFyUSXVHxUm3+8YXXUVhjM2hm700O3IyClGNdDVM
         u9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781429775; x=1782034575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6uhzggcYBf9ZojUJZXYZOedKy8TL71m8+1uHUmTjSGs=;
        b=FTyregxxeakKmMB8ln2YMbQJtErJbo6YpmMl72Wmj4UKYztRKzskj0uTYu8BkHcGM1
         SrA9aeQ9DE2QJU4yxJdlyw4mMjysCZ05l2hGCYBt8JCQ/+y3Q6il/R6jLzh0nebGq31u
         qgQ575mRXuRHijURpfpVpIltZepBoNWbACh6IzSwC07v7irBQQWw/4F+1xUtLyiBuLm8
         1QWgbo174tELgqzg0k3FTwTSuV/+3h8duUvjFrtLVk7HkV3VHu4+iHP0rhCI4f8D5R94
         KchLk9KGIqJWCDCBEamYGO2tHaKQt86CrNRumwbIMptlHdvZdwih+koaOw0Q/cpvAjuK
         qB/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+vRTMBmvOOC6s3IFQxruHGDeI6On24C5TQFYub4b6r4Nqw5k31+Q2riTXVMn2pz5IgtRWGl9BA3hVwFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFvyFqMRZW/dmHYRXAIhyShSYz+khNRBh26rhcbu6jHQdDmPZn
	D7SR0akpv9V/WDe3CzFdkkFsjo4aXHBdozeCxvr6Ooia50hJXmYOXWxYldRHrcDbo3dtAnrODrI
	Vs8o/3sco0OWdS4dnLfG+CpVnXzDAPyesqWh5
X-Gm-Gg: Acq92OGTivgPkYJf7bCxGENlrJPqBdVsQ/YY1W4GPsYstrExzsoXpPF2a1k8XRBPdLQ
	y0ZlnOs8ShYRG61h93khXq9ouOvzBWZoOofW7viU2HafmEXtmgn9s4k15VXJzOIi9fA6PPjfFwn
	/5LyX/mBWuVzOXDWEi6TJFS02Cp9nzEtXfAmvqU9UZKI/gb2KK5uFUetWu/YodePhB10lpsh8ay
	Mf8m9pLRQbhhQcsLANxIvREXSDlU5KXXrsl4NPNzwlEDvnz3bCpgRlyhCLfPdowpTJXRcUKhzed
	siS2Qe4=
X-Received: by 2002:a05:6820:138c:b0:69e:264b:cced with SMTP id
 006d021491bc7-69edc7531e5mr6172237eaf.41.1781429775361; Sun, 14 Jun 2026
 02:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610142952.3335586-1-kernel-linux-20260610-80b7ab08@raman.v1.sg>
In-Reply-To: <20260610142952.3335586-1-kernel-linux-20260610-80b7ab08@raman.v1.sg>
From: Michael Zaidman <michael.zaidman@gmail.com>
Date: Sun, 14 Jun 2026 12:36:00 +0300
X-Gm-Features: AVVi8Ce4epODd7EyUdn-8D3EO5xEsrDf3SP-UUJGVD0bPFa4W7aiY6G9RUo7VLE
Message-ID: <CAPnwWgOwtOib1UoOWYX1xVPFKDuXRQYkwEEuweGqo9H7BCXQ7w@mail.gmail.com>
Subject: Re: [PATCH] HID: ft260: fix stack-use-after-return write in I2C read race
To: Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-i2c@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Raman,

Thanks for this patch. The race is real and separate from the input
report length checks already in for-7.1: those bound the HID report
source, but do not protect read_buf lifetime after a timed-out read
unwinds. A spinlock (not dev->lock) is the right fix for the IRQ/input
path.

For stable backport notes: did you reproduce the use-after-return, or
was this found by inspection?

Optional hardening for v2: initialize read_lock before hid_hw_open(), or
immediately after allocating dev, so a malicious USB device cannot hit
spin_lock on an uninitialized lock during the brief probe window after
the input path is live.

I'm validating on FT260 hardware and will follow up on this thread with
Tested-by when that is complete.

Reviewed-by: Michael Zaidman <michael.zaidman@gmail.com>


On Wed, Jun 10, 2026 at 5:30=E2=80=AFPM Raman Varabets
<kernel-linux-20260610-80b7ab08@raman.v1.sg> wrote:
>
> ft260_i2c_read() points dev->read_buf at a caller-supplied buffer
> (often an on-stack variable), arms a completion and waits up to five
> seconds for the device to return the data. The HID input callback
> ft260_raw_event() runs in the input/IRQ path, independent of the
> dev->lock mutex held by the read path, and copies the device-supplied
> payload into dev->read_buf after a plain NULL check.
>
> These two paths share read_buf, read_idx and read_len with no
> serialization. If the device delays its response until the read
> times out, ft260_i2c_read() resets the controller, clears read_buf
> and returns, unwinding the stack frame the buffer lived in. A
> response that arrives at that moment lets ft260_raw_event() pass the
> NULL check and then memcpy() the device-controlled payload into the
> now-freed stack location, a bounded but attacker-influenced
> stack-use-after-return write triggerable by malicious or
> malfunctioning hardware.
>
> Add a dedicated spinlock that serializes every access to read_buf,
> read_idx and read_len. ft260_raw_event() now holds it across the
> NULL check, the memcpy and the index update, while the read path
> takes it when arming and when clearing the buffer, so the teardown
> can no longer slip between the check and the copy.
>
> Fixes: 6a82582d9fa4 ("HID: ft260: add usb hid to i2c host bridge driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg=
>
> ---
>  drivers/hid/hid-ft260.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 70e2eedb4..f47945954 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -240,6 +240,8 @@ struct ft260_device {
>         struct mutex lock;
>         u8 write_buf[FT260_REPORT_MAX_LENGTH];
>         unsigned long need_wakeup_at;
> +       /* Protects read_buf, read_idx and read_len against ft260_raw_eve=
nt() */
> +       spinlock_t read_lock;
>         u8 *read_buf;
>         u16 read_idx;
>         u16 read_len;
> @@ -501,6 +503,7 @@ static int ft260_i2c_read(struct ft260_device *dev, u=
8 addr, u8 *data,
>         int timeout, ret =3D 0;
>         struct ft260_i2c_read_request_report rep;
>         struct hid_device *hdev =3D dev->hdev;
> +       unsigned long irqflags;
>         u8 bus_busy =3D 0;
>
>         if ((flag & FT260_FLAG_START_REPEATED) =3D=3D FT260_FLAG_START_RE=
PEATED)
> @@ -526,9 +529,11 @@ static int ft260_i2c_read(struct ft260_device *dev, =
u8 addr, u8 *data,
>
>                 reinit_completion(&dev->wait);
>
> +               spin_lock_irqsave(&dev->read_lock, irqflags);
>                 dev->read_idx =3D 0;
>                 dev->read_buf =3D data;
>                 dev->read_len =3D rd_len;
> +               spin_unlock_irqrestore(&dev->read_lock, irqflags);
>
>                 ret =3D ft260_hid_output_report(hdev, (u8 *)&rep, sizeof(=
rep));
>                 if (ret < 0) {
> @@ -543,7 +548,9 @@ static int ft260_i2c_read(struct ft260_device *dev, u=
8 addr, u8 *data,
>                         goto ft260_i2c_read_exit;
>                 }
>
> +               spin_lock_irqsave(&dev->read_lock, irqflags);
>                 dev->read_buf =3D NULL;
> +               spin_unlock_irqrestore(&dev->read_lock, irqflags);
>
>                 if (flag & FT260_FLAG_STOP)
>                         bus_busy =3D FT260_I2C_STATUS_BUS_BUSY;
> @@ -562,7 +569,9 @@ static int ft260_i2c_read(struct ft260_device *dev, u=
8 addr, u8 *data,
>         } while (len > 0);
>
>  ft260_i2c_read_exit:
> +       spin_lock_irqsave(&dev->read_lock, irqflags);
>         dev->read_buf =3D NULL;
> +       spin_unlock_irqrestore(&dev->read_lock, irqflags);
>         return ret;
>  }
>
> @@ -1018,6 +1027,7 @@ static int ft260_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>                  "FT260 usb-i2c bridge");
>
>         mutex_init(&dev->lock);
> +       spin_lock_init(&dev->read_lock);
>         init_completion(&dev->wait);
>
>         ret =3D ft260_xfer_status(dev, FT260_I2C_STATUS_BUS_BUSY);
> @@ -1067,6 +1077,7 @@ static int ft260_raw_event(struct hid_device *hdev,=
 struct hid_report *report,
>  {
>         struct ft260_device *dev =3D hid_get_drvdata(hdev);
>         struct ft260_i2c_input_report *xfer =3D (void *)data;
> +       unsigned long irqflags;
>
>         if (size < offsetof(struct ft260_i2c_input_report, data)) {
>                 hid_err(hdev, "short report %d\n", size);
> @@ -1075,6 +1086,8 @@ static int ft260_raw_event(struct hid_device *hdev,=
 struct hid_report *report,
>
>         if (xfer->report >=3D FT260_I2C_REPORT_MIN &&
>             xfer->report <=3D FT260_I2C_REPORT_MAX) {
> +               bool complete_read;
> +
>                 ft260_dbg("i2c resp: rep %#02x len %d size %d\n",
>                           xfer->report, xfer->length, size);
>
> @@ -1085,8 +1098,15 @@ static int ft260_raw_event(struct hid_device *hdev=
, struct hid_report *report,
>                         return -1;
>                 }
>
> +               /*
> +                * Hold read_lock so a timed-out ft260_i2c_read() cannot
> +                * clear read_buf between the NULL check and the memcpy.
> +                */
> +               spin_lock_irqsave(&dev->read_lock, irqflags);
> +
>                 if ((dev->read_buf =3D=3D NULL) ||
>                     (xfer->length > dev->read_len - dev->read_idx)) {
> +                       spin_unlock_irqrestore(&dev->read_lock, irqflags)=
;
>                         hid_err(hdev, "unexpected report %#02x, length %d=
\n",
>                                 xfer->report, xfer->length);
>                         return -1;
> @@ -1095,8 +1115,11 @@ static int ft260_raw_event(struct hid_device *hdev=
, struct hid_report *report,
>                 memcpy(&dev->read_buf[dev->read_idx], &xfer->data,
>                        xfer->length);
>                 dev->read_idx +=3D xfer->length;
> +               complete_read =3D dev->read_idx =3D=3D dev->read_len;
> +
> +               spin_unlock_irqrestore(&dev->read_lock, irqflags);
>
> -               if (dev->read_idx =3D=3D dev->read_len)
> +               if (complete_read)
>                         complete(&dev->wait);
>
>         } else {
> --
> 2.54.0
>
