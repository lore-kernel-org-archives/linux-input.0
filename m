From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: Merging hid-huion into hid-uclogic
Date: Tue, 27 Jan 2015 13:10:49 +0200
Message-ID: <54C77239.5000508@gmail.com>
References: <54C4EE18.4030005@gmail.com> <alpine.LNX.2.00.1501271109200.10817@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:65318 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbbA0LKw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jan 2015 06:10:52 -0500
Received: by mail-wi0-f172.google.com with SMTP id h11so3929732wiw.5
        for <linux-input@vger.kernel.org>; Tue, 27 Jan 2015 03:10:51 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1501271109200.10817@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>

On 01/27/2015 12:10 PM, Jiri Kosina wrote:
> On Sun, 25 Jan 2015, Nikolai Kondrashov wrote:
>
>> I'd like to have your opinion if it will be fine to merge hid-huion.c into
>> hid-uclogic.c, keeping tablet support intact, of course.
>
> huion driver module doesn't take any module parameters, so that should be
> fine (renaming modules that accept parameters is more tricky due to
> potential userspace configuration breakage).

Thanks a lot, Jiri. I'll work towards that then.

Nick
