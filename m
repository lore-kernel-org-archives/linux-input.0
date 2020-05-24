Return-Path: <SRS0=tlcf=7G=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E0FC433E0
	for <linux-input@archiver.kernel.org>; Sun, 24 May 2020 11:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B975120823
	for <linux-input@archiver.kernel.org>; Sun, 24 May 2020 11:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590319368;
	bh=vxjidV+o2Zato0RAyIvJcJditbT+FyBOCaV10Y80YQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eputkTxhRW5I0jy5KEPAC6m20tQ9UZfsgWF/Gi3XMNn0S7D+N4AfyLkEhxuJhYwCB
	 pzoGqZjUKjdybY5nmVpX4YKIc46YpBglZgI5dPc+OKvDjIVPU+GqD8CQXh4r/r9LtN
	 NNVpxKBrPPDLjIAVeMILjHO7D7D53zoT5ZZa+yFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgEXLWs (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 24 May 2020 07:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728405AbgEXLWs (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 24 May 2020 07:22:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C0FF2076C;
        Sun, 24 May 2020 11:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590319367;
        bh=vxjidV+o2Zato0RAyIvJcJditbT+FyBOCaV10Y80YQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Im33GO9LfLxWwBjtMKGvnzdPvsLx2KCug4xfziF2buJwpIRRH1AJW+Gl0a+FVubuj
         SmdxHyT7QCnuLc+nmAXSAjCbEqziNmy7YCwakN/uS+p+2p4FUsj/Rv4SvRGOoNc6bG
         uf4o0tti7P7Ulw7CWsD3MU0CvIyBlNyTtvNTs7Q4=
Date:   Sun, 24 May 2020 13:22:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     syzbot <syzbot+20458a5eab138777efc9@syzkaller.appspotmail.com>
Cc:     brendanhiggins@google.com, dmitry.torokhov@gmail.com,
        heikki.krogerus@linux.intel.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        rdunlap@infradead.org, rydberg@bitmath.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in evdev_cleanup
Message-ID: <20200524112244.GA1919625@kroah.com>
References: <0000000000007ae41505a66243fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007ae41505a66243fb@google.com>
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
> console output: https://syzkaller.appspot.com/x/log.txt?x=14f54441100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3f6dbdea4159fb66
> dashboard link: https://syzkaller.appspot.com/bug?extid=20458a5eab138777efc9
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133e254a100000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dbf016100000
> 
> The bug was bisected to:
> 
> commit 4ef12f7198023c09ad6d25b652bd8748c965c7fa
> Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Date:   Wed May 13 15:18:40 2020 +0000
> 
>     kobject: Make sure the parent does not get released before its children

All issues that point to this commit can be now marked invalid as it has
been reverted in Linus's tree.

thanks,

greg k-h
