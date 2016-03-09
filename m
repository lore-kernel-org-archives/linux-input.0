From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: i2c-hid: Add hid-over-i2c name to i2c id table
Date: Wed, 9 Mar 2016 21:50:15 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1603092150060.3656@cbobk.fhfr.pm>
References: <20160308192539.GA23955@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43677 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999AbcCIUuS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Mar 2016 15:50:18 -0500
In-Reply-To: <20160308192539.GA23955@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 8 Mar 2016, Dmitry Torokhov wrote:

> When using the device tree binding OF compatible = "hid-over-i2c" the
> i2c id table also needs to have that name in order to auto load this
> driver, since i2c core reports module alias as i2c:<string> where
> <string> is compatible string of OF binding stripped of manufacturer's
> prefix.
> 
> Signed-off-by: Benson Leung <bleung@chromium.org>
> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

