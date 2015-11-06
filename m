From: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Subject: Fake KEY_5 continuous keydown events with Logitech wireless
 keyboard on Kernel 4.2
Date: Fri, 6 Nov 2015 11:50:53 -0200
Message-ID: <20151106115053.487d81b7@recife.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:39214 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161220AbbKFNu6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Nov 2015 08:50:58 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

Since I upgraded my desktop to Fedora 23 (with comes with Kernel 4.2.5), I'm
noticing a weird bug... from time to time, it starts producing an endless
sequence of KEY_5 events.

I opened a bug at Fedora:
	https://bugzilla.redhat.com/show_bug.cgi?id=1278818

But I suspect it could be some Kernel bug. Do you know if some change
between 4.1 and 4.2 might have triggered such bug?

Thanks!
Mauro
