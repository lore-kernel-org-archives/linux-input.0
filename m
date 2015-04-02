From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 0/3] Cleanup to get rid of a static checker warning
Date: Thu, 2 Apr 2015 15:45:02 -0700
Message-ID: <CAF8JNhK1ivp0H=yoLyggPwzBFbuLGQ6U+N5Mnqq8Cm-oHrGRSw@mail.gmail.com>
References: <1426888600-8603-1-git-send-email-pingc@wacom.com>
	<alpine.LNX.2.00.1504021420150.843@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yh0-f50.google.com ([209.85.213.50]:36145 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbbDBWpD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Apr 2015 18:45:03 -0400
Received: by yhme10 with SMTP id e10so341706yhm.3
        for <linux-input@vger.kernel.org>; Thu, 02 Apr 2015 15:45:02 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1504021420150.843@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>

On Thu, Apr 2, 2015 at 5:21 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Fri, 20 Mar 2015, Ping Cheng wrote:
>
>> Patch e2c7d8877e5c leads to the following Smatch complaint:
>>
>> drivers/hid/wacom_wac.c:602 wacom_intuos_inout()
>>          error: we previously assumed 'wacom->shared' could be null (see line 584)
>>
>> The first patch in this series fixes that warning. The next two cleans up the code
>> and fixes a logic order.
>>
>> The patchset is based on Jiri's for-4.0/upstream-fixes branch.
>>
>> Ping Cheng (3):
>>   HID: wacom: remove hardcoded WACOM_QUIRK_MULTI_INPUT
>>   HID: wacom: use wacom_wac_finger_count_touches to set touch_down
>>   HID: wacom: set stylus_in_proximity before checking touch_down
>
> I've had to fix a few conflicts between for-4.1/wacom and
> for-4.1/upstream-fixes to make everything apply. Hopefully everything is
> okay, but please doublecheck.

I checked and tested. Everything looks good.

> It's now pushed out to for-4.1/wacom (and merged to for-next).

Thank you,

Ping
