From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: xpad - power off wireless 360 controllers on
 suspend
Date: Wed, 27 Jul 2016 17:29:44 -0700
Message-ID: <20160728002944.GF24351@dtor-ws>
References: <6203d65c-4e15-c44c-edc9-d47cc78f1c28@gmail.com>
 <20160727213222.GB24351@dtor-ws>
 <20160727213912.GD24351@dtor-ws>
 <8a8bea8a-69c4-3f2f-c32c-151b3076e7cb@gmail.com>
 <20160728000416.GE24351@dtor-ws>
 <4fdf587c-0d51-68ca-edc6-5978d9bfa0ca@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34908 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162467AbcG1A3s (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jul 2016 20:29:48 -0400
Received: by mail-pa0-f66.google.com with SMTP id cf3so2517232pad.2
        for <linux-input@vger.kernel.org>; Wed, 27 Jul 2016 17:29:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4fdf587c-0d51-68ca-edc6-5978d9bfa0ca@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>
Cc: rojtberg@gmail.com, linux-input@vger.kernel.org

On Wed, Jul 27, 2016 at 05:10:41PM -0700, Cameron Gutman wrote:
> On 07/27/2016 05:04 PM, Dmitry Torokhov wrote:
> > On Wed, Jul 27, 2016 at 04:24:06PM -0700, Cameron Gutman wrote:
> >> On 07/27/2016 02:39 PM, Dmitry Torokhov wrote:
> >>> On Wed, Jul 27, 2016 at 02:32:22PM -0700, Dmitry Torokhov wrote:
> >>>> On Mon, Jul 25, 2016 at 10:35:08PM -0700, Cameron Gutman wrote:
> >>>>> When the USB wireless adapter is suspended, the controllers
> >>>>> lose their connection. This causes them to start flashing
> >>>>> their LED rings and searching for the wireless adapter
> >>>>> again, wasting the controller's battery power.
> >>>>>
> >>>>> Instead, we will tell the controllers to power down when
> >>>>> we suspend. This mirrors the behavior of the controllers
> >>>>> when connected to the console itself and how the official
> >>>>> Xbox One wireless adapter behaves on Windows.
> >>>>>
> >>>>> Signed-off-by: Cameron Gutman <aicommander@gmail.com>
> >>>>> ---
> >>>>> This patch is independent of the other xpad patch [0] that I
> >>>>> submitted (and decided to wait on). It applies against
> >>>>> unmodified xpad.c in master.
> >>>>>
> >>>>> [0] http://www.spinics.net/lists/linux-input/msg46062.html
> >>>>> ---
> >>>>>  drivers/input/joystick/xpad.c | 43 +++++++++++++++++++++++++++++++++++++++++++
> >>>>>  1 file changed, 43 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> >>>>> index a529a45..3408019 100644
> >>>>> --- a/drivers/input/joystick/xpad.c
> >>>>> +++ b/drivers/input/joystick/xpad.c
> >>>>> @@ -115,6 +115,10 @@ static bool sticks_to_null;
> >>>>>  module_param(sticks_to_null, bool, S_IRUGO);
> >>>>>  MODULE_PARM_DESC(sticks_to_null, "Do not map sticks at all for unknown pads");
> >>>>>  
> >>>>> +static bool disable_auto_poweroff;
> >>>>> +module_param(disable_auto_poweroff, bool, S_IRUGO);
> >>>>> +MODULE_PARM_DESC(disable_auto_poweroff, "Do not power off wireless controllers on suspend");
> >>>>
> >>>> Why negating? Why not do
> >>>>
> >>>> static bool xpad_auto_poweroff = true;
> >>>>
> >>>> ?
> >>>>
> >>>> (No need to resubmit if agree/disagree, I can fix up on my side).
> >>
> >> Yeah, sounds fine to make it default Y and get rid of the negation.
> >>
> >> I'm fine with it if you want to make that change and apply it. See my
> >> comments below about the other issues.
> >>
> >>>
> >>> By the way, I think we can allow root writing to it, there is nothing
> >>> that stops us from changing behavior at runtime.
> >>
> >> Yep, I was following the convention of the existing module params. They
> >> can probably all be changed to allow root writing.
> > 
> > My rule of thumb is we allow writing if behavior changes immediately.
> > The other parameters only affect devices that will be bound after the
> > parameter has been changed, which woudl be confusing. So they are RO and
> > you have to specify them at module load time.
> > 
> > Thanks.
> > 
> 
> Sounds reasonable. Would you like to make the permission change also or
> do you prefer I resubmit the patch with those 2 modifications?

No, I made them. If you have a moment please take a look at my "next"
branch on kernel.org.

-- 
Dmitry
