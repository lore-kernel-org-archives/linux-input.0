From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: feed more data into entropy pool
Date: Thu, 19 May 2016 09:15:54 +0200
Message-ID: <20160519071554.GG23234@mail.corp.redhat.com>
References: <20160518213244.GA3167@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54609 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753849AbcESHP7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 May 2016 03:15:59 -0400
Content-Disposition: inline
In-Reply-To: <20160518213244.GA3167@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, djkurtz@chromium.org

On May 18 2016 or thereabouts, Dmitry Torokhov wrote:
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

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks!
