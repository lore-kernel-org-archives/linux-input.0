From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/4] input: serio: Replace timeval by timespec64
Date: Tue, 13 Sep 2016 17:13:48 +0200
Message-ID: <2982423.lGps9KTD1c@wuerfel>
References: <1473775805-2242-1-git-send-email-deepa.kernel@gmail.com> <1473775805-2242-5-git-send-email-deepa.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:61419 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753562AbcIMPNw (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Sep 2016 11:13:52 -0400
In-Reply-To: <1473775805-2242-5-git-send-email-deepa.kernel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, y2038@lists.linaro.org

On Tuesday, September 13, 2016 7:10:05 AM CEST Deepa Dinamani wrote:
> struct timeval is not y2038 safe.
> All references to timeval will be deleted from the
> kernel to make it y2038 safe.
> Replace its uses by y2038 safe struct timespec64.
> 
> The timestamps changed here only keep track of delta
> times. These timestamps are also internal to kernel.
> Hence, monotonic times are sufficient here.
> The unit of the delta times is also changed in certain
> cases to nanoseconds rather than microseconds. This is
> in line with timespec64 which keeps time in nanoseconds.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> 

Looks all correct to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

I think it could be done a little nicer using ktime_get()
instead of ktime_get_ts64(), but probably nobody cares with
this driver.

	Arnd
