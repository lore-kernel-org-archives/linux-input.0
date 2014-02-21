From: Daniel J Blueman <daniel@quora.org>
Subject: Re: USB keyboard occasional key stuck
Date: Fri, 21 Feb 2014 11:44:25 +0800
Message-ID: <CAMVG2stP-LEqu_YGBUdzQbawu+=N4iYuUyMoRymJWuaEdfGbjg@mail.gmail.com>
References: <CAMVG2ss9nA4zcOT3c47EwEMrR7Z_gAQU-HTYGjdWcdYzihSnbg@mail.gmail.com>
	<5302C0B2.9010506@gmail.com>
	<20140218022105.14422.qmail@stuge.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:46246 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616AbaBUDo0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Feb 2014 22:44:26 -0500
Received: by mail-oa0-f53.google.com with SMTP id m1so3454807oag.40
        for <linux-input@vger.kernel.org>; Thu, 20 Feb 2014 19:44:25 -0800 (PST)
In-Reply-To: <20140218022105.14422.qmail@stuge.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Stuge <peter@stuge.se>
Cc: Clinton Sprain <clintonsprain@gmail.com>

Peter, Dmitry et al,

This is a real bug that dents the usability of Linux against Windows
or MacOS. We can enable model-specific workarounds, but what approach
would catch phantom stuck keys in the input stack?

On 18 February 2014 10:21, Peter Stuge <peter@stuge.se> wrote:
> Clinton Sprain wrote:
>> I noticed your examples are both fn combos. I'm seeing something like
>> this and it seems specifically related to the fn key. Reproducible on a
>> Macbook (3,1) and a Lenovo Yoga 13. Sequence is simple:
>>
>> Press key
>> Press fn
>> Release key
>> Release fn
>>
>> The key will be 'stuck' until you press another key. It seems to only
>> apply to keys that are part of a fn combo
>
> Fn is handled by the embedded controller (H8 as per Intel reference
> design in case of Macbook or Thinkpad) which has its own closed
> firmware which is rarely perfectly bug-free.
>
>
> //Peter



-- 
Daniel J Blueman
