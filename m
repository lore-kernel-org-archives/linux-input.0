From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: uinput: Avoid Object-Already-Free with a
 global lock
Date: Thu, 18 Apr 2019 01:43:21 +0000
Message-ID: <20190418014321.dptin7tpxpldhsns@penguin>
References: <1554883176-24318-1-git-send-email-mojha@codeaurora.org>
 <7299a6db-38b7-75c7-633a-00d2257eba45@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7299a6db-38b7-75c7-633a-00d2257eba45@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mukesh Ojha <mojha@codeaurora.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Gaurav Kohli <gkohli@codeaurora.org>, Peter Hutterer <peter.hutterer@who-t.net>, Martin Kepplinger <martink@posteo.de>, "Paul E. McKenney" <paulmck@linux.ibm.com>
List-Id: linux-input@vger.kernel.org

Hi Mukesh,

On Mon, Apr 15, 2019 at 03:35:51PM +0530, Mukesh Ojha wrote:
> 
> Hi Dmitry,
> 
> Can you please have a look at this patch ? as this seems to reproducing
> quite frequently
> 
> Thanks,
> Mukesh
> 
> On 4/10/2019 1:29 PM, Mukesh Ojha wrote:
> > uinput_destroy_device() gets called from two places. In one place,
> > uinput_ioctl_handler() where it is protected under a lock
> > udev->mutex but there is no protection on udev device from freeing
> > inside uinput_release().

uinput_release() should be called when last file handle to the uinput
instance is being dropped, so there should be no other users and thus we
can't be racing with anyone.

> > 
> > This can result in Object-Already-Free case where uinput parent
> > device already got freed while a child being inserted inside it.
> > That result in a double free case for parent while kernfs_put()
> > being done for child in a failure path of adding a node.

Can you please describe scenario in more detail? How do you free the
parent device while child input device is being registered?

Thanks.

- 
Dmitry
