Return-Path: <SRS0=ZXj0=6F=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A98C54FCC
	for <linux-input@archiver.kernel.org>; Tue, 21 Apr 2020 21:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EBA7206B8
	for <linux-input@archiver.kernel.org>; Tue, 21 Apr 2020 21:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BUOaSS3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDUVhV (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726012AbgDUVhU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Apr 2020 17:37:20 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364F9C0610D5
        for <linux-input@vger.kernel.org>; Tue, 21 Apr 2020 14:37:20 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id j20so11394956edj.0
        for <linux-input@vger.kernel.org>; Tue, 21 Apr 2020 14:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=85i8dWB5KsmbiC5p4z50gZ46TVNBxqebreSVo+qFPPA=;
        b=BUOaSS3OF7m0BSGtOLWY1IEj5ESR7fJswhwN0PgY4zATTKVSoSTHQYXNCIpm0nzE2v
         YFBxIDuILGPpYXBXnk0DsnUkbqsBNKGPb+dO3JsphcnT6O9Ain9e2T7MnTjf7M8eNFZ2
         kna7xIBu0lO5i2klT9QsZAM6g+LIZvqvc934YnaD6aMoKWyZSRA1mEKMWGiXvmJR5BU7
         Fi3FFlzx6gD7zcGMSzOhxoDeShfhLz5KppetresM6BU8/e7+qFJFffToGUb/r7eP8mC3
         xfxNKPxdAVayN9dXzAW4OoOIZAHmhlfhN0ebjYhOb84G6JUzO1eRzNaOKu8OxXgeLRMM
         dmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=85i8dWB5KsmbiC5p4z50gZ46TVNBxqebreSVo+qFPPA=;
        b=aWk25XMiYlMYl3pzElLRoOsTcG2jcWuw72Wxm/4cepWUJNfRz6Z0onC1cQq6yA3Ozo
         e8Pgy4tBYRPdi8JM4qm6EGmpQwkSggSnzHDFSpTZN0nHDypCZbbKGqE4p4w51gp6ye3f
         Rm8Ez3ygCATcHU0JCeL+dYSBJYdv9bwx9BPoMr/hfDuD7FaJ37Mnt+owmHKxsnpwAWMu
         n6hBPWqzq1LgufZSA02DAzjy1DSLpjzJv3e9qQoJURLv2GDlte8zwtaG7qClTvrMLaTr
         SRm7KgJmacO/Ncqfla++IOnd+GjFrZgm1r0VXZEuiGQHxNVSYZUAB4ouvCRZIGUgbIyK
         6A6A==
X-Gm-Message-State: AGi0PuYxpjQLRqOyCVu6IDBCSCllV+DtDQvVBTMPAUfUtakmHyJ1Mah5
        TzTzIx5YillZUgbx+MkAVn/J2ZgrHQ5tA84hQZs61A==
X-Google-Smtp-Source: APiQypI1XXdlrotB49BTc5a2EHySbH+x5koHTNhIPW0ZcqQLa8vYdnNyYWZdS6BKUJsv5Mz4ddyvE4Xlxs+pfDtSTGs=
X-Received: by 2002:aa7:daca:: with SMTP id x10mr19781297eds.59.1587505038209;
 Tue, 21 Apr 2020 14:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAKF84v2gWnokoyhRe_feiWJcYOAPUcWwjaX93GkqmXqm8OzmYg@mail.gmail.com>
 <CAKF84v1yRUjvxdWUNXdKXFQw7=9rjR0+pwvXP1ORjq5JEijc4g@mail.gmail.com>
In-Reply-To: <CAKF84v1yRUjvxdWUNXdKXFQw7=9rjR0+pwvXP1ORjq5JEijc4g@mail.gmail.com>
From:   Siarhei Vishniakou <svv@google.com>
Date:   Tue, 21 Apr 2020 14:37:07 -0700
Message-ID: <CAKF84v1R4xs3HKH8v-SnBrZ2eEVim2W9OPD+BWPQchpfVJTHXQ@mail.gmail.com>
Subject: Re: behaviour change for keyboards introduced by "HID: generic:
 create one input report per application type"
To:     Garfield Tan <xutan@google.com>,
        linux-input <linux-input@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Bringing this back.

Any thoughts on this Jiri and Benjamin?

On Wed, Apr 8, 2020 at 9:45 AM Siarhei Vishniakou <svv@google.com> wrote:
>
> Hi Benjamin and Jiri,
>
> Could you provide your thoughts on this?
>
> On Wed, Apr 1, 2020 at 1:02 PM Siarhei Vishniakou <svv@google.com> wrote:
> >
> > Hello linux-input,
> >
> > We have noticed a recent behavior change introduced by the commit:
> > https://github.com/torvalds/linux/commit/f07b3c1da92db108662f99417a212f=
c1eddc44d1
> > HID: generic: create one input report per application type.
> >
> > We have been looking into the behaviour of the Microsoft Designer
> > keyboard. Prior to these patches, the keyboard would report as a
> > single input_device to the user space. After these patches, the
> > keyboard is now split into 2 input devices: =E2=80=9CDesigner Keyboard
> > Consumer Control=E2=80=9D and =E2=80=9C"Designer Keyboard Keyboard". We=
 noticed that
> > this behavior also applies to the keyboard Dell KB216. In the Dell
> > case, it is split into 3 devices, which include =E2=80=9CConsumer Contr=
ol=E2=80=9D
> > (for some of the media keys) and =E2=80=9CSystem Control=E2=80=9D (for =
the sleep
> > button).
> >
> > In both Microsoft and Dell cases, these are pretty standard keyboards,
> > although they do contain media keys and power/sleep keys.
> >
> > Could you please confirm that this new behaviour is indeed
> > intentional, and that you wanted keyboards to be split in this
> > fashion?
> >
> > Thanks,
> > Siarhei
