Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F78D2931F1
	for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 00:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792024573; cv=pass; b=u042mHekGkNVuBnYiGEFtusb5BHMmba+cMO/lduVQdVBV+fHPEzZRWLq7wLG3CJR93kTlDzmZJTQL6NcJNeHxNIjen37jEbJqMJ1Kq7AjnOFrgrBZsK+1hBUop06HtmD7qz/TsU+souy5KKNb28oV0wCzO2+j1tDrAdWtGHI5+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792024573; c=relaxed/simple;
	bh=xHIQ30qGJc+FXgEM5mQzAPKve3FI5FAHCGNtCGoOO8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ArJEgyIKFE5dyKr0hFQm+oQz6oyDK/K8Jev3h5qpVKmAd67fq4QiW5MROKDMHNZa9ClpDaG2OXKwpqAm+XT6GXqi9O5y/r605RIs94RBOCOb0CGD2eo4mnjvEFgzblnbEy99J2HTxmU92CwKRYVKeM6uoutAk5Jdw+axmsIN+1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiG6A87Z; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiG6A87Z"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c38ac26cc5dso289689966b.2
        for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 17:36:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792024570; cv=none;
        d=google.com; s=arc-20260327;
        b=Crmyx+SSOZVlj5WuJhYSAMpcttNrXd/+aYNe0pyvCJNMVO1Fd7EvNzGIXoMvM6ABAC
         0vsvzJK72BkG0AlyiqBm3frcfLITQt9DbKgG3cS1VSAijZ234vkGrTq3oE9/hEqJWAXf
         It8K0bk9NRRU7txGR1BAUFIdKJ7PAdMfVX4w5ZIK7e0PA042+rlL1RY2yMu8FtA74aHS
         hB8vZBZeWrx7QXMYDPfh5jOvP6DZhm2qLaIIkyc5xWwuezoi8mBFvYX9lDZMv5hM6KPK
         PfMBTEuTXQ05iMC7bXpDOFn6R8voIyRMdNSp+eL9mIEkHwRwpIwGPDH9lQ9WTT5WQt65
         e6EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2R0gXEt+P6rEHxwRyXuQ4nOXa7nTp9PwrTLPEOwbe5c=;
        fh=F8KxOAG42m49DkOOKUvcX/0gr4FhtM1VnwvAnTcQKO4=;
        b=h/54yo/bmBgYeJBxYw1DPk/PkJqBWbqeG0LwOnc6BbpDUw+ZoAKZMZfZ9KueQjqcFy
         RjRTs0CEOzYM1A2w8gkOIku91/UvOdzrrq94pJi09pNg8bnBpUQCBnHAAh/W01p6LM+5
         kWBGu3lq8sAcUvmEhx42YUbMFs0pvgpEo/ARJiyiBMIbjBueQPwrVOtooxbOdP+op2QO
         rfpEC4UdGkZTaSZeemA9/OPRiO8sj6is9gQVTxXyqK2dyI5FszhL1cgP4wJZul5sxYRe
         9dEqIob7cfLLcb6XfSaClqbJssIvuWJxh+o9WChAd1NSHlgnS/q8+g1vZ+9tOIaSCuFf
         4YwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792024570; x=1792629370; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2R0gXEt+P6rEHxwRyXuQ4nOXa7nTp9PwrTLPEOwbe5c=;
        b=KiG6A87ZEMWBQLulzKOGegJeEJrkS4oXu2+hlLn0D0SJ3jdPiEWUNZKGezyhT4NEwc
         oAIsbpVf4ynGOTsdJ0C+qjy/ZewD53H1ZRxYojrf1pyl4d+Z2DaJNfSfJrrYOxhsSela
         R+udcSomWV3GGZbEdH+XC9qoQkCwG1COIuLIAfNI3mGnYoZJubOzQq3S1d8pW9hUzE89
         mNx/4vFfqwKrCgUOxwIoKQAKtQpBWrxPTwUGSz9sOgjsLGizIY/Ary7/NAfHE96dbkQN
         ciK7P+NdpojkB1O/Gk6DliWgjyPtoeUvoUF8WE9Qatl0nQGOHWJVuSKd3amhzXkvu3Kq
         Zm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792024570; x=1792629370;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2R0gXEt+P6rEHxwRyXuQ4nOXa7nTp9PwrTLPEOwbe5c=;
        b=Vw1yrS/Yt1QGby0MOLUReX5ZyHbZ1S6JxRIHJ2IhP3yWfVJooJXl1W8lZw6OFtLlZX
         G/ZzPwgETKnYyK6+zz00NckkUW+EWUbjxqn3nkyzN8Jim0NFfHgBmUpY7tgPWJe746Lo
         dvkTxseiO1ZfIKwb5OMaorNC1FbNcAq602u6n6VtbkH8ku2WE5bfvvSA7vpBik6qWDIw
         JVgE+RtBkr8wYRI9yvQPR5EftcxXKgzSN/muJn2bWjAOSQ46nl4fkVTUwRC5L8DMWVoI
         oRe8wYKofPqbH+zzht1+h0tbVbzD2rFMu80zbqbgu4tW+PaTfwVXvbgtykdvEhqEQ6/0
         VeKg==
X-Forwarded-Encrypted: i=1; AKwUvBx8IaRxKcUtY2tvqpwGgvpPrIzJ7v34UFdgmVNNhMuFP+2f/9gFjh4aU6GSePHb3IMiuMuFOZ3z/qbWow==@vger.kernel.org
X-Gm-Message-State: AFq9FYKCvp379JaP2OKy+3Ur/e/Rb+gR4grfSSgCxBPQpgwEdRum8LJy
	8BTvHDMpDHH8QrQY6q+QMmbPuKQng0Ed4XqtagbEopBvV80WFL7GVWNZZiSBM/OQTu9SXJdFxNS
	V4D7rc9Vap1HQG26+5RQ1gMTlD8jM0A==
X-Gm-Gg: AYBFou0dmoNJbSReh01tRQaof2NpZXyz43yTzfgxTpoJ73hGxTxM3bp2DEMVJDZxp/S
	oRU5cnwjJzE9lA6U6Da3xqr73Fed9q+jWQodQQYVfxvV+M+sCLnldcFReGSWriAJ2v3zpzTPuZh
	tGx/YOpRz+QfifrJR5B3VnMlg7RftH4ZnlnqgpQ1OuXljHv/u0lxPgqzxHIUMT805Vqlc63tjDl
	i650d+SlajOOBoNH2EpZS8PFb8sBzu2zPRFg4SJmPCoGQeBbK217XdsPm+tQDQI3xQSq0NfsJSa
	1wQV4ANV6VpYDuoQhSXR4KIztzFPjZEI/L1TfBGetTH/0FAyeyruvY53yht/HUoGB6k01cyFLsL
	JWajHg8satxnz2UNr1IegmpMO0EtyHPhjkS6pZ9iaZVwq2H73/Q3ZzXitL+HYZQO8/IISYn8Wwp
	R93PI=
X-Received: by 2002:a17:907:9409:b0:c29:f5d8:9c72 with SMTP id
 a640c23a62f3a-c31aa088548mr1508202666b.33.1792024570437; Wed, 14 Oct 2026
 17:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011220531.2073892-1-mhun512@gmail.com> <20261011220531.2073892-2-mhun512@gmail.com>
 <SJ0PR11MB770448ECA655129850E63866F49E2@SJ0PR11MB7704.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB770448ECA655129850E63866F49E2@SJ0PR11MB7704.namprd11.prod.outlook.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Wed, 14 Oct 2026 20:35:58 -0400
X-Gm-Features: AclHuK_FiO8k2ANUvLel5w3-UBeosXNT17OFpLfw1OUVvRsSVTFeVw-K27VERoA
Message-ID: <CAGEsz8H4z7cpJQkmFGcqnCT+H56OuUHQDch6kh13TiOo0b-TFA@mail.gmail.com>
Subject: Re: [PATCH 1/2] HID: intel-thc-hid: quickspi: quiesce IRQs during teardown
To: "Xu, Even" <even.xu@intel.com>
Cc: "Sun, Xinpeng" <xinpeng.sun@intel.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Even,

Thanks for reviewing the patch.

No, I haven't tested it on actual hardware. I have only
compile-tested it with GCC and W=3D1 on x86_64.

Best regards,
Myeonghun

2026=EB=85=84 10=EC=9B=94 12=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 8:52, =
Xu, Even <even.xu@intel.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>
> > -----Original Message-----
> > From: Myeonghun Pak <mhun512@gmail.com>
> > Sent: Monday, October 12, 2026 6:06 AM
> > To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>;=
 Jiri
> > Kosina <jikos@kernel.org>; Benjamin Tissoires <bentiss@kernel.org>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>; Mark Pea=
rson
> > <mpearson-lenovo@squebb.ca>; linux-input@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Ijae Kim <ae878000@gmail.com>
> > Subject: [PATCH 1/2] HID: intel-thc-hid: quickspi: quiesce IRQs during =
teardown
> >
> > The managed IRQ can access HID/DMA buffers or queue recovery work while
> > remove or probe unwind tears down those resources.
> >
> > Disable and synchronize the IRQ, drain recovery work, then mask THC int=
errupts
> > before freeing the IRQ and releasing HID/DMA resources.
> > Track IRQ/DMA initialization for conditional probe cleanup.
> >
> > Disable the IRQ before shutdown deinit as well. Keep IRQ disabling and =
release
> > outside the shared hibernation helper.
> >
> > This issue was found by static analysis.
>
> Thanks for your patch!
>
> I think this patch is still necessary. It can prevent some extremely unli=
kely but problematic cases, such as an interrupt already being queued in th=
e thread before the THC interrupt is disabled. Have you tested this code on=
 actual hardware?
>
> Best Regards,
> Even Xu
>
> >
> > Fixes: 4138f21115ae ("HID: intel-thc-hid: intel-quickspi: Complete THC =
QuickSPI
> > driver")
> > Assisted-by: LLM
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> > Compile-tested with GCC, W=3D1 (x86_64). No runtime testing.
> >
> > Related recovery-work review and series:
> > https://lore-kernel.gnuweeb.org/linux-input/20260717035609.3874015-1-
> > even.xu@intel.com/T/
> > https://patchew.org/linux/20260729050145.2272597-1-even.xu@intel.com/
> >
> >  .../intel-quickspi/pci-quickspi.c             | 28 +++++++++++++++----
> >  1 file changed, 22 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> > b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> > index 89226f5ce45e..0bd22f285c78 100644
> > --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> > +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> > @@ -597,6 +597,8 @@ static int quickspi_probe(struct pci_dev *pdev,
> >                         const struct pci_device_id *id)
> >  {
> >       struct quickspi_device *qsdev;
> > +     bool dma_initialized =3D false;
> > +     bool irq_requested =3D false;
> >       void __iomem *mem_addr;
> >       int ret;
> >
> > @@ -649,6 +651,7 @@ static int quickspi_probe(struct pci_dev *pdev,
> >                                       qsdev);
> >       if (ret)
> >               goto dev_deinit;
> > +     irq_requested =3D true;
> >
> >       ret =3D reset_tic(qsdev);
> >       if (ret) {
> > @@ -667,17 +670,18 @@ static int quickspi_probe(struct pci_dev *pdev,
> >               dev_err(&pdev->dev, "Setup THC DMA failed, ret=3D %d\n", =
ret);
> >               goto dev_deinit;
> >       }
> > +     dma_initialized =3D true;
> >
> >       ret =3D quickspi_get_report_descriptor(qsdev);
> >       if (ret) {
> >               dev_err(&pdev->dev, "Get report descriptor failed, ret =
=3D %d\n",
> > ret);
> > -             goto dma_deinit;
> > +             goto dev_deinit;
> >       }
> >
> >       ret =3D quickspi_hid_probe(qsdev);
> >       if (ret) {
> >               dev_err(&pdev->dev, "Failed to register HID device, ret =
=3D %d\n",
> > ret);
> > -             goto dma_deinit;
> > +             goto dev_deinit;
> >       }
> >
> >       qsdev->state =3D QUICKSPI_ENABLED;
> > @@ -692,10 +696,16 @@ static int quickspi_probe(struct pci_dev *pdev,
> >
> >       return 0;
> >
> > -dma_deinit:
> > -     quickspi_dma_deinit(qsdev);
> >  dev_deinit:
> > +     if (irq_requested) {
> > +             WRITE_ONCE(qsdev->recovery_disabled, true);
> > +             disable_irq(pdev->irq);
> > +     }
> >       quickspi_dev_deinit(qsdev);
> > +     if (irq_requested)
> > +             devm_free_irq(&pdev->dev, pdev->irq, qsdev);
> > +     if (dma_initialized)
> > +             quickspi_dma_deinit(qsdev);
> >  disable_pci_device:
> >       pci_clear_master(pdev);
> >
> > @@ -718,9 +728,12 @@ static void quickspi_remove(struct pci_dev *pdev)
> >       if (!qsdev)
> >               return;
> >
> > -     quickspi_hid_remove(qsdev);
> > -
> > +     WRITE_ONCE(qsdev->recovery_disabled, true);
> > +     disable_irq(pdev->irq);
> >       quickspi_dev_deinit(qsdev);
> > +     devm_free_irq(&pdev->dev, pdev->irq, qsdev);
> > +
> > +     quickspi_hid_remove(qsdev);
> >
> >       quickspi_dma_deinit(qsdev);
> >
> > @@ -747,6 +760,9 @@ static void quickspi_shutdown(struct pci_dev *pdev)
> >       if (!qsdev)
> >               return;
> >
> > +     WRITE_ONCE(qsdev->recovery_disabled, true);
> > +     disable_irq(pdev->irq);
> > +
> >       quickspi_dev_deinit(qsdev);
> >
> >       /* Must stop DMA before reboot to avoid DMA entering into unknown
> > state */
