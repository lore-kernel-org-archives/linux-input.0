From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Use for_each_set_bit where appropriate
Date: Sat, 19 Sep 2015 11:26:22 -0700
Message-ID: <20150919182622.GF7081@dtor-ws>
References: <1436378929-65748-1-git-send-email-aksgarg1989@gmail.com>
 <1442520167.3355.13.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33013 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbbISS00 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Sep 2015 14:26:26 -0400
Received: by pacex6 with SMTP id ex6so78894804pac.0
        for <linux-input@vger.kernel.org>; Sat, 19 Sep 2015 11:26:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1442520167.3355.13.camel@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Chandler Paul <cpaul@redhat.com>
Cc: aksgarg1989@gmail.com, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Sep 17, 2015 at 04:02:47PM -0400, Stephen Chandler Paul wrote:
> Hi! The currently upstream version of this patch actually breaks
> uinput, and causes the kernel to panic when attempting to run it under
> qemu using spice. Here's a backtrace from kdb:
> 
> Stack traceback for pid 656
> 0xffff8800babed480      656        1  1    2   R  0xffff8800babefa80 *spice-vdagentd
>  ffff88013747bd58 0000000000000018 ffff88013747bd80 ffff8800b7977000
>  0000000000000003 0000000000000001 0000000000000001 ffff8800b7977240
>  ffff88013747bdc0 ffffffff8163f449 0000000000000286 0000000000000018
> Call Trace:
>  [<ffffffff8163f449>] ? input_event+0x59/0x80
>  [<ffffffffa0509234>] ? uinput_write+0x154/0x460 [uinput]
>  [<ffffffffa00e704d>] ? port_fops_read+0xfd/0x1f0 [virtio_console]
>  [<ffffffff81261627>] ? __vfs_write+0x37/0x100
>  [<ffffffff81261ff9>] ? vfs_write+0xa9/0x1a0
>  [<ffffffff81283386>] ? __fget_light+0x66/0x90
>  [<ffffffff81262cf8>] ? SyS_write+0x58/0xd0
>  [<ffffffff81833c72>] ? entry_SYSCALL_64_fastpath+0x12/0x76
> 
> And the relevant messages from dmesg:
> 
> <1>[   15.064330] BUG: unable to handle kernel NULL pointer dereference at 0000000000000024
> <1>[   15.064336] IP: [<ffffffff8163f142>] input_handle_event+0x232/0x4e0
> <4>[   15.064343] PGD 0 
> <4>[   15.064345] Oops: 0000 [#1] SMP
> 
> The steps for reproducing this are pretty simple: setup a Fedora 22 VM,
> build the latest kernel and install it with make install, and try to
> boot the machine and use it over spice with qemu. After moving the
> cursor it'll run into a NULL dereference and panic.
> 
> I've tested reverting this commit, and that fixes the NULL dereference
> completely. I'm willing to git send-email you the revert if wish.

*sigh* Sorry about that, the 2nd chunk of the change was completely
bogus.

Does the patch below fixes this for you?

Thanks.

-- 
Dmitry

Input: uinput - fix crash when using ABS events

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Commit b6d30968d86c45a7bb599eaca13ff048d3fa576c (Input: uinput - switch to
using for_each_set_bit()) switched driver to use for_each_set_bit().
However during initial write of the uinput structure that contains min/max
data for all possible axes none of them are reflected in dev->absbit yet
and so we were skipping over all of them and were not allocating absinfo
memory which caused crash later when driver tried to sens EV_ABS events:

<1>[   15.064330] BUG: unable to handle kernel NULL pointer dereference at 0000000000000024
<1>[   15.064336] IP: [<ffffffff8163f142>] input_handle_event+0x232/0x4e0
<4>[   15.064343] PGD 0
<4>[   15.064345] Oops: 0000 [#1] SMP

Fixes: b6d30968d86c45a7bb599eaca13ff048d3fa576c
Cc: stable@vger.kernel.org
Reported-by: Stephen Chandler Paul <cpaul@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/uinput.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 345df9b..5adbced 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -414,7 +414,7 @@ static int uinput_setup_device(struct uinput_device *udev,
 	dev->id.product	= user_dev->id.product;
 	dev->id.version	= user_dev->id.version;
 
-	for_each_set_bit(i, dev->absbit, ABS_CNT) {
+	for (i = 0; i < ABS_CNT; i++) {
 		input_abs_set_max(dev, i, user_dev->absmax[i]);
 		input_abs_set_min(dev, i, user_dev->absmin[i]);
 		input_abs_set_fuzz(dev, i, user_dev->absfuzz[i]);
