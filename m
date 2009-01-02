From: "F. Heitkamp" <heitkamp@ameritech.net>
Subject: Re: keyboards and evdev printing multiple keys
Date: Fri, 02 Jan 2009 11:26:57 -0500
Message-ID: <495E4051.10602@ameritech.net>
References: <494FF40A.7000806@ameritech.net> <20090101034926.GA7361@dingo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from flpi195.sbcis.sbc.com ([207.115.20.197]:45207 "EHLO
	flpi195.prodigy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758547AbZABQ1I (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Jan 2009 11:27:08 -0500
In-Reply-To: <20090101034926.GA7361@dingo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org

Peter Hutterer wrote:
> On Mon, Dec 22, 2008 at 03:09:46PM -0500, F. Heitkamp wrote:
>    
>> I am not sure this is a bug.
>> I have a Apple keyboard connected to a IOGear USB KVM.
>> I have installed evdev and the Xorg 1.5.3 server.
>> When I use any X apps the keyboard repeats three for one in.  i.e.
>> typing one 'L' puts three of them in the input.
>> I noticed when looking at /proc/bus/input/devices there are three
>> instanced of the keyboard.
>>      
>
> This is an X server problem and the most likely cause is that your server is
> picking up a keyboard device (driver "kbd") and the evdev device separately.
> If you are using evdev 2.1, then you will get two events for each key press.
>
> Another reason may be that you have an evdev device configured in the
> xorg.conf, and the same device gets added again through HAL.
>    

I've tried commenting out all InputDevice sections in xorg.conf.
It seems to have worked so far.  No "EE"s in Xorg.0.conf and my keyboard 
and mouse
are working.  Thanks!

Fred

