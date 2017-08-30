From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [GIT PULL] Immutable branch between MFD and HWMON due for the
 v4.14 merge window
Date: Tue, 29 Aug 2017 19:06:50 -0700
Message-ID: <706b6632-dffc-ec94-1258-5ddc030a7ca2@roeck-us.net>
References: <20170821145404.18902-1-sebastian.reichel@collabora.co.uk>
 <20170822074741.jjynyudbfgzsl7ju@dell>
 <20170829125113.g74twfnahomtdr2x@earth>
 <a61ad063-07a2-c24c-45b8-c3bdfe630a0c@roeck-us.net>
 <20170829141913.ieujukwf4xxed3ez@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170829141913.ieujukwf4xxed3ez@earth>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 08/29/2017 07:19 AM, Sebastian Reichel wrote:
> Hi Guenter,
> 
> On Tue, Aug 29, 2017 at 06:34:39AM -0700, Guenter Roeck wrote:
>> On 08/29/2017 05:51 AM, Sebastian Reichel wrote:
>>> Hi Lee,
>>>
>>> I noticed, that you did not yet push out your for-mfd-next branch,
>>> so the patches did not yet appear in linux-next. Was this
>>> intentional?
>>>
>> The immutable branch referenced below doesn't exist either.
> 
> The immutable branch looks ok for me:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/log/?h=ib-mfd-hwmon-v4.14
> 

Hmm, yes, I must be blind.

Guenter

>> Guenter
>>
>>> -- Sebastian
>>>
>>> On Tue, Aug 22, 2017 at 08:47:41AM +0100, Lee Jones wrote:
>>>> Enjoy!
>>>>
>>>> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
>>>>
>>>>     Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>     git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-hwmon-v4.14
>>>>
>>>> for you to fetch changes up to 4f16cab19a3d57638dd5d962ff6e87c154a6cab2:
>>>>
>>>>     hwmon: da9052: Add support for TSI channel (2017-08-22 08:45:02 +0100)
>>>>
>>>> ----------------------------------------------------------------
>>>> Immutable branch between MFD and HWMON due for the v4.14 merge window
>>>>
>>>> ----------------------------------------------------------------
>>>> Sebastian Reichel (4):
>>>>         mfd: da9052: Add register details for TSI
>>>>         hwmon: da9052: Replace S_IRUGO with 0444
>>>>         mfd: da9052: Make touchscreen registration optional
>>>>         hwmon: da9052: Add support for TSI channel
>>>>
>>>>    drivers/hwmon/da9052-hwmon.c      | 285 +++++++++++++++++++++++++++++++++++---
>>>>    drivers/mfd/da9052-core.c         |  26 +++-
>>>>    include/linux/mfd/da9052/da9052.h |   6 +
>>>>    include/linux/mfd/da9052/reg.h    |  11 +-
>>>>    4 files changed, 302 insertions(+), 26 deletions(-)
>>>> -- 
>>>> Lee Jones
>>>> Linaro STMicroelectronics Landing Team Lead
>>>> Linaro.org │ Open source software for ARM SoCs
>>>> Follow Linaro: Facebook | Twitter | Blog
>>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
