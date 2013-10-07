From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH] HID: logitech - lg2ff: Add IDs for Formula Vibration
 Feedback Wheel
Date: Mon, 07 Oct 2013 20:56:23 +0300
Message-ID: <5252F5C7.3060700@iki.fi>
References: <1381164492-27145-1-git-send-email-anssi.hannula@iki.fi> <cec1e0ca61cf17ceb6e52faa4f2baad9.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <cec1e0ca61cf17ceb6e52faa4f2baad9.squirrel@mungewell.org>
Sender: stable-owner@vger.kernel.org
To: simon@mungewell.org
Cc: Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Elias Vanderstuyft <elias.vds@gmail.com>, stable@vger.kernel.org, =?ISO-8859-1?Q?Michal_Mal=FD?= <madcatxster@prifuk.cz>
List-Id: linux-input@vger.kernel.org

07.10.2013 20:48, simon@mungewell.org kirjoitti:
>> From: Elias Vanderstuyft <Elias.vds@gmail.com>
>>
>> Add USB IDs for Logitech Formula Vibration Feedback Wheel (046d:ca04).
>>
>> The lg2ff force feedback subdriver is used for vibration and
>> HID_GD_MULTIAXIS is set to avoid deadzone like other Logitech wheels.
>>
>> Kconfig description etc are also updated accordingly.
>>
>> Signed-off-by: Elias Vanderstuyft <Elias.vds@gmail.com>
>> [anssi.hannula@iki.fi: added description and CCs]
>> Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
>> Cc: Simon Wood <simon@mungewell.org>
>> Cc: <stable@vger.kernel.org>
>> ---
>>
>> Simon, does this look OK to you, or do you think it should be an lg4ff
>> device? Though I guess lg2ff is better than nothing even in that case.
>>
>> Jiri, lets see if we get a comment from Simon before applying.
>>
> 
> I've cc'ed Michal as he contributed a lot to lg4ff and is looking at
> improving ff-memless.
> 
> I am unfamiliar with this wheel (180' rotation, bungee cord for autocenter
> and rumble motors - or so google tells me...), it's not listed on
> Wikipedia (hint, hint):
> http://en.wikipedia.org/wiki/Racing_wheel
> 
> At present lg4ff does not support RUMBLE effects (only CONSTANT and
> AUTOCENTER), so lg2ff seems a sensible place. The only minor concern I
> would have is any confusion from the descriptions in Kconfig.
> 
> I didn't build, but think that the patch looks OK to commit.
> 
> For the other wheels we have re-written the HID descriptors to split
> brake/accel into seperate axis. Do you know whether this is possible for
> this wheel too?

Elias noted earlier that it is configurable in Windows at least, so that
might be the case. We didn't look at the HID descriptors, though, but
feel free to work with him to see if it is possible :)

> Thanks for your patch,
> Simon.
> 
> Signed-off-by: Simon Wood <simon@mungewell.org>

-- 
Anssi Hannula
