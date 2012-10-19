From: simon@mungewell.org
Subject: Multiple clients reading from /dev/input/eventX
Date: Fri, 19 Oct 2012 11:49:29 -0400
Message-ID: <e6193392fbe49d7236b39e3b17b8fa81.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:39238 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755744Ab2JSPta (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Oct 2012 11:49:30 -0400
Received: from localhost ([127.0.0.1] helo=mungewell.org)
	by host171.canaca.com with esmtpa (Exim 4.69)
	(envelope-from <simon@mungewell.org>)
	id 1TPEpF-00029z-Af
	for linux-input@vger.kernel.org; Fri, 19 Oct 2012 11:49:29 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all,
I'm trying to track down a problem with SDL missing events from a gaming
wheel. It looks like it's not seeing a 'section' of events and this
results in an axis from the wheel/joystick being stuck on.

If I simultaneously use evtest to monitor the same /dev/input/eventX I see
all the events in evtest, but not in SDL.

I suspect that some scheduling (or other business) is causing SDL not to
check the file handle, and as a result the input system is
dropping/resyncing the interface.

Can anyone here confirm the behaviour under the situation that one client
is busy? What is the maximum time it can be 'away' or what is the size of
the inline buffer?

Many thanks,
Simon.

