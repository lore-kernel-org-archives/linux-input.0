From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: New "ABS_WHEEL2" axis?
Date: Thu, 6 Oct 2011 13:31:09 -0700
Message-ID: <CANRwn3S4XJT=KS1yp8YqAT0e3Da7hfBq2Aen2QzsdzdjTiZQXw@mail.gmail.com>
References: <CANRwn3SH9VO-1P_zAkDopVJRjApnZWpEZWP3YpuXg3cbiCQffg@mail.gmail.com>
	<201110052034.52397.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49035 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757226Ab1JFUbL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2011 16:31:11 -0400
Received: by wyg34 with SMTP id 34so3237948wyg.19
        for <linux-input@vger.kernel.org>; Thu, 06 Oct 2011 13:31:09 -0700 (PDT)
In-Reply-To: <201110052034.52397.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>

On Wed, Oct 5, 2011 at 8:34 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Wednesday, October 05, 2011 12:44:40 PM Jason Gerecke wrote:
>> I'm working on adding support for the recently-announced Cintiq 24HD,
>> and am hashing out most of the details on the linuxwacom mailing list.
>> In the discussions there, it was suggested that we add a new e.g.
>> "ABS_WHEEL2" axis to the input.h header to represent the second touch
>> ring available on the 24HD. I think it's a good idea, but wanted to
>> get some opinions from over here before making a patch. The other
>> option we have available is to use an axis not already in use by the
>> wacom driver (such as ABS_RUDDER), but none have a matching semantic
>> meaning.
>
> And what if next device adds another wheel? And another...
>
> Do these rings only make sense in the context of entire Cintiq device,
> or maybe they should be treated as ancillary devices (with separate
> input_dev from the main tablet device)?
>
> Thanks.
>
> --
> Dmitry
>

The rings are controls built into the "pad" -- the hardware you bring
the stylus in proximity to. Along with the touch rings, there are also
buttons and touch strips. Now, some devices have controls on only the
left-hand side of the pad, while others have the controls on both
sides of the pad. While one could argue that this makes each "side" a
complete context that can be broken apart into separate devices, that
doesn't really solve anything. What's stopping us from grouping
several rings together?

>From a practical standpoint, I don't see tablets with more than two
rings on the horizon. The rings already have mode-switch buttons,
obviating the need for more than one ring per hand. And since the user
only has two hands, it makes the need for more than two rings somewhat
difficult to imagine...

Jason

---
Day xee-nee-svsh duu-'ushtlh-ts'it;
nuu-wee-ya' duu-xan' 'vm-nvshtlh-ts'it.
Huu-chan xuu naa~-gha.
