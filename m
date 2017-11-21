From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: Add special driver for Jabra devices
Date: Tue, 21 Nov 2017 12:58:08 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1711211257550.11505@cbobk.fhfr.pm>
References: <1507113082-31678-1-git-send-email-nolsen@jabra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751382AbdKUL6K (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Nov 2017 06:58:10 -0500
In-Reply-To: <1507113082-31678-1-git-send-email-nolsen@jabra.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Niels Skou Olsen <nolsen@jabra.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com

On Wed, 4 Oct 2017, nolsen@jabra.com wrote:

> From: Niels Skou Olsen <nolsen@jabra.com>
> 
> Add a hid-jabra driver to the list of special drivers in hid-core. The
> driver prevents vendor defined HID usages (FF00-FFFF) in Jabra devices
> from being mapped to input events, that become unintended mouse events
> in the X11 server.
> 
> Signed-off-by: Niels Skou Olsen <nolsen@jabra.com>
> ---
> v2: Rebase on patch set "Quirks cleanup and hid-generic niceness", v2
>     (http://www.spinics.net/lists/linux-input/msg53428.html)

Applied to for-4.16/hid-quirks-cleanup/jabra as well.

Thanks,

-- 
Jiri Kosina
SUSE Labs

