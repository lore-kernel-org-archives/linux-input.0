From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: enable all buttons on the TiVo Slide Pro remote
Date: Fri, 11 Dec 2015 11:18:10 -0800
Message-ID: <CAKdAkRS6HfP91-Hn789GQdgcE3whrCey1Dxu+j3xcDNM2ySNYA@mail.gmail.com>
References: <i825gaplvjcd1oha4ethkjj325m51ujano@4ax.com>
	<alpine.LNX.2.00.1503151005240.24876@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33266 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbbLKTSL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Dec 2015 14:18:11 -0500
Received: by obbsd4 with SMTP id sd4so40751439obb.0
        for <linux-input@vger.kernel.org>; Fri, 11 Dec 2015 11:18:10 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1503151005240.24876@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Forest Wilkinson <web11.forest@tibit.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, illumilore@gmail.com

On Sun, Mar 15, 2015 at 7:05 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Thu, 12 Mar 2015, Forest Wilkinson wrote:
>
>> The linux kernel has supported the TiVo Slide remote control for some time,
>> but does not recognize the USB ID of the newer Slide Pro. This patch adds
>> the missing data structures so the newer remote will be recognized by the
>> driver, thereby allowing the TiVo, LiveTV, and Thumbs Up/Down buttons to be
>> mapped with a hwdb file.
>>
>> Signed-off-by: Forest Wilkinson <web11.forest@tibit.com>
>
> Applied to for-4.0/upstream-fixes.

There is a complaint in bugzilla that it may have broken their remote:
https://bugzilla.kernel.org/show_bug.cgi?id=107791

Thanks.

-- 
Dmitry
