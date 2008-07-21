From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: Sleeping inside spinlock in force feedback input event code
Date: Mon, 21 Jul 2008 11:27:31 +0300
Message-ID: <48844873.8050705@gmail.com>
References: <4868e2410806151036o1a1652d8y8bf8432e3c6c0d06@mail.gmail.com> <4868e2410806151036r6d96a840v41b8ee745041db35@mail.gmail.com> <4868e2410806151105v3fec88a1qa439e2cc1423bc6a@mail.gmail.com> <48556723.2090204@gmail.com> <20080616143112.ZZRA012@mailhub.coreip.homeip.net> <485807F4.3010903@gmail.com> <20080617153423.ZZRA012@mailhub.coreip.homeip.net> <48581857.2080906@gmail.com> <4866E804.3000603@gmail.com> <4883474D.6080602@gmail.com> <20080721042112.GB14432@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:53174 "EHLO
	kirsi2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755010AbYGUI1c (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jul 2008 04:27:32 -0400
In-Reply-To: <20080721042112.GB14432@anvil.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, James Carthew <jcarthew@gmail.com>

Dmitry Torokhov wrote:
> On Sun, Jul 20, 2008 at 05:10:21PM +0300, Anssi Hannula wrote:
>> Ping? Please comment :) I'd really much like the hid-pidff driver
>> to not panic when used.
>>
>> For the record, here is a workqueue solution. It is much less
>> intrusive than the previous patch, but IMO less correct.
>>
> 
> I was deferring the final judgement to Jiri but I like the generic
> solution with com plete copy of the report best of all. I also wonder if
> we could pre-allocate the buffer for the report queue so we dont need to
> allocate it separately for each request.

It would take (biggest report of the hid device)*64 bytes for output
fifo and (biggest report of the hid device)*256 bytes for control fifo.
Maximum report size is 4096 bytes, though I guess most devices' biggest
report is far shorter than that.

I'll leave it up to you people. I'll be away (military service) for the
next 2 weeks, but after that I can do some quick testing on any
suggested patch on my next short vacation.

-- 
Anssi Hannula
