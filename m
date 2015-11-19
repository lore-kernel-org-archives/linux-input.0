From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v11 4/8] Input: goodix - add power management support
Date: Thu, 19 Nov 2015 23:18:06 +0100
Message-ID: <CAJZ5v0iPwohZt+N1quhnCq0zj+HSROaA_8nOTFV_zisYCa2bRw@mail.gmail.com>
References: <1447936001-21420-1-git-send-email-irina.tirdea@intel.com>
	<1447936001-21420-5-git-send-email-irina.tirdea@intel.com>
	<20151119182433.GB24773@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33750 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934293AbbKSWSJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2015 17:18:09 -0500
In-Reply-To: <20151119182433.GB24773@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Irina Tirdea <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, linux-input@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Octavian Purdila <octavian.purdila@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi,

On Thu, Nov 19, 2015 at 7:24 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Nov 19, 2015 at 02:26:37PM +0200, Irina Tirdea wrote:
>> Implement suspend/resume for goodix driver.
>>

[cut]

>>
>> +static int __maybe_unused goodix_suspend(struct device *dev)
>> +{
>> +     struct i2c_client *client = to_i2c_client(dev);
>> +     struct goodix_ts_data *ts = i2c_get_clientdata(client);
>> +     int error;
>> +
>> +     /* We need gpio pins to suspend/resume */
>> +     if (!ts->gpiod_int || !ts->gpiod_rst)
>> +             return 0;
>> +
>> +     wait_for_completion(&ts->firmware_loading_complete);
>
> This is not that nice as it may lead to angry splats from the PM core if
> firmware loading takes too long and we start suspending before it
> completes.

What exactly do you mean?  The suspend watchdog or something else?

> Rafael, if we issue pm_stay_awake() before requesting firmware and
> pm_relax() once it is done, will this prevent the current suspend
> timeouts?

pm_stay_awake() only works if the checking of wakeup sources is
enabled which generally depends on what user space does.

Thanks,
Rafael
