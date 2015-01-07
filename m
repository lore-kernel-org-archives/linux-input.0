From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hid-sensor-hub: Correct documentation
Date: Wed, 7 Jan 2015 09:48:33 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1501070946540.25732@pobox.suse.cz>
References: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60327 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755935AbbAGIsg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Jan 2015 03:48:36 -0500
In-Reply-To: <1420592328-9942-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org

Srinivas,

the way you sent the patches are really confusing.

Most importantly, you seem to have inter-mixed three patch series (with 
4,8 and 9 patches respectively) into one thread, plus there are 4 patches 
which aren't marked by series numbering. All this is mixed together into 
one thread without any particular ordering.

This way it makes it really difficult to review (and possibly apply 
afterwards).

Could you please resend as proper independent series, with correct 
threading etc?

-- 
Jiri Kosina
SUSE Labs
