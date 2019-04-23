From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: uinput: Avoid Object-Already-Free with a
 global lock
Date: Tue, 23 Apr 2019 03:28:39 +0000
Message-ID: <20190423032839.xvbldglrmjxkdntj@penguin>
References: <1554883176-24318-1-git-send-email-mojha@codeaurora.org>
 <7299a6db-38b7-75c7-633a-00d2257eba45@codeaurora.org>
 <20190418014321.dptin7tpxpldhsns@penguin>
 <bb92c3f2-faf1-04ec-4c67-3aba56c507a9@codeaurora.org>
 <a4d1a2f3-1db7-e300-9569-7b7a2fadd64e@codeaurora.org>
 <20190419071152.x5ghvbybjhv76uxt@penguin>
 <f3cd46fb-2bb1-0422-b2be-3f7625ec9c4e@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f3cd46fb-2bb1-0422-b2be-3f7625ec9c4e@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mukesh Ojha <mojha@codeaurora.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Gaurav Kohli <gkohli@codeaurora.org>, Peter Hutterer <peter.hutterer@who-t.net>, Martin Kepplinger <martink@posteo.de>, "Paul E. McKenney" <paulmck@linux.ibm.com>
List-Id: linux-input@vger.kernel.org

On Fri, Apr 19, 2019 at 02:13:48PM +0530, Mukesh Ojha wrote:
> 
> On 4/19/2019 12:41 PM, dmitry.torokhov@gmail.com wrote:
> > Hi Mukesh,
> > 
> > On Fri, Apr 19, 2019 at 12:17:44PM +0530, Mukesh Ojha wrote:
> > > For some reason my last mail did not get delivered,  sending it again.
> > > 
> > > 
> > > On 4/18/2019 11:55 AM, Mukesh Ojha wrote:
> > > > 
> > > > On 4/18/2019 7:13 AM, dmitry.torokhov@gmail.com wrote:
> > > > > Hi Mukesh,
> > > > > 
> > > > > On Mon, Apr 15, 2019 at 03:35:51PM +0530, Mukesh Ojha wrote:
> > > > > > Hi Dmitry,
> > > > > > 
> > > > > > Can you please have a look at this patch ? as this seems to reproducing
> > > > > > quite frequently
> > > > > > 
> > > > > > Thanks,
> > > > > > Mukesh
> > > > > > 
> > > > > > On 4/10/2019 1:29 PM, Mukesh Ojha wrote:
> > > > > > > uinput_destroy_device() gets called from two places. In one place,
> > > > > > > uinput_ioctl_handler() where it is protected under a lock
> > > > > > > udev->mutex but there is no protection on udev device from freeing
> > > > > > > inside uinput_release().
> > > > > uinput_release() should be called when last file handle to the uinput
> > > > > instance is being dropped, so there should be no other users and thus we
> > > > > can't be racing with anyone.
> > > > Lets say an example where i am creating input device quite frequently
> > > > 
> > > > [   97.836603] input: syz0 as /devices/virtual/input/input262
> > > > [   97.845589] input: syz0 as /devices/virtual/input/input261
> > > > [   97.849415] input: syz0 as /devices/virtual/input/input263
> > > > [   97.856479] input: syz0 as /devices/virtual/input/input264
> > > > [   97.936128] input: syz0 as /devices/virtual/input/input265
> > > > 
> > > > e.g input265
> > > > 
> > > > while input265 gets created [1] and handlers are getting registered on
> > > > that device*fput* gets called on
> > > > that device as user space got to know that input265 is created and its
> > > > reference is still 1(rare but possible).
> > Are you saying that there are 2 threads sharing the same file
> > descriptor, one issuing the registration ioctl while the other closing
> > the same fd?
> 
> Dmitry,
> 
> I don't have a the exact look inside the app here, but this looks like the
> same as it is able to do
> fput on the uinput device.
> 
> FYI
> Syskaller app is running in userspace (which is for syscall fuzzing) on
> kernel which is enabled
> with various config fault injection, FAULT_INJECTION,FAIL_SLAB,
> FAIL_PAGEALLOC, KASAN etc.

Mukesh,

We need to understand exactly the failure mode. I do not think that
introducing another mutex into uinput actually fixes the issue, as we do
not order mutex acquisition, so I think it is still possible for the
release function to acquire the mutex and run first, and then ioctl
would run with freed object.

My guess that this needs to be fixed in VFS layer.

Thanks.

-- 
Dmitry
