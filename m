Return-Path: <SRS0=Nb3C=7S=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5F1C433E0
	for <linux-input@archiver.kernel.org>; Fri,  5 Jun 2020 04:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF46207D5
	for <linux-input@archiver.kernel.org>; Fri,  5 Jun 2020 04:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591330742;
	bh=VN0ik2TYEZZIvqEvEgU7z+srHbryyBYf8JHFGdryclI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2ZkHnNYgH+vp4Pf5MrB+xn+0Z4LbTzgOTwN3HD1Yfej+tuJYw9W5OMPAze0js0slA
	 jOzHne4pd5ki8OGnc25wIqZnSEf6fk95KAh3XIUl+LH57QRcYaI96cH2SmRS+ejtbc
	 Vh4A4Zc51j4JhvmTHj24s+qrC2Fs7KC10SOeWBVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgFEETB (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 5 Jun 2020 00:19:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgFEETB (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 5 Jun 2020 00:19:01 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11DCF207D3;
        Fri,  5 Jun 2020 04:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591330741;
        bh=VN0ik2TYEZZIvqEvEgU7z+srHbryyBYf8JHFGdryclI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XT0qg7eC5OYl3JEMDNB8eQ9l7V9FVlscmHhItoVJtgB2weYTX2O2AOWsKWkAwgIPO
         vVpxLZwrMIVNo0PcNAa/IBMuS3c4aUc1YkwClwEKRPtfKCrFbgCPJs+vdF4PK0pePt
         /3dNEEt8OqMjBEpUjV2k4z2YJrZlstJrUD6uKjww=
Date:   Thu, 4 Jun 2020 21:18:59 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+20458a5eab138777efc9@syzkaller.appspotmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, brendanhiggins@google.com,
        dmitry.torokhov@gmail.com, heikki.krogerus@linux.intel.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael.j.wysocki@intel.com, rdunlap@infradead.org,
        rydberg@bitmath.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in evdev_cleanup
Message-ID: <20200605041859.GJ2667@sol.localdomain>
References: <0000000000007ae41505a66243fb@google.com>
 <20200524112244.GA1919625@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524112244.GA1919625@kroah.com>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Sun, May 24, 2020 at 01:22:44PM +0200, Greg KH wrote:
> On Sun, May 24, 2020 at 03:24:12AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    c11d28ab Add linux-next specific files for 20200522
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14f54441100000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3f6dbdea4159fb66
> > dashboard link: https://syzkaller.appspot.com/bug?extid=20458a5eab138777efc9
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133e254a100000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dbf016100000
> > 
> > The bug was bisected to:
> > 
> > commit 4ef12f7198023c09ad6d25b652bd8748c965c7fa
> > Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Date:   Wed May 13 15:18:40 2020 +0000
> > 
> >     kobject: Make sure the parent does not get released before its children
> 
> All issues that point to this commit can be now marked invalid as it has
> been reverted in Linus's tree.
> 

This is the way to invalidate a syzbot bug report:

#syz invalid
