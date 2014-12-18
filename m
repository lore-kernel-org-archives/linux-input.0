From: Dudley Du <dudl@cypress.com>
Subject: RE: [PATCH v16 01/12] input: cyapa: re-design driver to support
Date: Thu, 18 Dec 2014 01:45:24 +0000
Message-ID: <BN1PR06MB0706683F43D01A545F0EB21D16A0@BN1PR06MB070.namprd06.prod.outlook.com>
References: <BAY407-EAS4239EB7A931AAE7C4C747F3BD6D0@phx.gbl>
 <20141217101434.GA2155@newt.localdomain>
 <BN1PR06MB0702F0782A3A6B975EDA156D16D0@BN1PR06MB070.namprd06.prod.outlook.com>
 <20141217121719.GA7134@hudson.localdomain>
 <BAY176-W39AFAEB1037657BD495F30BD6D0@phx.gbl>
 <20141217150443.GB3895@newt.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2on0135.outbound.protection.outlook.com ([207.46.100.135]:64544
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751252AbaLRBp2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Dec 2014 20:45:28 -0500
In-Reply-To: <20141217150443.GB3895@newt.localdomain>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>, DuDudley <dudlx@outlook.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "rydberg@euromail.se" <rydberg@euromail.se>, "bleung@google.com" <bleung@google.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Solda <dso@cypress.com>



> -----Original Message-----
> From: Jeremiah Mahler [mailto:jmmahler@gmail.com]
> Sent: 2014?12?17? 23:05
> To: DuDudley
> Cc: Dudley Du; dmitry.torokhov@gmail.com; rydberg@euromail.se;
> bleung@google.com; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org;
> David Solda
> Subject: Re: [PATCH v16 01/12] input: cyapa: re-design driver to support
>
> Dudley,
>
> On Wed, Dec 17, 2014 at 01:53:38PM +0000, DuDudley wrote:
> >
> >
> > > Date: Wed, 17 Dec 2014 04:17:19 -0800
> > > From: jmmahler@gmail.com
> > > To: dudl@cypress.com
> > > CC: dudlx@outlook.com; dmitry.torokhov@gmail.com; rydberg@euromail.se;
> bleung@google.com; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org;
> dso@cypress.com
> > > Subject: Re: [PATCH v16 01/12] input: cyapa: re-design driver to support
> > >
> > > Dudley,
> > >
> > > On Wed, Dec 17, 2014 at 10:55:00AM +0000, Dudley Du wrote:
> > > > Jeremiah,
> > > >
> > > > Thanks for the feedback.
> > > > Yes, the our net proxy may broken this. It needs sometime to fix this.
> > > >
> > > > Attched are the patch files, could you try to apply these patch files firstly.
> > > >
> > > > Thanks,
> > > > Dudley
> > > >
> > >
> > > Attachments are difficult to comment on [1].  Just re-send the series
> > > when you can format them properly.
> > Sorry, I cannot fix it today. I need IT help to try to fix this tommorrow.
>
> That is fine.  What do you normally use to send your patches?  I use
> git send-email after creating a series with git format-patch and it has
> always worked well.

Yes, I also use git format-path and git send-email to create and send patches.
This working fine during several months, but stop working on this Wednesday when I do same as before. :(
The connect to smtp.gmail.com is blocked (connection refused always).
I will talk with IT to find out the problem.

>
> > >
> > >   [1]: linux/Documentation/SubmittingPatches
> > >
> > > [...]
> > >
> > > --
> > > - Jeremiah Mahler
> >
>
> --
> - Jeremiah Mahler

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
