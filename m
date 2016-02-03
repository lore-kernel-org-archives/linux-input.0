From: Richard Pospesel <pospeselr@gmail.com>
Subject: Re: [PATCH] psmouse: added BYD touchpad driver
Date: Wed, 3 Feb 2016 08:59:47 -0800
Message-ID: <56B23203.3080509@gmail.com>
References: <CAHc7Qt33N4LZNm1kjeFKKtqCHt8o8e-ZGu7BBuc0oGJZeB_JyA@mail.gmail.com>
 <20160203004153.GA15147@smaug>
 <CAHc7Qt3cMu4+qXvruXtY7-GxL=skaUda1c4bfA5DDdNMfOfKGg@mail.gmail.com>
 <20160203085816.GA3307@smaug>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35425 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194AbcBCQ7t (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Feb 2016 11:59:49 -0500
In-Reply-To: <20160203085816.GA3307@smaug>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Diamand <chris@diamand.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Chris,

See inline:

On 02/03/2016 12:58 AM, Chris Diamand wrote:
> Hi Richard,
>
>> Reporting absolute position allows the synaptics and libinput xorg drivers
>> to treat the BYD touchpad as a touchpad, rather than a mouse.  This allows
>> edge scrolling, tap to click, natural scrolling and any other location
>> based single touch gesture to work.
>>
>> I opted to completely disable the hardware multitouch gesture recognition
>> (including two finger scroll) for a couple of reasons:
>>
>> 1.  time delta between gesture packets was very large resulting in a rather
>> jerky scrolling experience, especially compared to touchpad with real
>> multitouch reporting.
>> 2.  Reporting absolute position and touch support enables the users to
>> configure the touchpad in the touchpad settings section of gnome, cinnamon,
>> etc because those applets configure synaptics and libinput.  Otherwise xorg
>> thinks it's just a mouse.
>
> This all sounds good - I look forward to trying your patch!
>
> Also, how did you figure out how to enable the absolute packets? I couldn't
> find anything like that with the Windows driver I was using.

The Windows driver provides a visualization of the regions for the 
hardware edge scrolling capability. When entering that screen, a 
particular command pair is sent, and the touchpad starts sending 
interleaved REL and ABS packets.  When leaving that screen, another 
particular command pair is sent, and the touchpad resumes the normal REL 
only stream.

>
>> 3.  Enabling multitouch gesture recognition results in the mouse cursor
>> freezing up when the user uses two fingers, one to move the mouse cursor
>> and another to click.  This is because movement packets stop getting sent
>> while a gesture (such as pinch, rotate, etc) is being detected and/or
>> reported.
>
> So with your patch, how will this gesture work, if it can only recognise one
> finger at a time? I guess you'd have to enable the "double-tap then drag"
> thing in synaptics and use that?

With multi-touch gestures disabled and two fingers on the pad, the 
touchpad sends ONLY a stream of REL packets, even when in absolute mode. 
  When this occurs I just anchor the start position at the middle of the 
pad.  Its not 100% accurate obviously, but in practice it works.

One side note, it's also possible for this driver to send ABS_X/Y 
packets with positions OUTSIDE the touchpad's supposed range due to the 
scheme where we anchor with a low-res ABS packet and update with hi-res 
REL packets.  I've talked about this potential issue with Peter Hutterer 
(from xorg input) and have been assured that this is fine and isn't 
taking advantage of an undefined behaviour in synaptics or libinput.

>
>> Disabling all hardware gesture detection, including two finger
>> scroll, provides the most fluid user experience.
>
> Yep, I agree that if it works, good one-finger scrolling would be much better
> than the touchpad's internal gesture recognition.
>
>> Regarding serio_pause_rx(), I was following a pattern similar to another
>> touchpad driver in psmouse.  That whole callback mechanism is required to
>> report the touch had ended, since the BYD hardware only sends packets when
>> a touch is occurring.  Is there a better way?
>
> You're right, actually - I was worried that the input_report_* functions might
> sleep, but I just had a proper look and they don't.
>
>> I'll try to rebase and post an updated patch tonight.
>
> Cheers!
> Chris
>

best,
-Richard
