From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v3] HID: Allow drivers to be their own listener
Date: Fri, 20 Jul 2012 14:49:41 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1207201449290.21929@pobox.suse.cz>
References: <1342777749-31457-1-git-send-email-dh.herrmann@googlemail.com> <20120720122801.GA1463@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38960 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753563Ab2GTMtr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Jul 2012 08:49:47 -0400
In-Reply-To: <20120720122801.GA1463@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.se>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-input@vger.kernel.org

On Fri, 20 Jul 2012, Henrik Rydberg wrote:

> > hid-picolcd and hid-wiimote do not allow any of hidinput, hiddev or hidraw
> > to claim the device but still want to remain on the bus. Hence, if a
> > driver uses the raw_event callback but no other listener claimed the
> > device, we still leave it on the bus as the driver handles everything by
> > itself. It thus becomes its own listener.
> > 
> > Under some circumstances (eg., hidinput_connect() fails and raw_event set)
> > a device may be left on the bus even though it requires external
> > listeners. But then if hidinput_connect() fails there are bigger issues
> > than a device that is left unhandled. So we can safely use this heuristic
> > to avoid adding another flag for special devices like hid-picolcd and
> > hid-wiimote.
> > 
> > This also removes the ugly hack from hid-picolcd as this is no longer
> > required.
> > 
> > Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> > ---
> > Sorry for the delay. I had two exams this week that got into my way. Anyway, I
> > hope this time the patch looks ok.
> > 
> > Thanks to Henrik for reviewing it the previous times.
> 
> Thanks, David, looking good now.
> 
>     Acked-by: Henrik Rydberg <rydberg@euromail.se>

Now queued for 3.6. Thanks,

-- 
Jiri Kosina
SUSE Labs
