From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] hid: Fix uninitialized variable "size" in
 hid-wiimote-debug
Date: Fri, 18 Jan 2013 10:59:57 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1301181059470.8266@pobox.suse.cz>
References: <1358456572-22851-1-git-send-email-sque@chromium.org> <CANq1E4Q+1S+wZU=HOrJq+_CbbnzB++GJg_qgU=rb6K+Ozz23ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58896 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300Ab3ARKAB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Jan 2013 05:00:01 -0500
In-Reply-To: <CANq1E4Q+1S+wZU=HOrJq+_CbbnzB++GJg_qgU=rb6K+Ozz23ZA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Simon Que <sque@chromium.org>, linux-input@vger.kernel.org, msb@chromium.org

On Thu, 17 Jan 2013, David Herrmann wrote:

> > This variable is initialized conditionally, based on whether a wiimote
> > call succeeds.  However, the logic is not obvious to the compiler so it
> > throws a warning.  Eliminate the warning by initializing "size" to 0.
> >
> > The warning is:
> > files/drivers/hid/hid-wiimote-debug.c:69:18: warning: 'size' may be used
> > uninitialized in this function [-Wmaybe-uninitialized]
> 
> Thanks!
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>

Applied, thanks!

-- 
Jiri Kosina
SUSE Labs
