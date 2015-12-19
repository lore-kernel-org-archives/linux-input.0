From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: uinput - add new UINPUT_DEV_SETUP and
 UI_ABS_SETUP ioctl
Date: Fri, 18 Dec 2015 17:50:12 -0800
Message-ID: <20151219015012.GC26333@dtor-ws>
References: <1440515579-5359-1-git-send-email-benjamin.tissoires@redhat.com>
 <20151024225341.GA17120@dtor-pixel>
 <CANq1E4TLDMjbfMY-rOM7M8VE_EKejk5DmbPF_BgwNtRwbJV-Aw@mail.gmail.com>
 <20151028151006.GB20468@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:32898 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbbLSBuP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Dec 2015 20:50:15 -0500
Content-Disposition: inline
In-Reply-To: <20151028151006.GB20468@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Wed, Oct 28, 2015 at 11:10:06AM -0400, Benjamin Tissoires wrote:
> Hi,
> 
> On Oct 25 2015 or thereabouts, David Herrmann wrote:
> > Hi
> > 
> > On Sun, Oct 25, 2015 at 12:53 AM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > > Hi Benjamin,
> > >
> > > On Tue, Aug 25, 2015 at 11:12:59AM -0400, Benjamin Tissoires wrote:
> > >> +static int uinput_abs_setup(struct uinput_device *udev,
> > >> +                         struct uinput_setup __user *arg, size_t size)
> > >> +{
> > >> +     struct uinput_abs_setup setup = {};
> > >> +     struct input_dev *dev;
> > >> +
> > >> +     if (size > sizeof(setup))
> > >> +             return -E2BIG;
> > >> +     if (udev->state == UIST_CREATED)
> > >> +             return -EINVAL;
> > >> +     if (copy_from_user(&setup, arg, size))
> > >> +             return -EFAULT;
> > >> +     if (setup.code > ABS_MAX)
> > >> +             return -ERANGE;
> > >> +
> > >> +     dev = udev->dev;
> > >> +
> > >> +     input_alloc_absinfo(dev);
> > >> +     if (!dev->absinfo)
> > >> +             return -ENOMEM;
> > >> +
> > >> +     set_bit(setup.code, dev->absbit);
> > >> +     dev->absinfo[setup.code] = setup.absinfo;
> > >> +
> > >> +     /*
> > >> +      * We restore the state to UIST_NEW_DEVICE because the user has to call
> > >> +      * UI_DEV_SETUP in the last place before UI_DEV_CREATE to check the
> > >> +      * validity of the absbits.
> > >> +      */
> > >
> > > Do we have to be this strict? It seems to me that with the new IOCTLs
> > > you naturally want to use the new ioctl to setup the device, then adjust
> > > various axes and bits and then validate everything.
> > 
> > Indeed, we now force the order to be abs-setup first, then
> > device-setup as last step. Appended is a follow-up patch to cleanup
> > ABS handling in uinput. It is untested. Benjamin, care to give it a
> > spin?
> > 
> 
> Sorry it took so long for the tests/review.
> 
> So the test part is fine. It works as expected. (Tested-by: BT
> <benjamin.tissoires@redhat.com>)
> 
> For the review part, everything looks good except that now the doc for
> UI_ABS_SETUP in uapi/linux/uinput.h should be changed to reflect the
> fact that UI_DEV_SETUP is not a pre-requirement before calling
> UI_ABS_SETUP.
> 
> With the doc change, the patch is also Reviewed-by: me.

OK, I applied the original and also adjusted the docs and applied this
one as a separate patch.

Thanks.

-- 
Dmitry
