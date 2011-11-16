From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 16/16] HID: wiimote: Enable NO_INIT_REPORTS quirk
Date: Wed, 16 Nov 2011 19:39:28 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1111161938430.15187@pobox.suse.cz>
References: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com> <1321190839-3517-17-git-send-email-dh.herrmann@googlemail.com> <alpine.LNX.2.00.1111161805250.15187@pobox.suse.cz>
 <CANq1E4T-mMYgEZFSEcZnWZvPCBRg1J=f8zJSc-OOqVK9bJ9dsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46236 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751765Ab1KPSja (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 13:39:30 -0500
In-Reply-To: <CANq1E4T-mMYgEZFSEcZnWZvPCBRg1J=f8zJSc-OOqVK9bJ9dsA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org

On Wed, 16 Nov 2011, David Herrmann wrote:

> >> -#define WIIMOTE_VERSION "0.2"
> >> +#define WIIMOTE_VERSION "0.3"
> >
> > Do we really need this?
> >
> > I generally prefer not having any file versioning for the files that are
> > implicitly tracked by kernel git.
> 
> No, not at all. But I thought this was common practice. I have removed
> it all together. The next series will be updated.

It definitely might make sense for your internal tracking during driver 
development. I just would like to have it dropped for final merge.

Otherwise, I have just finished first round of review, and overall the 
driver looks fine, thanks!

-- 
Jiri Kosina
SUSE Labs
