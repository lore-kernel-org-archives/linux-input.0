From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] HID: logitech-hidpp: add battery support for HID++
 2.0 devices
Date: Mon, 11 Jul 2016 13:18:29 +0200
Message-ID: <20160711111829.GC4663@mail.corp.redhat.com>
References: <1467192482-2723-1-git-send-email-peter.hutterer@who-t.net>
 <1467988545.2317.4.camel@hadess.net>
 <1467999483.2277.19.camel@hadess.net>
 <alpine.LNX.2.00.1607082023400.24757@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43975 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753536AbcGKLSe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2016 07:18:34 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1607082023400.24757@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>

On Jul 08 2016 or thereabouts, Jiri Kosina wrote:
> On Fri, 8 Jul 2016, Bastien Nocera wrote:
> 
> > Sorry about not being able to test this before it was merged for 
> > inclusion.
> 
> This is just in a topic branch of hid.git as of now, so we can still tweak 
> things (including API) if/as needed.

Hmm, I think before this gets pushed to Linus' tree, we'll also need to
have battery support for HID++ 1.0 devices too (upower seems to be
handling them, so this would introduce a regression).
So depending on how much work we can do, it might be better to consider
this as v4.9 material (or at least keep in mind that this might not be
ready before the v4.8 merge window opens, and decide its fate at that
time).

Cheers,
Benjamin 
