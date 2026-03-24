Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4922459ED
	for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382434; cv=pass; b=IuRi6ET0O2hSTRl0/p6GHxKbr3XT4Dzq+3PNxaiT/OZ+2maBQMS8+q6wn4gtB+rq4PEbzTwZ6uyFmHwgCbUC+/XognvDoRyaINJsYChEB6+qIyIf08fyBmvyJR7C37A0wRUCWf4SI7v0groGof9cwsiDBaeVkHQKG42nnV0nCa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382434; c=relaxed/simple;
	bh=H/3/HljBKkNQvfAF2nYLo4pPn7IMLelTewsSEwuiXqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlb+UbXLUilXIi3ZvzqDSI77pC63O1RoeTDOYjH2IKBosO5mJp9G8ybLUBwaSr1skFa3RkEwshUn351g2PK3xK6/WBfSTGCLue4K92uwy7Gmc+5oV0P4+tBl3G0YpThhBixb1dT35TdHy/fZt1uLjP3SuZ2Z4TZj2zFFB6JWc18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7mtgBtR; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7mtgBtR"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9825ba7e8dso232236166b.3
        for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 13:00:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774382431; cv=none;
        d=google.com; s=arc-20240605;
        b=Ry25t1RF/QjKr3COFF3Uig90O9KointaN/JQEm1sHof/IDs3Ml8UFpjQlPDM2ZUbea
         UOGgjyz/twwtavF9lE+93JPJ/0zEVCs2vIAxdUFGlhpKsUfqT1b+xKe6vKdpYg5lGZjj
         rP6nxx5Q33+hE75cC+JEdy+FFsm85sNZOypfB/2VwuYSWzBkBAIs3B3ecQ5UERnwANNw
         9ltNsQWem2jzy3ref7vIzoIMaytVL3BIQ4JoWLfMH+Cfe5o1QFhviBq1itxJyWGUxOxC
         vovI+rkgSV4ykElKDPa6rcDsZ4wF6A25mjBkr2RF3Pd7yS0eKb+6okirVt5VSSMB1/Ga
         Amcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1nuigy5i6MlCzZ5OS0a7Db3vipXMg/2DN1anL0e9s4w=;
        fh=3S/f950CO8n7DOBotDJBvTGwHoDqTwXyu4nktnBJFso=;
        b=Rl204oHgRAbN9GFrsSco7JVZzt0HKRNOxuuvKImQf+PrKsplqq36/pE5cY5TQZZR20
         /D1nMyn9ODoWshc4ygpVIzv1f5urQ3XWl4jZEvQMHOE9mB9MhqSLLxLs44M8R1Rhgzno
         Cece/c0DWg0r2iHIu9TJCG7s0qiSnDEKrXHMHimBFX2Z67AoYR1LjxWnFSDYanvFxX0D
         Jw+yIveM5FYzE0lUMMiFAy3vVVVXpqmH+KB9z6EbkXrRbLFz+y8UEM+DAwOlrgRrvHVq
         s/xOK42j4hTjsN2D9jrj2jjGMfBvlLkFxfSrRVOs4bCwOtvkNE/FcFxPIP2Z3d5TSKh5
         qMnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774382431; x=1774987231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nuigy5i6MlCzZ5OS0a7Db3vipXMg/2DN1anL0e9s4w=;
        b=F7mtgBtRyRp+eUyW0oozsSHJAmc87CmiVVOlDMGik0btrZGo5RYmJmYgRT96t2z4Z0
         nsrFs9OpzCJIGsa781SDRlkGBbsYJqmGG97BglLgX61JkLrPRiD3SfBwjtB0YVa7iG+9
         6BYQAdAtt5l1GPtIhdFwwhxzq0/HecEKOW02Wqa7Ri8HmEvzRj/ScQAhuUAagwjHmXmc
         /RJYmPkOxHygfmmfKQxW83CzScLwt2/udvyzth7Sh5HsjFF8k0KmUSD9CO2SC+u2BvA9
         B0VEhihjRnX36imrSDFJLI8UV4rEG+PCUgEvq8z/skQhTZi3D2fphLhf/K83K6MJ8/Kz
         Ffcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774382431; x=1774987231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1nuigy5i6MlCzZ5OS0a7Db3vipXMg/2DN1anL0e9s4w=;
        b=kaB08Z1VGKP7EK7+ulzKVJUUqrUifQmenUSboZTZc4SnLcu/D7vWKS5Wh4hZ+pBDq1
         3PTlrpzpztI82gcorPt6mrjkdJuC0ArwrbFG46NhUJ1JIytspdOA30Vx6mBB+M00NJve
         98bFZMXpEz9LefSD0svvMI8zT+Wn84LGDSXLE2k1aPJaoNHgiycIhv9KeZ1WDNjlNunA
         Zzsreg9H7+VOWzjxgfMYAaoYIKD/mcjOp8SaIMAe+kZKXeaotIojXbVSLH14OSdfnWEL
         u+Ry/S5a+CkCd667sO6e+o4cTt3gbeqik7MKJHDo9Lo/r3gvHSI5exOdG0l4aNoKkAAq
         1cXA==
X-Forwarded-Encrypted: i=1; AJvYcCWi0NkPmyd7kC7tfqnh7cx5HPUr2e0rE9xBTrENNCxRsxHZA2pKn7zpUB2Ug3SSkvzM35A8o1tgUpsA3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOXojZKgXvjZPBLM+NvfbzJnivLqSw3fJ6trOmBcJc46lPIwM8
	fC6RCWe5Gl2CkO0VespKlEl43gYr3Ey2ivLsAQYeA3HKkwzFmaidJ1yvy91FJKSe4INIlvpHLzI
	Rd0P3DpiU7EuWOWPButEuHmGG/8iLssc=
X-Gm-Gg: ATEYQzwKOkm5AOKx8eX1L76ytj+ocuLJ/hLM4DdnZPOL0HqYjRCXo5EThtxIQAAc2ON
	bCNNT4MYowM9Q6LkeVv0JEsFirW9qU3+92ajc5bnzmW7/e4kA4YP0hIA7dsEVN6Gk4SHtuj32pa
	KVDPjUNXhr8yq+cVnX9it2zeA+fNPER7Hp3MO5UrOlv8ZVmIt45vZW3lT5jPJZqB4Qm1egUCz20
	epwgRuyydoIMrCS5UNL03VuUpxBIhT1J3ltnzbBJjVtcEvFJ2Ln1SVG3Y6iIkvP4uX4KnCcnw0K
	S0ttqAQ=
X-Received: by 2002:a17:907:1999:b0:b97:89b5:d7a0 with SMTP id
 a640c23a62f3a-b9a54288647mr44602266b.48.1774382431128; Tue, 24 Mar 2026
 13:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324173527.11321-1-sebasjosue84@gmail.com>
In-Reply-To: <20260324173527.11321-1-sebasjosue84@gmail.com>
From: Michael Zaidman <michael.zaidman@gmail.com>
Date: Tue, 24 Mar 2026 22:00:20 +0200
X-Gm-Features: AQROBzD7DJFoR-w2ZbaKS2onxXaNipjwmPIQropG4PSX5rpIV2agbqhUt5sEkcM
Message-ID: <CAPnwWgOY6UO2JKMNWw_fZK3Vvg_v9zQWX6Ugz=X+b4esPTn7Rg@mail.gmail.com>
Subject: Re: [PATCH] HID: ft260: validate report size in raw_event handler
To: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-i2c@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

Thanks for the patch. The report size validation gap in ft260_raw_event()
is a valid concern - the raw_event callback is indeed invoked before
hid_report_raw_event() validates the report size, so a truncated report
from a malicious or buggy device could cause OOB reads.

However, I have a couple of comments on the proposed fix:

Please use the existing FT260_REPORT_MAX_LENGTH macro instead of the
hardcoded 64.

More importantly, the size < 64 check alone is insufficient. It prevents
accessing struct fields in a truncated buffer, but does not guard against
a corrupted xfer->length field in an otherwise full-sized report.

Consider: a device sends a valid 64-byte report (passes the size check),
but with xfer->length set to, say, 100. The data payload starts at offset 2=
,
so only 62 bytes are available in the buffer. The existing check at line 10=
77
validates against the destination buffer (dev->read_len - dev->read_idx),
not the source. If read_len is large enough (e.g., 180), the check passes,
and the memcpy reads 100 bytes from a 62-byte region - a 38-byte OOB heap
read from the source side.

A more complete fix would validate xfer->length against the actual report s=
ize:

    struct ft260_i2c_input_report *xfer =3D (void *)data;
    if (size < FT260_REPORT_MAX_LENGTH) {
        hid_warn(hdev, "short report: %d\n", size);
        return 0;
    }
    if (xfer->length > size -
        offsetof(struct ft260_i2c_input_report, data)) {
        hid_warn(hdev, "payload %d exceeds report size %d\n",
             xfer->length, size);
        return 0;
    }
This catches both truncated reports and corrupted length fields.

Would you like to send a v2 addressing the above?

Thanks, Michael

On Tue, Mar 24, 2026 at 7:35=E2=80=AFPM Sebastian Josue Alba Vives
<sebasjosue84@gmail.com> wrote:
>
> ft260_raw_event() casts the raw data buffer to a
> ft260_i2c_input_report struct and accesses its fields without
> validating the size parameter. Since __hid_input_report() invokes
> the driver's raw_event callback before hid_report_raw_event()
> performs its own report-size validation, a device sending a
> truncated HID report can cause out-of-bounds heap reads in the
> kernel.
>
> In the I2C response path, xfer->length (data[1]) is used as the
> length for a memcpy into dev->read_buf. While xfer->length is
> checked against dev->read_len, there is no check that size is large
> enough to actually contain xfer->length bytes of data starting at
> offset 2. A malicious USB device could therefore cause an OOB read
> from the kernel heap, with the result accessible from userspace via
> the I2C read interface.
>
> FT260 devices use 64-byte HID reports. Add a check at the top of
> the handler to reject any report shorter than expected, and log a
> warning to aid debugging.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
> ---
>  drivers/hid/hid-ft260.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 333341e80..7ca323992 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -1068,6 +1068,12 @@ static int ft260_raw_event(struct hid_device *hdev=
, struct hid_report *report,
>         struct ft260_device *dev =3D hid_get_drvdata(hdev);
>         struct ft260_i2c_input_report *xfer =3D (void *)data;
>
> +       /* FT260 always sends 64-byte reports */
> +       if (size < 64) {
> +               hid_warn(hdev, "report too short: %d < 64\n", size);
> +               return 0;
> +       }
> +
>         if (xfer->report >=3D FT260_I2C_REPORT_MIN &&
>             xfer->report <=3D FT260_I2C_REPORT_MAX) {
>                 ft260_dbg("i2c resp: rep %#02x len %d\n", xfer->report,
> --
> 2.43.0
>
