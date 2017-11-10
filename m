From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/3] HID: cp2112: fix interface specification URL
Date: Fri, 10 Nov 2017 11:04:42 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1711101104200.32604@cbobk.fhfr.pm>
References: <1509621164-28830-1-git-send-email-sebastien.szymanski@armadeus.com> <nycvar.YFH.7.76.1711091245160.32604@cbobk.fhfr.pm> <8af16807-1e7e-2a80-82a7-1c7d685337b4@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51405 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750850AbdKJKEo (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Nov 2017 05:04:44 -0500
In-Reply-To: <8af16807-1e7e-2a80-82a7-1c7d685337b4@armadeus.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?S=E9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Julien Boibessot <julien.boibessot@armadeus.com>

On Fri, 10 Nov 2017, Sébastien Szymanski wrote:

> >> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> >> ---
> >>  drivers/hid/hid-cp2112.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> >> index 078026f..28e3c18 100644
> >> --- a/drivers/hid/hid-cp2112.c
> >> +++ b/drivers/hid/hid-cp2112.c
> >> @@ -21,7 +21,7 @@
> >>   * Data Sheet:
> >>   *   http://www.silabs.com/Support%20Documents/TechnicalDocs/CP2112.pdf
> >>   * Programming Interface Specification:
> >> - *   http://www.silabs.com/Support%20Documents/TechnicalDocs/AN495.pdf
> >> + *   https://www.silabs.com/documents/public/application-notes/an495-cp2112-interface-specification.pdf
> >>   */
> > 
> > I've applied patches 1 and 2 (with stable anotation) for now. Thanks,
> > 
> 
> Thanks, I've send a v2 of patch 3.
> 
> Regards,
> 
> P.S: I don't see patch 1 on your cgit, is it normal?

It's been applied only locally, today I've actually pushed it out. Thanks,

-- 
Jiri Kosina
SUSE Labs

