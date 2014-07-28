From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 00/15] atmel_mxt_ts - device tree, bootloader, etc
Date: Mon, 28 Jul 2014 15:23:28 -0600
Message-ID: <53D6BF50.3070306@wwwdotorg.org>
References: <1404399697-26484-1-git-send-email-nick.dyer@itdev.co.uk>	<53CECAEC.8080905@wwwdotorg.org>	<53CFD50C.4040509@itdev.co.uk>	<53CFEF6E.2060905@wwwdotorg.org>	<53D10E78.4010908@itdev.co.uk>	<53D17845.4020507@wwwdotorg.org>	<53D26572.3030404@itdev.co.uk>	<53D2B8D0.5090000@wwwdotorg.org> <CAPDwgkNrBRJRR6WtoPSfs8Yq=ui-Ptjju4mJ=9h=95YVFuxw7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDwgkNrBRJRR6WtoPSfs8Yq=ui-Ptjju4mJ=9h=95YVFuxw7g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yufeng Shen <miletus@chromium.org>
Cc: Nick Dyer <nick.dyer@itdev.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, benson Leung <bleung@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan Bowens <Alan.Bowens@atmel.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>, Olof Johansson <olofj@chromium.org>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-input@vger.kernel.org

On 07/28/2014 02:20 PM, Yufeng Shen wrote:
> On Fri, Jul 25, 2014 at 4:06 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>
>> On 07/25/2014 08:10 AM, Nick Dyer wrote:
>>>
>>> On 24/07/14 22:19, Stephen Warren wrote:
>>
>> ...
>>
>>>> I've uploaded 2 logs to:
>>>>
>>>> http://avon.wwwdotorg.org/downloads/mxt-logs/
>>>> (note there's no directory indexing, so manually add the filenames below to
>>>> the URL)
>>>>
>>>> mxt-save-no-movement.xml
>>>>
>>>> This is with the whole series applied. Neither mouse movement nor clicks
>>>> works. I tried mxt-app --reset and it made no difference to the dump results.
>>>>
>>>> mxt-save-move-ok-no-clicking.xml
>>>>
>>>> This is with "Input: atmel_mxt_ts - use deep sleep mode when stopped"
>>>> reverted; mouse movement works, but clicking doesn't.
>>>
>>>
>>> Great, this has identified the issue with mouse movement (touch).
>>>
>>> The config programmed into the NVRAM on your touch controller has the first
>>> byte of the T9 touchscreen object set to zero. This is the CTRL byte which
>>> enables/disables the touch object and what it reports. It is relying on
>>> this to enable the touchscreen on resume:
>>>
>>> https://github.com/dtor/input/blob/9d8dc3e529/drivers/input/touchscreen/atmel_mxt_ts.c#L2005-L2006
>>>
>>> My "use deep sleep mode when stopped" patch stops the driver writing to the
>>> T9.CTRL byte, so whatever config you have in NVRAM for that byte will be
>>> used (ie zero, disabled). Going forward, deep sleep is more generic.
>>> Indeed, newer chips do not have T9 at all, or they might be using other
>>> touch objects. The deep sleep mode is a lower power state to be in, and is
>>> what Atmel recommends.
>>>
>>> However, it does mean changing the maxtouch cfg - you can write the 0x83 to
>>> the first byte of T9 and save it to NVRAM, by doing:
>>>
>>> mxt-app [device] -W -T9 83
>>> mxt-app [device] --backup
>>
>>
>> If I do that, then both mouse movement and "touch" clicks work:-)
>>
>> (Dmitry, I guess that means it's fine to go ahead and apply "Input: atmel_mxt_ts - use deep sleep mode when stopped".)
>>
>> I wonder why the configuration NVRAM in my device was incorrect though? I'm CCing a few ChromeOS people to try and find out any relevant history for the touchpad NVRAM settings on Venice2. Perhaps this is simply something that wasn't noticed because the driver used to initialize this configuration bit, so nobody realized the config in NVRAM was wrong.
>
> Where did you get the configuration file ? It is possible that we rely
> too much on mxt_start to turn on the T9.CTRL bit and have neglected
> its setting in the config file.
> If you can tell me where you get the config file I can do a check.

It was already flashed into the touchpad when I received the board. I 
did try to track down the firmware/config files a few months ago, but 
didn't manage to; I was told since they were already flashed so I didn't 
need them. The board is Venice2.
