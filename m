Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781B5541E68
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 22:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929235; cv=pass; b=IPWw4WY5+ouz2xlRk7uywPJUHn1cvl4tfbXOmz+23BQR8n4zj/I0DBNgIEhkZXw2fRH4z4WREyCZ5s/Twxq9Pfi7sXulS/aZsp3UUARf2f6BXRqS2kPtQc04Ww1sI32lmUnXi24p60kIHZVQgytmM70BtSh6eCHhvznHeHBriTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929235; c=relaxed/simple;
	bh=t3LBPAFHnhQ1u7O0ECQtw6w9DPC/4CEOsts9RgS3xwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=al80sZE5Xr9oQ+W+e3rOyWr+tjVqOppaCrYYiqU9/u6YKu0YbBN9iH4ytEAKHtoRY8sWu0n1DFomJ2NpuIRgPPv5mYiiNPptmyMVXx/M7d1rRGOQ916SzRFl2nmT7/9bv/7LZznGMpe6YzRcjxANYAyBljMB2mqSfaJlfE5s6AY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ey6DWjkb; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ey6DWjkb"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b094046a7aso8764687b3.1
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 15:07:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791929232; cv=none;
        d=google.com; s=arc-20260327;
        b=EBlULzgPEG6c6McMktCBQHV2IW6QkgcWdOt3CaGA9+7y/6jKnTHwImmYcxno/kQzD1
         jv9Q9CMAA+KGBTLb2Qb27T4zuZM8jinDFh0PUf8DuUXi5qbWuZmSaKYlOtboTp9EQcrd
         /n56VDTOXKHutHtaw0gBXuivNXS59l36G4rBpyU4oXuDl7qFnZssuKVLEvtxWDcAq6D4
         qLYHLqw3bmzbf6bd2Cc+NtwqWTpV7MZpMGXnMsaTZ7IDevZS9pTXW7H4aJwgLOQ+uhiP
         irdjckEAcw7vN9p2QuQZo6nud2iXdN4lGhYvTlm2Q3MTxHFmuzkb+am80JphNr8txy2l
         nx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3V04dj+1E4Q2ne6jooiMIXl4K+a/cJClSlFVSPgO3gA=;
        fh=+Ud4t0jQNB0Grc1UwDC1Mmj2TglxI4CHBh5rN0CzddE=;
        b=hah6/3/VY/zo/y5dxQQKHsSNudmhKUCgM60wVJA1h7Fwel+1ShXECpwLHhgFr56/0z
         gf6PBbphCWV1fWx7uUytiQJUkGrJCyvyZTGVOtcPV43lLv1b4lbBSNuSR1lIQBkuUKWw
         CcHUjRu1qTIO51e4eZiOaRDDBlq+YSrRZ8bdBTjJAd+dMUnpQOkgeicZd8hs0vKdNLmr
         NsQRAbdLmlDE69pwGwpKTMjgGJ7H8Zw/dgN0ZRe5XZ9nByAq+UC1P3KkkPOoHkgUJhmI
         USn1QBv+cu6pFvMP5Stuu2vyyuYpPEuToXJ3Rg4U3PjA42a4JRzYGlrL8wRuzThXkd3W
         aUcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791929232; x=1792534032; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3V04dj+1E4Q2ne6jooiMIXl4K+a/cJClSlFVSPgO3gA=;
        b=Ey6DWjkbOIyawtqs6Gaz6LyujBWqXV2JJ0avzsShdblSrHTzy2K63aUSbRMBPxIBRh
         xrcyPJ8X+yw8A6U7nFuOR1mlne4DsiOCq/2POVGTcWi3Yf811m+4i6jkdSRjzWavacVy
         DWBYm0oafBtwftnG3SDqlHLfemjNcD+xLuBnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791929232; x=1792534032;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3V04dj+1E4Q2ne6jooiMIXl4K+a/cJClSlFVSPgO3gA=;
        b=x/KdiJ+4BOPKNxtl0mFkhH1V8erVk5yfQ0mthMNmo+L4TySpwz5t/o8zEHbaSG36O8
         v7p3N+ilH2YhzDyGW3vDoONezHSC78BgRia+VHJwwKBPqUDWx4G4U/nQS0vlCSpnT2oW
         3RqOJ3mRee5FVPT6/ir9Mzf0F+VkCKxKEi35OxQSetvS/eLDgiCAV7/9cxHOU57MgwP7
         hFnRjc6TMPIOwFacghIxChau7WOREOuf8s/Frqs1d2y/dBm4kiShEwM62m/XasP9iSrG
         mxXiGk5TCa47hqqCCl+ZbwWt56OcflTtQLpdpB+IAcWewJ3L2x0R2TPav4A2e8cCYksx
         bAjw==
X-Forwarded-Encrypted: i=1; AKwUvByxv7AbUqm/FTj0XKqewAmLo+HUDiWxsu29jhbe7Rhr5vbP8g/aXBeg0ArVkihg5fLTsHjxw5xCN2b/4Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYJbTYQCkoV/tRxUuBe53ZAbox9uhaakU8mHD3RXWvJQbvSdCt6/
	X61U/K5fB3Gwy/9KIc+tNBmujGZuCdSkJ52jGmUPwxQ+PdLuI22PshCMwn24Z6clxGiiJuCUTIV
	etVglc1rfippbEjWvYiIROkZ32mfTU4uY139hfj040WSTL9CojgzsCA==
X-Gm-Gg: AYBFou0cXHuIOP+/OI7q7T7pn0tBHI58be5RcWgbiF0QpTos5OityQG2vv515ydA5m6
	19HjjPLMbUOldpZfrdW5sMNYlP/TRLfMoeAtrYEGPygnORBXX3QESqf2qQ2hNHyp+vYfLXHOwNm
	20bOzRimLJ7olOR8GXecx/Bjor5QOLJm8kSUzbKhqBvbyk5odPBfw6HYehOHK574eoMN/dtAA64
	wERB/3WQVGAKWM6ZLRydTz1w9/VAJImfa1TXbCnaUZoCs/9zIxL33LgQcBdCX0di1i+AZolwY1B
	6kbffG/yTW1LkQsXSgnyyYNyxpBC9irtNhOI7PxZnECtHtrxNBY06X1XC7joxhVYFkz76Zlro4n
	nRz5o5ALjWgw=
X-Received: by 2002:a05:690c:112:b0:8b0:b12d:6c3c with SMTP id
 00721157ae682-8b0b12d703emr16903837b3.43.1791929232182; Tue, 13 Oct 2026
 15:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-5-384af01da3ee@chromium.org> <sashiko-outbox-166153@kernel.org>
In-Reply-To: <sashiko-outbox-166153@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 13 Oct 2026 15:07:00 -0700
X-Gm-Features: AclHuK8JEhgVWod97Oeyuxy5mtDaH6c72Kz69Kz8EDN-ZL4874rxGG-gecFiSkY
Message-ID: <CAEe3GZFWJ45Up6=4UbW=MQAPmc3BEdVHqkMYnDM3FfNYvuFRjQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/11] HID: spi-hid: add HID SPI protocol implementation
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	conor+dt@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, 
	robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 3:42=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
> - [High] hid: sleeping in atomic context via synchronous output_report
> - [High] spi: dma: unaligned DMA transfer buffers cause memory corruption
> - [High] hid: spi-hid: use-after-free of transport buffers on concurrent =
realloc
> - [Medium] hid: spi-hid: SPI_HID_REFRESH_IN_PROGRESS breaks hid_device_io=
_start() during probe
> --
>
> commit 4647f83267b811c038d6b541aee03ea186664da4
> Author: Jingyuan Liang <jingyliang@chromium.org>
> Subject: HID: spi-hid: add HID SPI protocol implementation
>
> This commit adds a new driver for the HID over SPI protocol. It supports
> basic input and output reports but omits features like multi-fragment
> reports and power states.
>
> > diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/s=
pi-hid-core.c
> > --- a/drivers/hid/spi-hid/spi-hid-core.c
> > +++ b/drivers/hid/spi-hid/spi-hid-core.c
> [ ... ]
> > +static int spi_hid_input_sync(struct spi_hid *shid, void *buf, u16 len=
gth,
> > +                           bool is_header)
> > +{
> > +     int error;
> > +
> > +     shid->input_transfer[0].tx_buf =3D is_header ?
> > +                                      shid->read_approval_header :
> > +                                      shid->read_approval_body;
> > +     shid->input_transfer[0].len =3D SPI_HID_READ_APPROVAL_LEN;
> > +
> > +     shid->input_transfer[1].rx_buf =3D buf;
>
> [Severity: High]
> Could this cause memory corruption on non-cache-coherent architectures?
>
> The read_approval_body is a 5-byte array that immediately follows
> read_approval_header in struct spi_hid. Since it starts at an unaligned
> 5-byte offset, passing it as tx_buf to the DMA sync path violates
> architecture DMA API rules.
>
> The rx_buf parameter also receives unaligned memory when buf is passed as
> shid->input->body later in the IRQ handler, which starts 4 bytes after th=
e
> dynamically allocated input header. This can trigger CONFIG_DMA_API_DEBUG
> warnings or corrupt adjacent memory.

I don't think so. The read approvals are TX-only and never change
after probe, and the RX body only shares a cacheline with the input
header, which isn't touched during the body transfer.

>
> [ ... ]
> > +static int __spi_hid_send_output_report(struct spi_hid *shid,
> > +                                     struct spi_hid_output_report *rep=
ort,
> > +                                     u8 expected_response)
> > +{
> > +     struct spi_hid_output_buf *buf =3D shid->output;
> > +     struct device *dev =3D &shid->spi->dev;
> > +     u16 report_length;
> > +     u16 padded_length;
> > +     u8 padding;
> > +     int error;
> > +
> > +     lockdep_assert_held(&shid->output_lock);
>
> [Severity: High]
> Is there a potential use-after-free here if the output buffer is realloca=
ted
> concurrently?
>
> When the HID core calls spi_hid_ll_start() dynamically from userspace or
> BPF, it expands the transport buffers by calling spi_hid_alloc_buffers()
> if the report sizes have increased. This reallocation uses devm_krealloc(=
)
> to free shid->output and replace it.
>
> However, spi_hid_ll_start() does not appear to acquire shid->output_lock
> before reallocating. If a spontaneous device reset interrupt schedules
> reset_work on a global worker thread:
>
> spi_hid_reset_work()
>   spi_hid_reset_response()
>     spi_hid_sync_request()
>       __spi_hid_send_output_report()
>
> This path can execute concurrently, accessing the freed shid->output buff=
er
> under the lock, leading to a use-after-free when writing the header and
> payload.

Thank you. I will fix it in v6.

>
> [ ... ]
> > +static int spi_hid_send_output_report(struct spi_hid *shid,
> > +                                   struct spi_hid_output_report *repor=
t)
> > +{
> > +     guard(mutex)(&shid->output_lock);
> > +     return __spi_hid_send_output_report(shid, report, 0);
> > +}
> > +
> > +static int __spi_hid_sync_request(struct spi_hid *shid,
> > +                               struct spi_hid_output_report *report)
> > +{
> > +     struct device *dev =3D &shid->spi->dev;
> > +     int error;
> > +
> > +     error =3D __spi_hid_send_output_report(shid, report,
> > +                                          spi_hid_response_type(report=
->report_type));
>
> [Severity: High]
> Does this sleeping lock violation trigger scheduling while atomic warning=
s?
>
> According to the HID subsystem guidelines, the low-level output_report
> callback is used for high-throughput data on the interrupt channel and
> must be asynchronous.
>
> When spi_hid_ll_output_report() calls spi_hid_send_output_report() or
> spi_hid_sync_request(), these helpers immediately acquire shid->output_lo=
ck
> (a sleeping mutex) and perform a synchronous, blocking SPI transfer. Sinc=
e
> the callback can be invoked from atomic contexts (like updating LED state=
s
> from an input event handler), sleeping here may cause panics.

No. hid-input defers LED updates from input events to a workqueue, so
->output_report() isn't called from atomic context there, and USB-HID
and I2C-HID already sleep in this callback too.

>
> [ ... ]
> > +static int spi_hid_input_report_handler(struct spi_hid *shid,
> > +                                     struct spi_hid_input_buf *buf)
> > +{
> > +     struct device *dev =3D &shid->spi->dev;
> > +     struct hid_device *hid;
> > +     struct spi_hid_input_report r;
> > +     int error =3D 0;
> > +
> > +     scoped_guard(mutex, &shid->io_lock) {
> > +             if (!test_bit(SPI_HID_READY, &shid->flags) ||
> > +                 !test_bit(SPI_HID_STARTED, &shid->flags) ||
> > +                 test_bit(SPI_HID_REFRESH_IN_PROGRESS, &shid->flags) |=
| !shid->hid) {
> > +                     dev_dbg(dev, "HID not ready (flags 0x%lx), droppi=
ng input report\n",
> > +                             shid->flags);
> > +                     return 0;
> > +             }
>
> [Severity: Medium]
> Will this prevent drivers from receiving input reports during probe?
>
> When spi_hid_refresh_device() is executed, it sets the
> SPI_HID_REFRESH_IN_PROGRESS flag before tearing down the old HID device
> and creating the new one:
>
> spi_hid_refresh_device()
>   set_bit(SPI_HID_REFRESH_IN_PROGRESS, ...)
>   spi_hid_create_device()
>     hid_add_device()
>       -> driver probe()
>
> During this entire time, the input report handler will drop all incoming
> reports. This conflicts with the HID core API contract, which explicitly
> allows a driver to receive inputs during its probe phase by calling
> hid_device_io_start(). A driver that requires a firmware handshake or
> data during probe could hang or fail upon device refresh.

Thank you. I will fix it in v6.

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-send-ups=
tream-v5-0-384af01da3ee@chromium.org?part=3D5
