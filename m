Return-Path: <SRS0=Nb3C=7S=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46D8C433E0
	for <linux-input@archiver.kernel.org>; Fri,  5 Jun 2020 04:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA1E207D5
	for <linux-input@archiver.kernel.org>; Fri,  5 Jun 2020 04:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591330803;
	bh=yr2lNhySyjTAqk88/DfbvYyzTWs9YwgsZWVXVbcavpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QqJo/RetcyQHF3LKpEzOGjN3yQQyyRJo75DFaAZdkwbc9C138k8Fbj274rtHAPyPf
	 v5q1+h6SCcjJb1ISI3+EHrHldkF3CYTZzVTCuwbtSe4+FoNOJQ4fu3svoYgeV+7FHg
	 gE5PPI3PGJCp0EfDDoMFNNTb0h7QyE8cXTrlxNWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgFEEUC (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 5 Jun 2020 00:20:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgFEEUC (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 5 Jun 2020 00:20:02 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D21F207D3;
        Fri,  5 Jun 2020 04:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591330802;
        bh=yr2lNhySyjTAqk88/DfbvYyzTWs9YwgsZWVXVbcavpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=POyhlySDRQUiXLxTsatMNVSI3oKUO4CvD8DMQAzplIYRjaf6mwcUd2TZXJwTDMX6i
         fOz2/wDLdML9InRkGJ59ah7r9xuN1DItmDY3uy7bFxnJfalSxdvej+s2+GvfOnyfQT
         1pwb8xXJfYLUxy+aoQmzDBP40GcFVcYh5kg5QI/0=
Date:   Thu, 4 Jun 2020 21:20:00 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+833ac95f0a2451d63a9f@syzkaller.appspotmail.com>
Cc:     brendanhiggins@google.com, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael.j.wysocki@intel.com, rdunlap@infradead.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in joydev_cleanup
Message-ID: <20200605042000.GK2667@sol.localdomain>
References: <0000000000007f040505a6624308@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007f040505a6624308@google.com>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sun, May 24, 2020 at 03:24:12AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    c11d28ab Add linux-next specific files for 20200522
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1587269a100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3f6dbdea4159fb66
> dashboard link: https://syzkaller.appspot.com/bug?extid=833ac95f0a2451d63a9f
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1114d626100000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c4da9a100000
> 
> The bug was bisected to:
> 
> commit 4ef12f7198023c09ad6d25b652bd8748c965c7fa
> Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Date:   Wed May 13 15:18:40 2020 +0000
> 
>     kobject: Make sure the parent does not get released before its children
> 

Commit was reverted.

#syz invalid
