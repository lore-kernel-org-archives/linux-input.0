From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 1/6] HID: wacom: generic: Send MSC_SERIAL and ABS_MISC
 when leaving prox
Date: Fri, 8 Sep 2017 15:09:26 -0700
Message-ID: <CAF8JNhJGOaAPL2pJu5P99QKCMCJJdFK0gKGX8wpMXzyDCoSjKw@mail.gmail.com>
References: <20170908004412.2698-1-ping.cheng@wacom.com> <nycvar.YFH.7.76.1709081413360.3285@jbgna.fhfr.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:45832 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756063AbdIHWJs (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 8 Sep 2017 18:09:48 -0400
In-Reply-To: <nycvar.YFH.7.76.1709081413360.3285@jbgna.fhfr.qr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input <linux-input@vger.kernel.org>, Jason Gerecke <killertofu@gmail.com>, "stable # v4 . 10" <stable@vger.kernel.org>, Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>

Hi Jiri,

On Fri, Sep 8, 2017 at 5:14 AM, Jiri Kosina <jikos@kernel.org> wrote:
> Hi,
>
> so, my plan with this patchset is to push first two patches into 4.14-rc
> as bufixes, and queue patches 3-6 for next merge window (4.15). Please let
> me know in case you disagree.

This set of patches were triggered by Bug 196673
(https://bugzilla.kernel.org/show_bug.cgi?id=196673). First two
patches fix patch f85c9dc678 ("HID: wacom: generic: Support tool ID
and additional tool types"). But, they may not be enough to fix Bug
196673. We are waiting for a confirmation from Hrvoje Zeba.

If you can't push all 6 into 4.14-rc, just the first 2 would be fine.

Cheers,
Ping
