From: Ignacy =?iso-8859-2?Q?Gaw=EAdzki?= <bugs@qult.net>
Subject: Dell XPS 13 Fn key bug?
Date: Wed, 25 Jan 2017 09:47:32 +0100
Message-ID: <20170125084732.5hawvooeegtw4wwc@zenon.in.qult.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [78.193.33.39] ([78.193.33.39]:35006 "EHLO mail.qult.net"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1751474AbdAYJby (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Jan 2017 04:31:54 -0500
Received: from zenon.in.qult.net ([192.168.64.1])
        by mail.qult.net with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        (envelope-from <bugs@qult.net>)
        id 1cWJEt-0000kb-3X
        for linux-input@vger.kernel.org; Wed, 25 Jan 2017 09:47:35 +0100
Received: from ig by zenon.in.qult.net with local (Exim 4.87)
        (envelope-from <bugs@qult.net>)
        id 1cWJEq-0003ph-G6
        for linux-input@vger.kernel.org; Wed, 25 Jan 2017 09:47:32 +0100
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

There is a bug in the processing of the Fn key on the first generation
of Dell XPS 13 laptops (at least models L321X and L322X have the problem).
It happens with the combinations for Home, End, Page Up and Page Down
keys, achieved with pressing Fn with respectively Left, Right, Up and
Down.  If the Fn key is released before the other key, the release of
the other key is not passed through.  In that case, an auto-repeat of
the key may activate itself until any other key is pressed.

This is confirmed by running evtest:

Event: time 1485332907.361701, type 4 (EV_MSC), code 4 (MSC_SCAN), value cf
Event: time 1485332907.361701, type 1 (EV_KEY), code 107 (KEY_END), value 1
Event: time 1485332907.659714, type 4 (EV_MSC), code 4 (MSC_SCAN), value cd

The second MSC_SCAN happens when the Fn key is released and after it,
until any key is pressed again, the End key is considered pressed and
auto-repeating eventually starts.

Another similar situation happens if for instance the Right key is
pressed, then the Fn key is pressed before the Right key is released.
The subsequent release of the Right key is not passed through:

Event: time 1485333101.589438, type 4 (EV_MSC), code 4 (MSC_SCAN), value cd
Event: time 1485333101.589438, type 1 (EV_KEY), code 106 (KEY_RIGHT), value 1
Event: time 1485333101.959561, type 4 (EV_MSC), code 4 (MSC_SCAN), value cf

Interestingly, after such an event, if the not-released-key is pressed
again, the key press is not registered by whatever application has the
focus and evtest shows the following:

Event: time 1485333306.755393, type 4 (EV_MSC), code 4 (MSC_SCAN), value cd
Event: time 1485333306.755393, type 1 (EV_KEY), code 106 (KEY_RIGHT), value 2
Event: time 1485333306.847098, type 4 (EV_MSC), code 4 (MSC_SCAN), value cd
Event: time 1485333306.847098, type 1 (EV_KEY), code 106 (KEY_RIGHT), value 0

The same happens after the first sequence (first Fn press, then Right
press), the value with KEY_END is 2 on press and then 0 on release.

I tested this on kernel 4.8 (live Ubuntu 16.10) but I haven't tested
it with the latest vanilla kernel just yet.  I searched through
linux-input archives and found some threads about repeating keys, but
this looks like a different problem altogether.  Also note that on my
L321X I've upgraded the BIOS to the latest version (A08) long ago.

The problem doesn't appear either on the Linux console or in Windows.

Do you think this is something that could be fixed in the input
driver?

Regards,

Ignacy

-- 
Sex on TV doesn't hurt....unless you fall off.
