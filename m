Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE165277029
	for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781429284; cv=pass; b=ArDRUpulyOBUKuFWy9N41OPTwCKFLbz4MGmd6g3/Zv8GPNGbuz8UpM55oItbSlO1ChCoSO1BbWyQHXLO64gp+cu7f4MnLy0OWdYtR4dxHRK2Z6P3w0L7jXxye6E7nEXyUc5ZrecaHjNmvssSGyo1tEzF1/Xw2qKPbnwzJfkbjdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781429284; c=relaxed/simple;
	bh=6r4U9R99dbPRpiaffjdEr+Fo1qhnTwDcQsAMMtkwyug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ada0KPN4aRwZStwL28cUQ5Gxn4lzx6lTfHZMVmJFhC8gilFyg55rbofcxu99OS2vXwHOhLvTlAMNtIRQKB5GeRkcerKzp4NT2eeqWway23vaYbDP3Ix3Yfl6ctGp/T/i4jJN7yy05yC42z54wBVO+CulWrha321Mq37BiAuNvK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVU7QZfL; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVU7QZfL"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bebac79fff8so285951766b.0
        for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 02:28:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781429281; cv=none;
        d=google.com; s=arc-20240605;
        b=fqYMnrvaXZvfcExDAaAPa8ZniDiahpgX3AEaL3FKI0CfwHCW1cDtTaBazgnaSmDLsa
         fXXvcArDDMUaknw27dfnjPuXv9HqHH3nsSSuS0fr/Qj44StllaWBPBkCsmrvUfru8s5A
         sASMBxr40Fs8631fDfgXXKhbQ9BsU4Uafdh4SixTLabzfF+1lQeu3wt5C4FxFUFN6CmM
         rQ0uyYRoYi5iCys76ObXpy5QZSFXSJU215AoOiwph/rXkXKs+cnFZ86D/h3ioCXyUVx6
         zC86BoKEmJjynRE/3dJPi8TJIM5CwkUQvjXmX1d3r1eoxkztxF3cGv2SXZc7vOpUy2hT
         ARPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KfLnUSNfvNSyz22YZcSw2u31gAfTNQlrSNtk4+9js6I=;
        fh=4ogm8T2FlYD3BHiK6lY4gsmJZQxMCDgIg5aCr1qNXBI=;
        b=iBOx0cXowKLPjvUmWWRTe1CmOFJkJjhWQTR2kmrJLn/6QGT8o5uD9/UzLlt9zUGj9U
         m9vsq2npDfGqC0Mz5idvLB012UTgREdPGVO1EeNR55pxLOQ4N8h+67+fBAzE+awsixH4
         odS8ZrtZjr2a27/TPxmkeRkmFih8aivaiiHpOIN16N7+OLXVU6O7CWWwMiv5mZWp1bkd
         ClT06PT9hlsAqsRAsIXuvzmAaLrnVpzW3pMGpJawOY6WhTqjvFu6o3QZ3ZOA8naK4rWy
         pz8G8AXu+vfLHC+p/UsEOkgvMvUHrA/nihJKlIVDHFxnaOhtegFXsswuaGpqLetERhOO
         o6jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781429281; x=1782034081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfLnUSNfvNSyz22YZcSw2u31gAfTNQlrSNtk4+9js6I=;
        b=IVU7QZfLHwXi3tPIMad7A7El+QjrIRUljmZ+KL2jl8Jlk1naOhSyPthttvqkdOtxiX
         oPFJV1d4wjTSAf7OOTrBtgGMGq8M3u2nuDrRMnfRw5lYMacInHrXtV1ooH/vgHFEumkL
         6awYDRn1IWzlueihFRFfgwtbo01nWcVaDND7YZH/JAfsOeFOeQ8WBSnTIRaferXkgncp
         HS7VO60UXK0de69Cfj0TJvH9ZycjCsFl4jp2tJhcYmFGz45KHABslu1obELavUVuAl8L
         ozztqoGNoXBa7tsOjUAb+5oNDb193pQ1qjUcu5aZ0TvQg98XNB9J5hHGElt4adYaGzTJ
         H1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781429281; x=1782034081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KfLnUSNfvNSyz22YZcSw2u31gAfTNQlrSNtk4+9js6I=;
        b=Lnn7z5xHTwoSyIYyCZ4pP8PRtn5H2vRr9/+eRpmiQZbPH56Uc6SG1sx55QI+pxqthj
         BcrvPD4MiH9HmVZPGF7wydXPW4cuJaohdzkk1P3GWV8t18MiHUtBsnSBRx2hKgrMbVHF
         +U7oP8KzVw10DCPNMpeJZoET8CAKiKxVQZxLFM3G7soVrN4i/cfHDeJyGYkQPH+pJY4/
         WXZds4mHrgUptFsFhwksF7Alg0b455vDeptfG9aV1K/PfXJyYRxB5PAKzA84zFaP41tG
         2yPqRh6SQPwOiv7qjMBst3NRgZxtYvhqHrDaZXej9p+xKkc/WpciU0G/tucBwypt1oq1
         GATg==
X-Forwarded-Encrypted: i=1; AFNElJ/EexSfgi6GoCcUczI3WAmSlUM+XzmjjhRIDUYCfafgYxPUNru808YOvjZ+A0yp9LOOQnf96A0VJloQFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YylcAUvVy17ZTjVvhaEBoM6UgYe8vAQTJf2i/lDsJSqMD0wVIUO
	lYyBL34sehEpuxrzBVh3FiWxx6iGz5pd2j9JVvJ7QlmEYQRd5fqTPThV6ubdSsPFdFa7DG9MpCb
	UMBsrQeOpOjyGgYz5da2h3qz4Um5czNM=
X-Gm-Gg: Acq92OEb5HQUAPIQ0ThHF7geqSHpNT5i68e+MS+c8MmhMHWApqZsO5VIF/BQ2xpq0/m
	cO0ZQXxKkAp1rXPErHb1ZI/9MjY2YS3U0B1Qg3r/xCDksuum5WHsA1DMgvzUzNAFwLJprNKGBu/
	PfdbWHHBYp91vJN1kfZARinsd60cD2vynckwHm/juLdYqAYelZCaM2w5yXEBk7r3ZQFSv3zC+jG
	Ln8rWn5Pmlc2VjCM3IRVOBddAkI9tEIwOVAkEYonpkD2/TR8azf5q8JeaN/evcF+nel9NM4XTnB
	KIdxsA8=
X-Received: by 2002:a17:907:6b07:b0:bf7:a616:cafa with SMTP id
 a640c23a62f3a-bfe2aaf718dmr504436766b.34.1781429280979; Sun, 14 Jun 2026
 02:28:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610134119.3313484-1-kernel-linux-20260610-80b7ab08@raman.v1.sg>
In-Reply-To: <20260610134119.3313484-1-kernel-linux-20260610-80b7ab08@raman.v1.sg>
From: Michael Zaidman <michael.zaidman@gmail.com>
Date: Sun, 14 Jun 2026 12:27:50 +0300
X-Gm-Features: AVVi8CcUCzyNGfYKEbKnW1Y5hRq5SFufjr5Nfx6Yd1SLAvRisdRSA2wHtp-44GE
Message-ID: <CAPnwWgNLd2RZVx__T1Z9siKwN_5HrA2hcKwrZ2C6YivQuF6Ubw@mail.gmail.com>
Subject: Re: [PATCH] HID: ft260: fix SMBus block read protocol handling
To: kernel-linux-20260610-80b7ab08@raman.v1.sg
Cc: jikos@kernel.org, bentiss@kernel.org, linux-i2c@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Raman,

Thanks for the patch. Your analysis matches what I see in the driver:
on a block read the count comes from the slave, data->block[0] is not
initialized by the caller, so sizing the read from data->block[0] + 1
is wrong. Reading and validating the count first is the correct fix
for the FT260.

I'm validating on FT260 hardware and will follow up on this thread with
Tested-by/Acked-by when that is complete.

Reviewed-by: Michael Zaidman <michaelz@xsightlabs.com>

On Wed, Jun 10, 2026 at 4:42=E2=80=AFPM Raman Varabets
<kernel-linux-20260610-80b7ab08@raman.v1.sg> wrote:
>
> For I2C_SMBUS_BLOCK_DATA reads, ft260_smbus_xfer() passed
> data->block[0] + 1 as the read length. But on a block read the byte
> count is supplied by the slave as the first byte of the response;
> data->block[0] is not initialized by the caller, so the transfer
> length was taken from stale buffer contents, and the count byte the
> slave did return was stored without any validation.
>
> Implement the SMBus 2.0 block read protocol properly: read the count
> byte first with a repeated START and no STOP, validate it against
> I2C_SMBUS_BLOCK_MAX (resetting the bus and returning -EPROTO on a
> bogus count), then read exactly that many data bytes and finish the
> transaction with STOP. This keeps the whole sequence within a single
> I2C transaction:
>
>   S Addr+Wr A Reg A Sr Addr+Rd A Count A Data... P
>
> To support issuing the two reads as one transaction, teach
> ft260_i2c_read() to honor the caller's flags instead of always
> forcing a START and unconditionally appending STOP to the last
> chunk: START is only emitted if requested, and STOP is appended to
> the final chunk only when the caller asked for it.
>
> Signed-off-by: Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg=
>
> ---
>  drivers/hid/hid-ft260.c | 45 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 40 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 70e2eedb4..946ed0c6f 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -502,15 +502,23 @@ static int ft260_i2c_read(struct ft260_device *dev,=
 u8 addr, u8 *data,
>         struct ft260_i2c_read_request_report rep;
>         struct hid_device *hdev =3D dev->hdev;
>         u8 bus_busy =3D 0;
> +       /*
> +        * STOP terminates the last chunk; clear means hold the bus so a
> +        * follow-up call continues the same I2C transaction.
> +        */
> +       bool want_stop =3D !!(flag & FT260_FLAG_STOP);
>
>         if ((flag & FT260_FLAG_START_REPEATED) =3D=3D FT260_FLAG_START_RE=
PEATED)
>                 flag =3D FT260_FLAG_START_REPEATED;
> -       else
> +       else if (flag & FT260_FLAG_START)
>                 flag =3D FT260_FLAG_START;
> +       else
> +               flag =3D 0;       /* no fresh START - continue current tr=
ansaction */
>         do {
>                 if (len <=3D rd_data_max) {
>                         rd_len =3D len;
> -                       flag |=3D FT260_FLAG_STOP;
> +                       if (want_stop)
> +                               flag |=3D FT260_FLAG_STOP;
>                 } else {
>                         rd_len =3D rd_data_max;
>                 }
> @@ -708,14 +716,41 @@ static int ft260_smbus_xfer(struct i2c_adapter *ada=
pter, u16 addr, u16 flags,
>                 break;
>         case I2C_SMBUS_BLOCK_DATA:
>                 if (read_write =3D=3D I2C_SMBUS_READ) {
> +                       u8 count =3D 0;
> +
> +                       /*
> +                        * SMBus 2.0 section 6.5.7 block read in one I2C
> +                        * transaction:
> +                        *
> +                        *   S Addr+Wr A Reg A Sr Addr+Rd A Count A Data.=
.. P
> +                        *
> +                        * The count is read separately and validated
> +                        * before sizing the data read so a misbehaving
> +                        * slave cannot drive a write past data->block[].
> +                        */
>                         ret =3D ft260_smbus_write(dev, addr, cmd, NULL, 0=
,
>                                                 FT260_FLAG_START);
>                         if (ret)
>                                 goto smbus_exit;
>
> -                       ret =3D ft260_i2c_read(dev, addr, data->block,
> -                                            data->block[0] + 1,
> -                                            FT260_FLAG_START_STOP_REPEAT=
ED);
> +                       ret =3D ft260_i2c_read(dev, addr, &count, 1,
> +                                            FT260_FLAG_START_REPEATED);
> +                       if (ret)
> +                               goto smbus_exit;
> +
> +                       if (count =3D=3D 0 || count > I2C_SMBUS_BLOCK_MAX=
) {
> +                               hid_warn(hdev,
> +                                        "smbus block read: invalid count=
 %u from slave 0x%02x\n",
> +                                        count, addr);
> +                               ft260_i2c_reset(hdev);
> +                               ret =3D -EPROTO;
> +                               goto smbus_exit;
> +                       }
> +
> +                       data->block[0] =3D count;
> +
> +                       ret =3D ft260_i2c_read(dev, addr, data->block + 1=
,
> +                                            count, FT260_FLAG_STOP);
>                 } else {
>                         ret =3D ft260_smbus_write(dev, addr, cmd, data->b=
lock,
>                                                 data->block[0] + 1,
>
> base-commit: ab5fce87a778cb780a05984a2ca448f2b41aafbf
> --
> 2.54.0
>
