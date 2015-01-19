From: Dudley Du <dudl@cypress.com>
Subject: RE: [PATCH v18 00/12] input: cyapa: instruction of cyapa patches
Date: Mon, 19 Jan 2015 01:50:11 +0000
Message-ID: <BN1PR06MB0706B2EAB238F68A18F2DC4D14A0@BN1PR06MB070.namprd06.prod.outlook.com>
References: <1421390055-32760-1-git-send-email-dudl@cypress.com>
 <20150117104415.GA2083@hudson.localdomain>
 <0F1DD2F3-F620-4161-A406-43C8F56A1304@cypress.com>
 <20150117224620.GA2855@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2on0117.outbound.protection.outlook.com ([207.46.100.117]:55193
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751179AbbASBuQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Jan 2015 20:50:16 -0500
In-Reply-To: <20150117224620.GA2855@hudson.localdomain>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>, David Solda <dso@cypress.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "rydberg@euromail.se" <rydberg@euromail.se>, "bleung@google.com" <bleung@google.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Jeremiah,

Thanks.
If there is something that I could do, please let me know.

Thanks,
Dudley

> -----Original Message-----
> From: Jeremiah Mahler [mailto:jmmahler@gmail.com]
> Sent: 2015?1?18? 6:46
> To: David Solda
> Cc: Dudley Du; dmitry.torokhov@gmail.com; rydberg@euromail.se;
> bleung@google.com; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v18 00/12] input: cyapa: instruction of cyapa patches
>
> Dave,
>
> On Sat, Jan 17, 2015 at 06:00:29PM +0000, David Solda wrote:
> > Can we just reverse the prior change that caused the bug, or are you saying that
> the owner of the prior patch has to fix it?
> >
> > Dave
> >
>
> I tried to revert the patch but it didn't do so cleanly.
>
>   git revert ea2c67bb4aff
>
> So I just reverted back to next-20150112.
>
>   git reset --hard next-20150112
>
> I hope the owner of the prior patch responds promptly and fixes their
> bug.  But for the time being the cyapa patch series works when that
> other bug is avoided.
>
> If you have any suggestions, let me know.
>
> --
> - Jeremiah Mahler

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
