From: Bastien Nocera <hadess@hadess.net>
Subject: RE: [PATCHes] Implement Bluetooth Wacom tablet's mode change in
 the kernel
Date: Thu, 21 Jan 2010 01:35:59 +0000
Message-ID: <1264037759.1735.5008.camel@localhost.localdomain>
References: <1263833399.20565.2905.camel@localhost.localdomain>
	 <1263886149.5591.166.camel@localhost.localdomain>
	 <1263897015.20565.3988.camel@localhost.localdomain>
	 <FE57175CCE23E5419899C1B0CFA26FAD101B5E591A@EXMBXSD.dm.solekai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44584 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190Ab0AUBgP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jan 2010 20:36:15 -0500
In-Reply-To: <FE57175CCE23E5419899C1B0CFA26FAD101B5E591A@EXMBXSD.dm.solekai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Gunn, Brian" <bgunn@solekai.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, BlueZ development <linux-bluetooth@vger.kernel.org>, Ping <pinglinux@gmail.com>, Jiri Kosina <jikos@jikos.cz>

On Wed, 2010-01-20 at 17:08 -0800, Gunn, Brian wrote:
> Bastien Nocera wrote:
> > The patch was written by Jiri and tested by Brian. Not sure what sort of
> > device Brian tested this with...
> 
> I just tested this patch with my device and it does work.  I had to
> slightly alter the data I send (had to add 0xA2 to the front of it),
> but then it does work.
> 
> In my initial attempts, it does seem to work a little worse, but that
> is probably because of the device I'm using, which is still under
> development.

I sent a new version of the patch, which uses "HIDP_TRANS_SET_REPORT |
HIDP_DATA_RTYPE_FEATURE" for the first byte. Would that work?

