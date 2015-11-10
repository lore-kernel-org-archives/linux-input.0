From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 04/26] Input: synaptics-rmi4 - prevent oopses when irq
 arrives while the device is not bound
Date: Tue, 10 Nov 2015 10:11:41 +0100
Message-ID: <CAN+gG=FPhL6bek41k=gw9+Mx=kEn7QTq11PpThkOOnQn7RTU0w@mail.gmail.com>
References: <1446766645-30350-1-git-send-email-aduggan@synaptics.com>
	<20151109231610.GF9155@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151109231610.GF9155@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>
List-Id: linux-input@vger.kernel.org

On Tue, Nov 10, 2015 at 12:16 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Nov 05, 2015 at 03:37:25PM -0800, Andrew Duggan wrote:
>> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>
>> If the device has been registered but is not populated, we should not
>> process any incoming interrupt.
>> Make sure the pointers we are following are valid.
>
> Why are the interrupts enabled when device is not ready?

Hmm... Yes, maybe this should have been tackled at the smbus level.
Sorting this out might also help in the various suspend/resume bugs we
are experiencing.

Cheers,
Benjamin

>
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> Tested-by: Andrew Duggan <aduggan@synaptics.com>
>> ---
>>  drivers/input/rmi4/rmi_driver.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
>> index 2fdc7e8..fe5f2f9 100644
>> --- a/drivers/input/rmi4/rmi_driver.c
>> +++ b/drivers/input/rmi4/rmi_driver.c
>> @@ -279,6 +279,9 @@ int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
>>       struct rmi_function *entry;
>>       int error;
>>
>> +     if (!data || !data->f01_container || !data->irq_status)
>> +             return 0;
>> +
>>       error = rmi_read_block(rmi_dev,
>>                               data->f01_container->fd.data_base_addr + 1,
>>                               data->irq_status, data->num_of_irq_regs);
>> --
>> 2.1.4
>>
>
> --
> Dmitry
