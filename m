From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: Bug: HID-Sony: DS4 touch-pad corrupts Axis0
Date: Tue, 22 Apr 2014 13:31:32 -0400
Message-ID: <5356A774.5050505@gmail.com>
References: <23e61b7ee30edafb338935ae40285dce.squirrel@mungewell.org>    <535555C6.5050407@gmail.com> <53557CB5.1010100@gmail.com> <35342da9a382362bc86ab7abfa7ee07a.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:57680 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933390AbaDVRbg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Apr 2014 13:31:36 -0400
Received: by mail-ie0-f179.google.com with SMTP id lx4so5365266iec.24
        for <linux-input@vger.kernel.org>; Tue, 22 Apr 2014 10:31:36 -0700 (PDT)
In-Reply-To: <35342da9a382362bc86ab7abfa7ee07a.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: Frank Praznik <frank.praznik@oh.rr.com>, HID CORE LAYER <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On 4/22/2014 12:50, simon@mungewell.org wrote:
>> The joydev device *is* missing the mappings for the touchpad axes for
>> some reason (JSIOCGAXES returns 14 instead of 17 like it should).  I'm
>> not sure why though.  In the Sony driver the touchpad axis bits are set
>> in the probe function and work correctly via the evdev interface and
>> looking in the joydev module it should properly handle and map all axes
>> up to ABS_MAX so the problem probably lies somewhere else.  If I had to
>> guess, it seems like the joydev device is being created after the HID
>> descriptor is parsed, but before the device probe function is called.
>>
>> Can anyone more familiar with the general input system comment on why
>> this might be happening?
> I find it suspicious that it doesn't happen the first time (after boot)
> that the controller is plugged in, but then does every subsequent time...
> maybe some un-init memory somewhere.
>
> Is this kernel behaviour, or down to the controller state (ie alive after
> first plug)? We see that the DS3 behaves differently wrt leds depending on
> whether it is asleep or alive when plugged in.
>
> I'll dig a little deeper tonight to see if I can track the problem down.
> Simon.
>

It might be a matter of the joydev module not being loaded into memory 
the first time thus allowing the probe function to complete and set the 
proper axis bits before the js* device is created.  On subsequent 
connects the module would already be loaded so the js* device would be 
created before the extra axis bits are set, assuming that my earlier 
hypothesis is correct and the joystick device is being created before 
the probe function returns.

The joydev system also zero initializes the mapping arrays and doesn't 
filter out unmapped axis or button events, which is why the unmapped 
axes always effect axis 0.
