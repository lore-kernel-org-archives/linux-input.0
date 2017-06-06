From: Laura Abbott <labbott@redhat.com>
Subject: Re: [REGRESSION] Touchpad failure after e7348396c6d5 ("Input: ALPS -
 fix V8+ protocol handling (73 03 28)")
Date: Tue, 6 Jun 2017 09:59:11 -0700
Message-ID: <e841f28c-4d63-170a-482f-8ef1deda1900@redhat.com>
References: <937d0082-5c51-e0b5-dcf9-efade5ecbde5@redhat.com>
 <20170603040349.GB16345@TopQuark.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:35592 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbdFFQ7P (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 6 Jun 2017 12:59:15 -0400
Received: by mail-qt0-f174.google.com with SMTP id w1so137058557qtg.2
        for <linux-input@vger.kernel.org>; Tue, 06 Jun 2017 09:59:15 -0700 (PDT)
In-Reply-To: <20170603040349.GB16345@TopQuark.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Donohue <linux-kernel@PaulSD.com>
Cc: Masaki Ota <masaki.ota@jp.alps.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pali Rohar <pali.rohar@gmail.com>, Nick Fletcher <nick.m.fletcher@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, scott.s.lowe@gmail.com

On 06/02/2017 09:03 PM, Paul Donohue wrote:
> This might be related to https://bugzilla.kernel.org/show_bug.cgi?id=195215
> 
> Could you have the user try this change? https://bugzilla.kernel.org/show_bug.cgi?id=195215#c12
> 

https://bugzilla.redhat.com/show_bug.cgi?id=1447327#c13

"Cursor movement seems to work, but there are intermittent two-finger scrolling
issues on the right-hand side of the touchpad. There are no issues with cursor
movement or two-finger scrolling on the left-hand side of the touchpad."

> On Fri, Jun 02, 2017 at 10:54:52AM -0700, Laura Abbott wrote:
>> Hi,
>>
>> Fedora got a bug report https://bugzilla.redhat.com/show_bug.cgi?id=1447327
>> of a touchpad failure on a Dell Latitude E7370. Testing showed that the
>> bad commit was
>>
>> commit e7348396c6d51b57c95c6646c390cd078e038e19
>> Author: Masaki Ota <masaki.ota@jp.alps.com>
>> Date:   Fri Mar 17 14:10:57 2017 -0700
>>
>>     Input: ALPS - fix V8+ protocol handling (73 03 28)
>>     
>>     Devices identified as E7="73 03 28" use slightly modified version of V8
>>     protocol, with lower count per electrode, different offsets, and different
>>     feature bits in OTP data.
>>     
>>     Fixes: aeaa881f9b17 ("Input: ALPS - set DualPoint flag for 74 03 28 devices")
>>     Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
>>     Acked-by: Pali Rohar <pali.rohar@gmail.com>
>>     Tested-by: Paul Donohue <linux-kernel@PaulSD.com>
>>     Tested-by: Nick Fletcher <nick.m.fletcher@gmail.com>
>>     Cc: stable@vger.kernel.org
>>     Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>
>> I suspect this particular model needs special handling as well?
>>
>> Thanks,
>> Laura
>>

