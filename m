From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: uinput: Avoid Object-Already-Free with a
 global lock
Date: Fri, 19 Apr 2019 07:11:52 +0000
Message-ID: <20190419071152.x5ghvbybjhv76uxt@penguin>
References: <1554883176-24318-1-git-send-email-mojha@codeaurora.org>
 <7299a6db-38b7-75c7-633a-00d2257eba45@codeaurora.org>
 <20190418014321.dptin7tpxpldhsns@penguin>
 <bb92c3f2-faf1-04ec-4c67-3aba56c507a9@codeaurora.org>
 <a4d1a2f3-1db7-e300-9569-7b7a2fadd64e@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a4d1a2f3-1db7-e300-9569-7b7a2fadd64e@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mukesh Ojha <mojha@codeaurora.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Gaurav Kohli <gkohli@codeaurora.org>, Peter Hutterer <peter.hutterer@who-t.net>, Martin Kepplinger <martink@posteo.de>, "Paul E. McKenney" <paulmck@linux.ibm.com>
List-Id: linux-input@vger.kernel.org

Hi Mukesh,

On Fri, Apr 19, 2019 at 12:17:44PM +0530, Mukesh Ojha wrote:
> For some reason my last mail did not get delivered,  sending it again.
> 
> 
> On 4/18/2019 11:55 AM, Mukesh Ojha wrote:
> > 
> > 
> > On 4/18/2019 7:13 AM, dmitry.torokhov@gmail.com wrote:
> > > Hi Mukesh,
> > > 
> > > On Mon, Apr 15, 2019 at 03:35:51PM +0530, Mukesh Ojha wrote:
> > > > Hi Dmitry,
> > > > 
> > > > Can you please have a look at this patch ? as this seems to reproducing
> > > > quite frequently
> > > > 
> > > > Thanks,
> > > > Mukesh
> > > > 
> > > > On 4/10/2019 1:29 PM, Mukesh Ojha wrote:
> > > > > uinput_destroy_device() gets called from two places. In one place,
> > > > > uinput_ioctl_handler() where it is protected under a lock
> > > > > udev->mutex but there is no protection on udev device from freeing
> > > > > inside uinput_release().
> > > uinput_release() should be called when last file handle to the uinput
> > > instance is being dropped, so there should be no other users and thus we
> > > can't be racing with anyone.
> > 
> > Lets say an example where i am creating input device quite frequently
> > 
> > [   97.836603] input: syz0 as /devices/virtual/input/input262
> > [   97.845589] input: syz0 as /devices/virtual/input/input261
> > [   97.849415] input: syz0 as /devices/virtual/input/input263
> > [   97.856479] input: syz0 as /devices/virtual/input/input264
> > [   97.936128] input: syz0 as /devices/virtual/input/input265
> > 
> > e.g input265
> > 
> > while input265 gets created [1] and handlers are getting registered on
> > that device*fput* gets called on
> > that device as user space got to know that input265 is created and its
> > reference is still 1(rare but possible).

Are you saying that there are 2 threads sharing the same file
descriptor, one issuing the registration ioctl while the other closing
the same fd?

Thanks.

-- 
Dmitry
