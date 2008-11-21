From: Jim Gettys <jg@laptop.org>
Subject: Re: [PATCH] input: Add a detailed multi-touch finger data report
	protocol
Date: Fri, 21 Nov 2008 09:43:44 -0500
Message-ID: <1227278624.7218.16.camel@jg-vaio>
References: <49142351.9080805@euromail.se>
	 <20081119113508.ZZRA012@mailhub.coreip.homeip.net>
	 <1227113699.7181.103.camel@jg-vaio>  <4924A289.6030906@euromail.se>
Reply-To: jg@laptop.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qmta02.westchester.pa.mail.comcast.net ([76.96.62.24]:46341
	"EHLO QMTA02.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753292AbYKUOoH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Nov 2008 09:44:07 -0500
In-Reply-To: <4924A289.6030906@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Interesting....  I know of the a different case: a device which
certainly does not report ellipses, rather reports x, y, dx, dy.
                          - Jim


On Thu, 2008-11-20 at 00:34 +0100, Henrik Rydberg wrote:
> Jim Gettys wrote:
> [...]
> > Also, I'm still concerned about using elipses. I doubt very much any
> > hardware will ever be reporting elipses; more likely are parallelograms,
> > or trapezoids, other simple geometric figures, rather than a center with
> > size and orientation.
> 
> The bcm5974 chip is doing precisely this.
> 
> Henrik
> 
-- 
Jim Gettys <jg@laptop.org>
One Laptop Per Child

