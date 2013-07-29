From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH] Fix key release for Fn keys with Samsung series 5 ultra
Date: Sun, 28 Jul 2013 23:26:36 -0300
Message-ID: <20130728232636.16b24b9e@infradead.org>
References: <20130728070827.32e7cd31@infradead.org>
	<12081355.tI48ExGXTL@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56702 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269Ab3G2C0n (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 28 Jul 2013 22:26:43 -0400
In-Reply-To: <12081355.tI48ExGXTL@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Em Sun, 28 Jul 2013 19:14:56 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> escreveu:

> Hi Mauro,
> 
> On Sunday, July 28, 2013 07:08:27 AM Mauro Carvalho Chehab wrote:
> > Samsung series 5 ultra notebooks don't produce release events for certain
> > keys (Fn+F1, Fn+F11, Fn+F12 and Fn Lock). Add those keys at the release
> > fixup table.
> > 
> > Note: Fn Lock actually produces two scancodes: 0xa8 and 0xa9.
> 
> Please add a quirk to udev to handle this please.

Ok. I actually opened already a BZ# adding it to udev at Fedora:
	https://bugzilla.redhat.com/show_bug.cgi?id=989103

Btw, please don't apply the patch I sent you yet. I'm finishing to test a
new patchset that includes also another Samsung series 5 notebook, and adds
the switch for FN LOCK.

Thanks!
Mauro
