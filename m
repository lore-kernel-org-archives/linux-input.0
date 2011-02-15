From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hidinput: kernel oops in out_cleanup in function
 hidinput_connect
Date: Tue, 15 Feb 2011 23:48:14 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1102152347330.2160@pobox.suse.cz>
References: <1297780870-4006-1-git-send-email-benjamin.tissoires@enac.fr> <20110215164614.GA18862@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59734 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752706Ab1BOWsT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Feb 2011 17:48:19 -0500
In-Reply-To: <20110215164614.GA18862@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 15 Feb 2011, Dmitry Torokhov wrote:

> > Goto out_cleanup infers a kernel oops: hidinput_disconnect calls
> > input_unregister_driver to all members of hid->inputs.
> > However, hidinput already has been added to hid->inputs even
> > though input_register_device was not called.
> > 
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
> 
> Yep, well spotted.
> 
> Reviewed-by: Dmitry Torokhov <dtor@mail.ru>

Indeed, thanks a lot for spotting this Benjamin. Apparently this codepath 
is not excercised too heavily (which is good :) ).

Applied.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
