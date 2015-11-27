From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: [PATCH v2] HID: report only one button for PenMount 6000 USB
 touchscreen controller
Date: Fri, 27 Nov 2015 16:18:22 +0100
Message-ID: <CAH9NwWfj4pNuqBhYj7ZJQbzqyJ19UpT3iNY8avX-Uu6XLtMW7g@mail.gmail.com>
References: <1446131389-21759-1-git-send-email-andrew.shadura@collabora.co.uk> <565456F3.8080408@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33187 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbbK0PSn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Nov 2015 10:18:43 -0500
Received: by wmec201 with SMTP id c201so74533933wme.0
        for <linux-input@vger.kernel.org>; Fri, 27 Nov 2015 07:18:42 -0800 (PST)
In-Reply-To: <565456F3.8080408@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Shadura <andrew.shadura@collabora.co.uk>
Cc: Linux Input Mailing List <linux-input@vger.kernel.org>, =?UTF-8?B?SmnFmcOtIEtvc2luYQ==?= <jkosina@suse.com>

2015-11-24 13:24 GMT+01:00 Andrew Shadura <andrew.shadura@collabora.co.uk>:
> On 29/10/15 16:00, Andrew Shadura wrote:
>> PenMount 6000 USB resistive touchscreen controller reports it has three
>> buttons, while in reality it doesn't have any and doesn't support active
>> styli, and only generates touch events.
>>
>> In penmount_input_mapping(), map only the first button (with code 0),
>> ignore the rest.
>>
>> Signed-off-by: Andrew Shadura <andrew.shadura@collabora.co.uk>
>
> Any news on this patch? It'd be cool if it could be merged.
>

I try to get access to the hardware and will test it.

greets
--
Christian Gmeiner, MSc

https://soundcloud.com/christian-gmeiner
