From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v1] HID: hid-sensor-hub: Processing for duplicate physical
 ids
Date: Mon, 17 Feb 2014 17:16:56 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402171716420.1192@pobox.suse.cz>
References: <1391198650-15468-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43882 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830AbaBQQRA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Feb 2014 11:17:00 -0500
In-Reply-To: <1391198650-15468-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jic23@kernel.org, linux-input@vger.kernel.org, Archana Patni <archana.patni@intel.com>

On Fri, 31 Jan 2014, Srinivas Pandruvada wrote:

> In HID sensor hub, HID physical ids are used to represent different
> sensors. For example physical id of 0x73 in usage page = 0x20, represents
> an accelerometer. The HID sensor hub driver uses this physical ids to
> create platform devices using MFD. There is 1:1 correspondence between
> an phy id and a client driver.
> But in some cases these physical ids are reused. There is a phy id 0xe1,
> which specifies a custom sensor, which can exist multiple times to represent
> various custom sensors. In this case there can be multiple instances
> of client MFD drivers, processing specific custom sensor. In this
> case when client driver looks for report id or a field index, it
> should still get the report id specific to its own type. This is
> also true for reports, they should be directed towards correct instance.
> This change introduce a way to parse and tie physical devices to their
> correct instance.
> Summary of changes:
> - To get physical ids, use collections. If a collection of type=physical
> exist then use usage id as in the name of platform device name
> - As part of the platform data, we assign a hdsev instance, which has
> start and end of collection indexes. Using these indexes attributes
> can be tied to correct MFD client instances
> - When a report is received, call callback with correct hsdev instance.
> In this way using its private data stored as part of its registry, it
> can distinguish different sensors even when they have same physical and
> logical ids.
> This patch is co-authored with Archana Patni<archna.patni@intel.com>.

I have massaged the changelog a little bit, and applied.

-- 
Jiri Kosina
SUSE Labs
