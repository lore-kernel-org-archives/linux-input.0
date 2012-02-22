From: Andreas =?iso-8859-1?Q?H=FCbner?= <andreas@k4n.de>
Subject: Re: Saitek PS1000 gamepad - HID descriptor wonky
Date: Wed, 22 Feb 2012 01:50:41 +0100
Message-ID: <20120222005037.GA28945@tapura.fritz.box>
References: <20111123084340.GA18805@tapura>
 <3b70c0a60fd5821240583b7b5c1412b0.squirrel@host171.canaca.com>
 <20111124081205.GA22623@tapura>
 <30cc35606560d634477e2a288bdf6db3.squirrel@host171.canaca.com>
 <20111208123424.GA1298@tapura>
 <a8799dfc5b69fd158ec54b099d231961.squirrel@host171.canaca.com>
 <20111210131702.GA5620@tapura>
 <d13c53ac7f835eaff26cfc2aae0fac6c.squirrel@mungewell.org>
 <20111211214010.GA14046@tapura>
 <98f3f0015149c06f45aa0af8e5851777.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from v36691.1blu.de ([89.202.1.191]:44118 "EHLO v36691.1blu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754265Ab2BVA4P (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Feb 2012 19:56:15 -0500
Content-Disposition: inline
In-Reply-To: <98f3f0015149c06f45aa0af8e5851777.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org

I'm finally coming back to this after quite some time.

Tried to find more info regarding the issue with the constant bit on those
input reports, but I wasn't able to come up with anything useful.
Windows just seems to ignore it.

Well, it's probably not worth it to spend anymore time on this, so I
prepared a patch that fixes the report descriptor accordingly.

I tried to follow the kernel patch policy, but since this is my first
patch I might have screwed something up. Just let me know.


Andreas
