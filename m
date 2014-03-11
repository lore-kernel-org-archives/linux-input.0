From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] Revert "HID: microsoft: Add ID's for Surface
 Type/Touch, Cover 2"
Date: Tue, 11 Mar 2014 16:54:25 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1403111653050.3690@pobox.suse.cz>
References: <531CAA1F.4080809@yahoo.de> <531CAA97.4020802@yahoo.de> <20140310202219.GA4125@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58204 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753471AbaCKPy1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Mar 2014 11:54:27 -0400
In-Reply-To: <20140310202219.GA4125@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Derya <derya.kiran@yahoo.de>, linux-input <linux-input@vger.kernel.org>

On Mon, 10 Mar 2014, Benjamin Tissoires wrote:

> > The MS Surface Pro 2 has an USB composite device with 3 interfaces
> > - interface 0 - sensor hub
> > - interface 1 - wacom digitizer
> > - interface 2 - the keyboard cover, if one is attached
> > This USB composite device changes it product id dependent on if and which
> > keyboard cover is attached. Adding the covers to hid_have_special_driver
> > prevents loading the right hid drivers for the other two interfaces, all 3
> > get loaded with hid-microsoft. We don't even need hid-microsoft for the
> > keyboards. We have to revert this to load the right hid modules for each
> > interface.
> > 
> > Signed-off-by: Derya <derya.kiran@yahoo.de>
> 
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Hoewever, Derya, you should reconsider re-sending the whole series
> through "git send-email" or configuring your e-mail client according to
> Documentation/email-clients.txt . This series has the lines wrapped and
> tabs are converted to spaces, which means that Jiri ca not take the
> patch without reformatting them to his tree.

Indeed, the patches have been mangled by your mail client beyond repair.

Could you please resend them (and include Benjamin's Ack), so that I can 
queue them?

Thanks!

-- 
Jiri Kosina
SUSE Labs
