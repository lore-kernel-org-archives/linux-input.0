From: Andrew de los Reyes <andrew-vger@gizmolabs.org>
Subject: How to indicate hover touch when exact distance unknown?
Date: Tue, 23 Sep 2014 07:37:15 -0700
Message-ID: <CAG_cf+djt_eFajNML=nFgojNdZvpf6zd3rNnxMPsHoFbLv_1yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33248 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755688AbaIWOhh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Sep 2014 10:37:37 -0400
Received: by mail-yk0-f174.google.com with SMTP id q9so1411515ykb.33
        for <linux-input@vger.kernel.org>; Tue, 23 Sep 2014 07:37:36 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: hdegoede@redhat.com, Benjamin Tissoires <benjamin.tissoires@redhat.com>, rydberg@euromail.se, jikos@jikos.cz, David Herrmann <dh.herrmann@gmail.com>, peter.hutterer@who-t.net, dmitry.torokhov@gmail.com
Cc: Linux Input <linux-input@vger.kernel.org>

[resending as plain text for the list]

Hi folks,

More and more we're seeing touch input devices that support detection
of fingers that are above the surface and not touching. We were
thinking of writing a kernel patch for one such device. Normally we
would indicate distance with ABS_MT_DISTANCE, but we ran into the
problem that sometimes the hardware will not be able to report a
distance (or will stop reporting a distance when it's too great a
number), and we had the (bad) idea to simply report a value or 1 or
255 or something like that when distance is unknown.

Dmitry warned that a similar thing happened with PRESSURE a while ago,
and it was a mess as different drivers did different things.

We are now wondering if we should come up with a standard way to
indicate hover with or without distance (or with distance being
optional). Dmitry had the idea for a new tool type, HOVER; FINGER
would be for touches that are actually touching.

What do folks here think?

Thanks,
-andrew
