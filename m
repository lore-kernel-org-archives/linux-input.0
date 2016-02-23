From: Dudley Du <dudl@cypress.com>
Subject: RE: [PATCH] input: cyapa: fix the report events may lost issue during
 set power mode
Date: Tue, 23 Feb 2016 01:43:16 +0000
Message-ID: <SN1PR0601MB19032820A81DB9C6726B09F9D1A40@SN1PR0601MB1903.namprd06.prod.outlook.com>
References: <1452750033-25692-1-git-send-email-dudl@cypress.com>
 <20160115053410.GA21967@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2on0123.outbound.protection.outlook.com ([65.55.169.123]:41549
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754795AbcBWCRA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Feb 2016 21:17:00 -0500
In-Reply-To: <20160115053410.GA21967@hudson.localdomain>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "eugenesan@gmail.com" <eugenesan@gmail.com>, "bleung@google.com" <bleung@google.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Dmitry,

Is there any update on this patch?

Thanks,
Dudley

> -----Original Message-----
> From: Jeremiah Mahler [mailto:jmmahler@gmail.com]
> Sent: 2016?1?15? 13:34
> To: Dudley Du
> Cc: dmitry.torokhov@gmail.com; eugenesan@gmail.com; bleung@google.com;
> linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] input: cyapa: fix the report events may lost issue during set
> power mode
>
> Dudley,
>
> On Thu, Jan 14, 2016 at 01:40:33PM +0800, Dudley Du wrote:
> > When driver set the power mode to change the scan rate in auto suspend
> > process, some events may be lost because
> > 1) for gen3 trackpad, the driver must msleep() some time to avoid issuing
> > next command encounter error;
> > 2) for gen5 and later trackpads, the queue dumping function will simply
> > ignore the events when waiting for the set power mode command response.
> > so, when auto resume process will be executed, the set power mode command
> > will be issued can cause the events may be lost.
> > The solution is kept polling and report those valid events when the set
> > power mode command is in progress.
> >
> > TEST=test on Acer C720P Chromebook
> >
> > Signed-off-by: Dudley Du <dudl@cypress.com>
> > ---
> >  drivers/input/mouse/cyapa.c      |  22 ++++----
> >  drivers/input/mouse/cyapa.h      |  14 ++++-
> >  drivers/input/mouse/cyapa_gen3.c | 108
> ++++++++++++++++++++++++++++-----------
> >  drivers/input/mouse/cyapa_gen5.c |  99
> +++++++++++++++++++++++++++++------
> >  drivers/input/mouse/cyapa_gen6.c |   4 +-
> >  5 files changed, 188 insertions(+), 59 deletions(-)
> >
> [...]
>
> I tested this on my Acer C720 and it appears to work properly.
>
> Tested-by: Jeremiah Mahler <jmmahler@gmail.com>
>
> --
> - Jeremiah Mahler

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
