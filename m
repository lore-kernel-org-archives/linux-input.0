From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Reporting screen/laptop orientation data to userspace
Date: Fri, 3 Jun 2011 00:19:25 +0200
Message-ID: <20110602221925.GC14328@ucw.cz>
References: <4DE1FA7F.3050308@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:34935 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753087Ab1FNGl4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2011 02:41:56 -0400
Content-Disposition: inline
In-Reply-To: <4DE1FA7F.3050308@users.sourceforge.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alberto Mardegan <mardy@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, "Javier S. Pedro" <maemo@javispedro.com>, linux-input@vger.kernel.org

Hi!

>   the WMI interfaces in some Lenovo Ideapad laptops provide notification
> callbacks when the laptop orientation changes, reporting 4 different
> values defining the new orientation.

Zaurus has two microswitches, indicating one of 3 configurations:

notebook, closed

notebook, open

tablet

They are exported as event/switch in the input. If possible, it would
be nice to have one interface for that, too. (And it probably should
be input,  and not fake-accelerator based; after all, there are no
accelerometers on zaurus-like systems).

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
