From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] HID: sony: Cache the output report for the Dualshock
 4
Date: Mon, 20 Jan 2014 13:02:15 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1401201302050.7575@pobox.suse.cz>
References: <alpine.DEB.2.10.1401171443040.3454@franz-virtual-machine> <CANq1E4QH_XbShAMQrCAW46dKkP7wmz6jRjA0+3xE0ag=fhDHQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43079 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751538AbaATMCT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jan 2014 07:02:19 -0500
In-Reply-To: <CANq1E4QH_XbShAMQrCAW46dKkP7wmz6jRjA0+3xE0ag=fhDHQQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Frank Praznik <frank.praznik@oh.rr.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Sat, 18 Jan 2014, David Herrmann wrote:

> > Retrieve and cache the output report for the Dualshock 4 in sony_probe()
> > instead of repeatedly walking the report list in the worker function.
> 
> Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
