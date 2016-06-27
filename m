From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH] Fix effect aborting in ff-memless
Date: Mon, 27 Jun 2016 21:31:36 +0300
Message-ID: <1545a709-3f18-7b73-5c63-cadf0571deb9@iki.fi>
References: <c2278d36-993b-402f-dd07-635980112bbe@m-reimer.de>
 <20160620173303.GA22426@dtor-ws>
 <034f5c4e-ed69-60c4-d199-5aa978e4c6a1@m-reimer.de>
 <20160625152956.GA17812@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail3.ippnet.fi ([62.197.168.3]:33674 "EHLO mail3.ippnet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639AbcF0S4r (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jun 2016 14:56:47 -0400
In-Reply-To: <20160625152956.GA17812@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Manuel Reimer <mail+linux-input@m-reimer.de>, linux-input <linux-input@vger.kernel.org>, Cameron Gutman <aicommander@gmail.com>, jikos@kernel.org

25.06.2016, 18:29, Dmitry Torokhov kirjoitti:
> On Sat, Jun 25, 2016 at 03:28:05PM +0200, Manuel Reimer wrote:
>> On 06/20/2016 07:33 PM, Dmitry Torokhov wrote:
>>> I am not clear how this can happen. If effect hasn't actually started
>>> playing (i.e. we have FF_EFFECT_STARTED bit set, but FF_EFFECT_PLAYING
>>> is not yet set), then when stopping effect we do not need to do anything
>>> except clear FF_EFFECT_STARTED (since we did not touch the hardware
>>> yet).
>>
>> That's true, but I think my crash works a bit different.
>>
>> What I'm doing is "hammering" the code with "start playback" events.
>> Maybe not common in normal use, but it shouldn't be possible to
>> crash the kernel with something like this.
>>
>>
>> For the crash to happen, the uploaded effect has to have a replay
>> delay of some seconds. With this, what is actually happening is:
>>
>> - The first playback request is accepted in ml_ff_playback
>>   (nonzero value to ml_ff_playback).
>>   --> FF_EFFECT_STARTED is set, FF_EFFECT_PLAYING not set
>>   --> play_at is in the future
>> - Some time later (play_at reached) the effect actually is started
>>   --> Now both, FF_EFFECT_STARTED and FF_EFFECT_PLAYING are set
>>   --> play_at is in the past
>> - Now a new playback request for the same effect is accepted
>>   in ml_ff_playback
>>   --> Still both, FF_EFFECT_STARTED and FF_EFFECT_PLAYING set
>>   --> play_at is now in the future!!!
>>
>> => That's the time where the USB plug is pulled
>> => Kernel is trying to stop possible running effects
>>    Current situation:
>>    - The effect is playing and hasn't stopped playing so far
>>    - The same effect is scheduled to be playing again
>>      (play_at in future)
>>
>> - Now we get a "stop playback" request (zero value to ml_ff_playback)
>>   --> FF_EFFECT_PLAYING still set --> FF_EFFECT_ABORTING will be set
>>   --> play_at still in the future
>> - The "FF_EFFECT_ABORTING" request now isn't handled directly in
>>   ml_get_combo_effect, as it is filtered out "play_at in future".
>> - A timer is set (as play_at is in future)
>> - Some time later the aborting is triggered with all memory already
>>   freed in both, ff-memless and hid-sony, modules.
>>
>>
>>
>> With this knowledge, it now is *very* easy to reproduce this one:
>> - Open fftest on the device
>> - press "4" and "enter", immediately pre-enter a "4" after that
>> - As soon as the controller starts to vibrate, press enter and
>>   disconnect the controller
>> - Wait some seconds
>>
>> Crashes *every time* with the hid-sony module.
>> Produces ugly output on dmesg with xpad module. Seems like some
>> strings are read from freed memory in this case.
>>
>> My patch fixes this by setting play_at to "now", so the
>> "FF_EFFECT_ABORTING" is handled immediately in this case. --> No
>> crash
> 
> I see. I however wonder what the proper behavior should be when we
> basically request to restart the effect. If start delay is 0 then new
> effect parameters would immediately be applied, so I guess it would be
> reasonable to say that if we apply new start_delay to the effect then
> currently playing instance should be stopped...
> 
> Anssi, what is your take here?

I agree with you, starting a delayed effect should immediately stop the
effect if it is already running.

So I guess e.g. ml_ff_playback() should set FF_EFFECT_ABORTING in such a
case, and ml_get_combo_effect() should process FF_EFFECT_ABORTING
effects regardless of their ->play_at being in the future (the latter
would fix the original issue too, AFAICS).


I guess an easier-to-follow state bit set would be e.g. the following:

FF_EFFECT_STARTED: always reflects started/stopped state
FF_EFFECT_PLAYING: always reflects hardware state
FF_EFFECT_DIRTY: effect requires immediate refresh (stop or modify)

which would make it clearer where each is set/cleared as there is no
more need for "delayed" handling of STARTED/PLAYING via ABORTING or
clearing FF_EFFECT_PLAYING in various places to force an effect refresh.


-- 
Anssi Hannula

