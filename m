From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: simplify implement() a bit
Date: Thu, 7 Apr 2016 15:46:46 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1604071546270.27368@cbobk.fhfr.pm>
References: <20160406171958.GA39482@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51363 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753684AbcDGNqs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Apr 2016 09:46:48 -0400
In-Reply-To: <20160406171958.GA39482@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Doug Anderson <dianders@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 6 Apr 2016, Dmitry Torokhov wrote:

> The 'size' variable is not really needed, and we can also shift constant
> in the loop body when masking off existing bits.
> 
> Also we do not have to us 64 bit calculations if we take an extra
> branch.
> 
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied to for-4.7/upstream. Thanks!

-- 
Jiri Kosina
SUSE Labs

