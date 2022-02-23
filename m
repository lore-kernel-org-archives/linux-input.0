Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C17C433F5
	for <linux-input@archiver.kernel.org>; Wed, 23 Feb 2022 05:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbiBWFSd (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 23 Feb 2022 00:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiBWFSc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 23 Feb 2022 00:18:32 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03B966AE8
        for <linux-input@vger.kernel.org>; Tue, 22 Feb 2022 21:18:05 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d3so21960984wrf.1
        for <linux-input@vger.kernel.org>; Tue, 22 Feb 2022 21:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i0BgigNUrNvplvAukfXfrovtiwMmzb+y5eO45fKBV6E=;
        b=g2zccOH7ylqr4PUi2B42mMTqWAZRAuQKQ2Hh3/SobWWAQCZs6layh8kvpP4KOS2BhH
         mxfthf1CYVxJKkj/n1Rrj3iN6ZTHerNah+Oc5LrTlO0NT34dZa5TDxdVPQYHVFbJEZII
         CQVagn9OtQuhNmGnTxKAWUCGwIhnFObmFEFcnEszONYFPkfNquzsYT1khtOsh53TIyQW
         Op3DQgUDiJXsBsBSar7QV/LnEZK8cg6RiATUMtwZrBlxMFAhAwKb/z8oEp1MNNufH/Ti
         UfzRKKA/hVBUswDDEbXnaLSeoSqjwIs0t5+lfpxMrTclw0aQZ6avkTHRZOtWe8Yd4KTB
         v7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i0BgigNUrNvplvAukfXfrovtiwMmzb+y5eO45fKBV6E=;
        b=TUCi9ucwV1nQVxZVOHPUszc3y5vnAQfYnbdo/Q1/IV4DN0oHwLOfGVstfU8sUIfVJf
         U/z4ofyCWdyjU3jl+LnRHZ9Jx5OdiDpczl43Iq5cGKk98EVEmg8JbE4tIRe7tBR2NpEv
         XP+YGlEbXCbtTWGGMhxc/qLg4xrD/P26CtcRedPzK543pHkH8aKMcaCgyJ3VLa5Az2ee
         hUwUH/mF643bMCjlTg2VaWuNQioBRcPAu4nM60QcSx6HilCJzvBVmPLojNWR1BH40Dmz
         AsAIbbfjfu++6SY8ZU58pdDSWgjuye8atYG7cQr1uvBSmwNWw4NgXJ/ETPBRtGeMhzTK
         M6NA==
X-Gm-Message-State: AOAM533Wt8SvFV02g516GXLv+uDnQQeLu40oyF892Kdv2GRmk/hlHyAV
        7EvLYRI7Jyq4EU+Tzqd36Sr8nwb7CO8FKN42gRz3Gw==
X-Google-Smtp-Source: ABdhPJzy4RsYm2AifyKCzU32taS+CwXeaQzrPMUsKpWqayY7FOX66cwITzM7el7Petj4+mxg3d6Byp9ZoG97wQsVrJc=
X-Received: by 2002:adf:ec51:0:b0:1e3:d68:6398 with SMTP id
 w17-20020adfec51000000b001e30d686398mr21450737wrn.203.1645593484381; Tue, 22
 Feb 2022 21:18:04 -0800 (PST)
MIME-Version: 1.0
References: <20220214165021.1.I89632f95e6af380102cdb1ec9f7a6d5cb948b029@changeid>
In-Reply-To: <20220214165021.1.I89632f95e6af380102cdb1ec9f7a6d5cb948b029@changeid>
From:   Pablo Ceballos <pceballos@google.com>
Date:   Tue, 22 Feb 2022 21:17:52 -0800
Message-ID: <CAO9JgFwwZ8u_rZgj5=cKiJ511kk6_nKgUF3S6a+rucr943VC0w@mail.gmail.com>
Subject: Re: [PATCH] HID: input: Handle OOC toggle switches mapped to keys
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Mon, Feb 14, 2022 at 1:51 PM Pablo Ceballos <pceballos@google.com> wrote:
> I'm not sure if this is the best way to resolve this issue that's
> happening with the "Phone Mute" HID usage. Or if this approach will
> cause issues with other HID devices.

Further testing shows that this won't work. The problem with this
approach is that there is no way to know the initial state of the
toggle switch. Please ignore this patch.
