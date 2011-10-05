From: Jeff Mitchell <jeff@jefferai.org>
Subject: Re: [PATCH] This adds support for keyboards on mid-2011 MacBook Airs
Date: Wed, 05 Oct 2011 10:16:34 -0400
Message-ID: <4E8C66C2.6010503@jefferai.org>
References: <efc66984043a292faa31fee381945d18@jefferai.org> <20111005090735.GA6840@polaris.bitmath.org> <alpine.LNX.2.00.1110051103140.31654@pobox.suse.cz> <20111005094851.GA7261@polaris.bitmath.org> <alpine.LNX.2.00.1110051212320.31654@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from paravion.emailgoeshere.com ([46.4.199.70]:54278 "EHLO
	paravion.emailgoeshere.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753981Ab1JEOQj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 5 Oct 2011 10:16:39 -0400
In-Reply-To: <alpine.LNX.2.00.1110051212320.31654@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, jvdillon@gmail.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

On 10/05/2011 06:13 AM, Jiri Kosina wrote:
> On Wed, 5 Oct 2011, Henrik Rydberg wrote:
> 
>>> please check what is in my hid tree (included in linux-next as well) and 
>>> let me know whether there is anything that need to be applied on top of 
>>> that. I believe all the HID-related 4,1 and 4,2 bits are already in there.
>>
>> Finding the right tree is the big challenge these days. ;-)
> 
> Indeed :)
> 
> I will be moving my trees back to kernel.org as soon as it is possible.

Yep, sorry -- I honestly had no idea where to look for the "right" tree.

>> Looking at the twin.jikos.cz tree, the upstream and for-next branches 
>> have the same content with regard to these devices. Both 4,1 and 4,2 are 
>> included in the special driver and mouse ignore lists. Whether the 
>> keyboard handling is correct, I cannot say, but it looks consistent.
> 
> Perfect, thanks for verification.

Great.

To clear up an earlier point: AFAIK the new MBAs have the same keyboard
layout as normal MacBooks and hence uses the same table. An earlier
patch that was floating around added another table for the new MBAs but
if you looked at the mappings it was the exact same table as the normal
MacBook one.

--Jeff
