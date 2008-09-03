From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Remove HID ignore quirk for MGE UPS devices
Date: Wed, 3 Sep 2008 15:33:36 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0809031530430.23448@jikos.suse.cz>
References: <1218798061.14646.13.camel@hughsie-work>  <ec33acbd0809010450r1a14a3e8x3ea3e1ada63c2484@mail.gmail.com> <1220271242.16219.39.camel@hughsie-work>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:60616 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751888AbYICNdi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Sep 2008 09:33:38 -0400
In-Reply-To: <1220271242.16219.39.camel@hughsie-work>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Hughes <rhughes@redhat.com>
Cc: Arnaud Quette <aquette.dev@gmail.com>, linux-input <linux-input@vger.kernel.org>, David Zeuthen <davidz@redhat.com>, "kay.sievers" <kay.sievers@vrfy.org>

On Mon, 1 Sep 2008, Richard Hughes wrote:

> > the userland support is there, and for some time mature, propose more 
> > features, best device handling (and there are many devices specifics 
> > out there)
> Right, there are a ton of HID quirks right now, I don't think adding a
> couple more for obsolete devices there would be a problem.

Agreed. Even the "quirk support" is now more mature -- there are hidbus 
patches queued in my tree, that allow for creation of separate drivers for 
every non-standard HID device, so that quirks don't have to be sprinkled 
randomly all over the HID code.
If you are going to add any new more or less complex quirks, I'd like to 
ask you to look into this infrastructure.

Thanks,

-- 
Jiri Kosina
SUSE Labs
