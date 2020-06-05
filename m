Return-Path: <SRS0=Nb3C=7S=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931C2C433DF
	for <linux-input@archiver.kernel.org>; Fri,  5 Jun 2020 04:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BB8A207D3
	for <linux-input@archiver.kernel.org>; Fri,  5 Jun 2020 04:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591330874;
	bh=HPBz3bEE1JJprSdQmAaivjDc+V/hPAnqgVqPd5/obIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tDVpv2fyvKXI5CUUKuq+PJBBlSeKtI+b4OyR5Wqqv6G59G6zgtjXm+hLSdq8yoHHk
	 pIkWQZd+Fqqgh6pnwRWMVVDchOSpBhyJEpOUATsQaSZZiuyxXzcCooW/pkJxp0hI5I
	 ziVqle7yDC+CRyyPGNpdivongKxbXDKh15+o42dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgFEEVN (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 5 Jun 2020 00:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgFEEVN (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 5 Jun 2020 00:21:13 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 260B8206E6;
        Fri,  5 Jun 2020 04:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591330873;
        bh=HPBz3bEE1JJprSdQmAaivjDc+V/hPAnqgVqPd5/obIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bkhq0XGSCLnXIpq4nIRYxNClZQvfffiRaSb12Dtoe/sRGAwQ+Bv05ax2wuPmEK/pd
         gkGURJ93CPxS0jgxWt0lDY2qo80L4TxQMnXDR9OK94GVRERWppy7Wf5bZKRdwXUZqg
         TfH71+6nTMgEr16DkIBo4qHQlT8crSIpbHYqdlzY=
Date:   Thu, 4 Jun 2020 21:21:11 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+29b33f3f410e564731f1@syzkaller.appspotmail.com>
Cc:     brendanhiggins@google.com, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael.j.wysocki@intel.com, rdunlap@infradead.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in mousedev_cleanup
Message-ID: <20200605042111.GN2667@sol.localdomain>
References: <00000000000041728005a653bcd7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000041728005a653bcd7@google.com>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sat, May 23, 2020 at 10:04:14AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    c11d28ab Add linux-next specific files for 20200522
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=119c3f06100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3f6dbdea4159fb66
> dashboard link: https://syzkaller.appspot.com/bug?extid=29b33f3f410e564731f1
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135ffa9a100000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1076acba100000
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
