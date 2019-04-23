From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] Input: uinput: Avoid Object-Already-Free with a
 global lock
Date: Tue, 23 Apr 2019 13:15:40 +0100
Message-ID: <20190423121539.GM2217@ZenIV.linux.org.uk>
References: <7299a6db-38b7-75c7-633a-00d2257eba45@codeaurora.org>
 <20190418014321.dptin7tpxpldhsns@penguin>
 <bb92c3f2-faf1-04ec-4c67-3aba56c507a9@codeaurora.org>
 <a4d1a2f3-1db7-e300-9569-7b7a2fadd64e@codeaurora.org>
 <20190419071152.x5ghvbybjhv76uxt@penguin>
 <f3cd46fb-2bb1-0422-b2be-3f7625ec9c4e@codeaurora.org>
 <20190423032839.xvbldglrmjxkdntj@penguin>
 <17f4a0be-ab04-8537-9197-32fbca807f3f@codeaurora.org>
 <20190423084944.gj2boxfcg7lp4zad@penguin>
 <20190423110611.GL2217@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190423110611.GL2217@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: Mukesh Ojha <mojha@codeaurora.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Gaurav Kohli <gkohli@codeaurora.org>, Peter Hutterer <peter.hutterer@who-t.net>, Martin Kepplinger <martink@posteo.de>, "Paul E. McKenney" <paulmck@linux.ibm.com>
List-Id: linux-input@vger.kernel.org

On Tue, Apr 23, 2019 at 12:06:12PM +0100, Al Viro wrote:
> On Tue, Apr 23, 2019 at 08:49:44AM +0000, dmitry.torokhov@gmail.com wrote:
> > On Tue, Apr 23, 2019 at 12:51:13PM +0530, Mukesh Ojha wrote:
> 
> > > I have taken care this case from ioctl and release point of view.
> > > 
> > > Even if the release gets called first it will make the
> > > file->private_data=NULL.
> > > and further call to ioctl will not be a problem as the check is already
> > > there.
> > 
> > Al, do we have any protections in VFS layer from userspace hanging onto
> > a file descriptor and calling ioctl() on it even as another thread
> > calls close() on the same fd?
> > 
> > Should the issue be solved by individual drivers, or more careful
> > accounting for currently running operations is needed at VFS layer?
> 
> Neither.  An overlap of ->release() and ->ioctl() is possible only
> if you've got memory corruption somewhere.
> 
> close() overlapping ioctl() is certainly possible, and won't trigger
> that at all - sys_ioctl() holds onto reference to struct file, so
> its refcount won't reach zero until we are done with it.

I'd like to see a reproducer; _if_ we are really getting such overlaps,
we have something buggering struct file refcounts (e.g. stray fput()
eventually leading to dangling pointer in descriptor table) or an
outright memory corruption mangling descriptor table/kernel stack/
refcount/->private_data/etc.

Details, please - I tried to google some context for that, but hadn't
found anything useful ;-/
