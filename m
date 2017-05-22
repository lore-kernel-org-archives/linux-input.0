From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/5] HID: intel_ish-hid: fix potential uninitialized
 data usage
Date: Mon, 22 May 2017 23:33:58 +0200
Message-ID: <CAK8P3a1vjTUzMxDcYtPMCCjhH97g7Rty776c5kWFgkVfRTBssw@mail.gmail.com>
References: <20170518202144.3482304-1-arnd@arndb.de> <20170518202144.3482304-2-arnd@arndb.de>
 <1495480621.109485.60.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33942 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933820AbdEVVeA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 22 May 2017 17:34:00 -0400
In-Reply-To: <1495480621.109485.60.camel@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, May 22, 2017 at 9:17 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> Hi Arnd,
> On Thu, 2017-05-18 at 22:21 +0200, Arnd Bergmann wrote:
>> gcc points out an uninialized pointer dereference that could happen
>> if we ever get to recv_ishtp_cl_msg_dma() or recv_ishtp_cl_msg()
>> with an empty &dev->read_list:
>>
>> drivers/hid/intel-ish-hid/ishtp/client.c: In function
>> 'recv_ishtp_cl_msg_dma':
>> drivers/hid/intel-ish-hid/ishtp/client.c:1049:3: error: 'cl' may be
>> used uninitialized in this function [-Werror=maybe-uninitialized]
>>
>> The warning only appeared in very few randconfig builds, as the
>> spinlocks tend to prevent gcc from tracing the variables. I only
>> saw it in configurations that had neither SMP nor LOCKDEP enabled.
>>
>> As we can see, we only enter the case if 'complete_rb' is non-NULL,
>> and then 'cl' is known to point to complete_rb->cl. Adding another
>> initialization to the same pointer is harmless here and makes it
>> clear to the compiler that the behavior is well-defined.
>>
> Did you get chance to test these changes on a platform with ISH?

No, I only build-tested it and though about the fix carefully.

        Arnd
