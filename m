From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/6] HID: wacom: generic: Send MSC_SERIAL and ABS_MISC
 when leaving prox
Date: Wed, 13 Sep 2017 10:18:55 -0700 (PDT)
Message-ID: <nycvar.YFH.7.76.1709131018230.4703@jbgna.fhfr.qr>
References: <20170908004412.2698-1-ping.cheng@wacom.com> <nycvar.YFH.7.76.1709081413360.3285@jbgna.fhfr.qr> <CAF8JNhJGOaAPL2pJu5P99QKCMCJJdFK0gKGX8wpMXzyDCoSjKw@mail.gmail.com> <nycvar.YFH.7.76.1709111050000.3285@jbgna.fhfr.qr>
 <CAF8JNh+7e=2HWNumAQFY1zyfH7mmJXW8Q=6KSPuSMpovt+cxDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36837 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751117AbdIMRS5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 13 Sep 2017 13:18:57 -0400
In-Reply-To: <CAF8JNh+7e=2HWNumAQFY1zyfH7mmJXW8Q=6KSPuSMpovt+cxDA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jason Gerecke <killertofu@gmail.com>, stable@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Mon, 11 Sep 2017, Ping Cheng wrote:

> Only the first 2 need to go in 4.14-rc. The other 4 can wait until
> 4.15 is open, as you suggested.

Thanks a lot for verifying. Applied the first two to 
for-4.14/upstream-fixes and the rest on top into for-4.15/wacom

-- 
Jiri Kosina
SUSE Labs

