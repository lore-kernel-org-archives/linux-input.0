From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC] HID and multitouch
Date: Fri, 18 Dec 2009 11:30:17 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912181129150.3755@pobox.suse.cz>
References: <95A5C232-DB80-4186-B473-0D2593E57691@enac.fr> <alpine.LNX.2.00.0912151500160.3755@pobox.suse.cz> <4B27A83B.5000709@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47861 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752140AbZLRKaT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Dec 2009 05:30:19 -0500
In-Reply-To: <4B27A83B.5000709@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>, linux-input@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>

On Tue, 15 Dec 2009, Rafi Rubin wrote:

> My impression is that most or all of the other devices perform finger 
> tracking in which case they need to buffer at most just the maximum 
> number of fingers, though if using dynamic structures, might be able to 
> shrink that to the current max contact id (max id of active inputs).  
> It sounds like the devices are sending full data, when they just want to 
> transmit a sparse array.
> 
> I'm not sure there's a significant benefit to a dynamic data structure 
> for holding the incoming points.  I don't think any of these devices are 
> capable of reporting more than 5 or 10 points.  With the current 
> firmware, the ntrig only reports 4+pen, though it reports them as 6 
> points (id 4 is always transmitted and always 0, and 5 is the pen).  
> Anyway, we're talking small arrays with just a little state in each 
> cell.

Thanks for information. If other devices behave similar to n-trig in this 
respect, we can easily have static caching data structure for that then.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
