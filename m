From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: wacom: Update last_slot_field during pre_report
 phase
Date: Thu, 11 Aug 2016 22:39:19 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1608112239000.22028@cbobk.fhfr.pm>
References: <f20b53ac-1bde-7005-2874-74bdd6d6aa96@gmail.com> <20160721161046.25608-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44777 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbcHKUjV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Aug 2016 16:39:21 -0400
In-Reply-To: <20160721161046.25608-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Thu, 21 Jul 2016, Jason Gerecke wrote:

> If a touchscreen contains both multitouch and single-touch reports in its
> descriptor in that order, the driver may overwrite information it saved
> about the format of the multitouch report. This can cause the report
> processing code to get tripped up and send an incorrect event stream to
> userspace.
> 
> In particular, this can cause last_slot_field to be overwritten with the
> result that the driver prematurely assumes it has finished processing a
> slot and sending the ABS_MT_SLOT event at the wrong point in time,
> associating events for the current contact with the following contact
> instead.
> 
> To prevent this from occurring, we update the value of last_slot_field
> durring the pre_report phase to ensure that it is correct for the report
> that is to be processed.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Applied to for-4.8/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs

