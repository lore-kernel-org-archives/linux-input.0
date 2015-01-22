From: Dudley Du <dudl@cypress.com>
Subject: RE: Input: cyapa - add gen5 trackpad device basic functions support
Date: Thu, 22 Jan 2015 08:44:03 +0000
Message-ID: <BN1PR06MB070473ED56F5AF92B35A82DD1490@BN1PR06MB070.namprd06.prod.outlook.com>
References: <20150121131949.GA4622@mwanda>
 <BN1PR06MB070851B957DB3FB5E40BDEFD1490@BN1PR06MB070.namprd06.prod.outlook.com>
 <20150122083100.GI6507@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2on0143.outbound.protection.outlook.com ([207.46.100.143]:20292
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752245AbbAVIoI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Jan 2015 03:44:08 -0500
In-Reply-To: <20150122083100.GI6507@mwanda>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: 2015?1?22? 16:31
> To: Dudley Du
> Cc: linux-input@vger.kernel.org
> Subject: Re: Input: cyapa - add gen5 trackpad device basic functions support
>
> On Thu, Jan 22, 2015 at 01:50:59AM +0000, Dudley Du wrote:
> > Hi Carpenter,
> >
> > Thanks for the information.
> > Could you indicate the tool and the command to generate this warning message?
> >
>
> This a Smatch warning.

Thank you for the information.

>
> > In the code,
> > 1) length = *gen5_pip->resp_len to get the expected response length,
> > 2) then cyapa_empty_pip_output_data() try to polling the response data with the
> expect length,
> > 3) at last, the length stored the real response length that it got in the polling
> function.
> > 4) if the real response length is not 0, then assign the real response to replace the
> excpeted response length.
>
> The error message is that we dereferenced gen5_pip->resp_len before we
> checked whether it was NULL.  I believe you are saying that
> cyapa_empty_pip_output_data() can modify "gen5_pip->resp_len" so we
> need to do the check for NULL.
>
> The problem is that I don't see where "gen5_pip->resp_len" gets changed
> inside cyapa_empty_pip_output_data().  Smatch is supposed to do cross
> function analysis and detect this but it doesn't see the modification
> either.  I have been working on this code recently in Smatch so Smatch
> may be buggy.
>
> Can you help me out here so I can improve the tools?
>
> According to Smatch "gen5_pip->resp_len" is set in two different
> functions.
>
> $ smdb where cyapa_gen5_cmd_states resp_len
> drivers/input/mouse/cyapa_gen5.c | cyapa_gen5_initialize          | (struct
> cyapa_gen5_cmd_states)->resp_len | 0
> drivers/input/mouse/cyapa_gen5.c | cyapa_i2c_pip_cmd_irq_sync     | (struct
> cyapa_gen5_cmd_states)->resp_len | 0,4096-2117777777777777777
>
> Also I looked at the call tree to see if cyapa_empty_pip_output_data
> calls cyapa_i2c_pip_cmd_irq_sync but it doesn't.
>
> $ smdb call_tree cyapa_i2c_pip_cmd_irq_sync | grep
> cyapa_empty_pip_output_data
>
> But, uh..  it's been years since I tried looking at the call_tree code
> so I have no idea if it works...

Thanks for the detail info.
I misunderstood the message previously, but finally, I got the issue.
So I submitted that patch 2 to fix this issue.
[PATCH 1/2] input: cyapa: fix sparse warning issue of incorrect type in assiggment
[PATCH 2/2] input: cyapa: fix variable dereferenced before check 'gen5_pip->resp_len' issue

I will try to learn and use the tool of Smatch, and update to you if any.
Thanks.

>
> regards,
> dan carpenter


This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
