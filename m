From: Dudley Du <dudl@cypress.com>
Subject: RE: [PATCH v16 00/12] input: cyapa: instruction of cyapa patches
Date: Mon, 22 Dec 2014 02:56:11 +0000
Message-ID: <BN1PR06MB070D9DC501F22048B9EAB4ED1560@BN1PR06MB070.namprd06.prod.outlook.com>
References: <1418896856-15766-1-git-send-email-dudl@cypress.com>
 <20141220071533.GA1139@newt.localdomain> <20141220073154.GB4637@dtor-ws>
 <BN1PR06MB0701C428956C2E7F7A1DD76D1560@BN1PR06MB070.namprd06.prod.outlook.com>
 <20141222023959.GA30082@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2on0148.outbound.protection.outlook.com ([207.46.100.148]:44768
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753733AbaLVC4O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Dec 2014 21:56:14 -0500
In-Reply-To: <20141222023959.GA30082@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jeremiah Mahler <jmmahler@gmail.com>, "rydberg@euromail.se" <rydberg@euromail.se>, "bleung@google.com" <bleung@google.com>, David Solda <dso@cypress.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Got it.
Thanks, Dmitry.

Dudley

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: 2014?12?22? 10:40
> To: Dudley Du
> Cc: Jeremiah Mahler; rydberg@euromail.se; bleung@google.com; David Solda;
> linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v16 00/12] input: cyapa: instruction of cyapa patches
>
> Hi Dudley,
>
> On Mon, Dec 22, 2014 at 02:09:36AM +0000, Dudley Du wrote:
> > Thanks, Dmitry and Jeremiah,
> >
> > I reproduced this issue in my side when putting fingers on trackpad when system
> booting up.
> > It only happened on gen3 trackpad device.
> > The root cause is, for gen3 TP, the cyapa->ops->sort_empty_output_data is not
> set, so when cyapa->input is not set,
> > the interrupt process should be passed, but since the logica error, it's not, so this
> issue happen.
> >
> > The fix code should be as below.
> > I will correct it and resubmited the patches.
>
> Please hold off resubmitting the patches just yet, let me go over the
> last version you posted.
>
> Thanks!
>
>
> --
> Dmitry

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
