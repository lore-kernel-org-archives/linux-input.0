From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Use for_each_set_bit where appropriate
Date: Mon, 21 Sep 2015 15:58:14 -0700
Message-ID: <20150921225814.GB20559@dtor-ws>
References: <1436378929-65748-1-git-send-email-aksgarg1989@gmail.com>
 <1442520167.3355.13.camel@redhat.com>
 <20150919182622.GF7081@dtor-ws>
 <1442845851.5133.0.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33689 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756538AbbIUW6S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Sep 2015 18:58:18 -0400
Received: by pacex6 with SMTP id ex6so129085261pac.0
        for <linux-input@vger.kernel.org>; Mon, 21 Sep 2015 15:58:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1442845851.5133.0.camel@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Chandler Paul <cpaul@redhat.com>
Cc: aksgarg1989@gmail.com, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, Sep 21, 2015 at 10:30:51AM -0400, Stephen Chandler Paul wrote:
> On Sat, 2015-09-19 at 11:26 -0700, Dmitry Torokhov wrote:
> > On Thu, Sep 17, 2015 at 04:02:47PM -0400, Stephen Chandler Paul
> > wrote:
> > > Hi! The currently upstream version of this patch actually breaks
> > > uinput, and causes the kernel to panic when attempting to run it
> > > under
> > > qemu using spice. Here's a backtrace from kdb:
> > > 
> > > Stack traceback for pid 656
> > > 0xffff8800babed480      656        1  1    2   R 
> > >  0xffff8800babefa80 *spice-vdagentd
> > >  ffff88013747bd58 0000000000000018 ffff88013747bd80
> > > ffff8800b7977000
> > >  0000000000000003 0000000000000001 0000000000000001
> > > ffff8800b7977240
> > >  ffff88013747bdc0 ffffffff8163f449 0000000000000286
> > > 0000000000000018
> > > Call Trace:
> > >  [<ffffffff8163f449>] ? input_event+0x59/0x80
> > >  [<ffffffffa0509234>] ? uinput_write+0x154/0x460 [uinput]
> > >  [<ffffffffa00e704d>] ? port_fops_read+0xfd/0x1f0 [virtio_console]
> > >  [<ffffffff81261627>] ? __vfs_write+0x37/0x100
> > >  [<ffffffff81261ff9>] ? vfs_write+0xa9/0x1a0
> > >  [<ffffffff81283386>] ? __fget_light+0x66/0x90
> > >  [<ffffffff81262cf8>] ? SyS_write+0x58/0xd0
> > >  [<ffffffff81833c72>] ? entry_SYSCALL_64_fastpath+0x12/0x76
> > > 
> > > And the relevant messages from dmesg:
> > > 
> > > <1>[   15.064330] BUG: unable to handle kernel NULL pointer
> > > dereference at 0000000000000024
> > > <1>[   15.064336] IP: [<ffffffff8163f142>]
> > > input_handle_event+0x232/0x4e0
> > > <4>[   15.064343] PGD 0 
> > > <4>[   15.064345] Oops: 0000 [#1] SMP
> > > 
> > > The steps for reproducing this are pretty simple: setup a Fedora 22
> > > VM,
> > > build the latest kernel and install it with make install, and try
> > > to
> > > boot the machine and use it over spice with qemu. After moving the
> > > cursor it'll run into a NULL dereference and panic.
> > > 
> > > I've tested reverting this commit, and that fixes the NULL
> > > dereference
> > > completely. I'm willing to git send-email you the revert if wish.
> > 
> > *sigh* Sorry about that, the 2nd chunk of the change was completely
> > bogus.
> > 
> > Does the patch below fixes this for you?
> Yep! Applied it to my local tree, and the virtual machine appears to
> have no issues now.

Thanks Lyude!

-- 
Dmitry
