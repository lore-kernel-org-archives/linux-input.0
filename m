From: Laura Abbott <labbott@redhat.com>
Subject: Re: [REGRESSION] Touchpad failure after e7348396c6d5 ("Input: ALPS -
 fix V8+ protocol handling (73 03 28)")
Date: Wed, 14 Jun 2017 11:52:45 -0700
Message-ID: <75b84b97-5f36-a3be-bb4e-e43cd72d9921@redhat.com>
References: <937d0082-5c51-e0b5-dcf9-efade5ecbde5@redhat.com>
 <20170603040349.GB16345@TopQuark.net>
 <e841f28c-4d63-170a-482f-8ef1deda1900@redhat.com>
 <KAWPR01MB1092C3572946C54C2CC4DEFBC7CD0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:34995 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752073AbdFNSwu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Jun 2017 14:52:50 -0400
Received: by mail-qt0-f169.google.com with SMTP id w1so11030904qtg.2
        for <linux-input@vger.kernel.org>; Wed, 14 Jun 2017 11:52:49 -0700 (PDT)
In-Reply-To: <KAWPR01MB1092C3572946C54C2CC4DEFBC7CD0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>, Paul Donohue <linux-kernel@PaulSD.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pali Rohar <pali.rohar@gmail.com>, Nick Fletcher <nick.m.fletcher@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "scott.s.lowe@gmail.com" <scott.s.lowe@gmail.com>

On 06/11/2017 10:25 PM, Masaki Ota wrote:
> Hi, Laura,
> 
> Could you try to check below modification?
> https://bugzilla.kernel.org/show_bug.cgi?id=195215#c10
> 
> This thread person said, the issue was fixed by this change.
> I guess it's a XY coordinate setting problem, though the code that before the patch is applied also has a problem.
> 

With the previous patch plus the part you suggested:

"it appears as if this resolves all remaining touchpad issues.
Cursor movement works as expected, both on the left-hand and right-hand
sides of the touchpad, and I did not see any issues with two-finger
scrolling on either side of the touchpad. Behavior with this test
build appeared to be identical to 4.10.5, the last "official" kernel
release to work with my touchpad."

So it sounds like both parts together fix the issue.

Thanks,
Laura

> Best Regards,
> Masaki Ota
> -----Original Message-----
> From: Laura Abbott [mailto:labbott@redhat.com] 
> Sent: Wednesday, June 07, 2017 1:59 AM
> To: Paul Donohue <linux-kernel@PaulSD.com>
> Cc: 太田 真喜 Masaki Ota <masaki.ota@jp.alps.com>; Dmitry Torokhov <dmitry.torokhov@gmail.com>; Pali Rohar <pali.rohar@gmail.com>; Nick Fletcher <nick.m.fletcher@gmail.com>; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; scott.s.lowe@gmail.com
> Subject: Re: [REGRESSION] Touchpad failure after e7348396c6d5 ("Input: ALPS - fix V8+ protocol handling (73 03 28)")
> 
> On 06/02/2017 09:03 PM, Paul Donohue wrote:
>> This might be related to 
>> https://bugzilla.kernel.org/show_bug.cgi?id=195215
>>
>> Could you have the user try this change? 
>> https://bugzilla.kernel.org/show_bug.cgi?id=195215#c12
>>
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1447327#c13
> 
> "Cursor movement seems to work, but there are intermittent two-finger scrolling issues on the right-hand side of the touchpad. There are no issues with cursor movement or two-finger scrolling on the left-hand side of the touchpad."
> 
>> On Fri, Jun 02, 2017 at 10:54:52AM -0700, Laura Abbott wrote:
>>> Hi,
>>>
>>> Fedora got a bug report 
>>> https://bugzilla.redhat.com/show_bug.cgi?id=1447327
>>> of a touchpad failure on a Dell Latitude E7370. Testing showed that 
>>> the bad commit was
>>>
>>> commit e7348396c6d51b57c95c6646c390cd078e038e19
>>> Author: Masaki Ota <masaki.ota@jp.alps.com>
>>> Date:   Fri Mar 17 14:10:57 2017 -0700
>>>
>>>     Input: ALPS - fix V8+ protocol handling (73 03 28)
>>>     
>>>     Devices identified as E7="73 03 28" use slightly modified version of V8
>>>     protocol, with lower count per electrode, different offsets, and different
>>>     feature bits in OTP data.
>>>     
>>>     Fixes: aeaa881f9b17 ("Input: ALPS - set DualPoint flag for 74 03 28 devices")
>>>     Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
>>>     Acked-by: Pali Rohar <pali.rohar@gmail.com>
>>>     Tested-by: Paul Donohue <linux-kernel@PaulSD.com>
>>>     Tested-by: Nick Fletcher <nick.m.fletcher@gmail.com>
>>>     Cc: stable@vger.kernel.org
>>>     Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>>
>>> I suspect this particular model needs special handling as well?
>>>
>>> Thanks,
>>> Laura
>>>
> 

