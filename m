Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F475C4742C
	for <linux-input@archiver.kernel.org>; Fri, 13 Nov 2020 07:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E58B20936
	for <linux-input@archiver.kernel.org>; Fri, 13 Nov 2020 07:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qL1Sgeun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgKMHmu (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 13 Nov 2020 02:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgKMHmu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 13 Nov 2020 02:42:50 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C9DC0613D1;
        Thu, 12 Nov 2020 23:42:49 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id u4so8041950qkk.10;
        Thu, 12 Nov 2020 23:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8BBRskIzqXb+Gk5MGiRjDG5bxT3CFF0XWRP/XyHTJi0=;
        b=qL1SgeunlkoC7JJD6Xvopnf0GofAR6fbmNE72kMbNWS+ekPW3XW6vPNAT/XVNK4FqO
         dbIkS6K/uGZA4UcxHosl3Im9G0K3qIcGO0VzNBt9Vz8WcLLUEa0aZMv+WmVVLwrgas4i
         DyXGsAcu3r87iDN28haaS2N7KdYde7Gkiw20FodVV0gy7MSTDwQ4x8cXj341QqXf8Rgm
         MDWb8FBGDvgOxk4HEtCEJ4+sbL8fJR6h7STurx2zABFW7l6FSsLXMmzB4kxjgfdPjQmj
         lpNeRuENuLY7Tr+4psnE2Y4gfPo9dS/QJGHYdT0jtTjgsOuO2JKnKijxzsGWVXc675et
         36Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8BBRskIzqXb+Gk5MGiRjDG5bxT3CFF0XWRP/XyHTJi0=;
        b=PZ9sRbovt3sIqQP/q8PQR0ynY7Zo+70Con9HnmrZrcT59ql//O2yFIOkIHbZJvXeVr
         OguDOcy5xULkiGove5ek9WeOx6UgWMozvu0kpFfzg13fMXtdxEGCHhl+oc12Na90abiA
         9lbL9EdouNlr6DcK4nN+N7XPmeDZvkg5STgsaffwp9n1CHOF5Gjb/R0CHf6fTzddSTKa
         mdlMje4jUFg8vKR7sy0egINvpOlFE3sIZRWj7v7jiTFavpcCDDwgpJXGxTAVvYx7ZzfQ
         TCEOwxFbSkG6BzknN+lxLaw3OaoocuhrOvxm0DNG96qk+baB/944X8ZjgelkkzKNr1lD
         eEhw==
X-Gm-Message-State: AOAM533fFJzz20OUVPIAfLaNdaAwPcD/qg9QjowyyuCXHwGzvpgJ9nQr
        /hgHwVpw6EU+oEkXHXB+5w2aOsQ56sDvrE+KOQQ=
X-Google-Smtp-Source: ABdhPJxp/sicG2+gTOLlGa1xG9phVk7ZlAizWElZSZHGU4Ti0fLAZM6AlL4K+0w/flw8R62UiuZPUeIjPvfsGIo6L6I=
X-Received: by 2002:a37:84b:: with SMTP id 72mr816197qki.435.1605253369119;
 Thu, 12 Nov 2020 23:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20201112110204.2083435-1-lee.jones@linaro.org>
 <20201112110204.2083435-9-lee.jones@linaro.org> <20201113074028.GI356503@dtor-ws>
In-Reply-To: <20201113074028.GI356503@dtor-ws>
From:   Benjamin Tissoires <benjamin.tissoires@gmail.com>
Date:   Fri, 13 Nov 2020 08:42:37 +0100
Message-ID: <CAN+gG=FjNfV9D9tYgMNYbCe6kgjFc0jDnreFsqOZ=2vnOv9eGA@mail.gmail.com>
Subject: Re: [PATCH 08/15] input: touchscreen: surface3_spi: Remove set but
 unused variable 'timestamp'
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     Lee Jones <lee.jones@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, Nov 13, 2020 at 8:40 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Thu, Nov 12, 2020 at 11:01:57AM +0000, Lee Jones wrote:
> > Fixes the following W=3D1 kernel build warning(s):
> >
> >  drivers/input/touchscreen/surface3_spi.c: In function =E2=80=98surface=
3_spi_process_touch=E2=80=99:
> >  drivers/input/touchscreen/surface3_spi.c:97:6: warning: variable =E2=
=80=98timestamp=E2=80=99 set but not used [-Wunused-but-set-variable]
> >
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Henrik Rydberg <rydberg@bitmath.org>
> > Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> > Cc: linux-input@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/input/touchscreen/surface3_spi.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/input/touchscreen/surface3_spi.c b/drivers/input/t=
ouchscreen/surface3_spi.c
> > index ce4828b1415a8..72dc4c562a4e1 100644
> > --- a/drivers/input/touchscreen/surface3_spi.c
> > +++ b/drivers/input/touchscreen/surface3_spi.c
> > @@ -94,9 +94,7 @@ static void surface3_spi_report_touch(struct surface3=
_ts_data *ts_data,
> >
> >  static void surface3_spi_process_touch(struct surface3_ts_data *ts_dat=
a, u8 *data)
> >  {
> > -     u16 timestamp;
> >       unsigned int i;
> > -     timestamp =3D get_unaligned_le16(&data[15]);
>
> Benjamin, should we pass timing data on to userspace instead?

Last time I checked, libinput was not using the HW timestamp. So I
don't mind dropping it.

Not sure if chrome/android uses it.

Cheers,
Benjamin

>
> >
> >       for (i =3D 0; i < 13; i++) {
> >               struct surface3_ts_data_finger *finger;
> > --
> > 2.25.1
> >
>
> Thanks.
>
> --
> Dmitry
