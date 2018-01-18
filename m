From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] input: joystick: make USB drivers depend on USB
Date: Thu, 18 Jan 2018 10:25:21 -0800
Message-ID: <bbdfcd99-8a2b-d04a-ae3f-a0cac50d312a@infradead.org>
References: <20180117213010.810-1-marcus.folkesson@gmail.com>
 <20180117215316.7qe5o2pspb3dqgny@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:48796 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932103AbeARSZY (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 18 Jan 2018 13:25:24 -0500
In-Reply-To: <20180117215316.7qe5o2pspb3dqgny@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Tomohiro Yoshidomi <sylph23k@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/17/2018 01:53 PM, Dmitry Torokhov wrote:
> On Wed, Jan 17, 2018 at 10:30:10PM +0100, Marcus Folkesson wrote:
>> A driver should not enable an entire subsystem.
> 
> I disagree. As you go through menuconfig and you encounter this option
> and you have the hardware and you want to enable it, you should be able
> to do so. Otherwise you enable bunch of functionality, then go back,
> see what new options appeared, enable them, go back, see if any more new
> options appeared, and so on.

I've been thinking about this.  If a user is using a distro .config file,
it most likely has USB support already enabled, so the description above will
not apply to them.  If they are using some kernel-supplied defconfig file,
I still think that the description above will not apply to them since those
defconfig file will most likely have USB enabled if the target platform supports
USB.  And if they are using some .config file that does not have USB support
enabled, it could be that way for a very good reason.  If the target platform
does not support USB but the user enables (sets) JOYSTICK_XPAD (which selects
USB) but then their device does not work, they will be both disappointed and
confused.

Anyway, I don't think that users will face the problem that you described
very often.  But I understand what you are saying also.


> What exactly prompted this change?
> 
>>
>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>> ---
>>  drivers/input/joystick/Kconfig | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
>> index 332c0cc1b2ab..4a199cff8c68 100644
>> --- a/drivers/input/joystick/Kconfig
>> +++ b/drivers/input/joystick/Kconfig
>> @@ -279,8 +279,7 @@ config JOYSTICK_JOYDUMP
>>  
>>  config JOYSTICK_XPAD
>>  	tristate "X-Box gamepad support"
>> -	depends on USB_ARCH_HAS_HCD
>> -	select USB
>> +	depends on USB
>>  	help
>>  	  Say Y here if you want to use the X-Box pad with your computer.
>>  	  Make sure to say Y to "Joystick support" (CONFIG_INPUT_JOYDEV)
>> -- 
>> 2.15.1
>>
> 


-- 
~Randy
