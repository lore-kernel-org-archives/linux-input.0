From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 1/3] hid-hyperv: Do not use hid_parse_report() directly
Date: Mon, 30 Apr 2012 20:15:45 +0000
Message-ID: <426367E2313C2449837CD2DE46E7EAF92E072B@SN2PRD0310MB382.namprd03.prod.outlook.com>
References: <1335097300-11881-1-git-send-email-rydberg@euromail.se>
 <1335097300-11881-2-git-send-email-rydberg@euromail.se>
 <alpine.LNX.2.00.1204271052330.1856@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:26331
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757044Ab2D3UQx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Apr 2012 16:16:53 -0400
In-Reply-To: <alpine.LNX.2.00.1204271052330.1856@pobox.suse.cz>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



> -----Original Message-----
> From: Jiri Kosina [mailto:jkosina@suse.cz]
> Sent: Friday, April 27, 2012 4:53 AM
> To: Henrik Rydberg
> Cc: Dmitry Torokhov; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org;
> KY Srinivasan
> Subject: Re: [PATCH 1/3] hid-hyperv: Do not use hid_parse_report() directly
> 
> On Sun, 22 Apr 2012, Henrik Rydberg wrote:
> 
> > Upcoming changes will split the semantics of hid_parse_report()
> > and hid_parse(), so make sure drivers use hid_parse() in probe().
> >
> > Compiled, not tested.
> >
> > Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> > Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> 
> KY, could I please get your Ack/Tested-by for this patch?

Done.

Tested-and-acked-by:  K. Y. Srinivasan <kys@microsoft.com>

K. Y
 



