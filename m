From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH 1/3] HID: wacom: Perform all event processing as part of
 report processing
Date: Thu, 23 Jul 2015 14:04:31 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507231404160.1141@pobox.suse.cz>
References: <1437502045-29927-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [89.191.203.168] ([89.191.203.168]:54686 "EHLO
	mail.emea.novell.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751325AbbGWMEe (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Thu, 23 Jul 2015 08:04:34 -0400
In-Reply-To: <1437502045-29927-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Aaron Skomra <skomra@gmail.com>, linux-input@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>

On Tue, 21 Jul 2015, Jason Gerecke wrote:

> In some cases, we need access to information before it becomes available
> to the 'event' handler. In particular, for some devices we cannot properly
> process the finger data without first knowing the "contact count" at the
> very end of the report (e.g. the Cintiq 24HDT touch screen, when forced
> through the GENERIC codepath).
> 
> Since the HID subsystem doesn't provide a way to take action before 'event'
> is called, we take a cue from hid-multitouch.c and add a pre-process step
> within the 'report' handler that performs the same function.

The whole series is now in for-4.3/wacom.

Thanks,

-- 
Jiri Kosina
SUSE Labs
