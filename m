From: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH 1/2] input: cros_ec_keyb: Report wakeup events
Date: Sun, 02 Apr 2017 08:10:15 +0800
Message-ID: <58E04167.5050004@rock-chips.com>
References: <1490867450-31765-1-git-send-email-jeffy.chen@rock-chips.com> <1490867450-31765-2-git-send-email-jeffy.chen@rock-chips.com> <20170401171237.GH17130@dtor-ws> <20170401171414.GI17130@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.136]:55459 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdDBAKa (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Apr 2017 20:10:30 -0400
In-Reply-To: <20170401171414.GI17130@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org, dbasehore@google.com, dianders@chromium.org, Gwendal Grignou <gwendal@chromium.org>, Vic Yang <victoryang@google.com>, linux-input@vger.kernel.org, Enric Balletbo Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>

Hi Dmitry,

On 04/02/2017 01:14 AM, Dmitry Torokhov wrote:
> On Sat, Apr 01, 2017 at 10:12:37AM -0700, Dmitry Torokhov wrote:
>> Hi Jeffy,
>>
>> On Thu, Mar 30, 2017 at 05:50:49PM +0800, Jeffy Chen wrote:
>>> Report wakeup events when process events.
>>>
>>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>>> ---
>>>
>>>   drivers/input/keyboard/cros_ec_keyb.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
>>> index 6a250d6..a93d55f 100644
>>> --- a/drivers/input/keyboard/cros_ec_keyb.c
>>> +++ b/drivers/input/keyboard/cros_ec_keyb.c
>>> @@ -286,6 +286,9 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>>>   		return NOTIFY_DONE;
>>>   	}
>>>
>>> +	if (device_may_wakeup(ckdev->dev))
>>> +		pm_wakeup_event(ckdev->dev, 0);
>>> +
>>>   	return NOTIFY_OK;
>>>   }
>>>
>>> @@ -632,6 +635,12 @@ static int cros_ec_keyb_probe(struct platform_device *pdev)
>>>   		return err;
>>>   	}
>>>
>>> +	err = device_init_wakeup(dev, 1);
>>
>> In the other patch you are adding "wakeup-source" to the DT binding, but
>> here you mark all EC deices as wakeup sources. You need to use
>> device_property_read_bool(dev, "wakeup-source") and use the result in
>> call to device_init_wakeup().
>
> And please also update device tree binding doc for the driver.
>
oops, sorry, i thought that dts property is needed to enable a wakeup 
source...but obviously it's not, only gpio-keys requires that.

so the dts patch is not needed, will remove in next version, thanx.
>>
>>> +	if (err) {
>>> +		dev_err(dev, "cannot init wakeup: %d\n", err);
>>> +		return err;
>>> +	}
>>> +
>>>   	return 0;
>>>   }
>>>
>>
>> Thanks.
>>
>> --
>> Dmitry
>


