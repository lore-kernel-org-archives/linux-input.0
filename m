From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] HID: multitouch: Fix system-control buttons not working
Date: Tue, 5 Sep 2017 12:04:14 +0200
Message-ID: <eda831f5-d70c-4444-68c0-6d2cdd39e0ac@redhat.com>
References: <20170822063752.3235-1-hdegoede@redhat.com>
 <dc4a4a3d-f8be-2436-7959-2c9b34179586@redhat.com>
 <nycvar.YFH.7.76.1709051138010.4077@jbgna.fhfr.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750738AbdIEKES (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 5 Sep 2017 06:04:18 -0400
In-Reply-To: <nycvar.YFH.7.76.1709051138010.4077@jbgna.fhfr.qr>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

Hi,

On 05-09-17 11:42, Jiri Kosina wrote:
> On Thu, 31 Aug 2017, Hans de Goede wrote:
> 
>>> Some laptops have system-control buttons (e.g. KEY_SLEEP) on the same
>>> interface as a hid-multitouch touch-pad.
>>>
>>> This commit fixes these buttons not working.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>> What is the status of this patch ? It would be nice to get this
>> bug-fix into 4.14.
> 
> I have been on vacation for past 14 days. I'll process this patch in the
> second wave once current merge window pull request is processed, and will
> be applied still as 4.14 bugfix.

Great, thank you.

Regards,

Hans

