From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] Input: uinput: Avoid Object-Already-Free with a
 global lock
Date: Wed, 24 Apr 2019 14:07:11 +0100
Message-ID: <20190424130711.GP2217@ZenIV.linux.org.uk>
References: <20190418014321.dptin7tpxpldhsns@penguin>
 <bb92c3f2-faf1-04ec-4c67-3aba56c507a9@codeaurora.org>
 <a4d1a2f3-1db7-e300-9569-7b7a2fadd64e@codeaurora.org>
 <20190419071152.x5ghvbybjhv76uxt@penguin>
 <f3cd46fb-2bb1-0422-b2be-3f7625ec9c4e@codeaurora.org>
 <20190423032839.xvbldglrmjxkdntj@penguin>
 <17f4a0be-ab04-8537-9197-32fbca807f3f@codeaurora.org>
 <20190423084944.gj2boxfcg7lp4zad@penguin>
 <20190423110611.GL2217@ZenIV.linux.org.uk>
 <5614f04f-827d-1668-9ed0-60d93e110b8e@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5614f04f-827d-1668-9ed0-60d93e110b8e@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mukesh Ojha <mojha@codeaurora.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Gaurav Kohli <gkohli@codeaurora.org>, Peter Hutterer <peter.hutterer@who-t.net>, Martin Kepplinger <martink@posteo.de>, "Paul E. McKenney" <paulmck@linux.ibm.com>
List-Id: linux-input@vger.kernel.org

On Wed, Apr 24, 2019 at 05:40:40PM +0530, Mukesh Ojha wrote:
> 
> Al,
> 
> i tried to put traceprintk inside ioctl after fdget and fdput on a simple
> call of open  => ioctl => close

in a loop, and multithreaded, presumably?

> on /dev/uinput.
> 
>           uinput-532   [002] ....    45.312044: SYSC_ioctl: 2     <= f_count
> >    <After fdget()
>           uinput-532   [002] ....    45.312055: SYSC_ioctl: 2           
> <After fdput()
>           uinput-532   [004] ....    45.313766: uinput_open: uinput: 1
>           uinput-532   [004] ....    45.313783: SYSC_ioctl: 1
>           uinput-532   [004] ....    45.313788: uinput_ioctl_handler:
> uinput: uinput_ioctl_handler, 1
>           uinput-532   [004] ....    45.313835: SYSC_ioctl: 1
>           uinput-532   [004] ....    45.313843: uinput_release: uinput:  0
> 
> 
> So while a ioctl is running the f_count is 1, so a fput could be run and do
> atomic_long_dec_and_test
> this could call release right ?

Look at ksys_ioctl():
int ksys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
{
        int error;
        struct fd f = fdget(fd);
an error or refcount bumped
        if (!f.file)
                return -EBADF;
not an error, then.  We know that ->release() won't be called
until we drop the reference we've just acquired.
        error = security_file_ioctl(f.file, cmd, arg);
        if (!error)
                error = do_vfs_ioctl(f.file, fd, cmd, arg);
... and we are done with calling ->ioctl(), so
        fdput(f);
... we drop the reference we'd acquired.

Seeing refcount 1 inside ->ioctl() is possible, all right:

CPU1: ioctl(2) resolves fd to struct file *, refcount 2
CPU2: close(2) rips struct file * from descriptor table and does fput() to drop it;
	refcount reaches 1 and fput() is done; no call of ->release() yet.
CPU1: we get arouund to ->ioctl(), where your trace sees refcount 1
CPU1: done with ->ioctl(), drop our reference.  *NOW* refcount gets to 0, and
	->release() is called.

IOW, in your trace fput() has already been run by close(2); having somebody else
do that again while we are in ->ioctl() would be a bug (to start with, where
did they get that struct file * and why wasn't that reference contributing to
struct file refcount?)

In all cases we only call ->release() once all references gone - both
the one(s) in descriptor tables and any transient ones acquired by
fdget(), etc.

I would really like to see a reproducer for the original use-after-free report...
