From: "Gunn, Brian" <bgunn@solekai.com>
Subject: RE: [PATCHes] Implement Bluetooth Wacom tablet's mode change in the
 kernel
Date: Thu, 28 Jan 2010 14:57:50 -0800
Message-ID: <FE57175CCE23E5419899C1B0CFA26FAD12CDF72C1E@EXMBXSD.dm.solekai.com>
References: <1263833399.20565.2905.camel@localhost.localdomain>
	 <1263886149.5591.166.camel@localhost.localdomain>
	 <1263897015.20565.3988.camel@localhost.localdomain>
	 <FE57175CCE23E5419899C1B0CFA26FAD101B5E591A@EXMBXSD.dm.solekai.com>
	 <1264037759.1735.5008.camel@localhost.localdomain>
	 <FE57175CCE23E5419899C1B0CFA26FAD12CDF72C0F@EXMBXSD.dm.solekai.com>
 <1264719198.29532.3149.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.solekai.com ([72.34.65.115]:57816 "EHLO mail.solekai.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744Ab0A1W5v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jan 2010 17:57:51 -0500
In-Reply-To: <1264719198.29532.3149.camel@localhost.localdomain>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, BlueZ development <linux-bluetooth@vger.kernel.org>, Ping <pinglinux@gmail.com>, Jiri Kosina <jikos@jikos.cz>

> > > I sent a new version of the patch, which uses "HIDP_TRANS_SET_REPORT |
> > > HIDP_DATA_RTYPE_FEATURE" for the first byte. Would that work?
> >
> > Actually for my application it doesn't.  I use HIDP_TRANS_DATA |
> HIDP_DATA_RTYPE_OUTPUT.
> >
> > Perhaps allowing the user the choice of what do to here is more flexible.
>
> Except that it would mean different code for USB and Bluetooth
> versions...

So do we need a method of setting which device reports we're sending before writing them?

Brian
