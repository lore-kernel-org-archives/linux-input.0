From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH 5/6] Input: evdev - Enable runtime PM of the evdev input handler
Date: Fri, 3 Apr 2015 15:03:43 +0200
Message-ID: <CAAObsKDQoUR728pnadJGx229-rGBm2=sU3nN-a8xN_hWk4FM0A@mail.gmail.com>
References: <1427818501-10201-1-git-send-email-tomeu.vizoso@collabora.com>
 <1427818501-10201-6-git-send-email-tomeu.vizoso@collabora.com> <20150331203138.GB29015@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150331203138.GB29015@dtor-ws>
Sender: linux-pm-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On 31 March 2015 at 22:31, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Tue, Mar 31, 2015 at 06:14:49PM +0200, Tomeu Vizoso wrote:
>> So ancestor devices can remain runtime-suspended when the system goes
>> into a sleep state, they and all of their descendant devices need to
>> have runtime PM enabled.
>
> I am confused. Input devices are not runtime-PM-enabled, so what
> enabling this on evdev handler buys us?

The UVC driver would be enabling runtime PM for the input device that
it registers.

> And what about joydev and
> mousedev? Other handlers that might be attached?

Not sure, tbh. What I have ended up doing in v2 is descending the tree
from the UVC device and enabling runtime PM for all descendants. The
idea is that the UVC driver knows whether it should remain runtime
suspended and that its descendants should copy it.

> The stubbing of prepare also feels wrong: we do want to suspend/resume
> input devices since we want to shut off and restore their leds even if
> device (keyboard) happens to be sleeping.

Fair enough, I have introduced a flag that allows the creator of the
input device to decide that.

Thanks,

Tomeu

> Thanks.
>
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> ---
>>  drivers/input/evdev.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
>> index a18f41b..3d60c20 100644
>> --- a/drivers/input/evdev.c
>> +++ b/drivers/input/evdev.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/major.h>
>>  #include <linux/device.h>
>>  #include <linux/cdev.h>
>> +#include <linux/pm_runtime.h>
>>  #include "input-compat.h"
>>
>>  enum evdev_clock_type {
>> @@ -1201,6 +1202,8 @@ static int evdev_connect(struct input_handler *handler, struct input_dev *dev,
>>       if (error)
>>               goto err_cleanup_evdev;
>>
>> +     pm_runtime_enable(&evdev->dev);
>> +
>>       return 0;
>>
>>   err_cleanup_evdev:
>> --
>> 2.3.4
>>
>
> --
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
