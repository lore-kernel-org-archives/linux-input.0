From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/5] HID: intel_ish-hid: fix potential uninitialized data usage
Date: Wed, 17 May 2017 21:44:16 +0200
Message-ID: <CAK8P3a22KdSVTG0LbL4UJZghbR-ENFxjOUqGArNfV73ekx_A1A@mail.gmail.com>
References: <20170516110907.3545799-1-arnd@arndb.de> <20170516110907.3545799-2-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33076 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753577AbdEQToR (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 17 May 2017 15:44:17 -0400
In-Reply-To: <20170516110907.3545799-2-arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

On Tue, May 16, 2017 at 1:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> gcc points out an uninialized pointer dereference that could happen
> if we ever get to recv_ishtp_cl_msg_dma() or recv_ishtp_cl_msg()
> with an empty &dev->read_list:
>
> drivers/hid/intel-ish-hid/ishtp/client.c: In function 'recv_ishtp_cl_msg_dma':
> drivers/hid/intel-ish-hid/ishtp/client.c:1049:3: error: 'cl' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>
> The warning only appeared in very few randconfig builds, as the
> spinlocks tend to prevent gcc from tracing the variables. I only
> saw it in configurations that had neither SMP nor LOCKDEP enabled.
>
> I have not been able to figure out whether this case can happen in
> practice, but it's better to be defensive here and handle the case
> explicitly by returning from the function.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Embarrassingly, this did not fix the warning in all cases after all, I ran
into the same warning with the patch applied now. The other patches
in the series are probably still good, but they might not apply without
the first, so I'll have to come up with a better fix here and resend the
series.

      Arnd
