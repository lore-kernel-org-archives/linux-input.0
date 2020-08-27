Return-Path: <SRS0=z9W1=CF=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DBEC433E1
	for <linux-input@archiver.kernel.org>; Thu, 27 Aug 2020 17:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 789742080C
	for <linux-input@archiver.kernel.org>; Thu, 27 Aug 2020 17:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gtp1cONN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgH0R4g (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgH0R4f (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Aug 2020 13:56:35 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E50C06121B
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2020 10:56:35 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id j188so3279391vsd.2
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2020 10:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f3B/Q02yvB9Yb/6f99Yh5bgWBIK4FmspfwcBGWYIhaQ=;
        b=gtp1cONNLRdqCbirQgaQZFoJMnU2+Pp93TVFD9+9a7EbozuUQabLEhaFWeodWKi/6A
         5yFTsxABrmxVdN5KKreOg0m5oB7Ffh7B4tvpdaZLlNPDvCQ2GiUUl3ne4fQ1a5jzMeZq
         gnsk8wIUwedu254Lobh9MlJxfV9jnafA5uwds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f3B/Q02yvB9Yb/6f99Yh5bgWBIK4FmspfwcBGWYIhaQ=;
        b=N4nrYjv+C4oOkzDJ6+wtEVUMVZbQhGVFfq1D9EIZzd7FxtSNgZzVka42geiIYVgPzf
         FTX7RTM3OVxwciR9Y/ee0UobxT3jE9XRpvd9u7INkL8njBwS8WThhMAbzhr65lFb9BTp
         coEr8OHAy1oqeo2hvdwNi7ac10iKQlfdTVDSFsxLT8EM/hx8LO8/q9uyc1c2DxnNG5gP
         CfWIs7GIpz7bCq2t5U/vouuoEO21MpV59qs3JiK0wrVLgs5YgoOvTfeBnmUObrb2mVoz
         Ci/5unMzlAAogMqFuvKP/o64X8mHobELIUSI8WYw0t7AgO9IQOaqKRgtWmHRRV4UTE8z
         F17g==
X-Gm-Message-State: AOAM533kHcmc2jlyf6N2+jRWziYI4iZuG1XIi9iU7X7GHlYwZj+hjnQp
        D3Qk77aCUCSuBBwJRnqGfjPy/hmUZcCx0Ojt
X-Google-Smtp-Source: ABdhPJzSLmErzFMIE1yaypmOg2/EeTQDfMY+S8DwNKLzjL+voynz1sm5oe/sa25j6l+zFYKXqOjJkg==
X-Received: by 2002:a05:6102:242c:: with SMTP id l12mr13138142vsi.21.1598550993433;
        Thu, 27 Aug 2020 10:56:33 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id g138sm520365vke.21.2020.08.27.10.56.32
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 10:56:32 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id y3so2632128vsn.1
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2020 10:56:32 -0700 (PDT)
X-Received: by 2002:a67:facb:: with SMTP id g11mr2701403vsq.56.1598550991774;
 Thu, 27 Aug 2020 10:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <1598492651-9072-1-git-send-email-johnny.chuang.emc@gmail.com>
In-Reply-To: <1598492651-9072-1-git-send-email-johnny.chuang.emc@gmail.com>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Thu, 27 Aug 2020 10:56:20 -0700
X-Gmail-Original-Message-ID: <CA+jURctrQcKsGwxZriX8bD3AQr-yh_J_Z7kkP+6HtD72Gt5DUw@mail.gmail.com>
Message-ID: <CA+jURctrQcKsGwxZriX8bD3AQr-yh_J_Z7kkP+6HtD72Gt5DUw@mail.gmail.com>
Subject: Re: [PATCH v2] Input: elants_i2c - Report resolution of
 ABS_MT_TOUCH_MAJOR by FW information.
To:     Johnny Chuang <johnny.chuang.emc@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Johnny Chuang <johnny.chuang@emc.com.tw>,
        James Chen <james.chen@emc.com.tw>,
        Jennifer Tsai <jennifer.tsai@emc.com.tw>,
        Paul Liang <paul.liang@emc.com.tw>,
        Jeff Chuang <jeff.chuang@emc.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 26 Aug 2020 at 18:44, Johnny Chuang <johnny.chuang.emc@gmail.com> wrote:
>
> This patch adds a new behavior to report touch major resolution
> based on information provided by firmware.
>
> In initial process, driver acquires touch information from touch ic.
> This information contains of one flag about reporting resolution of
> ABS_MT_TOUCH_MAJOR is needed, or not.
> Touch driver will report touch major resolution after geting this flag.

I think this paragraph needs updating now that the firmware's
reporting the actual resolution instead of a flag.

>
> Signed-off-by: Johnny Chuang <johnny.chuang.emc@gmail.com>
> ---
> Changes in v2:
>   - register real resolution instead of true/false.
> ---
>  drivers/input/touchscreen/elants_i2c.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> index b0bd5bb..dc7f4a5 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -151,6 +151,7 @@ struct elants_data {
>
>         bool wake_irq_enabled;
>         bool keep_power_in_suspend;
> +       u8 report_major_resolution;
>
>         /* Must be last to be used for DMA operations */
>         u8 buf[MAX_PACKET_SIZE] ____cacheline_aligned;
> @@ -459,6 +460,9 @@ static int elants_i2c_query_ts_info(struct elants_data *ts)
>         rows = resp[2] + resp[6] + resp[10];
>         cols = resp[3] + resp[7] + resp[11];
>
> +       /* Decide if report resolution of ABS_MT_TOUCH_MAJOR */
> +       ts->report_major_resolution = resp[16];
> +
>         /* Process mm_to_pixel information */
>         error = elants_i2c_execute_command(client,
>                                            get_osr_cmd, sizeof(get_osr_cmd),
> @@ -1325,6 +1329,8 @@ static int elants_i2c_probe(struct i2c_client *client,
>                              0, MT_TOOL_PALM, 0, 0);
>         input_abs_set_res(ts->input, ABS_MT_POSITION_X, ts->x_res);
>         input_abs_set_res(ts->input, ABS_MT_POSITION_Y, ts->y_res);
> +       if (ts->report_major_resolution > 0)
> +               input_abs_set_res(ts->input, ABS_MT_TOUCH_MAJOR, ts->report_major_resolution);
>
>         touchscreen_parse_properties(ts->input, true, &ts->prop);
>
> --
> 2.7.4
>

Harry Cutts
Chrome OS Touch/Input team
