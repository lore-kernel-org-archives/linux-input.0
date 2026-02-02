Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5B83D76
	for <linux-input@vger.kernel.org>; Mon,  2 Feb 2026 03:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770004656; cv=pass; b=VSoVFwXJjpIG2Xc5Hbs5M60z/QmciI4nFr3jOZKweIQSc+EZt8x5OWfsO5jBhJLjQ14yb3HjM0L/NQNP3KFSlpqKYPVSA9hjZ2zv3QgnpBZMdwrFJbGtbK6h2z6FtpLX/JQvivTDozrzqBoL/MO9LMNE+WLSr6EgNEBdYV8V0e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770004656; c=relaxed/simple;
	bh=NQqxDajhoKEjVOw3sQ9GExXSu0a7BSic0YieJ2RLuIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+kyF36xRXavmuB6Jw2Md1ItCvIq/qfT6YbJ+9Zzid5xJydWu7BA3I3/3jvzJZiRH5vMJyIxU35dYL42/oHlIYYHhGXXycrvzAuoIPseqss4VDbfU+RMnYiE4/7gg1suTJ6L7/CzQ8D/9MCVJNzLPby9mTPE3xx24caQn2EuDdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEOxp1Ft; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEOxp1Ft"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-382fb275271so39165681fa.0
        for <linux-input@vger.kernel.org>; Sun, 01 Feb 2026 19:57:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770004653; cv=none;
        d=google.com; s=arc-20240605;
        b=YebZoN6bqcCcFsapKOzJ76wFOUCqq1Jhds3GXsVJqCYm8Efx+ZVvYS5UKKzJ69XM54
         VtZjlX/2nPjB6gDkohWvSAYVZ1vbwmBq2ZXQ+YwmxWyYQjxDAfkRu4uAiYHFEOo15hq1
         7LxMFHW46bBEQhSOTFDZzLeXG4vHUVr7wNiItyx98A4sSUDd/x1jF5x27HHLj42MXDy5
         gEOKfeOWnZXV2Q5xFZ9oJKvYGKPhisVdsz75ix1y/+CB29obiUCbdR1noi+Qp3gR2lRu
         jTe1b36NkKvmtxumkggCLCe+I4qkJUEMpaHGF/6gKPlC9xQPPv68ZDIkjMWOPdYr+CQR
         iONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4KkZHBfEV4LhZKQypQJPlt0kdlnTL5wPT8BeiQYjtYA=;
        fh=4n6Fv4zvxXAeTBWTWyFJGXmu2ef5Fl9/iFZ2aVGGDcM=;
        b=UpWH6zGBN3t34B3tBlgaxfL+Hoyq4SgxVQwDemfGkMCuwOuAbQzyMr8sAPThw9N9ab
         /o9tSp5rzNYDfl5czNd4y0/zCVNi2k6J6A/HwMtU8cbxauL/HSDdcoQ8B/zU8GoMQ3Eq
         1ULv0eaYhNLOlx7fTxMAsEgXgZdpWkJAybqptMNfEscYxASkpIzflZHJbGFXgB8TCu35
         uElbeGlmJbME//Zx+TrOUmutRObAigcqRMU1B92CRoeaS40Dyk8Nhl0Dgw6m4veZhV3R
         /070JUR9Zn0zt4doj4UnS5HliSi2M+M59IajyujciBqprCLlo2yaeJcxM5/xfV0b5hpE
         v7hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770004653; x=1770609453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KkZHBfEV4LhZKQypQJPlt0kdlnTL5wPT8BeiQYjtYA=;
        b=BEOxp1FthZYwzVsjC3ePN3qNwM9mOoVDh0+qt7oD5lnJy4pHpX9FrKZzcMnNJDF/FJ
         zRzGosL21WU5OIZj2nN6YX0pWYCwp3Y3iSzzBjd65LVlu8TjRwbcmvPieSBKYrwEMI1b
         Q0FrrK4BNque5MsBC3zv5B4un3zcSrXS4e0u5EAn5WSA/q932q6LDBVC0GLkYz36Mzx5
         JROd+FSP61law8b7xIDsEXC6RC2VSucP6wBVssC7yeXxE7ln5lb6taKApV2MzXbwhjqM
         Cloh5AbGPcsvBLUSEqifFwXdiu2nH3BRNjM8W+kUBQLk6QCtO1xzx6ZB1X52xe8wxiDb
         ReUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770004653; x=1770609453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4KkZHBfEV4LhZKQypQJPlt0kdlnTL5wPT8BeiQYjtYA=;
        b=ucqwQHK81odvh+fHwpSePB/oqSINqDmoK0kYBsUG8Udf9cAe0bQuLBRld/gsNwpQoU
         OBgJzGgAPF6G8LpUVa+YVi7hB+kHqc1O+WGuZBEfhYl1xdm58tolYJdmMlXBTOIZeb/R
         fo2WAk4A4uWoTgzZEnF+rgYtW9NSZx/zIJVpvu0kdCcakmXVvbSZi6gPyvlkKJUK7sn0
         OHtK+kQ8ehZhd0Ea3tGiVtq+ezvCZms43PEfgyvjga+aP/KhneGj+dvu9oPUnpGtlnfA
         +rRPt+QD2f+M/fXnSSLD4CfAqey5r05e26fyvVc2AGZ79htnjk38lZXekT8o5nff9nYC
         rfdg==
X-Forwarded-Encrypted: i=1; AJvYcCVIa7O35cUjtaMWZRkD/nicy+wtvqqUK5QvYLb0TUl4lEHQjMG8C85PqPUa1oPVpiFJ7sr8CGXg/5WJgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmJA5OJdv0r3cBvgqDhoSFlOapYmj27Z0uBPQRIDuF4bB+a7VA
	/3XuzPt1SU/5SFxSFv9HMZWcToPjTTa9a8A1hhGaFB7xHeFZ1p+EIcDpxRYZLdOilV+3I8GkJgY
	F5ceqQGQBAHNMx9oKHNcDXBO22tjoCkM=
X-Gm-Gg: AZuq6aIRJ2AGL1v7nNjufG/TaEfJyqTr8Xy57U7SfK7pXj1W4pGhyVLoYQL/GOH3GGz
	4+EDQ6TzDtqx5dvRj3vSU/x75HuZVyNlmf7GZFlFCXdnvlAwgwhlNXk1vbp33pSsAX3ZX1489uz
	PZ2UOfg8to1shadrFrdUcpdmUFakU8XG8DSlPmugKK50RlwxZ3tPm/rbY618jvHkUXG5IXpRYXs
	dG7KYqACxufAj/No8Zkd1g56XKUdD4pTJ4zlQlGUAThXIgqEcJ1H9GLhyq+65+Xd5CVB8QM5haY
	tik=
X-Received: by 2002:a05:651c:1c8:b0:37f:d484:599c with SMTP id
 38308e7fff4ca-386466b57femr37828881fa.28.1770004653148; Sun, 01 Feb 2026
 19:57:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127103907.20269-1-vishnuocv@gmail.com> <20260127103907.20269-2-vishnuocv@gmail.com>
 <aX8JwB7F8_ypJRAz@google.com>
In-Reply-To: <aX8JwB7F8_ypJRAz@google.com>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Mon, 2 Feb 2026 12:56:56 +0900
X-Gm-Features: AZwV_Qi7tToR25uY6WlcGtxk-3piw3C98qRUN3Lr-_pA-7htZB6yfNnoroFq8-s
Message-ID: <CABxCQKtW5hnTdo7eojMCDyN_bFK3E9MSmacTA=sD+xLYVF279g@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] input: trackpoint - Enable doubletap by default on
 capable devices
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: mpearson-lenovo@squebb.ca, hmh@hmh.eng.br, hansg@kernel.org, 
	corbet@lwn.net, derekjohn.clark@gmail.com, ilpo.jarvinen@linux.intel.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ibm-acpi-devel@lists.sourceforge.net, linux-doc@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, vsankar@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Thank you for the comments.

On Sun, Feb 1, 2026 at 5:10=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Vishnu,
>
> On Tue, Jan 27, 2026 at 07:39:05PM +0900, Vishnu Sankar wrote:
> > @@ -470,6 +509,14 @@ int trackpoint_detect(struct psmouse *psmouse, boo=
l set_properties)
> >                    psmouse->vendor, firmware_id,
> >                    (button_info & 0xf0) >> 4, button_info & 0x0f);
> >
> > +     /* Enable doubletap by default on capable devices */
>
> This is obvious from the code, please drop the comment.
Understood.
Will remove this in v7.
>
>
> > +     if (trackpoint_is_dt_capable(ps2dev->serio->firmware_id)) {
> > +             if (trackpoint_write(ps2dev, TP_DOUBLETAP, TP_DOUBLETAP_E=
NABLE))
> > +                     psmouse_warn(psmouse, "Failed to enable doubletap=
: %d\n", error);
> > +             else
> > +                     psmouse_info(psmouse, "Doubletap enabled by defau=
lt!\n");
>
> Drop psmouse_info(), no need to make the driver too noisy.
Understood.
I will be removing his log as well.
>
> Otherwise:
>
>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Thank you
>
> --
> Dmitry



--=20

Regards,

      Vishnu Sankar
     +817015150407 (Japan)
