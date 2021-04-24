Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DACC433B4
	for <linux-input@archiver.kernel.org>; Sat, 24 Apr 2021 21:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5BC961263
	for <linux-input@archiver.kernel.org>; Sat, 24 Apr 2021 21:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbhDXVMe (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 24 Apr 2021 17:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbhDXVMe (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 24 Apr 2021 17:12:34 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A150C061574;
        Sat, 24 Apr 2021 14:11:55 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id y1so11280960plg.11;
        Sat, 24 Apr 2021 14:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F1cHbDPDF64Wi1+AKsHM3fUgzyza5XAOBv9Th82m2X4=;
        b=oevOwD6QohyAZBVfkdBrnTJ8soy08U0ibfEMC3BAK3zDjagUWxh6Nq4xjXFuI3mag9
         QnJcRb94nTy7hmpjXzKBzM5jmYka1lxqSt7NqQFfLLql62D7HptK7RcSQ+D1ok0cg1Ho
         BmAMFU9b0LhnYQdhMeatEopK5cuk5R8Kim7xwkikAkfGelP5Xz7UqNB+TWiWyn3w+6Mu
         zKqUlWLiyS9rGX2JgLPWg5Hq1kkG1kFU4O2+yKArZVCoNtcM0kNY3k98QZLe1DIBcXpx
         qu+y4Zi2O9dK2NHrUU+wmL5I83LaafXM0sGDBhkgwe/DweK57t9cRbYx/NpZXRGBtU6v
         qVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1cHbDPDF64Wi1+AKsHM3fUgzyza5XAOBv9Th82m2X4=;
        b=puIOw8L+gJIZhaerPEJsXwubkhC43wBMZct81sYtnGbdRtWnztMRma0/UCg7kvZCIK
         yNjkAX9J7Ia5/AbRZgtld4bpUbr960dmnrTAryNBef3sKLp4w3akChshFS282vkVRqRP
         GBnDI+F1lL5RCxL7qUlqCjqhLx1CgXCICz3gxxsx28j7p8b49zgBHTV1LP+azai4P6j7
         cRPz9VJBJT+LmdZZKz6FW/99LjTq881Uk0LfLk5wIkRH6tOzZiagoFPAMUGXZ9IvrT4G
         5WjgsPk+L2hOukaWBGhgAaYWsIysKQLlBnjzJJCg2+smf+6jDxzoDnifol7YQmzb4mw5
         sAWg==
X-Gm-Message-State: AOAM531olyPaZmgTvvW2X2Mhces4TkICmpEJoLMd4IuJ+nRX4VkGYCA9
        ZZtM3VIfeZAKUTrHeRtf86nZSFi9FwOYRJRxR+I=
X-Google-Smtp-Source: ABdhPJyPYU1jv0jT5o+s2UU2hZtcZhy+s5F7ZOUW1ei4+8vwAeBE9Taa94PO8tJyojP3szUj+ARAFXRilmaT1R9+sFg=
X-Received: by 2002:a17:90a:8906:: with SMTP id u6mr11702012pjn.162.1619298715074;
 Sat, 24 Apr 2021 14:11:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210411150623.8367-1-hcvcastro@gmail.com>
In-Reply-To: <20210411150623.8367-1-hcvcastro@gmail.com>
From:   Roderick Colenbrander <thunderbird2k@gmail.com>
Date:   Sat, 24 Apr 2021 14:11:44 -0700
Message-ID: <CAEc3jaAADGuPDwGLM6HskLq-OiecbV-76JbMe6yambVAT=h=bw@mail.gmail.com>
Subject: Re: [PATCH] drivers/hid: avoid invalid denominator
To:     Henry Castro <hcvcastro@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi Henry,

Thanks for your patch. In what case has this been an issue? Or was it
more theoretical.

During normal operation this condition should never be triggered for a
DualShock 4 when calibration succeeds. If it doesn't succeed the
device is not registered. We had an issue recently with the DS4 dongle
where the calibration data was 0, which was due to a race condition
with Steam, but that was resolved recently.

Thanks,
Roderick

On Sun, Apr 11, 2021 at 10:19 AM Henry Castro <hcvcastro@gmail.com> wrote:
>
> Avoid a potential panic in case wrong denominator
> is given.
>
> Signed-off-by: Henry Castro <hcvcastro@gmail.com>
> ---
>  drivers/hid/hid-sony.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 8319b0ce385a..67b45d82cc3b 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -1134,11 +1134,16 @@ static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
>                  * Note: we swap numerator 'x' and 'numer' in mult_frac for
>                  *       precision reasons so we don't need 64-bit.
>                  */
> -               int calib_data = mult_frac(calib->sens_numer,
> -                                          raw_data - calib->bias,
> -                                          calib->sens_denom);
> +               if (calib->sens_denom != 0) {
> +                       int calib_data = mult_frac(calib->sens_numer,
> +                                                  raw_data - calib->bias,
> +                                                  calib->sens_denom);
> +
> +                       input_report_abs(sc->sensor_dev, calib->abs_code, calib_data);
> +               } else {
> +                       hid_warn(sc->hdev, "DualShock 4 parse report, avoid invalid denominator");
> +               }
>
> -               input_report_abs(sc->sensor_dev, calib->abs_code, calib_data);
>                 offset += 2;
>         }
>         input_sync(sc->sensor_dev);
> --
> 2.20.1
>
