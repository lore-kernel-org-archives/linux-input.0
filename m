From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: fix out of bound access in extract and implement
Date: Tue, 19 Jan 2016 14:14:45 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1601191414290.21446@cbobk.fhfr.pm>
References: <20160119064037.GA18052@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49061 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184AbcASNOt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jan 2016 08:14:49 -0500
In-Reply-To: <20160119064037.GA18052@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 18 Jan 2016, Dmitry Torokhov wrote:

> extract() and implement() access buffer containing reports in 64-bit
> chunks, but there is no guarantee that buffers are padded to 64 bit
> boundary. In fact, KASAN has caught such OOB access with i2c-hid and
> Synaptics touch controller.
> 
> Instead of trying to hunt all parties that allocate buffers and make
> sure they are padded, let's switch extract() and implement() to byte
> access. It is a bit slower, bit we are not dealing with super fast
> devices here.
> 
> Also let's fix link to the HID spec while we are at it.
> 
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>

Good catch, applied to for-4.5/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

