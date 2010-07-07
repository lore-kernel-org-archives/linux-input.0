From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v6 3/3] input: samsung-keypad - Add samsung keypad driver
Date: Wed, 07 Jul 2010 10:28:57 +0900
Message-ID: <4C33D859.9050708@samsung.com>
References: <1277724824-13308-1-git-send-email-jy0922.shim@samsung.com>
 <1277724824-13308-3-git-send-email-jy0922.shim@samsung.com>
 <4C32E21A.8080100@samsung.com>
 <013401cb1d66$5fbf3fb0$1f3dbf10$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <013401cb1d66$5fbf3fb0$1f3dbf10$%kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: ch.naveen@samsung.com, linux-arm-kernel@lists.infradead.org, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 7/7/2010 8:52 AM, Kukjin Kim wrote:
> Joonyoung Shim wrote:
>> Hi, Naveen.
>>
>> On 6/28/2010 8:33 PM, Joonyoung Shim wrote:
>>> This patch adds support for keypad driver running on Samsung cpus. This
>>> driver is tested on GONI and Aquila board using S5PC110 cpu.
>>>
>>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>> ---
>>>  drivers/input/keyboard/Kconfig          |    9 +
>>>  drivers/input/keyboard/Makefile         |    1 +
>>>  drivers/input/keyboard/samsung-keypad.c |  491
>> +++++++++++++++++++++++++++++++
>>>  3 files changed, 501 insertions(+), 0 deletions(-)
>>>  create mode 100644 drivers/input/keyboard/samsung-keypad.c
>>>
>> Could you please test this v6 keypad driver on your various targets?
> 
> Hi,
> 
> I received the test result from Naveen.
> And now he is debugging about that.
> 
> ..his e-mail client has some problem..so I replied...
> 
> ---
> From: Naveen Ch
> 
> I've tested with v6 patches and they are working fine on SMDK6410, SMDKC100 and SMDKV210, except for some header inclusion (linux/sched.h) in samsung-keypad.c.
> 
> The build breaking error is like following:
> (make s5pc100_defconfig and select input->keypad->samsung keypad)
> 
> drivers/input/keyboard/samsung-keypad.c: In function 'samsung_keypad_irq':
> drivers/input/keyboard/samsung-keypad.c:170: error: 'TASK_UNINTERRUPTIBLE' undeclared (first use in this function)
> drivers/input/keyboard/samsung-keypad.c:170: error: (Each undeclared identifier is reported only once
> drivers/input/keyboard/samsung-keypad.c:170: error: for each function it appears in.)
> drivers/input/keyboard/samsung-keypad.c:170: error: implicit declaration of function 'schedule_timeout'
> drivers/input/keyboard/samsung-keypad.c: In function 'samsung_keypad_stop':
> drivers/input/keyboard/samsung-keypad.c:202: error: 'TASK_NORMAL' undeclared (first use in this function)
> make[3]: *** [drivers/input/keyboard/samsung-keypad.o] Error 1
> 

This error occurs on s5pc100_defconfig having disabled CONFIG_PREEMPT 
option. I think sched.h should be included to remove like this 
dependency in driver, are there other ways?
