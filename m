Return-Path: <SRS0=pnPe=CQ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC39C43461
	for <linux-input@archiver.kernel.org>; Mon,  7 Sep 2020 07:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1859207C3
	for <linux-input@archiver.kernel.org>; Mon,  7 Sep 2020 07:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZR+63to"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgIGHhR (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgIGHhR (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 7 Sep 2020 03:37:17 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689F6C061573;
        Mon,  7 Sep 2020 00:37:16 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id q6so11654347ild.12;
        Mon, 07 Sep 2020 00:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eolZlUfohQCfZPBZcIwQSDwC/RZau21wdgFrsxtxQ/Q=;
        b=fZR+63tocruhbQ29gKa2Bsb+yu0tbqWTH49j1FJXqZ1Z5rMSngcBRjNAgFCFaVoKMN
         rVu54yIOO9RwKIk4GoOHZWQn2ACkEI2FoPDT8a2k47lY9gxs63NFJi82rqObULMOYqPQ
         +O81OzCaagBiDzLyjPBWapXkUtQm71Fr1+895TYw0ofjGLnV9Lu8Qv9NwG65Gazxj3PO
         voKSLAbW+N44NZxypxr8RCu/5CNhMkhd0Lx7YR8BFM3NAIUL8eJpH0ThD2d480ZuHzsy
         YujBT4gcfd3uYtuA8ZaNCHhfaQQwfEYQC2GjC0YtybN1ll0nz1DDBV05sw2GlmJgMNaX
         mZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eolZlUfohQCfZPBZcIwQSDwC/RZau21wdgFrsxtxQ/Q=;
        b=pQ/BfJlwyk15nPJLwUKFf8L6YyMLaEOHhrouisxSwZQfmbuc1iCvDjSBQJ+2M0yKEo
         mX/AyWrlfCShCtkt43CaHTmOSQD8J8YoymRUJX93aT+0rebAI0+xlI1wRbDVRWU+0ogi
         b4XMyBAs907YZtbiQFw64barm2/qBF75r0D64b09Cykzws8W3xC3XPZUKNO6iNOxMyXO
         V02hbnwAh0GNfS3Ncz7hqgLQaZVGMSJiOcERHNT+aFqRzo2BTWAKxPJ8twjdCk7yDaZC
         6Zy899A8z9/7JzgBOWJIJ6PCq0p9zKLtSO6aYz1aUyhWaXB6Me7pY6gB2aPuDh5xD5iW
         dxjQ==
X-Gm-Message-State: AOAM532khZNlFVbXKDCybIczrwclnPUmYuGSgBk60FLuDwtoLoXpmiX2
        d/4n6emUYhsLJHy0Cj4sGKFNxS6jbAmVkUfFAoU=
X-Google-Smtp-Source: ABdhPJxUHqVjQ7XHcZ4b0XX0BxUwUksFCnJVZiI+Ufad/nOHFQde/oYEnPwshOIkmppn5BIl7Ryzrsz5ftL92TDgcJo=
X-Received: by 2002:a92:5f04:: with SMTP id t4mr18192392ilb.299.1599464234888;
 Mon, 07 Sep 2020 00:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200904132143.9496-1-abbotti@mev.co.uk>
In-Reply-To: <20200904132143.9496-1-abbotti@mev.co.uk>
From:   David Rheinsberg <david.rheinsberg@gmail.com>
Date:   Mon, 7 Sep 2020 09:37:02 +0200
Message-ID: <CADyDSO7znNjdrXzgU8yVCy6XGbcdwPdmrbu849ZtsqoBCePWQw@mail.gmail.com>
Subject: Re: {PATCH 0/2] HID: wiimote: Minor change to spinlock usage
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi

On Fri, 4 Sep 2020 at 15:21, Ian Abbott <abbotti@mev.co.uk> wrote:
>
> [I have posted these patches previously, but that was over a year ago.
> --IA]
>
> A couple of minor changes to the wiimote core module.  They do not
> change functionality of the driver:
>
> 1) HID: wiimote: make handlers[] const
> 2) HID: wiimote: narrow spinlock range in wiimote_hid_event()
>
>  drivers/hid/hid-wiimote-core.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Looks still good ;)

Reviewed-by: David Rheinsberg <david.rheinsberg@gmail.com>

Thanks!
David
