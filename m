From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH] Input: Adding graceful shutdown to sysrq key reset
Date: Tue, 23 Apr 2013 17:50:32 -0600
Message-ID: <51771E48.40600@linaro.org>
References: <1365169112-7999-1-git-send-email-mathieu.poirier@linaro.org> <20130415204535.GB4374@core.coreip.homeip.net> <516D6420.4070406@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:54087 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756454Ab3DWXtc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Apr 2013 19:49:32 -0400
Received: by mail-pd0-f181.google.com with SMTP id y10so742886pdj.12
        for <linux-input@vger.kernel.org>; Tue, 23 Apr 2013 16:49:31 -0700 (PDT)
In-Reply-To: <516D6420.4070406@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, arve@android.com, kernel-team@android.com, john.stultz@linaro.org

On 13-04-16 08:45 AM, Mathieu Poirier wrote:
> On 13-04-15 02:45 PM, Dmitry Torokhov wrote:
>> Hi Mathieu,
>>
>> On Fri, Apr 05, 2013 at 07:38:32AM -0600, mathieu.poirier@linaro.org wrote:
>>> From: "Mathieu J. Poirier" <mathieu.poirier@linaro.org>
>>>
>>> Attempt to reboot the system gracefully when a key combo
>>> is detected.  The system is force to go down if the first
>>> attempt failed and the key combo is pressed a second time.
>>>
>>
>> If system can gracefully shutdown can;t we request it through normal
>> means?
>>
>> Thanks.
>>
> 
> Can you provide more details on how you'd like to see this done please ?
>  Since 'kernel_restart' is found in 'linux/reboot.h' I was under the
> impression that it is fairly mainstream.
> 
> Thanks,
> Mathieu.
> 

I haven't hard back from my last question so I'll try to interpret your
original answer differently.

The proposed functionality is a last effort at rebooting the system when
the UI is hung.  In such case the rest of the system could still be
alive and as such should be given a chance to reboot more gracefully
than when using emergency_reset().

Hope this helps clarifying my position.  I would be more than happy to
re-work the commit message if need be.  Please consider getting back to me.

Mathieu.
