From: "Gunn, Brian" <bgunn@solekai.com>
Subject: RE: [PATCHes] Implement Bluetooth Wacom tablet's mode change in the
 kernel
Date: Tue, 19 Jan 2010 08:36:58 -0800
Message-ID: <FE57175CCE23E5419899C1B0CFA26FAD101B5F8B9D@EXMBXSD.dm.solekai.com>
References: <1263833399.20565.2905.camel@localhost.localdomain>
	 <1263886149.5591.166.camel@localhost.localdomain>,<1263897015.20565.3988.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.solekai.com ([72.34.65.115]:2066 "EHLO mail.solekai.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752294Ab0ASQnj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jan 2010 11:43:39 -0500
In-Reply-To: <1263897015.20565.3988.camel@localhost.localdomain>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Marcel Holtmann <marcel@holtmann.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, BlueZ development <linux-bluetooth@vger.kernel.org>, Ping <pinglinux@gmail.com>, Jiri Kosina <jikos@jikos.cz>

I tested this with a Bluetooth remote control.  As I understand, reports can be written to either the interrupt or control sockets.  I'm happy to test other changes to let this be selectable.

Brian

________________________________________
From: Bastien Nocera [hadess@hadess.net]
Sent: Tuesday, January 19, 2010 2:30 AM
To: Marcel Holtmann
Cc: Dmitry Torokhov; linux-input; BlueZ development; Gunn, Brian; Ping; Jiri Kosina
Subject: Re: [PATCHes] Implement Bluetooth Wacom tablet's mode change in the kernel

On Mon, 2010-01-18 at 23:29 -0800, Marcel Holtmann wrote:
> Hi Bastien,
>
> > Here's a patch to do the Bluetooth Wacom tablet's mode setting in the
> > kernel. In the past, it was done in a patch in bluetootd.
> >
> > The first patch is probably completely wrong. Right now,
> > hid_output_raw_report is done on the intr socket, instead of the ctrl
> > socket. If it's correct to do it on the intr socket, we'd need to add
> > some API as a way to select the ctrl socket instead for use in that
> > driver.
>
> actually the interrupt should be incoming only. So moving the raw output
> to the control channel seems fine to. Any reason why it is on the
> interrupt channel in the first place?

The patch was written by Jiri and tested by Brian. Not sure what sort of
device Brian tested this with...
