From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: [PATCH 1/2] HID: logitech-dj: prevent false errors to be shown
Date: Mon, 25 Aug 2014 09:55:52 +0200
Message-ID: <20140825075552.GA298@x4>
References: <1408738566-6805-1-git-send-email-benjamin.tissoires@redhat.com>
 <alpine.LNX.2.00.1408250249150.23162@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ud10.udmedia.de ([194.117.254.50]:60786 "EHLO
	mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbaHYHz6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Aug 2014 03:55:58 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1408250249150.23162@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ben Hawkes <hawkes@google.com>

On 2014.08.25 at 02:50 -0500, Jiri Kosina wrote:
> On Fri, 22 Aug 2014, Benjamin Tissoires wrote:
> 
> > Commit "HID: logitech: perform bounds checking on device_id early
> > enough" unfortunately leaks some errors to dmesg which are not real
> > ones:
> > - if the report is not a DJ one, then there is not point in checking
> >   the device_id
> > - the receiver (index 0) can also receive some notifications which
> >   can be safely ignored given the current implementation
> > 
> > Move out the test regarding the report_id and also discards
> > printing errors when the receiver got notified.
> > 
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> I have now queued this one for 3.17. Adding Markus to CC -- Markus, this 
> should make the spurious error messages you have reported go away.

Indeed it does. Feel free to add:

Reported-and-tested-by: Markus Trippelsdorf <markus@trippelsdorf.de>

-- 
Markus
