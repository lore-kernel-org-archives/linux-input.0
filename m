From: Dudley Du <dudl@cypress.com>
Subject: RE: [PATCH 1/2] input: cyapa: fix sparse warning issue of incorrect
 type in assiggment
Date: Thu, 22 Jan 2015 09:58:42 +0000
Message-ID: <BN1PR06MB070D1B27364DA910A96F263D1490@BN1PR06MB070.namprd06.prod.outlook.com>
References: <1421909406-1240-1-git-send-email-dudl@cypress.com>
 <20150122093129.GA7133@hudson.localdomain> <20150122095453.GL6507@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bl2on0105.outbound.protection.outlook.com ([65.55.169.105]:37712
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751299AbbAVJ6o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Jan 2015 04:58:44 -0500
In-Reply-To: <20150122095453.GL6507@mwanda>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Jeremiah Mahler <jmmahler@gmail.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "rydberg@euromail.se" <rydberg@euromail.se>, "bleung@google.com" <bleung@google.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: 2015?1?22? 17:55
> To: Jeremiah Mahler; Dudley Du; dmitry.torokhov@gmail.com;
> rydberg@euromail.se; bleung@google.com; linux-input@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/2] input: cyapa: fix sparse warning issue of incorrect type in
> assiggment
>
> On Thu, Jan 22, 2015 at 01:31:29AM -0800, Jeremiah Mahler wrote:
> > I wasn't able to reproduce the sparse warning.  Was it for a specific
> > architecture?  Perhaps include a link to the email sent by the kbuild
> > test robot.
>
> You need to add a "CF=-D__CHECK_ENDIAN__" to turn these on.
>
> make C=2 CF=-D__CHECK_ENDIAN__

Yes, thanks.
I verified it locally, no issue found currently.

>
> http://lwn.net/Articles/205624/
>
> regards,
> dan carpenter


This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
