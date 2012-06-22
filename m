From: Donald Kayser <linux@kayser.net>
Subject: Re: /dev/input/by-path/<link> unreliable with MultiTouch device
Date: Fri, 22 Jun 2012 07:56:35 -0500
Message-ID: <08D11A30-7F77-4B00-8B13-9E491FF18934@kayser.net>
References: <73A57920-C505-48DF-A1F2-393BF18585DC@kayser.net> <CAN+gG=F8eH-p3S3gH=_8+UZf63LcoyEU_9xu+hFcfsQwmqbWwg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from omr5.networksolutionsemail.com ([205.178.146.55]:33630 "EHLO
	omr5.networksolutionsemail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761821Ab2FVM4o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Jun 2012 08:56:44 -0400
Received: from cm-omr6 (mail.networksolutionsemail.com [205.178.146.50])
	by omr5.networksolutionsemail.com (8.14.4/8.14.4) with ESMTP id q5MCuhFo016699
	for <linux-input@vger.kernel.org>; Fri, 22 Jun 2012 08:56:43 -0400
In-Reply-To: <CAN+gG=F8eH-p3S3gH=_8+UZf63LcoyEU_9xu+hFcfsQwmqbWwg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input@vger.kernel.org

Thanks Benjamin. This will get me down a new path. I was very  
uncertain about the quirk and I am grateful you pointed it out.

On Jun 21, 2012, at 3:31 PM, Benjamin Tissoires wrote:
> 3) you seem to use very old kernels.

Yes, it is due to our priorities of delivering a system to our  
customers that is stable, that we have time to do complete system  
regression testing, and most importantly, our embedded system's  
distribution must work across several versions of the product with  
slightly different video and network interfaces. Right now two of my  
target systems have ATI graphics, in one I have to use the 1.10 fglrx  
drivers. On the other I have to use 1.12 fglrx drivers. The 1.10  
driver modules do not build past around kernel 2.6.38ish because of  
changes in the  kernel headers to change smp locking. The newest  
version of fglrx does not support both chip sets on my target  
machines. The matrix of which kernel is available becomes limited.

I would like to be able to do it different, but our products last  
around ten years or more in some cases. In a product delivery  
environment of our type, we just can't be idealists, or we would never  
have a product to sell.

> - rely on xorg input rules system to detect your devices (though I
> don't know when they added the physical path in the configuration

I haven't found this to be an automatic option. In order for us to  
have a panoramic surface of up to 6 screens, we have 6 X Displays. You  
end up this way when you have 3 graphics cards in a system as we do.  
Every screen has a touchscreen and in the environment we have to  
support directing the mouse input to the correct X Display. I have  
learned in the newer world of kernel and X you have this lovely affine  
matrix for all kinds of transformations, but not in our world yet. In  
order for evdev to work in our environment, I added an option ScreenNo  
so that I could do what the old elographics driver did and set the X  
display before passing off the event. We have a custom calibration  
utility that associates /dev/input/by-path/<dev> to an InputSection in  
xorg.conf that configures the ScreenNo option. Maybe there is a better  
way in the environment, but this is the solution that I came up with  
so the user doesn't have to calibrate until he adds and external  
touchscreen.

I know that the call I used in evdev to change to a different screen  
doesn't exist in the newest X server and they are relying on the  
matrices for the transformations. I have wondered if they have  
considered that with three video cards, each with its own device  
section in xorg.conf, will I be able to direct the press correctly?  
Does there definitions of screen coordinate cross across X Display  
boundaries?

Best regards and thanks again. I will get rid of the quirk solution  
and try again.

Donald

>
>
> On Thu, Jun 21, 2012 at 4:52 PM, Donald Kayser <linux@kayser.net>  
> wrote:
>> Hello All,
>>
>> I am part of development of a product that uses touchscreens  
>> extensively. We
>> have to maintain touchscreen calibration and X Display association  
>> across
>> boots. We support up to six screens, 3 internal to our product, 3  
>> external
>> to our product. All internal screens have touchscreens with cables  
>> that
>> don't move, so using the device /dev/input/by-path/<devicelink> I  
>> could
>> modify xorg.conf with an InputSection and associate the screen and
>> touchscreen, include calibration, and every time the user returned,  
>> it was
>> already calibrated and working correctly. It has worked great until  
>> we
>> started adding multi-touch devices. The line of multi-touch devices  
>> we are
>> using is manufactured my MosArt.
>>
>> I added the defines for the products in my local kernel tree's
>> driver/hid/hid-ids.h and added the quirk for HID_QUIRK_MULTI_INPUT in
>> hid-quirks.c. With the kernel 2.6.39.4 and earlier to 2.6.32.n,  
>> there is
>> confusion with the /dev/input/by-path/<devlink>.  These multi-touch  
>> devices
>> show up with four entries in /dev/input/<dev>. From looking at the  
>> output of
>> lsinput, two of the entries have identical information with regards  
>> to event
>> bits. Only one of these identical entries in /dev/input/<dev>  
>> actually work;
>> one reports 13 axis, one reports 3 axis. When the
>> /dev/input/by-path/<devlink> points to the 'working' /dev/input/ 
>> <dev> all is
>> fine. This only happens 50% of the time and with three screens it  
>> is not
>> likely to get all three right on any boot.
>>
>> So, is this a good place to ask this question? What other  
>> information would
>> be beneficial? I purposely left out a bunch of debug info so not to  
>> get too
>> noisy.
>>
>> Thanks in advance,
>> Donald Kayser
>> linux at kayser dot net
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux- 
>> input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

