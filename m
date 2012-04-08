From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Sun, 08 Apr 2012 13:48:06 +0300
Message-ID: <4F816CE6.4040900@gmail.com>
References: <1329773340-14066-1-git-send-email-spbnick@gmail.com> <alpine.LNX.2.00.1203301544270.25526@pobox.suse.cz> <4F78AD8B.9020104@gmail.com> <alpine.LNX.2.00.1204012137150.16928@pobox.suse.cz> <4F78BF82.70903@gmail.com> <alpine.LNX.2.00.1204030139470.16928@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37230 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab2DHKsL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Apr 2012 06:48:11 -0400
Received: by wibhr17 with SMTP id hr17so1545332wib.1
        for <linux-input@vger.kernel.org>; Sun, 08 Apr 2012 03:48:10 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1204030139470.16928@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Jiri,

On 04/03/2012 02:41 AM, Jiri Kosina wrote:
> On Sun, 1 Apr 2012, Nikolai Kondrashov wrote:
>
>>> I will be travelling for the whole day tomorrow, so I will look into this
>>> onboard the airplane and will try to come up with a fix.
>>
>> Great! Thank you :)!
>
> Please let me know whether the patch below fixes the rebinding for your
> drivers that replace the report descriptor. I believe it should. Thanks in
> advance for testing.

On a closer look, it seems simply freeing rdesc is far from enough. There
are lots of fields in the hid_device structure which describe the reports
and which are filled during report parsing. Namely: collection,
collection_size, maxcollection, maxapplication, report_enum, and likely
others. Parsing a new descriptor over the values of these variables,
corresponding to the previous descriptor, doesn't produce a meaningful
result.

These fields should be reset and linked data freed before a new report
descriptor could be parsed.

Sincerely,
Nick
