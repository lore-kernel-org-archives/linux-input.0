From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v3 0/6] HID: sony: Add full Bluetooth support for the
 Dualshock 4
Date: Mon, 17 Feb 2014 14:18:52 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402171418260.1192@pobox.suse.cz>
References: <1391648629-3077-1-git-send-email-frank.praznik@oh.rr.com> <CANq1E4TNzAuhUsTi_QA-NaqH2MbzS3awuJu0Tx0QyeL-MEBrmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39891 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753934AbaBQNSz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Feb 2014 08:18:55 -0500
In-Reply-To: <CANq1E4TNzAuhUsTi_QA-NaqH2MbzS3awuJu0Tx0QyeL-MEBrmA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Frank Praznik <frank.praznik@oh.rr.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Wed, 12 Feb 2014, David Herrmann wrote:

> > v3 of this patch series rebases the code against Benjamin Tissoires' HID
> > transport layer changes to use the safe inline hid_hw_* functions which
> > eliminates the need to check the function pointers manually.
> >
> > It adds an explicit Bluetooth initialization function instead of the controller
> > input report state being set as a side effect of initializing the LED system.
> >
> > It also uses a new DUALSHOCK4_CONTROLLER macro to simplify conditional cases
> > where the connection type is irrelevant.
> 
> The series looks good to me.
> 
> Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

I finally made it to reviewing this lot. Now applied, thanks everybody.

-- 
Jiri Kosina
SUSE Labs
