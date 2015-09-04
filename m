From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH v3] drivers/hid: Check result of debugfs_create_dir() and debugfs_create_file()
Date: Fri, 4 Sep 2015 19:34:37 +0600
Message-ID: <CANCZXo4ojcF8UgFrnLw7MxgGco+oDLvXEasDPzxePexjv2FDwQ@mail.gmail.com>
References: <1440092137-9228-1-git-send-email-kuleshovmail@gmail.com> <alpine.LNX.2.00.1509041516180.30132@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:32893 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933063AbbIDNe6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Sep 2015 09:34:58 -0400
In-Reply-To: <alpine.LNX.2.00.1509041516180.30132@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Yes, sorry, the CONFIG_DEBUG_FS was 'n' in that case that time. Will resend

2015-09-04 19:17 GMT+06:00 Jiri Kosina <jikos@kernel.org>:
> On Thu, 20 Aug 2015, Alexander Kuleshov wrote:
>
>> The debugfs_create_dir() and debugfs_create_file() functions may return -errno
>> if an error occurs. This patch adds a couple of checks of the result of the
>> debufs_create_dir() and debugfs_create_file() functions execution in the
>> hid_debug_register() and othre places.
>>
>> Changelog:
>>
>> v3:
>>
>>   * do not check hid_debug before the call of the hid_debug_init()
>> and hid_debug_exit() from v2
>>
>> v2:
>>
>>   * add check for the result of the debugfs_create_file() calls
>>   * call hid_debug_init() and hid_debug_exit() only if hid_debug
>>   * add check for the hid_debug_root in the hid_debug_register()
>>
>> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
>
> Did you try to even compile-test your patch?
>
> --
> Jiri Kosina
> SUSE Labs
>
