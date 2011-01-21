From: "Kevin McNeely" <Kevin.McNeely@cypress.com>
Subject: RE: [v4 3/3] 3/3 spi: Cypress TTSP G3 SPI Device Driver
Date: Fri, 21 Jan 2011 14:14:27 -0800
Message-ID: <FB9C2CB29A07AB45B575A4E8D2AABC0901518928@labamba.mis.cypress.com>
References: <kev@cypress.com> <1294188847-24728-3-git-send-email-kev@cypress.com> <20110112184550.GB9168@core.coreip.homeip.net> <FB9C2CB29A07AB45B575A4E8D2AABC0901490D54@labamba.mis.cypress.com> <4D38182B.60803@codeaurora.org> <20110121092739.GB24214@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Trilok Soni <tsoni@codeaurora.org>
Cc: David Brown <davidb@codeaurora.org>, Samuel Ortiz <sameo@linux.intel.com>, Eric Miao <eric.y.miao@gmail.com>, Mike Frysinger <vapier@gentoo.org>, Henrik Rydberg <rydberg@euromail.se>, Alan Cox <alan@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

Thank you for the update.  I will begin work on the protocol B and
cleanup according to your findings.  I appreciate your comments.

Best regards,
Kevin


> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Friday, January 21, 2011 1:28 AM
> To: Trilok Soni
> Cc: Kevin McNeely; David Brown; Samuel Ortiz; Eric Miao; Mike
> Frysinger; Henrik Rydberg; Alan Cox; linux-input@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [v4 3/3] 3/3 spi: Cypress TTSP G3 SPI Device Driver
> 
> On Thu, Jan 20, 2011 at 04:40:35PM +0530, Trilok Soni wrote:
> > Hi Dmitry,
> >
> > On 1/13/2011 12:32 AM, Kevin McNeely wrote:
> > > Hi Dmitry,
> > >
> > > Thank you for your review.
> > >
> > > Will the existing patches get into the current merge?
> > >
> > > Can I revisit this discussion as part of our plan to provide a
> Protocol
> > > B driver?
> > >
> > > Thanks and best regards,
> > > Kevin
> > >
> >
> > Any updates on Kevin's question here?
> >
> 
> Hi Trilok, Kevin,
> 
> Ah, sorry, was not feeling well last week and lost track of this
> driver.
> 
> No, I am sorry, bit the driver is not quite ready to be merged. Aside
> of
> SPI abort/timeout issues we also have cyttsp_close() implementation
> busted (once you close device you lose irq) and bunch of other things
I
> need to look over. I also have concern about having protocol A now and
> upgrading to protocol B: clients that only understand protocol A will
> get broken at A->B transition. I think we should consider implementing
> B
> right away for mainline (no, I do not want A/B config options).
> 
> Sorry for being slow with doing full review...
> 
> Thanks.
> 
> --
> Dmitry

---------------------------------------------------------------
This message and any attachments may contain Cypress (or its
subsidiaries) confidential information. If it has been received
in error, please advise the sender and immediately delete this
message.
---------------------------------------------------------------
