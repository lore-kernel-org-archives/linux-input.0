Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03443D88F1
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766228; cv=pass; b=pOWA4mBFWoTOGL4NZAE6dcJ+czZpYBu1SeMLgGXHAUJ3bO/5RVgj9JfIeSbbwmpIWbXPcdtrVnCSaYT8jwenPzkBm0Ij+jGd8sGBx7ekavvFB7EtnT9FW3sEvzhL265sy2vlyDRMh0gNC+ZiE5pSjyWqFCXH4myULTt02wDtz7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766228; c=relaxed/simple;
	bh=7Te0NodCkFdHORqZUiD6i1pe12tICwk/GjW2CLYy0sM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F2xF2xuvg9GZCXFYqyR2QKK/WCr5GJErMBULvz9AI2ExzCzHlAaiDhCXMrkzcDI/wgfke2gYUTOGP5nGgnQ4VLdte+Ike968j1RCJrUd04Mj1Chh11fBITAPd8POb3XSw80jZA8BDkUQLov1Ds37Bxzl410VpA3gN05HpDYUeBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBAiq4ar; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBAiq4ar"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8b62ca1d28eso71747526d6.2
        for <linux-input@vger.kernel.org>; Thu, 14 May 2026 06:43:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778766225; cv=none;
        d=google.com; s=arc-20240605;
        b=LJm1YGrvp83UvfCiiOvHouicUHOrL4dl+uhB/k2ZVdbjwezOhC4Srz4ntNMrlOAZco
         6iIUGtS/cX5JtW76rG/xqIh0QsAYjz+w7c3HoNUMlF3lZhClW0/sVQE6gjHESJu09ocI
         H96xkwN/CreC3Eo9KTqqpfWt3G6HzM8FvtHtiEHgpBC6PfxRWHpV1dCScc7dx8IcezPA
         tsyfeeKxJLel5xN7uex79h2r/TMPN+AvSbpKnr/1JRBzaTJsTR4cDF6ZKOY2HFJkPeSC
         telKw+8FhzOM+EhdLoithxpX0X6VPizBRZ/eg7jl2aJr0kNphAse5Sqr4ZbcANmsQ1tc
         ETpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eVd32T8J0fLOjF74ku1BQ845h9heIFsBXaPWaxr8uII=;
        fh=dfvPRi+t5KvUF1qpgNVmacxvd83mvku6fE8K+/2kbH8=;
        b=R6MRXxQiuF2cjpsKSRbSOa3SKdBNchmhRbCGAdQ6dW8rQK+B0CdkR5LWgJq84Wl2HV
         Gqw27nxUzS1YpadRGfmC5asPppDtRB60UpF40owjknwwmzeqikt5yxEBsQS+tGSTBPWz
         foRJlqVUFlPx9xq8JlUn7gYj9APyLdWoyT20Lz/BI+RwVmr2aeHg41p0W8IOJhSfah4v
         t0e23Ykutt4//5XaJro0N3nDLu8pRionkX43ignl0Uj7z/WhyFXpt2Lbzx4444n6ncKE
         ItHdTVGi6GsjKVcLLXZoQOj4xsnv/eNrGZSzOv4LfKz3dOPWcxG9MalILtsfaC2Vhs+B
         5EpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778766225; x=1779371025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVd32T8J0fLOjF74ku1BQ845h9heIFsBXaPWaxr8uII=;
        b=IBAiq4ar7Cmf2KY+0Ni17bY8deaFQCyP5VHK4QXPicaNMqrYKHKPe3AxGYOlwDEKnI
         o8flkzsq1aocD3mpzv118a6mjQBevNrGnN69RIdT16KRZ9CKAtSAgHBscAgCD0IPKNc+
         Qf/0tE1qfDlulpykrumufRdAWZhjCaXwXuEiRp3EpOiCKglnUXjxs09bz4supVJFb0yT
         +gVaveHP74eRGKZKvd9xLALoauCgNoextLxqPHoU49922/7U3A9V+3ED5VBJFt1WWOtx
         7QPfnBlqV9FkRw5BmOtN9AqHZFrVhdtkBL3URLKdEvdCuYAsyZlurIgVE55LD8Ydxqec
         5G9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778766225; x=1779371025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eVd32T8J0fLOjF74ku1BQ845h9heIFsBXaPWaxr8uII=;
        b=ZLUgQhFED7kEWs+0Am1BnLz5awt+BBOKouGnE0V1FoamR1qzpXMqLDqsLlwTh66hZI
         fgOWADNLLR1GOCGVeBlsDUdtp6m51JpvhU0WjxJxF7LkrkTZxJ24tCMKqrERe+74ZsA1
         52XcnDQDVEPCiqfTalSa/+Qg1258namc+vjjnPYQled5pdtIL8E3iemquTTvN8SJ2lYN
         LYgytht8F9YOsX+aH4JrfilJYVGD6pyVQgQZaEyW48vgmOZ3GxPd+o7rVPaUHVelbDIt
         I0qd/oeyNCAa93CrMZVP8RwXxids+E6OmmMeNkg0S2JCosJQM4dU7AbNUIzxb3mOSGLS
         bFNg==
X-Gm-Message-State: AOJu0Yx+1Vw934fEPxHDoHqjjq5HwGbIs5aX8nnT2C4xfN+TzHqeSo0R
	1e0sSZVR5Cn0Phk3HH2Z6v14yO8jp7pQQSTv2L5woNzLOYaOdTZewPEOqtHcx50QAkr4+OFt09a
	Ib5Hc1nZ1h4p6npoyWf3skEwHmvnq26J/WA==
X-Gm-Gg: Acq92OFzTe7BsKEa8AqONIBQ6k3n0mKdZPEEHZLGKIjHyZH5v2Ysv4APdFQwp+eqACi
	cFWd3mdw0bMD5d1hPCY3nlTdbEJWXME4iUstFjSTFuhupJf9YTc8tgtOHoRU7TTXBXEbMY1tGXt
	o76CJ93ju9duOJOHvN9xkBb8ATMPZ/r84pQTH9lV3a8DOxwLlHHunRTDQxhmHWqZcjr8nsME26w
	en5znrNbqpKclCu52I+2//J4+ynuQXdvTaV83urm7ZvE83TOvDSOoXE5I16gMbf2/AgeuUXkY4n
	3K4mx5NP
X-Received: by 2002:a05:6214:8008:b0:8a7:16f8:442a with SMTP id
 6a1803df08f44-8c7dfdbb90cmr106284576d6.39.1778766225071; Thu, 14 May 2026
 06:43:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513231445.3213501-2-derekjohn.clark@gmail.com> <20260514115126.BCAD8C2BCB3@smtp.kernel.org>
In-Reply-To: <20260514115126.BCAD8C2BCB3@smtp.kernel.org>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Thu, 14 May 2026 06:43:34 -0700
X-Gm-Features: AVHnY4Kn2jVO-U-moUNE1cgIf9WXF8fDYZ_p-TL1E_yjNHzpzQMvglHbSFs0OOU
Message-ID: <CAFqHKTmuupBLhQ5LGmDd+2qVn-0Gt3TnnHGmPp3-HiHq7tiJzQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] HID: hid-msi: Add MSI Claw configuration driver
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 4:51=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 5 potential issu=
e(s) to consider:
> - [High] The `guard(mutex)` macro in `claw_hw_output_report` is scoped to=
 an `if` block, prematurely releasing the lock before the critical section.
> - [High] The driver publishes `drvdata` via `hid_set_drvdata()` before fu=
lly initializing its mutex and completion objects, creating a race conditio=
n.
> - [Medium] An invalid, uninitialized gamepad mode (0) may be sent to the =
hardware during system resume.
> - [Medium] The 8ms timeout used in `claw_hw_output_report()` is vulnerabl=
e to jiffies rounding, leading to spurious read failures.
> - [Medium] The commit message claims probe checks MCU RAM address varianc=
es, but the implementation is missing.
> --
>
> commit 13b388de96d7484eee908adeed127e8086fc289e
> Author: Derek J. Clark <derekjohn.clark@gmail.com>
>
> HID: hid-msi: Add MSI Claw configuration driver
>
> This commit adds a configuration HID driver for the MSI Claw series of
> handheld PCs. It provides support for switching the gamepad mode and chan=
ging
> the behavior of the M-keys.
>
> >     Additionally, the MCU RAM address for writing configuration data ha=
s
> >     changed twice. Checks are done during probe to enumerate these vari=
ances.
>
> The commit message states that checks are done during probe to enumerate =
MCU
> RAM address variances.
>
> Looking at claw_probe() and msi_probe(), there does not appear to be any =
code
> that checks firmware versions or handles these variances.
>
> Was this functionality dropped during refactoring, or should the commit m=
essage
> be updated?
>
> > diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> > new file mode 100644
> > index 0000000000000..8915942af15e6
> > --- /dev/null
> > +++ b/drivers/hid/hid-msi.c
>
> [ ... ]
>
> > +static int claw_hw_output_report(struct hid_device *hdev, u8 index, u8=
 *data,
> > +                              size_t len, unsigned int timeout)
> > +{
> > +     unsigned char *dmabuf __free(kfree) =3D NULL;
> > +     u8 header[] =3D { CLAW_OUTPUT_REPORT_ID, 0, 0, 0x3c, index };
> > +     struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> > +     size_t header_size =3D ARRAY_SIZE(header);
> > +     int ret;
> > +
> > +     if (header_size + len > CLAW_PACKET_SIZE)
> > +             return -EINVAL;
> > +
> > +     /* We can't use a devm_alloc reusable buffer without side effects=
 during suspend */
> > +     dmabuf =3D kzalloc(CLAW_PACKET_SIZE, GFP_KERNEL);
> > +     if (!dmabuf)
> > +             return -ENOMEM;
> > +
> > +     memcpy(dmabuf, header, header_size);
> > +     if (data && len)
> > +             memcpy(dmabuf + header_size, data, len);
> > +
> > +     /* Don't hold a mutex when timeout=3D0, those commands cause USB =
disconnect */
> > +     if (timeout) {
> > +             guard(mutex)(&drvdata->cfg_mutex);
> > +             reinit_completion(&drvdata->send_cmd_complete);
> > +     }
>
> Does this drop the lock too early?
>
Hi robot,

Will fix.

> The guard() macro releases the lock at the end of its enclosing scope.
> Because it is declared inside the if (timeout) block, the mutex will be
> released immediately at the closing brace, leaving hid_hw_output_report()=
 and
> the subsequent wait unprotected against concurrent access.
>
> > +
> > +     dev_dbg(&hdev->dev, "Send data as raw output report: [%*ph]\n",
> > +             CLAW_PACKET_SIZE, dmabuf);
> > +
> > +     ret =3D hid_hw_output_report(hdev, dmabuf, CLAW_PACKET_SIZE);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret =3D ret =3D=3D CLAW_PACKET_SIZE ? 0 : -EIO;
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (timeout) {
> > +             ret =3D wait_for_completion_interruptible_timeout(&drvdat=
a->send_cmd_complete,
> > +                                                             msecs_to_=
jiffies(timeout));
>
> Could this timeout evaluate to 1 jiffy on systems configured with HZ=3D10=
0?
This seems like an unlikely config for a performance gaming system.
> Several callers, such as gamepad_mode_show(), pass an 8ms timeout to this
> function. A 1-jiffy timeout can expire almost instantaneously if the oper=
ation
> begins near the end of the current tick boundary, potentially leading to
> spurious -EBUSY timeouts.
>
> [ ... ]
>
> > +static void cfg_resume_fn(struct work_struct *work)
> > +{
> > +     struct delayed_work *dwork =3D container_of(work, struct delayed_=
work, work);
> > +     struct claw_drvdata *drvdata =3D container_of(dwork, struct claw_=
drvdata, cfg_resume);
> > +     u8 data[2] =3D { drvdata->gamepad_mode, drvdata->mkeys_function }=
;
>
> If the system suspends before cfg_setup_fn() executes, or if the device r=
ead in
> cfg_setup_fn() fails, could drvdata->gamepad_mode still be 0 here?
>
> Since 0 is not a valid mode (valid modes like CLAW_GAMEPAD_MODE_XINPUT st=
art
> at 1), will this send an uninitialized configuration state to the hardwar=
e?

I'll add a valid default value.

> > +     int ret;
> > +
> > +     ret =3D claw_hw_output_report(drvdata->hdev, CLAW_COMMAND_TYPE_SW=
ITCH_MODE, data,
> > +                                 ARRAY_SIZE(data), 0);
> > +     if (ret)
> > +             dev_err(&drvdata->hdev->dev, "Failed to set gamepad mode =
settings: %d\n", ret);
> > +}
> > +
> > +static int claw_probe(struct hid_device *hdev, u8 ep)
> > +{
> > +     struct claw_drvdata *drvdata;
> > +     int ret;
> > +
> > +     drvdata =3D devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL=
);
> > +     if (!drvdata)
> > +             return -ENOMEM;
> > +
> > +     hid_set_drvdata(hdev, drvdata);
> > +     drvdata->hdev =3D hdev;
> > +     drvdata->ep =3D ep;
> > +
> > +     mutex_init(&drvdata->cfg_mutex);
> > +     init_completion(&drvdata->send_cmd_complete);
>
> Is it safe to publish drvdata via hid_set_drvdata() before initializing t=
he
> mutex and completion object?
>
> Since hid_hw_start() was already called earlier in msi_probe(), the hardw=
are
> is active. If an input report arrives right after hid_set_drvdata(), the
> interrupt handler msi_raw_event() will process it and call complete() on =
an
> uninitialized waitqueue.
>
I'll reorder this.
> > +
> > +     /* For control interface: open the HID transport for sending comm=
ands. */
> > +     ret =3D hid_hw_open(hdev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     INIT_DELAYED_WORK(&drvdata->cfg_resume, &cfg_resume_fn);
> > +     INIT_DELAYED_WORK(&drvdata->cfg_setup, &cfg_setup_fn);
> > +     schedule_delayed_work(&drvdata->cfg_setup, msecs_to_jiffies(500))=
;
> > +
> > +     return 0;
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513231445.32=
13501-1-derekjohn.clark@gmail.com?part=3D1
