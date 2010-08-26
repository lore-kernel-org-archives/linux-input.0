From: Neil Leeder <nleeder@codeaurora.org>
Subject: Re: [PATCH v2] input: mouse: add qci touchpad driver
Date: Thu, 26 Aug 2010 14:45:48 -0400
Message-ID: <4C76B65C.9000702@codeaurora.org>
References: <1281631760-15589-1-git-send-email-nleeder@codeaurora.org> <0680EC522D0CC943BC586913CF3768C003B3909F9C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003B3909F9C@dbde02.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Horace Fu <horace.fu@quantatw.com>, Mandeep Singh Baines <msb@chromium.org>
List-Id: linux-input@vger.kernel.org

On 8/13/2010 4:36 AM, Datta, Shubhrajyoti wrote:
>
> Minor comments feel free to ignore if you feel so.

Thanks for reviewing this, I'll address these in the next patch.

>> +	err = i2c_master_send(context->ti2c_client, buf, 1);
>> +	if (err<  0)
>> +		goto i2c_fail;
>> +	msleep(100);
> Could you explain the time or have a #define XXX
>
Will add #define

>> +	gpio_direction_input(context->qcitp_gpio);
> The result is not checked here.

I'll check the result.

--
Neil
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
