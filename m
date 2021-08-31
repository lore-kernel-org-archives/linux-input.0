Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A22C4320E
	for <linux-input@archiver.kernel.org>; Tue, 31 Aug 2021 19:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44DF561074
	for <linux-input@archiver.kernel.org>; Tue, 31 Aug 2021 19:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241024AbhHaTyG (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:54:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240855AbhHaTyF (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 31 Aug 2021 15:54:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1EC76108B;
        Tue, 31 Aug 2021 19:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630439590;
        bh=gWVE2krHHJdmiWMD3Qxf6lZHqn+EypAzpF8Mvg5iX1U=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=lf2ldoh8kkL0XEugR1zRHurDpLUsczF05DD6ETz58W9BpwuYrDXjp5+GI9kzysEoc
         fNsQlhToE5LXDH7MZPWJYvR/f08J2Z7pdNEEjpSej5IpNoim46Jdrg4qzT7+S77TRl
         1ATRcqorM77Y9p1xHYq+zF874j8CgsOHqczthxaQYiGiX+ePkK1iSewg2VL92kd+ED
         6Rr7S8ljv/GqOJVWl79BVZBQ/at22zzLk1xQg3VsmkVLT0enIthAegFiiXWoY9F93H
         dx5mNc+/4Qfv0tN/FzJKCNkSw8QPJM1cP3ulG+qlXN6LitH18xJyJmF9f4hes8B3BE
         awPU3Xd+yCOVA==
Date:   Tue, 31 Aug 2021 21:53:06 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        syzbot <syzbot+9b57a46bf1801ce2a2ca@syzkaller.appspotmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Michal Kubecek <mkubecek@suse.cz>,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in hid_submit_ctrl/usb_submit_urb
In-Reply-To: <20210831133438.GA365946@rowland.harvard.edu>
Message-ID: <nycvar.YFH.7.76.2108312152340.15313@cbobk.fhfr.pm>
References: <20210819195300.GA8613@rowland.harvard.edu> <000000000000c322ab05c9f2e880@google.com> <20210820140620.GA35867@rowland.harvard.edu> <nycvar.YFH.7.76.2108241351490.15313@cbobk.fhfr.pm> <CAO-hwJ+i4MqOj0umUW9kFgYSZLt3QMb6hDZHQwb8AKH9pKxSTg@mail.gmail.com>
 <20210831133438.GA365946@rowland.harvard.edu>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Tue, 31 Aug 2021, Alan Stern wrote:

> > Alan, would you mind resending the patch with the various tags with a
> > commit description? (unless I missed it...)
> 
> Will do.  I'm rather busy today, so it may have to wait until tomorrow.

Thanks. I'll wait with my pull request to Linus for tomorrow then, to make 
sure we get the fix into -rc1 already.

-- 
Jiri Kosina
SUSE Labs

