From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Alps I2C HID Touchpad-Stick support
Date: Tue, 21 Jun 2016 09:35:01 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606210934100.6874@cbobk.fhfr.pm>
References: <1466070357-5315-1-git-send-email-masaki.ota@jp.alps.com> <20160621033925.GB35864@dtor-ws>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51702 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639AbcFUIXp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2016 04:23:45 -0400
In-Reply-To: <20160621033925.GB35864@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Masaki Ota <012nexus@gmail.com>, benjamin.tissorires@redhat.com, peter.hutterer@who-t.net, hdegoede@redhat.com, linux-input@vger.kernel.org, masaki.ota@jp.alps.com, naoki.saito@jp.alps.com

On Mon, 20 Jun 2016, Dmitry Torokhov wrote:

> > +struct u1_dev *priv;
> 
> I do not understand why you need this global. You can allocate arbitrary
> memory in probe() and you actually already do that, why do you need
> second copy?

Mea culpa, I raised this concern already quite some time ago, and missed 
the fact that it wasn't fixed in further submissions :/ 

Thanks,

-- 
Jiri Kosina
SUSE Labs

