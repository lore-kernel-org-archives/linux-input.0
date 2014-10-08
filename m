From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: How to indicate hover touch when exact distance unknown?
Date: Wed, 08 Oct 2014 17:00:15 +0200
Message-ID: <5435517F.9040507@euromail.se>
References: <CAG_cf+dJfiqW_V1k4MfGMBNUK9Kgc4=9BPAuum7dbs6rkmAgrQ@mail.gmail.com> <20140923145916.GA3110@mail.corp.redhat.com> <20140923162811.GB40700@core.coreip.homeip.net> <20140924045213.GA4194@jelly.redhat.com> <54225667.30801@euromail.se> <CAN+gG=G4Kik_Gicdo6zqZbJMqp8-hYxw8yy0rEqN7-Dj5HfKeQ@mail.gmail.com> <20141001162252.GA23115@dtor-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b32.telenor.se ([213.150.131.21]:45801 "EHLO
	smtprelay-b32.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026AbaJHO6I (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Oct 2014 10:58:08 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b32.telenor.se (Postfix) with ESMTP id D220DF0826
	for <linux-input@vger.kernel.org>; Wed,  8 Oct 2014 16:58:05 +0200 (CEST)
In-Reply-To: <20141001162252.GA23115@dtor-glaptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Andrew de los Reyes <andrew-vger@gizmolabs.org>, Hans de Goede <hdegoede@redhat.com>, jikos@jikos.cz, David Herrmann <dh.herrmann@gmail.com>, Linux Input <linux-input@vger.kernel.org>

Hi Dmitry,


> OK, so should we then say that we will continue reporting binary hovering
> with ABS_MT_DISTANCE 0/1 and such devices must report resolution of 0;
> devices reporting wider ABS_MT_DISTANCE ranges should also report
> appropriate resolution, same as X/Y coordinates?

Yes, I think this makes sense, after all.

Thanks,
Henrik

