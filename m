From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [BUG] capslock works across all keyboards but LED does not
Date: Tue, 23 Oct 2012 09:20:17 +0800
Message-ID: <CACVXFVMbc3eBMj4gcAVDZjB4SJYwbLeVzUi13C62FMVYymgFug@mail.gmail.com>
References: <CACVXFVM8soazSixttzDBq-zLAxCpVNBDsDoz4Hc9gdsU8WQniA@mail.gmail.com>
	<21783709.sVZtM4k8zF@dtor-d630.eng.vmware.com>
	<CACVXFVN8s52UiSF0Q98sXNZzR9srnZ9aUjNYcZU6hDPfNzRGgA@mail.gmail.com>
	<20121022155446.GB13791@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:44504 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932409Ab2JWBUT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Oct 2012 21:20:19 -0400
Received: from mail-ea0-f174.google.com ([209.85.215.174])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1TQTAI-0001Mk-9w
	for linux-input@vger.kernel.org; Tue, 23 Oct 2012 01:20:18 +0000
Received: by mail-ea0-f174.google.com with SMTP id c13so1004846eaa.19
        for <linux-input@vger.kernel.org>; Mon, 22 Oct 2012 18:20:18 -0700 (PDT)
In-Reply-To: <20121022155446.GB13791@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, Oct 22, 2012 at 11:54 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Keyboard LEDs are controlled by the kernel unless console is in the raw
> mode (X), in which case it is left to userspace. I see it on my box that
> sync between keyboards is broken while I am in X (so it is X problem)
> and works when I am in text console (so I do not see the kernel
> problem).
>
> Since it does not work for you in text console either your setup must be
> different than mine. If you switch to a text console and do
>
>         sudo lsof /dev/input/event*
>
> what do you see?

- lsof output from text console

lsof: WARNING: can't stat() fuse.gvfs-fuse-daemon file system /home/tom/.gvfs
      Output information may be incomplete.
COMMAND  PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
upowerd 2956 root   13r   CHR  13,64      0t0 7050 /dev/input/event0


- lsof output from X
[tom@~]$sudo lsof /dev/input/event*
[sudo] password for tom:
lsof: WARNING: can't stat() fuse.gvfs-fuse-daemon file system /home/tom/.gvfs
      Output information may be incomplete.
COMMAND  PID USER   FD   TYPE DEVICE SIZE/OFF  NODE NAME
Xorg    2110 root   12u   CHR  13,66      0t0  7052 /dev/input/event2
Xorg    2110 root   13u   CHR  13,70      0t0 10099 /dev/input/event6
Xorg    2110 root   14u   CHR  13,65      0t0  7051 /dev/input/event1
Xorg    2110 root   15u   CHR  13,71      0t0 13213 /dev/input/event7
Xorg    2110 root   16u   CHR  13,67      0t0  7058 /dev/input/event3
Xorg    2110 root   19u   CHR  13,69      0t0  7255 /dev/input/event5
Xorg    2110 root   52u   CHR  13,73      0t0 27009 /dev/input/event9
upowerd 2956 root   13r   CHR  13,64      0t0  7050 /dev/input/event0


Thanks,
--
Ming Lei
