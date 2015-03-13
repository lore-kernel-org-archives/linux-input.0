From: Pavel Machek <pavel@ucw.cz>
Subject: 3.18 to 3.19+: moon key stopped working
Date: Fri, 13 Mar 2015 11:12:48 +0100
Message-ID: <20150313101248.GA10375@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33835 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbbCMKMv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Mar 2015 06:12:51 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Hi!

Suspend-to-RAM works on the desktop, but moon key in X no longer
triggers it. Booting to older kernel seems to fix it.

3.19+ may be 4.0-rc0, not sure. Let me try latest 4.0.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
