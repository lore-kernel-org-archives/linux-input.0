From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH] Revert "Input: atmel_mxt_ts - disable interrupt for 50ms
 after reset"
Date: Fri, 8 Apr 2016 13:26:30 +0100
Message-ID: <5707A376.2080404@itdev.co.uk>
References: <1460069545-10322-1-git-send-email-trini@konsulko.com>
 <5707756E.30506@itdev.co.uk> <20160408121418.GT23166@bill-the-cat>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160408121418.GT23166@bill-the-cat>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Rini <trini@konsulko.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>
List-Id: linux-input@vger.kernel.org

On 2016-04-08 13:14, Tom Rini wrote:
> On Fri, Apr 08, 2016 at 10:10:06AM +0100, Nick Dyer wrote:
>> On 2016-04-07 23:52, Tom Rini wrote:
>>> This reverts commit 885f3fb9fa1f9e185e8a4e905157087495734349 due to this
>>> change breaking the touchpad on the Chromebook Pixel 2015 on resume from
>>> sleep or warm resets.
>>>
>>> Cc: Olof Johansson <olof@lixom.net>
>>> Cc: Nick Dyer <nick.dyer@itdev.co.uk>
>>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>> Cc: Henrik Rydberg <rydberg@bitmath.org>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>
>> Hi Tom-
>>
>> Sorry that this has caused a problem. I suggest we try and find a 3rd
>> option other than reverting this patch, because otherwise we will cause
>> problems on other platforms.
> 
> Yeah, it would be good to fix all platforms.  I'm curious, was there an
> observed problem on another platform or just a theoretical problem?

Yes, reported by several customers and I've seen it myself in testing
(Beagleboard + MXT Evaluation Kit). What happens is that the interrupt
triggers too early during the power on sequence after a soft reset and you
get an error message when the ISR fails to communicate on the appmode
address. There have been some anecdotal reports that the device may end up
stuck in the bootloader mode if this happens, although I'm not 100%
convinced this is accurate.

>> I have a Pixel 2 here - can you advise how to reproduce?
> 
> I (and a bunch of other folks, the linux-samus people now point people
> at using mxt-app every boot to reset the device) see this every time I
> either suspend the laptop or do a warm boot into a new kernel (I didn't
> try kexec but it too is probably broken).  Note that I'm not using
> mainline to boot ChromeOS but I've got a regular Linux distro in ROOT-C.

OK. I will try it. My Pixel is running Ubuntu with a mainline kernel, so
should be able to repro.
