From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] iio:hid-sensor-hub: Add in quirk for sensor hub in Lenovo
 Ideapad Yogas
Date: Tue, 6 May 2014 01:02:59 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1405060102400.3969@pobox.suse.cz>
References: <536816E4.2040109@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53635 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932076AbaEEXDB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 5 May 2014 19:03:01 -0400
In-Reply-To: <536816E4.2040109@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Peter F. Patel-Schneider" <pfpschneider@gmail.com>
Cc: linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Mon, 5 May 2014, Peter F. Patel-Schneider wrote:

> The sensor hub in Lenovo Yogas needs the enumeration quirk.  I've been running
> the patch for over a month with no problems, whereas the unpatched drivers
> reliably mis-initialized the sensors. (This is a resending of a previous patch
> that had formatting issues.)
> 
> Signed-off-by: Peter F. Patel-Schneider <pfpschneider@gmail.com>

Now applied. Will be pushing it for 3.15. Thanks,

-- 
Jiri Kosina
SUSE Labs
