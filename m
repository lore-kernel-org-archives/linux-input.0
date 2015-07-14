From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2] Input: pmic8xxx-pwrkey - Support shutdown
Date: Mon, 13 Jul 2015 17:58:18 -0700
Message-ID: <55A45EAA.9040001@codeaurora.org>
References: <1436830234-28316-1-git-send-email-sboyd@codeaurora.org> <20150714002504.GC7945@dtor-ws> <55A45931.4010509@codeaurora.org> <20150714004638.GD7945@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150714004638.GD7945@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Bjorn Andersson <bjorn.andersson@sonymobile.com>
List-Id: linux-input@vger.kernel.org

On 07/13/2015 05:46 PM, Dmitry Torokhov wrote:
> On Mon, Jul 13, 2015 at 05:34:57PM -0700, Stephen Boyd wrote:
>> On 07/13/2015 05:25 PM, Dmitry Torokhov wrote:
>>>> +
>>>> +static const struct of_device_id pm8xxx_pwr_key_id_table[] = {
>>>> +	{ .compatible = "qcom,pm8058-pwrkey", .data = &pm8058_pwrkey_shutdown },
>>>> +	{ .compatible = "qcom,pm8921-pwrkey", .data = &pm8921_pwrkey_shutdown },
>>>> +	{ }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, pm8xxx_pwr_key_id_table);
>>>> +
>>> Can we please keep IDs and device table where it was, close to the
>>> driver definition?
>> That would require forward declaring the array here. Is that
>> desired? I moved it so that I could use it in the probe function.
> Ah, yes, OF data is not passed into probe() :(... But we can always do:
>
> 	match = of_match_device(pdev->dev.driver->of_match_table, &pdev->dev);
>
> Maybe we could have a helper for this like:
>
> const struct of_device_id *of_get_current_match(struct device *dev)
> {
> 	return dev->drv ?
> 		of_match_device(dev->driver->of_match_table, dev) :
> 		NULL;
> }

Nice. I'll update and Cc the OF maintainers.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
