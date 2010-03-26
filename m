From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Merge plans for Staging  Synaptics Touchscreen Driver
Date: Fri, 26 Mar 2010 15:44:16 +0100
Message-ID: <20100326144415.GA1591@ucw.cz>
References: <19039.10.24.255.18.1269336516.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:60825 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753883Ab0CZOo1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Mar 2010 10:44:27 -0400
Content-Disposition: inline
In-Reply-To: <19039.10.24.255.18.1269336516.squirrel@dbdmail.itg.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org

Hi!

> Are there any plans to merge the synaptics touchscreen driver
> (drivers/staging/dream/synaptics_i2c_rmi.c) to
> drivers/input/touchscreen. We are interested in the same
> since OMAP3 based Zoom boards use this touchscreen.

Plans are, but day job interferes with them.

> Pl add (if required) below tested by for the staging driver.

Its not as easy.

So... 

1) are you able to use driver in staging?

at minimum, non-standard multitouch support needs to be removed before
merging to input. Do you have time to help?

Plus it would be good to investigate possibility of using threaded
interrupt support -- look through mail archives.
								Pavel 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
