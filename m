From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] input: joystick: make USB drivers depend on USB
Date: Wed, 17 Jan 2018 16:01:36 -0800
Message-ID: <0d326efa-9134-d515-973e-791919f478f0@infradead.org>
References: <20180117213010.810-1-marcus.folkesson@gmail.com>
 <20180117215316.7qe5o2pspb3dqgny@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117215316.7qe5o2pspb3dqgny@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Tomohiro Yoshidomi <sylph23k@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 01/17/2018 01:53 PM, Dmitry Torokhov wrote:
> On Wed, Jan 17, 2018 at 10:30:10PM +0100, Marcus Folkesson wrote:
>> A driver should not enable an entire subsystem.
> 
> I disagree. As you go through menuconfig and you encounter this option
> and you have the hardware and you want to enable it, you should be able
> to do so. Otherwise you enable bunch of functionality, then go back,
> see what new options appeared, enable them, go back, see if any more new
> options appeared, and so on.
> 
> What exactly prompted this change?

Two things:  today when I reviewed Marcus's patch that selected USB, I
commented something along that line.

But that was based on something that Linus has written at least two times
in the past on lkml.

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


-- 
~Randy
