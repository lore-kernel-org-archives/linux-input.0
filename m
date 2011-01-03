From: "Kevin McNeely" <Kevin.McNeely@cypress.com>
Subject: RE: [v3 1/3] 1/3 Touchscreen: Cypress TTSP G3 MTDEV Core Driver
Date: Mon, 3 Jan 2011 12:50:10 -0800
Message-ID: <FB9C2CB29A07AB45B575A4E8D2AABC0901400055@labamba.mis.cypress.com>
References: <kev@cypress.com> <1293650268-1561-1-git-send-email-kev@cypress.com> <20101231115323.GA9709@polaris.bitmath.org> <FB9C2CB29A07AB45B575A4E8D2AABC09013FFF98@labamba.mis.cypress.com> <20110103184533.GA7035@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns2.cypress.com ([157.95.67.5]:32989 "EHLO ns2.cypress.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753924Ab1ACUw1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Jan 2011 15:52:27 -0500
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Brown <davidb@codeaurora.org>, Trilok Soni <tsoni@codeaurora.org>, Samuel Ortiz <sameo@linux.intel.com>, Eric Miao <eric.y.miao@gmail.com>, Mike Frysinger <vapier@gentoo.org>, Alan Cox <alan@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Henrik,

The market we are currently servicing requires Protocol A and we are
trying to meet those submission requirements in the near term.

With Protocol A available to the market, we will immediately work on a
Protocol B driver which will take advantage of track id information that
our device can provide.  For that effort, I would sincerely appreciate
information about testing (in-kernel tracking module?).

Thank you and best regards,
Kevin


> -----Original Message-----
> From: Henrik Rydberg [mailto:rydberg@euromail.se]
> Sent: Monday, January 03, 2011 10:46 AM
> To: Kevin McNeely
> Cc: Dmitry Torokhov; David Brown; Trilok Soni; Samuel Ortiz; Eric
Miao;
> Mike Frysinger; Alan Cox; linux-input@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [v3 1/3] 1/3 Touchscreen: Cypress TTSP G3 MTDEV Core
> Driver
> 
> > > If the in-kernel tracking module was in place, would you consider
> > > switching to the slots protocol?
> >
> > Hi Henrik, can you please clarify?  Should I remove MTDEV from the
> patch
> > title?
> 
> Let me start over - is there a way to reliably track contacts from the
> device? If yes, the question is whether you would consider switching
> to type B right away. If no, the question was whether you would
> consider a switch to type B if there was a in-kernel tracking module
> to use. I understand if there are other reasons to stay with type A, I
> am mostly curious.
> 
> And perhaps MTDEV is a bit misplaced in the title, unless it has
> something to do with the device.
> 
> Thanks,
> Henrik

---------------------------------------------------------------
This message and any attachments may contain Cypress (or its
subsidiaries) confidential information. If it has been received
in error, please advise the sender and immediately delete this
message.
---------------------------------------------------------------

