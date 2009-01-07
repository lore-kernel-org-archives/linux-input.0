From: Jim Gettys <jg@laptop.org>
Subject: Re: [PATCH 2/2] input: Add a detailed multi-touch finger data
	report protocol (rev2)
Date: Wed, 07 Jan 2009 10:05:14 -0500
Message-ID: <1231340714.8379.141.camel@jg-vaio>
References: <495804B1.10300@euromail.se> <1231266769.8379.79.camel@jg-vaio>
	 <20090106222141.GA685@kroah.com>
Reply-To: jg@laptop.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qmta10.westchester.pa.mail.comcast.net ([76.96.62.17]:34192
	"EHLO QMTA10.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753691AbZAGPFR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Jan 2009 10:05:17 -0500
In-Reply-To: <20090106222141.GA685@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, jkosina@suse.cz, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel@vger.kernel.org

On Tue, 2009-01-06 at 14:21 -0800, Greg KH wrote:

> 
> > 2) do you want generic USB HID patches or do you want to, for now,
> > confine these to USB device specific drivers as much as possible?
> 
> As more devices should be showing up with this kind of support, it would
> seem to make sense to add it to the HID core, right?
> 

Yes, the HID core makes sense to me if we had more than one (partially)
implemented example in captivity and/or more than the unconfirmed pious
claims of one Microsoft document.  Right now, it is less than clear to
me which way to jump.

I'll try to see what may be involved....
                          - Jim

-- 
Jim Gettys <jg@laptop.org>
One Laptop Per Child

