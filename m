From: Cameron Gutman <aicommander@gmail.com>
Subject: Re: [PATCH 4/5] Input: xpad - restore LED state after device resume
Date: Sat, 4 Feb 2017 17:47:10 -0800
Message-ID: <2b2bb367-3c2f-e535-b8b9-2ea672b1d548@gmail.com>
References: <201702050949.mTJDZN2o%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34629 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbdBEBrM (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 4 Feb 2017 20:47:12 -0500
In-Reply-To: <201702050949.mTJDZN2o%fengguang.wu@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: rojtberg@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


On 02/04/2017 05:17 PM, kbuild test robot wrote:
> Hi Cameron,
> 
> [auto build test ERROR on input/next]
> [also build test ERROR on v4.10-rc6 next-20170203]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Cameron-Gutman/Correctly-support-some-quirky-Xbox-One-pads/20170205-083659
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
> config: x86_64-randconfig-x016-201706 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/input/joystick/xpad.c: In function 'xpad_resume':
>>> drivers/input/joystick/xpad.c:1700:10: error: 'struct usb_xpad' has no member named 'led'
>      if (xpad->led)
>              ^~
>>> drivers/input/joystick/xpad.c:1701:3: error: implicit declaration of function 'xpad_send_led_command' [-Werror=implicit-function-declaration]
>       xpad_send_led_command(xpad, xpad->led->led_cdev.brightness);
>       ^~~~~~~~~~~~~~~~~~~~~
>    drivers/input/joystick/xpad.c:1701:35: error: 'struct usb_xpad' has no member named 'led'
>       xpad_send_led_command(xpad, xpad->led->led_cdev.brightness);
>                                       ^~
>    cc1: some warnings being treated as errors

Whoops, missed a CONFIG_JOYSTICK_XPAD_LEDS guard around that.

I'll send a v2 in the next day or two, incorporating this fix plus any review
comments made in the meantime.

> 
> vim +1700 drivers/input/joystick/xpad.c
> 
>   1694				retval = xpad_start_xbox_one(xpad);
>   1695			}
>   1696			mutex_unlock(&input->mutex);
>   1697		}
>   1698	
>   1699		/* LED state is lost across resume, so resend the last command */
>> 1700		if (xpad->led)
>> 1701			xpad_send_led_command(xpad, xpad->led->led_cdev.brightness);
>   1702	
>   1703		return retval;
>   1704	}
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

Regards,
Cameron
