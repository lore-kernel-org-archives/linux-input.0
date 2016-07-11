From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/2] HID: logitech-hidpp: add battery support for HID++
 2.0 devices
Date: Mon, 11 Jul 2016 13:33:12 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1607111332550.24757@cbobk.fhfr.pm>
References: <1467192482-2723-1-git-send-email-peter.hutterer@who-t.net> <1467988545.2317.4.camel@hadess.net> <1467999483.2277.19.camel@hadess.net> <alpine.LNX.2.00.1607082023400.24757@cbobk.fhfr.pm> <20160711111829.GC4663@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47168 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203AbcGKLdP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2016 07:33:15 -0400
In-Reply-To: <20160711111829.GC4663@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>

On Mon, 11 Jul 2016, Benjamin Tissoires wrote:

> Hmm, I think before this gets pushed to Linus' tree, we'll also need to 
> have battery support for HID++ 1.0 devices too (upower seems to be 
> handling them, so this would introduce a regression). So depending on 
> how much work we can do, it might be better to consider this as v4.9 
> material (or at least keep in mind that this might not be ready before 
> the v4.8 merge window opens, and decide its fate at that time).

Makes sense, thanks Benjamin. I am putting 
hid.git#for-4.8/logitech-hidpp-battery on hold for now.

-- 
Jiri Kosina
SUSE Labs

