From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: hid-debug and CONFIG_DEBUG_FS
Date: Mon, 2 Dec 2013 17:07:22 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1312021707030.24931@pobox.suse.cz>
References: <520BAD40.8000909@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50345 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830Ab3LBQH0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Dec 2013 11:07:26 -0500
In-Reply-To: <520BAD40.8000909@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org

On Wed, 14 Aug 2013, Srinivas Pandruvada wrote:

> I am implementing some hid driver which require relatively higher throughput.
> HID debug relies on CONFIG_DEBUG_FS, which is by default turned on by many
> distros. These debugs causes issues with the throughput, because each report
> and event is logged.
> 
> What do you think about using something other than CONFIG_DEBUG_FS for
> enabling HID debug (something like CONFIG_HID_DEBUG_FS..)?

Hi Srinivas,

do you encounter performance penalty even if there are no debugfs readers?

-- 
Jiri Kosina
SUSE Labs
