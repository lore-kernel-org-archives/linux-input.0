From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v11 4/8] Input: goodix - add power management support
Date: Thu, 19 Nov 2015 14:31:07 -0800
Message-ID: <CAKdAkRSdWQwkpKBNohQT2QhgBM0gxqVxLniViM5TrBNUoqZ1sw@mail.gmail.com>
References: <1447936001-21420-1-git-send-email-irina.tirdea@intel.com>
	<1447936001-21420-5-git-send-email-irina.tirdea@intel.com>
	<20151119182433.GB24773@dtor-ws>
	<CAJZ5v0iPwohZt+N1quhnCq0zj+HSROaA_8nOTFV_zisYCa2bRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35369 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933972AbbKSWbI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2015 17:31:08 -0500
In-Reply-To: <CAJZ5v0iPwohZt+N1quhnCq0zj+HSROaA_8nOTFV_zisYCa2bRw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Irina Tirdea <irina.tirdea@intel.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Octavian Purdila <octavian.purdila@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, Nov 19, 2015 at 2:18 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> Hi,
>
> On Thu, Nov 19, 2015 at 7:24 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Thu, Nov 19, 2015 at 02:26:37PM +0200, Irina Tirdea wrote:
>>> Implement suspend/resume for goodix driver.
>>>
>
> [cut]
>
>>>
>>> +static int __maybe_unused goodix_suspend(struct device *dev)
>>> +{
>>> +     struct i2c_client *client = to_i2c_client(dev);
>>> +     struct goodix_ts_data *ts = i2c_get_clientdata(client);
>>> +     int error;
>>> +
>>> +     /* We need gpio pins to suspend/resume */
>>> +     if (!ts->gpiod_int || !ts->gpiod_rst)
>>> +             return 0;
>>> +
>>> +     wait_for_completion(&ts->firmware_loading_complete);
>>
>> This is not that nice as it may lead to angry splats from the PM core if
>> firmware loading takes too long and we start suspending before it
>> completes.
>
> What exactly do you mean?  The suspend watchdog or something else?

I was thinking about dpm watchdog that will panic the system if
suspend takes too long. Hmm, this is debug facility and the default
timeout is 60 seconds, so I guess we can ignore my concern.

>
>> Rafael, if we issue pm_stay_awake() before requesting firmware and
>> pm_relax() once it is done, will this prevent the current suspend
>> timeouts?
>
> pm_stay_awake() only works if the checking of wakeup sources is
> enabled which generally depends on what user space does.

I see.

Thanks.

-- 
Dmitry
