From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: Re: [PATCH] Fix effect aborting in ff-memless
Date: Sat, 25 Jun 2016 15:28:05 +0200
Message-ID: <034f5c4e-ed69-60c4-d199-5aa978e4c6a1@m-reimer.de>
References: <c2278d36-993b-402f-dd07-635980112bbe@m-reimer.de>
 <20160620173303.GA22426@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:45485 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249AbcFYNfd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 25 Jun 2016 09:35:33 -0400
In-Reply-To: <20160620173303.GA22426@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Cameron Gutman <aicommander@gmail.com>, jikos@kernel.org

On 06/20/2016 07:33 PM, Dmitry Torokhov wrote:
> I am not clear how this can happen. If effect hasn't actually started
> playing (i.e. we have FF_EFFECT_STARTED bit set, but FF_EFFECT_PLAYING
> is not yet set), then when stopping effect we do not need to do anything
> except clear FF_EFFECT_STARTED (since we did not touch the hardware
> yet).

That's true, but I think my crash works a bit different.

What I'm doing is "hammering" the code with "start playback" events. 
Maybe not common in normal use, but it shouldn't be possible to crash 
the kernel with something like this.


For the crash to happen, the uploaded effect has to have a replay delay 
of some seconds. With this, what is actually happening is:

- The first playback request is accepted in ml_ff_playback
   (nonzero value to ml_ff_playback).
   --> FF_EFFECT_STARTED is set, FF_EFFECT_PLAYING not set
   --> play_at is in the future
- Some time later (play_at reached) the effect actually is started
   --> Now both, FF_EFFECT_STARTED and FF_EFFECT_PLAYING are set
   --> play_at is in the past
- Now a new playback request for the same effect is accepted
   in ml_ff_playback
   --> Still both, FF_EFFECT_STARTED and FF_EFFECT_PLAYING set
   --> play_at is now in the future!!!

=> That's the time where the USB plug is pulled
=> Kernel is trying to stop possible running effects
    Current situation:
    - The effect is playing and hasn't stopped playing so far
    - The same effect is scheduled to be playing again
      (play_at in future)

- Now we get a "stop playback" request (zero value to ml_ff_playback)
   --> FF_EFFECT_PLAYING still set --> FF_EFFECT_ABORTING will be set
   --> play_at still in the future
- The "FF_EFFECT_ABORTING" request now isn't handled directly in
   ml_get_combo_effect, as it is filtered out "play_at in future".
- A timer is set (as play_at is in future)
- Some time later the aborting is triggered with all memory already
   freed in both, ff-memless and hid-sony, modules.



With this knowledge, it now is *very* easy to reproduce this one:
- Open fftest on the device
- press "4" and "enter", immediately pre-enter a "4" after that
- As soon as the controller starts to vibrate, press enter and
   disconnect the controller
- Wait some seconds

Crashes *every time* with the hid-sony module.
Produces ugly output on dmesg with xpad module. Seems like some strings 
are read from freed memory in this case.

My patch fixes this by setting play_at to "now", so the 
"FF_EFFECT_ABORTING" is handled immediately in this case. --> No crash

Manuel
