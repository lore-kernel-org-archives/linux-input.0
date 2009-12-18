From: Johannes Ebke <johannes.ebke@physik.uni-muenchen.de>
Subject: Re: Linux Force Feedback for Saitek Cyborg Evo Force
Date: Fri, 18 Dec 2009 09:59:42 +0100
Message-ID: <4B2B447E.80808@physik.uni-muenchen.de>
References: <4B26B824.8010403@physik.uni-muenchen.de> <alpine.LNX.2.00.0912151403440.3755@pobox.suse.cz> <4B2ABC62.2030600@physik.uni-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.physik.uni-muenchen.de ([192.54.42.129]:44371 "EHLO
	mail.physik.uni-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751889AbZLRI7p (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Dec 2009 03:59:45 -0500
In-Reply-To: <4B2ABC62.2030600@physik.uni-muenchen.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi,

...it worked in the jscalibrator, but in the game I noticed that the
axis ranges (as given by the HID driver, which also works for non-ff
mode) are different to the iforce ones:
x/y is from 0 (top, left, rudder left) to 4096 (bottom right) or 255
(rudder right), and throttle is from 255 (no throttle) to 0 (full)

In iforce the x-range is from -1920 to 1920, so 256 steps less than the
saitek range...
This is a bit more difficult to fit into the driver framework, because
the ranges are set in the initialization routine in iforce-main.c.
I'll put an if() in there for starters.

Cheers,
Johannes


Johannes Ebke wrote:
> Hi Jiri,
> 
> I have looked into the problems some more, and have found that the cause
> of the crash was a change I made because I misunderstood the code
> (LO(cmd) is the number of bytes in in the message, and is not
> transferred on USB - i had removed it from the message...)
> 
> First, the changes in the normal input, the joystick axis+buttons message:
> * Prefix is 0x06 instead of 0x01 (joystick) or 0x03 (gamepad)
> * Throttle is not inverted (data[4] instead of 255-data[4])
> * Rudder is present and unsigned (not signed, as in iforce)
> 
> I have attached a patch that I think fixes this (it works for me :)
> Since saitek uses a different protocol byte, this can be done without
> adding per-device flags to the driver.
> 
> It also adds a button map btn_saitek_cyborg that switches button 1&2 to
> make the button number the same as printed on the device, and
> abs_saitek_cyborg for a joystick with rudder but only one hat.
> 
> The fftest effects seem to work, but some are feeble and feel strange -
> I suspect there are some subtle changes, for example I am quite sure
> that the Saitek uses signed (twos complement) numbers for effect
> strength (this could perhaps explain the 'strange' behavior for 0x80
> byte values in the current code)...
> 
> Cheers,
> Johannes
> 
> 
> Jiri Kosina wrote:
>> On Mon, 14 Dec 2009, Johannes Ebke wrote:
>>
>>> I own a Saitek Cyborg Evo Force which works fine with the HID driver on
>>> Linux. However, i could not find a force feedback driver for it, and
>>> just adding the USB id and spec to the IForce driver does not work (and
>>> crashes the kernel)
>> Hi Johannes,
>>
>> thanks for your e-mail. I hope you don't mind adding a few relevant CCs.
>>
>> First, kernel crashing means that we are probably lacking some error 
>> handling in the iforce driver, which we should add if possible. Could you 
>> please post the oops message preceeding the crash?
>>
>>> After that, I have reverse-engineered the protocol using usb snoops from 
>>> a kvm virtual machine with XP on it. Using libusb, I have verified that 
>>> I understand the protocol, and it actually looks quite similar to the 
>>> iforce protocol (no wonder, it just implements the DirectInput interface 
>>> in hardware)
>> Good job, thanks a lot for doing this.
>>
>>> My question: Would it make sense to adapt the iforce modules to include 
>>> this slightly modified protocol (other initialization strings, other 
>>> magic bytes) or would it be better to copy & modify?
>> It really depends how much different the protocols really are. iforce 
>> driver currently doesn't support any per-device flags which would allow 
>> for introducing slight differences between individual models.
>>
>> Maybe it would help if you could just summarize the most important 
>> differences to iforce protocol, so that we could see what aproach would be 
>> the best.
>>
>> Thanks,
>>
