From: Jeff Mitchell <jeff@jefferai.org>
Subject: Re: [PATCH] This adds support for keyboards on mid-2011 MacBook Airs
Date: Thu, 06 Oct 2011 10:56:00 -0400
Message-ID: <4E8DC180.6060300@jefferai.org>
References: <efc66984043a292faa31fee381945d18@jefferai.org> <20111005090735.GA6840@polaris.bitmath.org> <alpine.LNX.2.00.1110051103140.31654@pobox.suse.cz> <20111005094851.GA7261@polaris.bitmath.org> <alpine.LNX.2.00.1110051212320.31654@pobox.suse.cz> <4E8C66C2.6010503@jefferai.org> <20111005172857.GA2195@polaris.bitmath.org> <alpine.LNX.2.00.1110051927340.31654@pobox.suse.cz> <20111005174347.GA28287@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from paravion.emailgoeshere.com ([46.4.199.70]:53186 "EHLO
	paravion.emailgoeshere.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754024Ab1JFO4F (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Oct 2011 10:56:05 -0400
In-Reply-To: <20111005174347.GA28287@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, jvdillon@gmail.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

On 10/05/2011 01:43 PM, Henrik Rydberg wrote:
> On Wed, Oct 05, 2011 at 07:28:31PM +0200, Jiri Kosina wrote:
>> On Wed, 5 Oct 2011, Henrik Rydberg wrote:
>>
>>>> To clear up an earlier point: AFAIK the new MBAs have the same keyboard
>>>> layout as normal MacBooks and hence uses the same table. An earlier
>>>> patch that was floating around added another table for the new MBAs but
>>>> if you looked at the mappings it was the exact same table as the normal
>>>> MacBook one.
>>>
>>> I see. The current tree actually contains two identical tables. Yikes.
>>> Using your patch would have prevented this, but it might be too late
>>> now. If so, the (untested) patch below might fix things up. Does it
>>> still work for you?

I believe that that patch should remove the duplication without any
problem, so everything should still work so long as the other bits are
still there (adding the wellspring6/6a entries to the other files).

Thanks,
Jeff
