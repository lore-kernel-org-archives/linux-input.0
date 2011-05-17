From: Anirudh Ghayal <aghayal@codeaurora.org>
Subject: Re: [PATCH V3 2/2] input: pmic8xxx_pwrkey: Add support for power
 key
Date: Tue, 17 May 2011 16:26:27 +0530
Message-ID: <4DD2545B.9090005@codeaurora.org>
References: <1305280071-1652-1-git-send-email-aghayal@codeaurora.org> <1305280071-1652-2-git-send-email-aghayal@codeaurora.org> <20110517063651.GE20428@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20110517063651.GE20428@core.coreip.homeip.net>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, Trilok Soni <tsoni@codeaurora.org>, adharmap@codeaurora.org
List-Id: linux-input@vger.kernel.org

Hi Samuel,

Can you please pull this patch in your MFD tree. 
https://patchwork.kernel.org/patch/782212/.
This patch depends on the pm8xxx MFD core.

Thank you,
~Anirudh

On 5/17/2011 12:06 PM, Dmitry Torokhov wrote:
> On Fri, May 13, 2011 at 03:17:51PM +0530, Anirudh Ghayal wrote:
>> From: Trilok Soni<tsoni@codeaurora.org>
>>
>> Add support for PMIC8XXX power key driven over dedicated
>> KYPD_PWR_N pin.
>>
>> Cc: Dmitry Torokhov<dmitry.torokhov@gmail.com>
>> Signed-off-by: Trilok Soni<tsoni@codeaurora.org>
>> Signed-off-by: Anirudh Ghayal<aghayal@codeaurora.org>
>
> Acked-by: Dmitry Torokhov<dtor@mail.ru>
>
> Anirudh,
>
> Looks great, thank you for making changes. Please feel free to merge
> with the rest of the pmic8xxx MFD patches. I assume they will go through
> MFD tree, right?
>
> Thanks.
>
