From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: Add special driver for Jabra devices
Date: Wed, 6 Sep 2017 11:25:29 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1709061124360.4077@jbgna.fhfr.qr>
References: <1504269832-23142-1-git-send-email-nolsen@jabra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55867 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752289AbdIFJZc (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 6 Sep 2017 05:25:32 -0400
In-Reply-To: <1504269832-23142-1-git-send-email-nolsen@jabra.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Niels Skou Olsen <nolsen@jabra.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com

On Fri, 1 Sep 2017, nolsen@jabra.com wrote:

> From: Niels Skou Olsen <nolsen@jabra.com>
> 
> Add a hid-jabra driver to the list of special drivers in hid-core. The
> driver prevents vendor defined HID usages (FF00-FFFF) in Jabra devices
> from being mapped to input events that become unintended mouse events
> in the X11 server.
> 
> Signed-off-by: Niels Skou Olsen <nolsen@jabra.com>

Do you plan to eventually map the vendor specific devices to anything 
meaningful?

Thanks,

-- 
Jiri Kosina
SUSE Labs

