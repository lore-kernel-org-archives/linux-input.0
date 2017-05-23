From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 4/5] HID: intel_ish-hid: fix format string for size_t
Date: Tue, 23 May 2017 10:35:46 +0200
Message-ID: <CAK8P3a1uoJur=sku_Yw9fxcLF1vxpQOU24NcM4yydbwmTot=ag@mail.gmail.com>
References: <20170518202144.3482304-1-arnd@arndb.de> <20170518202144.3482304-5-arnd@arndb.de>
 <1495496804.109485.75.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35063 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759734AbdEWIfr (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 23 May 2017 04:35:47 -0400
In-Reply-To: <1495496804.109485.75.camel@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, May 23, 2017 at 1:46 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Thu, 2017-05-18 at 22:21 +0200, Arnd Bergmann wrote:
>> When building for 32-bit architectures, we get a harmless warning:
>>
>> intel-ish-hid/ishtp-hid-client.c: In function 'process_recv':
>> intel-ish-hid/ishtp-hid-client.c:139:7: error: format '%lu' expects
>> argument of type 'long unsigned int', but argument 3 has type
>> 'unsigned int' [-Werror=format=]
>>
>> This changes the format string to print size_t variables using %zu
>> instead.
> Is the ordering of patch correct?
> ISH config depends on X86_64, so it would not be enabled for 32 bit
> build.
> So your patch 5/5 will adding "|| COMPILE_TEST", hence it is building.

Right, that is intentional. Adding ||COMPILE_TEST first would be a
regression by introducing  the warning on 32-bit allmodconfig builds.

       Arnd
