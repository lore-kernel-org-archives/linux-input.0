From: Dudley Du <dudl@cypress.com>
Subject: RE: [PATCH v15 00/12] input: cyapa: instruction of cyapa patches
Date: Tue, 16 Dec 2014 01:28:24 +0000
Message-ID: <BN1PR06MB07005FC71EF18F10F595E83D16C0@BN1PR06MB070.namprd06.prod.outlook.com>
References: <1418624603-19054-1-git-send-email-dudley.dulixin@gmail.com>
 <20141215141023.GB918@newt.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2on0111.outbound.protection.outlook.com ([207.46.100.111]:51199
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750813AbaLPB22 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Dec 2014 20:28:28 -0500
In-Reply-To: <20141215141023.GB918@newt.localdomain>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "rydberg@euromail.se" <rydberg@euromail.se>, "bleung@google.com" <bleung@google.com>, David Solda <dso@cypress.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Jeremiah,

No problem. :-)
Thank you very much for your help and so much time on review these patches.
I will fix this issue as soon as possible.

Thanks,
Dudley

> -----Original Message-----
> From: linux-input-owner@vger.kernel.org
> [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Jeremiah Mahler
> Sent: 2014?12?15? 22:10
> To: Dudley Du
> Cc: dmitry.torokhov@gmail.com; rydberg@euromail.se; bleung@google.com;
> David Solda; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v15 00/12] input: cyapa: instruction of cyapa patches
>
> Dudley,
>
> On Mon, Dec 15, 2014 at 02:23:11PM +0800, Dudley Du wrote:
> > V15 patches have below updates, details of other updates see history list:
> > 1) Fix all warning errors of sparse tool when running with "make C=1".
> > 2) Change variable name "unique_str" to "product_id" for clearer meanings.
> >
> >
> > This patch series is aimed to re-design the cyapa driver to support
> > old gen3 trackpad devices and new gen5 trackpad devices in one
> [...]
>
> The patch set still tests fine on my Acer C720.
>
> I went through all the patches and found lots of minor things to fix
> as you would expect from this large amount of code.
>
> I hope you don't get discouraged :-)
>
> --
> - Jeremiah Mahler
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
