From: Dudley Du <dudl@cypress.com>
Subject: RE: [PATCH v18 00/12] input: cyapa: instruction of cyapa patches
Date: Mon, 19 Jan 2015 01:54:21 +0000
Message-ID: <BN1PR06MB07059AE510C95932242461FD14A0@BN1PR06MB070.namprd06.prod.outlook.com>
References: <1421390055-32760-1-git-send-email-dudl@cypress.com>
 <20150117104415.GA2083@hudson.localdomain>
 <20150117113904.GA2133@hudson.localdomain> <20150118083521.GF15720@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn1on0115.outbound.protection.outlook.com ([157.56.110.115]:44173
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751179AbbASByY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Jan 2015 20:54:24 -0500
In-Reply-To: <20150118083521.GF15720@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jeremiah Mahler <jmmahler@gmail.com>, "rydberg@euromail.se" <rydberg@euromail.se>, "bleung@google.com" <bleung@google.com>, David Solda <dso@cypress.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Dmitry,

Thank you very much.

Thanks,
Dudley

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: 2015?1?18? 16:35
> To: Jeremiah Mahler; Dudley Du; rydberg@euromail.se; bleung@google.com;
> David Solda; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v18 00/12] input: cyapa: instruction of cyapa patches
>
> On Sat, Jan 17, 2015 at 03:39:04AM -0800, Jeremiah Mahler wrote:
> > Dudley,
> >
> > On Sat, Jan 17, 2015 at 02:44:15AM -0800, Jeremiah Mahler wrote:
> > > Dudley,
> > >
> > > Your patch series applies without issue but unfortunately I
> > > could not test them because I ran in to a bug created by someone
> > > elses patch (not yours) [1].
> > >
> > >   [1]: https://lkml.org/lkml/2015/1/17/24
> > >
> > > Once that issue gets resolved I would be happy to test your patch
> > > series.
> > >
> >
> > If I go back to linux-next 20150112 I can avoid the drm/i915 bug.
> > Then, with this patch series applied, everything works well.
> > Suspend/resume work, and the touchpad operates as expected.
> >
> > Tested-by: Jeremiah Mahler <jmmahler@gmail.com>
>
> OK, I believe that the code is in good shape now, so I queued all
> patches for 3.20 (currently in my 'next' branch and should show in
> linux-next soon). Any subsequent improvements to the code
> should be relative to this series.
>
> Jeremiah, thank you for testing the patches; Dudley thank you for your
> patience with the process.
>
> Thanks.
>
> --
> Dmitry

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
