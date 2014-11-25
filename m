From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH V2] HID: i2c-hid: fix race condition reading reports
Date: Tue, 25 Nov 2014 15:26:53 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1411251526170.23174@pobox.suse.cz>
References: <1416149064-25655-1-git-send-email-borneo.antonio@gmail.com> <1416415597-21235-1-git-send-email-borneo.antonio@gmail.com> <CAN+gG=HttchOAYcumPkZHKqfGb5FN83P3P8c3aKod25NXxZX1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42155 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908AbaKYO0o (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Nov 2014 09:26:44 -0500
In-Reply-To: <CAN+gG=HttchOAYcumPkZHKqfGb5FN83P3P8c3aKod25NXxZX1Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Antonio Borneo <borneo.antonio@gmail.com>, linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

On Mon, 24 Nov 2014, Benjamin Tissoires wrote:

> > Current driver uses a common buffer for reading reports either
> > synchronously in i2c_hid_get_raw_report() and asynchronously in
> > the interrupt handler.
> > There is race condition if an interrupt arrives immediately after
> > the report is received in i2c_hid_get_raw_report(); the common
> > buffer is modified by the interrupt handler with the new report
> > and then i2c_hid_get_raw_report() proceed using wrong data.
> >
> > Fix it by using a separate buffers for synchronous reports.
> >
> > Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> > [Antonio Borneo: cleanup, rebase to v3.17, submit mainline]
> > Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
> > Cc: stable@vger.kernel.org
> > ---
> > V1 -> V2
> >         rename the synchronous buffer as rawbuf (instead of the
> >         asynchronous one)
> 
> Sorry for the lag and thanks for resubmitting.
> 
> This one is reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thanks.


-- 
Jiri Kosina
SUSE Labs
