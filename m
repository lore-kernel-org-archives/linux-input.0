From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: DaVinci Keypad Driver
Date: Wed, 23 Sep 2009 10:41:30 -0700
Message-ID: <20090923174130.GD13435@core.coreip.homeip.net>
References: <1253654850-11983-1-git-send-email-miguel.aguilar@ridgerun.com> <20090923034643.GB1458@core.coreip.homeip.net> <4ABA3638.5070609@ridgerun.com> <20090923163546.GA13435@core.coreip.homeip.net> <4ABA55BA.7000009@ridgerun.com> <4ABA5A27.8040702@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:45894 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbZIWRlj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Sep 2009 13:41:39 -0400
Received: by fg-out-1718.google.com with SMTP id 22so321996fge.1
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2009 10:41:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4ABA5A27.8040702@ridgerun.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Cc: nsnehaprabha@ti.com, davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, David Brownell <david-b@pacbell.net>

On Wed, Sep 23, 2009 at 11:25:59AM -0600, Miguel Aguilar wrote:
>>>>> Please kopy keymap into the davinci_kp stucture and use it so that
>>>>> platform data is never changed and can be declared const.
>>>> Do you mean something like this?
>>>>
>>>> struct davinci_kp {
>>>>     ...
>>>>     const int    *keymap;
>>>>     ...
>>>> };
>>>>
>>>
>>> More like:
>>>
>>> struct davinci_kp {
>>>     ...
>>>     unsgned char keymap[];
>>>     ...
>>> };
>>>
>> [MA] Ok.
> [MA] Why usigned char with no pointer and not u32 as most of the keypad 
> driver as defined?

Sorry, meant to say "unsigned short keymap[...]", we not going to have
more than 64K keycodes. You need to fill the array dimension, if the
size is not known before hand (and if upper bound is too jigh to always
allocate max) then you'll have to allocate it separately. Hm, well, if
you make it the last element of the davinci_kp structure you can alwqays
allocate the needed amount of memory, like this:

struct davinci_kp {
	...
	...
	unsigned short keymap[];
};

...

kp = kzalloc(sizeof(struct davinci_kp) +
			sizeof(unsigned short) * pdata->keymap_size,
	     GFP_KERNEL);

-- 
Dmitry
