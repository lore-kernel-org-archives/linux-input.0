From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Input: feed more data into entropy pool
Date: Thu, 19 May 2016 10:39:14 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1605191038370.31937@cbobk.fhfr.pm>
References: <20160518213244.GA3167@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41830 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002AbcESIjN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 May 2016 04:39:13 -0400
In-Reply-To: <20160518213244.GA3167@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, djkurtz@chromium.org

On Wed, 18 May 2016, Dmitry Torokhov wrote:

> Commit 4369c64c79a22 ("Input: Send events one packet at a time")
> significantly reduced amount of entropy input core was feeding to the rest
> of the system, because only the very first event in the event block would
> be used as source of entropy.
> 
> With this change we will be calling add_input_randomness() for every event
> that is not filtered by the input core as a duplicate. In addition, all
> EV_SYN events are ignored.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

IMO absolutely reasonable thing to do. FWIW

	Acked-by: Jiri Kosina <jkosina@suse.cz>

Thanks,

-- 
Jiri Kosina
SUSE Labs

