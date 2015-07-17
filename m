From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input-polldev:Check poll_interval range while
 registering input device
Date: Fri, 17 Jul 2015 14:29:18 -0700
Message-ID: <20150717212918.GA39282@dtor-ws>
References: <aksgarg1989@gmail.com>
 <1437069433-76366-1-git-send-email-aksgarg1989@gmail.com>
 <20150716193510.GE32571@dtor-ws>
 <CA+HOOsjQ9=dVvet0bZ9uToVHGMXg26w6vBpDtFH4vjcX8nbpgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36383 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbbGQV3X (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jul 2015 17:29:23 -0400
Received: by pachj5 with SMTP id hj5so66902436pac.3
        for <linux-input@vger.kernel.org>; Fri, 17 Jul 2015 14:29:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+HOOsjQ9=dVvet0bZ9uToVHGMXg26w6vBpDtFH4vjcX8nbpgA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anshul Garg <aksgarg1989@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, Jul 17, 2015 at 07:11:04PM +0530, Anshul Garg wrote:
> Hi Mr. Dmitry
> ,
> 
> 
> 
> On Fri, Jul 17, 2015 at 1:05 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > Hi Anshul,
> >
> > On Thu, Jul 16, 2015 at 10:57:13AM -0700, Anshul Garg wrote:
> >> Added check for poll_interval range in input_register_polled_device
> >> function similar to input_polldev_set_poll function.
> >>
> >> Signed-off-by: Anshul Garg <aksgarg1989@gmail.com>
> >> ---
> >>  drivers/input/input-polldev.c |    6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/input/input-polldev.c b/drivers/input/input-polldev.c
> >> index 3664f81..0e88a9e 100644
> >> --- a/drivers/input/input-polldev.c
> >> +++ b/drivers/input/input-polldev.c
> >> @@ -309,6 +309,12 @@ int input_register_polled_device(struct input_polled_dev *dev)
> >>
> >>       input_set_drvdata(input, dev);
> >>       INIT_DELAYED_WORK(&dev->work, input_polled_device_work);
> >> +
> >> +     if (dev->poll_interval > dev->poll_interval_max ||
> >> +                     dev->poll_interval < dev->poll_interval_min) {
> >> +             pr_err("Poll interval Range incorrect\n");
> >> +             return -EINVAL;
> >> +     }
> >
> > What driver was this change tested with?
> I have not checked this change for any driver.
> 

Yes, I know that you did not test it because if you would have tested it
you would have noticed that it breaks existing devices, since hardly
any of them set dev->poll_interval_max and instead rely on the polldev
code to apply reasonable defaults.

There have been a few patches that had errors that would have been
easily caught if you tested the changes. Please next time you submit a
patch mention how you tested it to make sure it works as intended.

Thanks.

-- 
Dmitry
