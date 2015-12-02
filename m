From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH v2] hid: usbhid: hid-core: fix recursive deadlock
Date: Tue, 1 Dec 2015 16:00:12 -0800
Message-ID: <CAF8JNh+HEfj7JV-i5yZebwthZn_xFzT7Hra+RWBqFfVtH6_58g@mail.gmail.com>
References: <1447874755-8673-1-git-send-email-adi@adirat.com>
 <1448050742-10777-1-git-send-email-adi@adirat.com> <alpine.LNX.2.00.1512011736030.32500@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33071 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932128AbbLBAAc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Dec 2015 19:00:32 -0500
In-Reply-To: <alpine.LNX.2.00.1512011736030.32500@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Ioan-Adrian Ratiu <adi@adirat.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, joshc@ni.com, Benjamin Tissoires <benjamin.tissoires@gmail.com>

Hi Jiri,

On Tue, Dec 1, 2015 at 8:36 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Fri, 20 Nov 2015, Ioan-Adrian Ratiu wrote:
>
>> The critical section protected by usbhid->lock in hid_ctrl() is too
>> big and because of this it causes a recursive deadlock. "Too big" means
>> the case statement and the call to hid_input_report() do not need to be
>> protected by the spinlock (no URB operations are done inside them).
>>
>> The deadlock happens because in certain rare cases drivers try to grab
>> the lock while handling the ctrl irq which grabs the lock before them
>> as described above. For example newer wacom tablets like 056a:033c try
>> to reschedule proximity reads from wacom_intuos_schedule_prox_event()
>> calling hid_hw_request() -> usbhid_request() -> usbhid_submit_report()
>> which tries to grab the usbhid lock already held by hid_ctrl().
>>
>> There are two ways to get out of this deadlock:
>>     1. Make the drivers work "around" the ctrl critical region, in the
>>     wacom case for ex. by delaying the scheduling of the proximity read
>>     request itself to a workqueue.
>>     2. Shrink the critical region so the usbhid lock protects only the
>>     instructions which modify usbhid state, calling hid_input_report()
>>     with the spinlock unlocked, allowing the device driver to grab the
>>     lock first, finish and then grab the lock afterwards in hid_ctrl().
>>
>> This patch implements the 2nd solution.
>>
>> Signed-off-by: Ioan-Adrian Ratiu <adi@adirat.com>
>
> Applied to for-4.5/core branch. Thanks,

Since wacom_intuos_schedule_prox_event() was introduced on March 5,
2015, the call was first used in kernel 3.19. Shouldn't we back-port
this patch to other stable versions?

Thank you.

Ping
