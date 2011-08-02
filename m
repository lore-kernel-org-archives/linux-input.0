From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH] input: misc: Add support for pm8xxx based vibrator driver
Date: Tue, 02 Aug 2011 13:18:46 +0800
Message-ID: <4E3788B6.4020104@cn.fujitsu.com>
References: <1312258397-11039-1-git-send-email-aghayal@codeaurora.org> <4E378043.3080801@cn.fujitsu.com> <20110802051156.GA7372@core.coreip.homeip.net>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20110802051156.GA7372@core.coreip.homeip.net>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Anirudh Ghayal <aghayal@codeaurora.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Amy Maloche <amaloche@codeaurora.org>
List-Id: linux-input@vger.kernel.org

On 08/02/2011 01:11 PM, Dmitry Torokhov wrote:
> On Tue, Aug 02, 2011 at 12:42:43PM +0800, Wanlong Gao wrote:
>> On 08/02/2011 12:13 PM, Anirudh Ghayal wrote:
>>> +/*
>>> + * struct pm8xxx_vib - structure to hold vibrator data
>>> + * @vib_input_dev: input device supporting force feedback
>>> + * @vwork: work structure to set the vibration parameters
>> Anirudh,  It's should be @work?
>
> Looks like it, I can fix it up locally, no need to resubmit.
>
> BTW, please do not hesitate to add your Reviewed-by or Acked-by if you
> are mostly satisfied with the patch (sans a few minor issues that you
> should point out). I can't guarantee that I will always add your tags
> (depends on when I commit the patch to my one of my public branches) but
> I will try to do so.
>
> Thanks.
>
Sure, I see, thanks Dmitry.

Wanlong Gao
