From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH v2] hid: Misc tablet fixes and improvements
Date: Thu, 15 Sep 2016 12:09:09 +0300
Message-ID: <731ffd56-5888-1dc8-30af-dcac7ce14d9d@gmail.com>
References: <20160914101531.GJ25951@mail.corp.redhat.com>
 <20160914183820.20737-1-spbnick@gmail.com>
 <20160915071432.GA15777@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34250 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754739AbcIOJJO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Sep 2016 05:09:14 -0400
Received: by mail-wm0-f65.google.com with SMTP id g141so6143594wmd.1
        for <linux-input@vger.kernel.org>; Thu, 15 Sep 2016 02:09:13 -0700 (PDT)
In-Reply-To: <20160915071432.GA15777@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

On 09/15/2016 10:14 AM, Benjamin Tissoires wrote:
> On Sep 14 2016 or thereabouts, Nikolai Kondrashov wrote:
>> On 09/14/2016 01:15 PM, Benjamin Tissoires wrote:
>>> For this one and 7/9, I think you forgot the hid-core.c changes to not
>>> bind hid-generic on those.
>>
>> Thanks, Benjamin! Yes, I forgot those. Perhaps I could have just sent the two
>> patches fixed, but I respun the whole set with the hid-core changes added,
>> just in case. Hope that's not bothersome.
>>
>
> As replied in v1, the series is:
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks, Benjamin!

> BTW, patch 5/9 seems to be required for the Huion DWH69 which directly
> reports the buttons and not the keycode emulation:
> https://bugs.freedesktop.org/show_bug.cgi?id=97771

Ah, good to know. Unfortunately, as you know, I'm no longer working on new
tablet support.

I wonder what's the problem with KERNEL_VERSION comparison there, though.

Nick
