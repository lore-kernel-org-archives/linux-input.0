From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/2] Support for Stantum multitouch panel
Date: Mon, 4 Jan 2010 12:03:10 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001041202390.2277@pobox.suse.cz>
References: <20091209214928.1E24D9520C@enac.fr> <20091209231516.GF10138@core.coreip.homeip.net> <20091223105611.82AC3951F2@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:39402 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753068Ab0ADLDM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Jan 2010 06:03:12 -0500
In-Reply-To: <20091223105611.82AC3951F2@smtp.lii-enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephane Chatty <chatty@lii-enac.fr>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On Wed, 23 Dec 2009, Stephane Chatty wrote:

> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> >
> > > Dmitry
> >
> Added support for the Stantum multitouch panel.

I have applied the patch, thanks Stephane.

(I have removed the dependency on CONFIG_EMBEDDED, the same way we 
discussed this for 3M driver already).

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
