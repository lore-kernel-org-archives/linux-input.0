From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hid-sensor-hub: quirk for STM Sensor hub
Date: Mon, 17 Feb 2014 15:05:22 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402171505120.1192@pobox.suse.cz>
References: <1391411656-32684-1-git-send-email-archana.patni@linux.intel.com> <52FF48E7.9070400@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41391 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751516AbaBQOF0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Feb 2014 09:05:26 -0500
In-Reply-To: <52FF48E7.9070400@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Archana Patni <archana.patni@linux.intel.com>, linux-input@vger.kernel.org, srinivas.pandruvada@linux.intel.com

On Sat, 15 Feb 2014, Jonathan Cameron wrote:

> > We look for usage id for "power and report state", and modify
> > logical minimum value to 1.
> > 
> > This is a follow-up patch to commit id 875e36f8.
> > 
> > Signed-off-by: Archana Patni <archana.patni@linux.intel.com>
> > Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Hi Jiri,
> 
> I'm fine with any of these going in through the hid tree without without
> my Ack given they are just marking which drivers need the quirk and
> which do not.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
