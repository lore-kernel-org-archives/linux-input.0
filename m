From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] hid: core: add managed version of hid_hw_start
Date: Sun, 10 Jan 2016 15:33:34 +0100
Message-ID: <56926BBE.1020003@gmail.com>
References: <568D26B0.9080301@gmail.com>
 <alpine.LNX.2.00.1601081050520.3402@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:33235 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755425AbcAJOdl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jan 2016 09:33:41 -0500
Received: by mail-wm0-f54.google.com with SMTP id f206so185413278wmf.0
        for <linux-input@vger.kernel.org>; Sun, 10 Jan 2016 06:33:40 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1601081050520.3402@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org

Am 08.01.2016 um 10:51 schrieb Jiri Kosina:
> On Wed, 6 Jan 2016, Heiner Kallweit wrote:
> 
>> Most calls to hid_hw_stop are boilerplate code. The function comment
>> states: "This is usually called from remove function or from probe
>> when something failed and hid_hw_start was called already."
>>
>> A managed version of hid_hw_start allows to avoid this boilerplate
>> code in most cases (similar to the other devm_ functions). 
>> hid_hw_stop is called automatically before the device is deleted.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> Generally I agree with the idea, but I'll be merging this only together 
> with patches that are converting drivers to actually use this API.
> 
OK. When working on it I saw that hid_hw_stop is called by the core if
the driver doesn't define a remove callback.
This means if we use devm_hid_hw_start in a driver with a probe but no
remove callback then hid_hw_stop will be called twice.
To prevent this I'd switch all drivers with probe but no remove to the
new call and remove the fallback call to hid_hw_stop in the core.
At the same time I'd switch the fallback call to hid_hw_start in the core
(in case the driver doesn't define a probe callback) to the new call.
This way the change is transparent to drivers which define neither probe
nor remove.
Fine with you?

> Thanks,
> 
Regards, Heiner

