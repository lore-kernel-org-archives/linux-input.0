From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v4] Input: matrix-keypad - Add device tree support
Date: Wed, 07 Nov 2012 09:57:10 -0700
Message-ID: <509A92E6.8020905@wwwdotorg.org>
References: <1352280725-452-1-git-send-email-anilkumar@ti.com> <331ABD5ECB02734CA317220B2BBEABC13EA6620F@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:38758 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455Ab2KGQ5P (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Nov 2012 11:57:15 -0500
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA6620F@DBDE01.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "dgdunix@gmail.com" <dgdunix@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On 11/07/2012 02:38 AM, AnilKumar, Chimata wrote:
> On Wed, Nov 07, 2012 at 15:02:05, AnilKumar, Chimata wrote:
>> Add device tree support to matrix keypad driver and usage details
>> are added to device tree documentation. Driver was tested on AM335x
>> EVM.
> 
> +Stephen
> 
> ACK from the reviewers (Rob Herring and Stephen Warren) of earlier
> versions will help to get this in.

I thought I already asked a question about the clustered IRQ properties,
which don't make sense.
