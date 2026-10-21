Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792625066;
	b=ZfZVo9X8p9yB2/L7zC8U1iYbaXwKcXe2+2LrBqC3YR5A9Fyf+5YWmXa9FUHdhqHYgtVg
	 yKQc9x8kQ0xrNtPZtLvtU4HDROqI2pyulNOIBD7Q7TO/IvTmGstwykd0LJTw3qjJOLZwd
	 eceHqwPa7FZe2fiG3a5QZPCfswRnHoDpR5ARowjBZ6LfKTFsWUET3ToE1Y93MbJMbJPoY
	 vYJV9A5BJm5na0MbzQ6xvEsLpzyvXr0Af+OV3s3KfFkgIewfgX0+eIKLKyRlk1LmKT7eY
	 LSDfJbo2kcfxj9WAbi6UoM+OQvq3ON8WnZ7AXm836GOTQkH6n25FtYZK7Wypx0I3drA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=OOnJLMePRidiRd6Zbc0eEriUIlHpT2oioIudJsKLtbo=;
	b=d5DirEd1dWP7WEf9IhqiDgZk+IDFenGPlvuNpCJSm/TPjAy4/3Dqe6ajckwg2TxlbXPu
	 GBdtqEm4L+q6KtbhHaIv9quXYCYR3Asb5nDLSPPbhs+oMuzAtHpNDojQZo5mCHKrmJ1Z8
	 byyVaMuvIeRdrImZqfGGTRWRj6YuDPL3ScfIJ3OgCsuJz4ZkEAEj7bLQBCPihmqLSX57/
	 bDy4kAxWzErErhHEUkPXPn7awFuwYoeJb4QZgssyblDPIDAh/3DpRYTc4k1QhQfL1XxWM
	 vKK5rvFI41maudSGu4cSrZEjFPcsl0OjoR+uKACmR4oFHo7mWfHhQa8OZbYxRnyUyfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oLi8y7J2;
	arc=fail smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CDE606A31B
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 23:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16CDE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=oLi8y7J2
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8ab43af5e97so4181537b3.1
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 16:24:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792625065; cv=none;
        d=google.com; s=arc-20260327;
        b=JTf9Qu+feRNkp/FTdK6OOLC6OnbBFvkgKdktCNU2x0xfrU2Xo9JxHYHWR7xKuJV8Ne
         kUNwzNCCHcrx18WjI7gHUvcQq2kZwzg3SqUzzZL9qgQcEqu2/MwEBKX1PaecjCKyDBI3
         8SOIYweEet84SHqdamsVoa0VkN822ulwBkFIr9WuubyIvnBmnWRNyrwGHmk1gmInDoPG
         ii3rj3fVLUMeadyfPPhJak4Pkd00BOFMUOsqt2Rn44X/yO0i8uVu9ltIRCVsj87e67Z/
         1OlLkzKn2qSKH5Yg8CXjSx00xRtpU+AAw8RJh3lYUjky82TcV6/8qfSLCyw+k5CJi6Jz
         qffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OOnJLMePRidiRd6Zbc0eEriUIlHpT2oioIudJsKLtbo=;
        fh=osfj9leewLfc4MqIYaUjfG4KfpRUNqFnByXZRUnRoVs=;
        b=CV64U+yjr6z7EBvhKfzscqFd1OOV3CXa4A2HrXDtGyHwRyAC/IJ/CF90S1nWpwpM/v
         WF+ufAFAqjSQCT0/pwg4EvyGJu55Bmvwl9jI9D7ENJmh8TT5bnwZsIDT6GIrGI3x/wTP
         x+WU1jhfQQVvZQUXI66d+guoA9B9L2nmqaaLG9PTtR6Ty0QRrWxsy8SkqkUfHdutom/j
         mjn4oYIG/lpuMW7Nxz/jVem0STPyoj6cV7fxj9DuCX8DTD3lcJqsd8rW0F5so6pVUaC6
         rcAnca7DEoDh66wWqruNF+/IEm0cRv0UNOX3vVAzJouuWcFqj572YUbSgZ+qnB3TjV6u
         SFog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792625065; x=1793229865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OOnJLMePRidiRd6Zbc0eEriUIlHpT2oioIudJsKLtbo=;
        b=oLi8y7J2xgDhdaDp9fFCzXu3oc0F5lPk7JamTcvIw3le8Dw3lMLUBD6Gya+o37DXpE
         UyBfigPn8dmOyI3/uwfbcVVf7J58WFe+Fgp/s64m8mG4IhYwl7IHHJI92+G6kAxadobP
         XVMpG7fBQeNJo5ITGawxn7y6Io6uSkHTGov2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792625065; x=1793229865;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OOnJLMePRidiRd6Zbc0eEriUIlHpT2oioIudJsKLtbo=;
        b=V1ntYh0DPL2/Je/3QWECWmR3+uZcc7HPseyfqlGl5QCDv/n6fpFoWlAFommcW4dyS0
         z7E3xDzIJ7c10fnQMP01/X/WW09VBuAoWQJISfwwwXU34lkecKzPm3PrLezF45viCvpY
         xElmv3Y0wQ7OWKSe0sJK/ffRsH3WgJD4oI6IwQW1ZqdmGqCEYbqLR51VZI1jsMZu31wH
         KLralYD3NSDcNF1QMeSaCLKCVlo36gwulMu72StzDcXQGbcB7oyr0Uvo/6eFZFxB8QtE
         vxPPe0MfmFi3mU9KIBkW2nnd7l7MNQF/N0UUq3HA/2Mhk1xj+LYtNINIxZXYz4ms3ZlK
         8pEw==
X-Gm-Message-State: AFq9FYIjZj4GZJx20KPlca0laBksqtAhBGbdOSkoWCHk/2EUM6SoqoTU
	8nbza3zwvO7HyOas30avK/xF4626qgr1TwNNfAkt1rMtV6ZXgoeP3ZwfDT6wMVmZ2MQ6a/v3EGS
	fqehJ6C8YA5Tz0Pkyn/SOLmSUgbAZrTtMyKr2fRmS
X-Gm-Gg: AYBFou1ronSpa+hxdM/QuvSmPINc9ptVDV33q91TIqtlgH+EH1/hwjQOtK3pkT3g0X4
	9QWE02LrxdxZarZKRMEuGoHUKRU14VFS1xliO41pMjVpBsd6fviscV+0O+z37dD+USA5I+DkJf3
	E8C3LcC0j9VQvAjdOp4nYn+U53GDOmIwiQaE0D06b0N8JxPW3u815+e04L8GqbRDb8lWIEqEvrk
	1kPtdn+9P+89VZD/i7NWJeAuldXo6f9jqy/iGUhagVz6WLzWQ88feI2yHVDPgrHxU0rUOcd6D0N
	gYrrt+pC6hoZN99oS4T8vIbUs4NxKm2ah6xSzQ+yEkDLs3R+/NTqz7k2X5wjYlnCcBXgORRHXNd
	qshYzMgPumx0cgA4sxQfjksAydgF61ahO//4OsG2x0OzQM51WN/pBpFp3k40qMSybMsk=
X-Received: by 2002:a05:690c:2786:b0:8b0:88c7:f184 with SMTP id
 00721157ae682-8b14551034emr3963617b3.4.1792625064963; Wed, 21 Oct 2026
 16:24:24 -0700 (PDT)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
 <20261019-send-upstream-v6-4-cb9ba4b3d6fa@chromium.org> <sashiko-outbox-178143@kernel.org>
In-Reply-To: <sashiko-outbox-178143@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Wed, 21 Oct 2026 16:24:13 -0700
X-Gm-Features: AclHuK8I92dDi-a24-arJkNbKz40DybvKa54bpvCtfeFFEOTon1M-6c-zRbUBhQ
Message-ID: <CAEe3GZG3rHcRtHmg=vB5WdfsQ38Fghi_o80dSnsuaog2_xrieQ@mail.gmail.com>
Subject: Re: [PATCH v6 04/11] HID: spi-hid: add spi-hid driver HID layer
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 12:26=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] HID: spi-hid: zero-length report descriptor accepted in spi_hi=
d_ll_parse()
> --
>
> commit 9328ec8c48a0b55cf1019d845ec2c37e89f4cdbb
> Author: Jingyuan Liang <jingyliang@chromium.org>
>
> HID: spi-hid: add spi-hid driver HID layer
>
> This commit adds the HID low-level driver callbacks and device creation l=
ogic
> for spi-hid, handling report descriptor fetching, buffer allocation, and
> output/feature report requests.
>
> > diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/s=
pi-hid-core.c
> > index 02a7608c4b882..fca7a44eeb9f9 100644
> > --- a/drivers/hid/spi-hid/spi-hid-core.c
> > +++ b/drivers/hid/spi-hid/spi-hid-core.c
> [ ... ]
> > @@ -84,11 +185,484 @@ static const char *spi_hid_power_mode_string(enum=
 hidspi_power_state power_state
> [ ... ]
> > +/*
> > + * This function returns the length of the report descriptor, or a neg=
ative
> > + * error code if something went wrong.
> > + */
> > +static int spi_hid_report_descriptor_request(struct spi_hid *shid)
> > +{
> > +     struct device *dev =3D &shid->spi->dev;
> > +     struct spi_hid_output_report report =3D {
> > +             .report_type =3D REPORT_DESCRIPTOR,
> > +             .content_length =3D 0,
> > +             .content_id =3D SPI_HID_OUTPUT_REPORT_CONTENT_ID_DESC_REQ=
UEST,
> > +             .content =3D NULL,
> > +     };
> > +     int ret;
> > +
> > +     ret =3D  spi_hid_sync_request(shid, &report);
> > +     if (ret) {
> > +             dev_err(dev,
> > +                     "Expected report descriptor not received: %d\n", =
ret);
> > +             return ret;
> > +     }
> > +
> > +     ret =3D shid->response_length;
> > +     if (ret !=3D shid->desc.report_descriptor_length) {
> > +             ret =3D min_t(unsigned int, ret, shid->desc.report_descri=
ptor_length);
> > +             dev_err(dev, "Received report descriptor length doesn't m=
atch device descriptor field, using min of the two: %d\n",
> > +                     ret);
> > +     }
> > +
> > +     return ret;
> > +}
> [ ... ]
> > +static int spi_hid_ll_parse(struct hid_device *hid)
> > +{
> > +     struct spi_device *spi =3D hid->driver_data;
> > +     struct spi_hid *shid =3D spi_get_drvdata(spi);
> > +     struct device *dev =3D &spi->dev;
> > +     unsigned int rsize =3D shid->desc.report_descriptor_length;
> > +     int error, len;
> > +
> > +     if (rsize > HID_MAX_DESCRIPTOR_SIZE) {
> > +             dev_err(dev,
> > +                     "Report descriptor size %d is greater than HID_MA=
X_DESCRIPTOR_SIZE %d\n",
> > +                     rsize, HID_MAX_DESCRIPTOR_SIZE);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (rsize > shid->bufsize) {
> > +             error =3D spi_hid_alloc_buffers(shid, rsize);
> > +             if (error)
> > +                     return error;
> > +     }
> > +
> > +     len =3D spi_hid_report_descriptor_request(shid);
> > +     if (len < 0) {
> > +             dev_err(dev, "Report descriptor request failed, %d\n", le=
n);
> > +             return len;
> > +     }
> > +
> > +     /*
> > +      * FIXME: below call returning 0 doesn't mean that the report des=
criptor
> > +      * is good. We might be caching a crc32 of a corrupted r. d. or w=
ho
> > +      * knows what the FW sent. Need to have a feedback loop about r. =
d.
> > +      * being ok and only then cache it.
> > +      */
> > +     error =3D hid_parse_report(hid, (u8 *)shid->response->content, le=
n);
> > +     if (error) {
> > +             dev_err(dev, "failed parsing report: %d\n", error);
> > +             return error;
> > +     }
> > +     shid->report_descriptor_crc32 =3D crc32_le(0,
> > +                                              (unsigned char const *)s=
hid->response->content,
> > +                                              len);
> > +
> > +     set_bit(SPI_HID_READY, &shid->flags);
> > +
> > +     return 0;
> > +}
>
> [Severity: Medium]
> What happens in spi_hid_ll_parse() if the report descriptor length is 0?
>
> In spi_hid_ll_parse(), rsize (shid->desc.report_descriptor_length) is che=
cked
> against HID_MAX_DESCRIPTOR_SIZE, but not for zero. Later in the series, t=
he
> commit "HID: spi-hid: add HID SPI protocol implementation" validates
> raw->rep_desc_len !=3D 0 in spi_hid_dev_desc_response(), but if a device =
returns
> a REPORT_DESCRIPTOR_RESPONSE with content_length =3D=3D 0 (shid->response=
_length =3D=3D
> 0), spi_hid_report_descriptor_request() computes min_t(unsigned int, 0,
> shid->desc.report_descriptor_length) and returns 0.
>
> Both spi_hid_ll_parse() here and spi_hid_refresh_device() in the protocol=
 patch
> only check if (len < 0), treating len =3D=3D 0 as success.
>
> When len =3D=3D 0 is passed to hid_parse_report():
>
> drivers/hid/hid-core.c:hid_parse_report() {
>         hid->dev_rdesc =3D kmemdup(start, size, GFP_KERNEL);
>         if (!hid->dev_rdesc)
>                 return -ENOMEM;
>         hid->dev_rsize =3D size;
>         return 0;
> }
>
> kmemdup() returns ZERO_SIZE_PTR (non-NULL), so hid_parse_report() returns=
 0.
> spi_hid_ll_parse() then caches a CRC32 of 0 and sets SPI_HID_READY, and
> hid_add_device() sees a non-NULL hdev->dev_rdesc and calls device_add(),
> registering an unusable hid_device while bypassing SPI_HID_ERROR reset
> recovery.
>
> Should spi_hid_report_descriptor_request() or its callers reject a 0-leng=
th
> report descriptor (for example, checking !rsize in spi_hid_ll_parse() and
> returning -EINVAL when shid->response_length =3D=3D 0 or len <=3D 0)?

Will fix this in v7.

>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-send-ups=
tream-v6-0-cb9ba4b3d6fa@chromium.org?part=3D4
