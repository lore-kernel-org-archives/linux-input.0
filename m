From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Wed, 04 Apr 2012 11:27:18 +0300
Message-ID: <4F7C05E6.5040102@gmail.com>
References: <1329773340-14066-1-git-send-email-spbnick@gmail.com> <alpine.LNX.2.00.1203301544270.25526@pobox.suse.cz> <4F78AD8B.9020104@gmail.com> <alpine.LNX.2.00.1204012137150.16928@pobox.suse.cz> <4F78BF82.70903@gmail.com> <alpine.LNX.2.00.1204030139470.16928@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49464 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351Ab2DDI13 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Apr 2012 04:27:29 -0400
Received: by bkcik5 with SMTP id ik5so18858bkc.19
        for <linux-input@vger.kernel.org>; Wed, 04 Apr 2012 01:27:28 -0700 (PDT)
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

It seems it doesn't work. The report_fixup is called, but the parsed report
descriptor doesn't get fixed, at least as seen from debugfs.

I didn't have much time to see why this happens, but I will try to do so
today or tomorrow.

Sincerely,
Nick
