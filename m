From: Stephen J <stephenjust@gmail.com>
Subject: Re: [PATCH 2/2] HID: multitouch: enable the Surface 3 Type Cover to
 report multitouch data
Date: Wed, 22 Jun 2016 19:12:49 -0600
Message-ID: <CAOvWGzjqqctSfZtg5UdfKk6aY3RXjEKi1Yd0rQYu6rJO2EXH=w@mail.gmail.com>
References: <1463062363-12405-1-git-send-email-benjamin.tissoires@redhat.com> <1463062363-12405-2-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:35664 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbcFWBNK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jun 2016 21:13:10 -0400
In-Reply-To: <1463062363-12405-2-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, May 12, 2016 at 8:12 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> There is no reasons to filter out keyboard and consumer control collections
> in hid-multitouch.
> With the previous hid-input fix, there is now a full support of the Type
> Cover and we can remove all specific bits from hid-core and hid-microsoft.
>
> hid-multitouch will automatically set HID_QUIRK_NO_INIT_REPORTS so we can
> also remove it from the list of ushbid quirks.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I've been running with this series for almost a month now on Surface
3, and have not seen any issues at all in that time. Hopefully if this
series on its own doesn't introduce any regressions on other devices,
it will land in time for 4.8.

Tested-by: Stephen Just <stephenjust@gmail.com>

Regards,
Stephen
