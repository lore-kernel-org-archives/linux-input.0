From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [RFC v2 PATCH 4/7] input: pmic8058_pwrkey: Add support for power
 key
Date: Wed, 02 Feb 2011 13:13:23 +0530
Message-ID: <4D490B1B.2060403@codeaurora.org>
References: <1296568063-12010-1-git-send-email-aghayal@codeaurora.org> <1296568063-12010-5-git-send-email-aghayal@codeaurora.org> <20110201174911.GA518@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20110201174911.GA518@core.coreip.homeip.net>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Anirudh Ghayal <aghayal@codeaurora.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com, linux-arm-msm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On 2/1/2011 11:19 PM, Dmitry Torokhov wrote:
> On Tue, Feb 01, 2011 at 07:17:40PM +0530, Anirudh Ghayal wrote:
>> From: Trilok Soni <tsoni@codeaurora.org>
>>
>> Add support for PMIC8058 power key driven over dedicated
>> KYPD_PWR_N pin. It allows the user to specify the amount
>> of time by which the power key reporting can be delayed.
>>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Signed-off-by: Trilok Soni <tsoni@codeaurora.org>
>> ---
>> Changes from v1:
>> Addressed review comments from Dmitry.
>> Added KEY_SCREENLOCK instead of KEY_END.
> 
> ...
>> +	input_report_key(pwrkey->pwr, KEY_SCROLLLOCK, 1);
> ...
>> +	input_report_key(pwrkey->pwr, KEY_SCREENLOCK, 0);
> ...
>> +	input_set_capability(pwr, EV_KEY, KEY_SCROLLLOCK);
> 
> 
> You are confused about the event you are sending.

My mistake. I will fix this to KEY_SCREENLOCK in v3.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
