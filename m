From: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Subject: Regression in kernel 3.13: mouse freezes after entering in KDE
 (doesn't happen in 3.12)
Date: Tue, 4 Mar 2014 14:54:23 -0300
Message-ID: <lf55km$di5$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52630 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754581AbaCDSWj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Mar 2014 13:22:39 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-input-2@m.gmane.org>)
	id 1WKtzC-0004lh-8h
	for linux-input@vger.kernel.org; Tue, 04 Mar 2014 19:22:38 +0100
Received: from 177.189.69.196 ([177.189.69.196])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Tue, 04 Mar 2014 19:22:38 +0100
Received: from fragabr by 177.189.69.196 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Tue, 04 Mar 2014 19:22:38 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

	After I upgraded my kernel from 3.12 to 3.13, the mouse gets
stuck (freezes) after entering in KDE. The interesting is that the
mouse works with gpm at the console and in KDM (before login). Just
after I login into KDE, it freezes (and it freezes when Bitcoin-qt is
starting which is very disk intensive at the start... maybe something
related to high load?).

	My hardware:

Asus P8Z68-V Pro/Gen3
Core i7 2700k
HD Seagate 1.5 TB (using ext4)

	I tried to bisect between 3.12 and 3.13 but it failed to find
the bad commit. For example:

1) I bisect between 3.12 and 3.13:

37676af15c8d5a9689c9d1220d2a27d510cbe238 is the first bad commit

2) I bisect between 3.12 and 37676af15c8d5a9689c9d1220d2a27d510cbe238

afc4b47372ace24c630c1d79b3a0ed32bf1d19fd is the first bad commit

	And this goes on forever. The strangest fact is that bisect
test against commits which it shouldn't test like commits before 3.12
release (3.12-rc7 etc).

	So I'm asking for suggestions for what can I try to better find
the bad commit. 3.13-rc1 also fails, so the bad commit is between 3.12
and 3.13-rc1. I tried to bisect between 3.12 and 3.13-rc1 but without
success, since it points to a "bad commit" after the real bad commit (I
know because I always test with the previous commit before the "bad
commit" and it fails too).

	Any thins what I can do?

	Thanks.

	Ps: better yet, could you suggest commits I could test, so I
can report back and we can do a more rational bisect?

-- 
Linux 3.12.13: One Giant Leap for Frogkind
http://www.youtube.com/DanielFragaBR
http://mcxnow.com?r=danielfragabr
Bitcoin: 12H6661yoLDUZaYPdah6urZS5WiXwTAUgL


