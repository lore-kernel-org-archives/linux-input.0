From: Grant Likely <glikely@secretlab.ca>
Subject: Re: [PATCH v2 0/6] Intel Integrated Sensor Hub Support (ISH)
Date: Wed, 24 Aug 2016 12:16:19 -0400
Message-ID: <CACxGe6v6pDisF9FpKPJrojGS7qUn13xUUd-Uydr7B1701Y4szg@mail.gmail.com>
References: <1466574038-20613-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <b81da639-0ec5-bb30-1f77-b71d8e7ad434@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36491 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755056AbcHXQQl (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 24 Aug 2016 12:16:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id i138so3281503wmf.3
        for <linux-input@vger.kernel.org>; Wed, 24 Aug 2016 09:16:40 -0700 (PDT)
In-Reply-To: <b81da639-0ec5-bb30-1f77-b71d8e7ad434@secretlab.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, benjamin.tissoires@redhat.com
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-iio@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Jul 5, 2016 at 8:42 AM, Grant Likely <glikely@secretlab.ca> wrote:
>
> On 22/06/16 06:40, Srinivas Pandruvada wrote:
>>
>> Change log
>> v2:
>> - Overview in documentation show analogy with usbhid implementation
>> - sparse errors for statics. Also pointed by Jiri
>> - Clearly marking exported function header file. Clean up all exports
>> unused inteface functions
>> - Changed to tristate from boolean as pointed by Jiri:
>> this required remove/unload functions
>> - Prevent crash when ISH enabled on non supported platform
>> - Break client.c to smaller part by seprating buffer allocations
>> - move bus register/unregister to ishtp module
>> - There is only one config symbol INTEL_ISH_HID, removed silent
>> config for TRANSPORT and IPC
>
> Tested-by: Grant Likely <grant.likely@secretlab.ca>
>
> On an HP Spectre x360 laptop using v4.7-rc5.

Hey Srinivas. Any progress on this patch series?

g.
