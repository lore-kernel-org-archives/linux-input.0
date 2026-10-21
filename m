Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792621008;
	b=Rm86U8GEOHxJ68vJfcJUMdIosuSphA9NzdoEEGp0uAphyWRWUqw4zzCojxmf3USIiFy/
	 wHeH7965OjkU03N5Vlf3Zi2Wq1vzajK/P32sssjKxAQnHXr1c7tDJYFESJPgMwQ74+b2I
	 59S4Hd8sfdRa3KaaE+C9jO1t/hescFt58veMi3maIV2jfZyeL0oALpkLf2THta4oB9Rzl
	 uJO/0g7/pcloSHsEVRQD6nETbcnEjZC29L33SuYaphHLjvww8gANS3xverGvTE+3frmdA
	 sgSY+QZEPQgTu/9ly/yC+jZwliXKvY1oxWdY5xk2fx858GMoQoHnW14GYxZSNQNwF9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792621008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=pBxmybFhraH/PZu9TzxWt83yv/Plj5oQ+sfyrvjnp7k=;
	b=urmHg3KdHGhcX72PE78uV7w0L9pHtV24WvPjAceDHvlHl3uubXx7cLq9OVPpLt5HM9zV
	 SP7uLP2TcjVnTvN5p14BR1fhDH2Pply2SnEc1NYijhQVhIQ5uEPI6peOflOmrG9GnUI3/
	 0EEjg0WxdJbpfJSF5nJ6AZtKlev57p18wIKl5IS2o1ecY7h+rDb5YYjhIIWy/34RDQ9JA
	 D39sl5zUzpLekKbLmxsMNhKpN3SnIjRYDoSvXdocmWoYkFO9gLg6NjvKKy8z0bHfnwauH
	 iE+YWs1oL4XQXK6ZwWjg+fkUI0k24p05fTxSVCjyTONajBgwhmk7mzw4/xxLM34BzTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Pp3zPBI7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32030606A327
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 22:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32030606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Pp3zPBI7
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6767d92cde6so1216391d50.0
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 15:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792621007; cv=none;
        d=google.com; s=arc-20260327;
        b=Fy/DIfP2/ZW6woSr0216JIR3VTGqvv4iuN1mjZn7zj1tKkvMYUlo//44+50cS7s19V
         nUrAtcLO5/YrzsVGZjVbbs+snO+1bGVRMis+xuTA8TbNMNTQHjxlaSVDJVMCv/GYUhap
         hs1BArPBpqEn6WPQuMkFd4Da4NXFoTAM3D9aSXicTbzsIH0pae1raIb0PEj3w/xgWNiq
         sNyetr9BcBlkwtkDp4irTHy0YVyCelDiUc3BUqNMCW7qMG1qFdqUp2raX8fQn/x3Nh8B
         Lgtyq2croD4V8SQxqPVJY33jlgD+ZpheEzqAyOHLVF25xeJ47YtH7cdd5663oxuraZ74
         KyFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pBxmybFhraH/PZu9TzxWt83yv/Plj5oQ+sfyrvjnp7k=;
        fh=osfj9leewLfc4MqIYaUjfG4KfpRUNqFnByXZRUnRoVs=;
        b=Ws50PGTw+k4/RI8wskvmSggEpQyKH0GfAQ365NhxPrzLi4en0o3+/X+/W8IB2SXz3P
         6+m+xbgZNwCBM4aADEmtlZuvd0VSL8vSiJ3q6JxESInIcisLS8tQbelJ4H03LVlN1iQ9
         OIg7kBh7Ki04s9B+SVjcIaaODuVuE5VNOeMih2onJd0U9S1Nq551+ytYgc2/ee87v6hp
         JDZjU/4hMUtFQQnpASp0kS0IdHrAalgYy1rCMmWjxBsw/5ftJGo9OSV/QGTWvRaHPTt2
         4FLwnp1hIuW8IOGE8zP/tAdq5cep6ECI32uFWWbT6/EnDPP0Q5G7XwEbZcDBcuhhpdwf
         5kgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792621007; x=1793225807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pBxmybFhraH/PZu9TzxWt83yv/Plj5oQ+sfyrvjnp7k=;
        b=Pp3zPBI7GONExxATnfQd52OQh2njdUvt29F7MQp/AEVn70HzNcoaPB4/yDg8KSOeLq
         7wfrAe7ITktoLrUPAlRn2bXTEEP+lCh5VC3UG57EE8x/1HrBVgZUuwFgvxtiwwCITWnx
         k3x6DEkwQMjRO/7/TY5b4wQnKs0Yrbk+/XvFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792621007; x=1793225807;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pBxmybFhraH/PZu9TzxWt83yv/Plj5oQ+sfyrvjnp7k=;
        b=HZQ04q1phD8/vQGzGVlMag2EEg3UqcZt5EkCX4fEZwXt2omYJbabaQm8CAv3ZwMhxK
         Ns+T+jmV7ZzjdmuaiO0JzQ4RobM90/hyj+Q6jd6cxU2VObaHbwst6gzXpDWN0nL+tgen
         wQffbn2HK1TQ5UnvYgXyTo+yCdmdP6ILzQ4c/qF7IRP2BhD60Zaz/ZxYfsgwSm5DeGpW
         k1RqnCGxu88s5wsXOrv+bei5JZCsp05VWszvfKF7jAmZVoURdBD0KzOHQOWSb45dCIMt
         RKhYo5z7CvNJNpN6oHo2NqIbsDwVZUKm29bAUCvtkVduI410U/edeOEFT0q7n+H6qkRV
         88SQ==
X-Gm-Message-State: AFq9FYLDQpCanT8pk0nXOJaW1h946PhuESQwUIUsHRyVfbJJDZ2h4EIn
	+VxGGjx5i1uaDhW1+K/2B+l7Blvj9OBAbh0lwAgxAGXRXX+n1D2GnbTxAnWlu/ScR8glyQBgdmm
	EmDyxNHu4+ozRO7SZu0PvZc7vQyhq+SlwuRVNwwHl
X-Gm-Gg: AYBFou2y8lYrADzNWlPwnSlTJQdizTdLVJBpDWjQK72rw63x1eyNRbsDACuBZe+5TWK
	yshneJb1gWMY8d7PCR1qt+FaU4kdHG4DSLnyz9XPBeYFrWkptqf6MyiOkgzhhdBiatQyR20uGYy
	jnlR3zyxYgpl1X8cs9MsYYanRxj/+xvmytXNCIxBOX5L8kFOqSjpFUVrd30/H82tbgLUdlc0FCA
	84/r+rOuQUqFBjLAKL6FKaCr2VCKsQA845ikobeXrNpE99TwdWMeZGBvJdXQYCt7Li4WLiLJu1a
	TjkN26O7+/1FHEsOCK2UuHdn3+2mUkZCfeNyJ31KXs8u8iRl5EUFtb0t+quYYyn9Jjy/gBhkxUA
	PLjs3N44v6Cx7ty7GZI1ybcaEpHZGHujt5BFZObYxcddC9Nu+RzqgcxUpZ24HED3IXQ==
X-Received: by 2002:a05:690e:14ca:b0:679:938d:a5e1 with SMTP id
 956f58d0204a3-67a0e5d5717mr1652923d50.106.1792621007076; Wed, 21 Oct 2026
 15:16:47 -0700 (PDT)
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
 <20261019-send-upstream-v6-3-cb9ba4b3d6fa@chromium.org> <sashiko-outbox-178136@kernel.org>
In-Reply-To: <sashiko-outbox-178136@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Wed, 21 Oct 2026 15:16:36 -0700
X-Gm-Features: AclHuK97y_1C_fXZ7yRJHnp3ya3ECqu5ReTQG8sTLOF0eRq_fLLRwG53TU5NjZo
Message-ID: <CAEe3GZGsfB+zi3Qf6buPWP_3hkw9bsd4mB=PtBrp4irtM5Z0zA@mail.gmail.com>
Subject: Re: [PATCH v6 03/11] HID: spi-hid: add transport driver skeleton for
 HID over SPI bus
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 12:11=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] HID: spi-hid: multi-value sysfs attributes and missing ABI docume=
ntation
> --
>
> commit 4c66f3d16c395b79d0997b29357fb80b5a6f2708
> Author: Angela Czubak <acz@semihalf.com>
>
> HID: spi-hid: add transport driver skeleton for HID over SPI bus
>
> This commit creates the spi-hid directory with its Kconfig and Makefile, =
and
> adds the initial core driver skeleton including basic device structures,
> sysfs attributes, and probe/remove functions.
>
> > diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/s=
pi-hid-core.c
> > new file mode 100644
> > index 0000000000000..02a7608c4b882
> > --- /dev/null
> > +++ b/drivers/hid/spi-hid/spi-hid-core.c
> > @@ -0,0 +1,213 @@
>
> [ ... ]
>
> > +static ssize_t bus_error_count_show(struct device *dev,
> > +                                 struct device_attribute *attr, char *=
buf)
> > +{
> > +     struct spi_hid *shid =3D dev_get_drvdata(dev);
> > +
> > +     return sysfs_emit(buf, "%u (%d)\n",
> > +                       shid->bus_error_count, shid->bus_last_error);
> > +}
> > +static DEVICE_ATTR_RO(bus_error_count);
> > +
> > +static ssize_t regulator_error_count_show(struct device *dev,
> > +                                       struct device_attribute *attr,
> > +                                       char *buf)
> > +{
> > +     struct spi_hid *shid =3D dev_get_drvdata(dev);
> > +
> > +     return sysfs_emit(buf, "%u (%d)\n",
> > +                       shid->regulator_error_count,
> > +                       shid->regulator_last_error);
> > +}
> > +static DEVICE_ATTR_RO(regulator_error_count);
> > +
> > +static ssize_t device_initiated_reset_count_show(struct device *dev,
> > +                                              struct device_attribute =
*attr,
> > +                                              char *buf)
> > +{
> > +     struct spi_hid *shid =3D dev_get_drvdata(dev);
> > +
> > +     return sysfs_emit(buf, "%u\n", shid->dir_count);
> > +}
> > +static DEVICE_ATTR_RO(device_initiated_reset_count);
> > +
> > +static struct attribute *spi_hid_attrs[] =3D {
> > +     &dev_attr_bus_error_count.attr,
> > +     &dev_attr_regulator_error_count.attr,
> > +     &dev_attr_device_initiated_reset_count.attr,
> > +     NULL    /* Terminator */
> > +};
> > +
> > +static const struct attribute_group spi_hid_group =3D {
> > +     .attrs =3D spi_hid_attrs,
> > +};
> > +
> > +const struct attribute_group *spi_hid_groups[] =3D {
> > +     &spi_hid_group,
> > +     NULL
> > +};
> > +EXPORT_SYMBOL_GPL(spi_hid_groups);
>
> [Severity: Low]
> In drivers/hid/spi-hid/spi-hid-core.c, bus_error_count_show() and
> regulator_error_count_show() format both an unsigned error count and a si=
gned
> last error code in parentheses ("%u (%d)\n") into a single sysfs file whe=
n
> userspace reads bus_error_count or regulator_error_count via spi_hid_grou=
ps
> (which is attached to .dev_groups in the later ACPI and Device Tree suppo=
rt
> commits in this series).
>
> Per Documentation/filesystems/sysfs.rst, sysfs attributes should export o=
ne
> value per file without custom formatting or mixing types, and new sysfs
> attributes should be documented in Documentation/ABI/.
>
> Should bus_last_error and regulator_last_error be split into separate sys=
fs
> attributes (or moved to debugfs), and should Documentation/ABI/ entries b=
e
> added for the attributes in spi_hid_attrs?

Will drop these attributes in v7. Already reported via dev_err() and
tracepoints.

>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-send-ups=
tream-v6-0-cb9ba4b3d6fa@chromium.org?part=3D3
