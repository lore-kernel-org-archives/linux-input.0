From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] HID: sony: Fix work queue issues.
Date: Wed, 19 Feb 2014 23:22:52 +0100
Message-ID: <CANq1E4SRX6yE5ynN2zDctQ9uyt4NoYYp1cRVBAU=D8C7CJQ3Ew@mail.gmail.com>
References: <1392833362-4218-1-git-send-email-frank.praznik@oh.rr.com>
	<CANq1E4TmfDRQLqBEw8JpS6da=96+ZENFy__YJjskPqVaA04jdw@mail.gmail.com>
	<CAH+9E3rwDdz1wLLtT7ASWX9=_DzA=gL9WurWMouOxc83r4xjgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:50793 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbaBSWWx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Feb 2014 17:22:53 -0500
Received: by mail-lb0-f175.google.com with SMTP id p9so765574lbv.6
        for <linux-input@vger.kernel.org>; Wed, 19 Feb 2014 14:22:52 -0800 (PST)
In-Reply-To: <CAH+9E3rwDdz1wLLtT7ASWX9=_DzA=gL9WurWMouOxc83r4xjgw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi

On Wed, Feb 19, 2014 at 8:21 PM, Frank Praznik <frank.praznik@oh.rr.com> wrote:
> On Wed, Feb 19, 2014 at 1:41 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
>> Hi Frank
>>
>> On Wed, Feb 19, 2014 at 7:09 PM, Frank Praznik <frank.praznik@oh.rr.com> wrote:
>>> Don't initialize force-feedback for devices that don't support it to avoid calls
>>> to schedule_work() with an uninitialized work_struct.
>>>
>>> Move the cancel_work_sync() call out of sony_destroy_ff() since the state worker
>>> is used for the LEDs even when force-feedback is disabled.
>>>
>>> Remove sony_destroy_ff() to avoid a compiler warning since it is no longer used.
>>>
>>> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
>>
>> Sorry, my comment might have been misleading. You have to add the "Cc:
>> <stable@vger.kernel.org>" line underneath/above your "Signed-off-by".
>> This will send a notice to the stable guys once the patch is applied
>> in Linus' tree.
>>
>> But that's also described in the file Greg posted.
>>
>> Cheers
>> David
>>
> Actually, does this even need to go into stable? The issue doesn't
> exist below kernel 3.14 since the LED system wasn't added until commit
> 0a286ef278529f2bc4f4bb27c4cf99c05999c818 in December.  Could this just
> go into for-3.14/upstream-fixes and for-linus with the other pending
> fixes?

Sure.

Thanks
David
