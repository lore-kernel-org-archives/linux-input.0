From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH RESEND v2 1/2] Input: touchscreen: ads7846: keep copy
 of pdata in private struct
Date: Mon, 01 Jul 2013 09:14:04 +0200
Message-ID: <51D12C3C.1090002@gmail.com>
References: <1372626555-29479-1-git-send-email-zonque@gmail.com> <20130701013324.GA10755@core.coreip.homeip.net> <51D12652.3090804@gmail.com> <20130701070916.GC8047@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:35555 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab3GAHNa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Jul 2013 03:13:30 -0400
Received: by mail-bk0-f44.google.com with SMTP id r7so1517414bkg.3
        for <linux-input@vger.kernel.org>; Mon, 01 Jul 2013 00:13:29 -0700 (PDT)
In-Reply-To: <20130701070916.GC8047@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, broonie@kernel.org, grant.likely@linaro.org, agust@denx.de, imre.deak@nokia.com, chf@fritzc.com

On 01.07.2013 09:09, Dmitry Torokhov wrote:
> Hi Daniel,
> 
> On Mon, Jul 01, 2013 at 08:48:50AM +0200, Daniel Mack wrote:
>> Hi Dmitry,
>>
>> On 01.07.2013 03:33, Dmitry Torokhov wrote:
>>> On Sun, Jun 30, 2013 at 11:09:14PM +0200, Daniel Mack wrote:
>>>> +
>>>> +	if (!pdata->model)
>>>> +		pdata->model = 7846;
>>>> +
>>>> +	if (!pdata->vref_delay_usecs)
>>>> +		pdata->vref_delay_usecs = 100;
>>>> +
>>>> +	if (!pdata->x_plate_ohms)
>>>> +		pdata->x_plate_ohms = 400;
>>>> +
>>>> +	if (!pdata->pressure_max)
>>>> +		pdata->pressure_max = ~0;
>>>
>>> We should not be changing the platform data as the device does not own
>>> it and it may well be declared as a constant structure.
>>
>> We don't change the platform data that is passed in via the driver core.
>> We keep a copy of it in our private strucz (that's what the subject
>> says) and in case of DT, we modify that copy. The passed pdata is left
>> untouched.
>>
> 
> That might have been the intent but the patch only stores a _pointer_ to
> the platform data in the main structure, so in non-DT case you end up
> modifying the original structure.

Eh, ok. I'll change that to always make a copy. Somehow though, I like
the first approach (v1 of the set) better, which stored all data that is
modified inside the private struct directly.

Anyway, I'll submit v3 later.


Thanks,
Daniel

