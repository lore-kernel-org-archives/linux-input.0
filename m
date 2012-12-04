From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: Separate struct hid_device's driver_lock into two
 locks.
Date: Tue, 4 Dec 2012 09:04:10 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1212040902270.17055@pobox.suse.cz>
References: <CAG_cf+cXnNSyxcrsZncfr2KKFRhiCJ60vHrTt3_aB-Bc7m5eVw@mail.gmail.com> <20121126185627.7bff1f84@neptune.home> <CAN+gG=ENOU1oYRLd2ZMhPeCFPmTtiYRDZuuW3idvULShrnkPUg@mail.gmail.com>
 <CANq1E4Qc_GpRtghL5emCFTWOCh0-0TC1oJ6ZaAsQbOMixgS-5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37668 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751007Ab2LDIEP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Dec 2012 03:04:15 -0500
In-Reply-To: <CANq1E4Qc_GpRtghL5emCFTWOCh0-0TC1oJ6ZaAsQbOMixgS-5Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, Andrew de los Reyes <andrew-vger@gizmolabs.org>, Linux Input <linux-input@vger.kernel.org>

On Mon, 26 Nov 2012, David Herrmann wrote:

> The fix you are proposing actually looks pretty nice, although it puts
> the burden of locking to the hid-driver instead of the hid-core. So
> every .probe function must go sure that the lock is held when
> returning. This means if you unlock the input-lock, you need to lock
> it before calling return so hid-core can unlock it again. This opens a
> small race-condition where the hid-core might drop important
> input-events as input-lock is held during "return". Any ideas here?

But why should we care deeply?

The lost events wouldn't be the ones that are needed for initialization of 
the device, as all the probing as been finished already.

So they would be 'regular' events sent by the device. And as the 
initialization hasn't been finished yet, it really can't be predicted 
which events make it and which don't.

Thanks,

-- 
Jiri Kosina
SUSE Labs
