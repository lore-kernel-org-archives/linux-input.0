From: Rodolfo Giometti <giometti@enneenne.com>
Subject: Re: [PATCH 3/12] pxa: introduce driver structure and use KEY() to
	define matrix keys
Date: Tue, 29 Jan 2008 11:10:20 +0100
Message-ID: <20080129101019.GA27936@gundam.enneenne.com>
References: <f17812d70801222324s1eaeb67fl84c1dc598a41a025@mail.gmail.com> <200801290133.52434.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 81-174-11-161.static.ngi.it ([81.174.11.161]:41137 "EHLO
	mail.enneenne.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403AbYA2Knx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jan 2008 05:43:53 -0500
Content-Disposition: inline
In-Reply-To: <200801290133.52434.dtor@insightbb.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: eric miao <eric.y.miao@gmail.com>, linux-input@vger.kernel.org

On Tue, Jan 29, 2008 at 01:33:51AM -0500, Dmitry Torokhov wrote:

> I am a bit concerned with loss of backward compatibility with the driver.
> While there are currently no users of it inside the mainline kernel there
> may be people using it in the wild. Let's ask Rodolfo if he can cope
> with this change...

It's ok for me. :)

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
