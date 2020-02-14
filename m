Return-Path: <SRS0=V5p8=4C=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683EAC3B196
	for <linux-input@archiver.kernel.org>; Fri, 14 Feb 2020 10:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDE7206B6
	for <linux-input@archiver.kernel.org>; Fri, 14 Feb 2020 10:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewhqOzts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387397AbgBNKlU (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 14 Feb 2020 05:41:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29908 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387409AbgBNKlT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 14 Feb 2020 05:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581676878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JIODMyxS3Cw9NVg2Y0JpjutrQnRroxT6oU0d5Fa65Qk=;
        b=ewhqOztsGGh0rnquH7tSMrlo6BJflTgl5M1T4Cj9JHt2rQdLnY9iilzDiCPRgfU4Kzivb+
        BefGWG5LP3bXlrHJ7RkDc2aN+JB0RMoQAVfDMTc1ktsDI0jU3LVRa41ePJFCOBG8HdOT/X
        8zTywOyDlPMba13/ICiQkjdqIH08I1s=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-Cgkq1aUwNC-0PuFw8zUPaA-1; Fri, 14 Feb 2020 05:41:11 -0500
X-MC-Unique: Cgkq1aUwNC-0PuFw8zUPaA-1
Received: by mail-qt1-f197.google.com with SMTP id y3so5649877qti.15
        for <linux-input@vger.kernel.org>; Fri, 14 Feb 2020 02:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JIODMyxS3Cw9NVg2Y0JpjutrQnRroxT6oU0d5Fa65Qk=;
        b=F4nIHVBqI89j6Ghl1vuWNPeKOaNns+KUS2HoqHyb1VwicQcwrPb8Ic6UL3cJXcdnLP
         5N0e5hkmGJoNl7UHsQo9VoLFX6dpaheXahv1f5S1XAw5HkUcGNfWpVw+N+2+FSmoKsRn
         w5G8jGFEKEAKN3AXaiLGKjkFox3yeGaUVsFBmfnZZneEfJ8392NwkfmvGeHFpEaCQsdL
         ZFrJj3SGDJrRD+mYTtsu8mOz7ZPoTWgXtE/jAUWH/zBUJW2dboSa8wozNT4ZWTPwRhbz
         IUSkgnOnEOXEDSDlc4R9S1+oZhaO4vjnYnZy1alM9DW8IqElMT0XAMEa4tTKMI1m4zHg
         NpTQ==
X-Gm-Message-State: APjAAAW66qhK7yVTPT5By5Qbj63OqVhA779cySTR4nL/a2EFKy/H6qmC
        xOJqE4IlLVAwlNmH4/tQ4NMd+CyKD1wrLWjlKpKqd0EpAQ4Qf3XblovRZhy8fxaDRxlEmZYUkFp
        MhKTg0yXQzEZpeNt6tTcR4xZY5K7tlA+8zA1/Mu8=
X-Received: by 2002:a37:a717:: with SMTP id q23mr1847723qke.169.1581676870590;
        Fri, 14 Feb 2020 02:41:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqw8d+hGyj3olMhg+4toi9NBjWt6lr9Wsapa23D7XeqEdU1Ydn5be+Ql2yJAA553mDKf9WAuFnMbeiu3rclujH0=
X-Received: by 2002:a37:a717:: with SMTP id q23mr1847704qke.169.1581676870363;
 Fri, 14 Feb 2020 02:41:10 -0800 (PST)
MIME-Version: 1.0
References: <20200214065309.27564-1-kai.heng.feng@canonical.com> <189a7784-3754-99b8-3f3d-560b7657c134@redhat.com>
In-Reply-To: <189a7784-3754-99b8-3f3d-560b7657c134@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 14 Feb 2020 11:40:59 +0100
Message-ID: <CAO-hwJL5d4RGxOZ7NqDBdQ=0GYCDThCUR8b+-kRpwPEuhsFXyA@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: add Trekstor Surfbook E11B to descriptor override
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi,

On Fri, Feb 14, 2020 at 9:32 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 2/14/20 7:53 AM, Kai-Heng Feng wrote:
> > The Surfbook E11B uses the SIPODEV SP1064 touchpad, which does not supply
> > descriptors, so it has to be added to the override list.
> >
> > BugLink: https://bugs.launchpad.net/bugs/1858299
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> Patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thanks everybody for the patch submission and the quick review.

Patch is now queued in for-5.6/upstream-fixes

Cheers,
Benjamin

>
> Regards,
>
> Hans
>
>
>
> > ---
> >   drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
> > index d31ea82b84c1..a66f08041a1a 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
> > @@ -341,6 +341,14 @@ static const struct dmi_system_id i2c_hid_dmi_desc_override_table[] = {
> >               },
> >               .driver_data = (void *)&sipodev_desc
> >       },
> > +     {
> > +             .ident = "Trekstor SURFBOOK E11B",
> > +             .matches = {
> > +                     DMI_EXACT_MATCH(DMI_SYS_VENDOR, "TREKSTOR"),
> > +                     DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "SURFBOOK E11B"),
> > +             },
> > +             .driver_data = (void *)&sipodev_desc
> > +     },
> >       {
> >               .ident = "Direkt-Tek DTLAPY116-2",
> >               .matches = {
> >
>

