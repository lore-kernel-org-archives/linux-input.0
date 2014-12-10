From: Dudley Du <dudl@cypress.com>
Subject: RE: [PATCH v13 00/12] input: cyapa: instruction of cyapa patches
Date: Wed, 10 Dec 2014 05:10:04 +0000
Message-ID: <BN1PR06MB0705BA630BFB68AB0F53992D1620@BN1PR06MB070.namprd06.prod.outlook.com>
References: <1418116304-11392-1-git-send-email-dudley.dulixin@gmail.com>
 <20141210041018.GD4173@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn1bn0101.outbound.protection.outlook.com ([157.56.110.101]:5392
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750708AbaLJFKI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Dec 2014 00:10:08 -0500
In-Reply-To: <20141210041018.GD4173@hudson.localdomain>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "rydberg@euromail.se" <rydberg@euromail.se>, "bleung@google.com" <bleung@google.com>, David Solda <dso@cypress.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Jeremiah,

Thank you very much for your review, comments and test.
I will correct the spelling issues in next submit version.

Thanks,
Dudley

> -----Original Message-----
> From: linux-input-owner@vger.kernel.org
> [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Jeremiah Mahler
> Sent: 2014?12?10? 12:10
> To: Dudley Du
> Cc: dmitry.torokhov@gmail.com; rydberg@euromail.se; bleung@google.com;
> David Solda; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v13 00/12] input: cyapa: instruction of cyapa patches
>
> Dudley, all,
>
> On Tue, Dec 09, 2014 at 05:11:32PM +0800, Dudley Du wrote:
> > V13 patches have below updates, details of other updates see history list:
> > 1) Remove all debugfs interface, including read_fw and raw_data interfaces.
> > 2) This patches are made based linux next-20141208.
> >
> [...]
>
> I tested this patch set on an Acer C720 and other than the minor
> problems I pointed out in other emails (CONFIG_CYAPA, spelling) it seems
> to work fine and there are no obvious problems.
>
> Reviewed-by: Jeremiah Mahler <jmmahler@gmail.com>
>
> --
> - Jeremiah Mahler
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
