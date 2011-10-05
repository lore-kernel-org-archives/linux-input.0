From: Jason Gerecke <killertofu@gmail.com>
Subject: New "ABS_WHEEL2" axis?
Date: Wed, 5 Oct 2011 12:44:40 -0700
Message-ID: <CANRwn3SH9VO-1P_zAkDopVJRjApnZWpEZWP3YpuXg3cbiCQffg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49416 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933233Ab1JETol (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Oct 2011 15:44:41 -0400
Received: by wwf22 with SMTP id 22so3078453wwf.1
        for <linux-input@vger.kernel.org>; Wed, 05 Oct 2011 12:44:40 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>

I'm working on adding support for the recently-announced Cintiq 24HD,
and am hashing out most of the details on the linuxwacom mailing list.
In the discussions there, it was suggested that we add a new e.g.
"ABS_WHEEL2" axis to the input.h header to represent the second touch
ring available on the 24HD. I think it's a good idea, but wanted to
get some opinions from over here before making a patch. The other
option we have available is to use an axis not already in use by the
wacom driver (such as ABS_RUDDER), but none have a matching semantic
meaning.

Jason

---
Day xee-nee-svsh duu-'ushtlh-ts'it;
nuu-wee-ya' duu-xan' 'vm-nvshtlh-ts'it.
Huu-chan xuu naa~-gha.
