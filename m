From: Daniel J Blueman <daniel@quora.org>
Subject: Re: USB keyboard occasional key stuck
Date: Tue, 18 Feb 2014 11:36:55 +0800
Message-ID: <CAMVG2su7=nCM9Snj=s4kVSkoFymyCkvZPSZrJK8ayH8WxK6b9g@mail.gmail.com>
References: <CAMVG2ss9nA4zcOT3c47EwEMrR7Z_gAQU-HTYGjdWcdYzihSnbg@mail.gmail.com>
	<5302C0B2.9010506@gmail.com>
	<20140218022105.14422.qmail@stuge.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:52531 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317AbaBRDgz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Feb 2014 22:36:55 -0500
Received: by mail-ob0-f181.google.com with SMTP id va2so17917382obc.40
        for <linux-input@vger.kernel.org>; Mon, 17 Feb 2014 19:36:55 -0800 (PST)
In-Reply-To: <20140218022105.14422.qmail@stuge.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Stuge <peter@stuge.se>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Clinton Sprain <clintonsprain@gmail.com>

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

The likelyhood that the root-cause was in an embedded controller was
holding me back from reporting it.

I believe the Mac keyboards use the generic HID driver in Windows, so
it may be that there isn't a device-specific workaround, but maybe a
generic workaround, though I can't reason the mechanism without more
input-stack-fu.

I guess one test hack to confirm our sanity would be to re-read the
key state every 100ms until a matching key-up is received, logging
when it detects a disparity between key state and no key-up
received...?
-- 
Daniel J Blueman
