From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: [patch] hid: only dump report traffic with debug level 2
Date: Sat, 22 Mar 2008 23:59:05 +0200
Message-ID: <47E58129.7050607@gmail.com>
References: <47E4200D.9080904@gmail.com> <Pine.LNX.4.64.0803222248360.5541@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:49702 "EHLO
	pne-smtpout3-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753282AbYCVV7K (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Mar 2008 17:59:10 -0400
In-Reply-To: <Pine.LNX.4.64.0803222248360.5541@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Jiri Kosina wrote:
> On Fri, 21 Mar 2008, Anssi Hannula wrote:
> 
>> Currently using debug=1 with hid module prints out all sent and received 
>> reports to the kernel log, while in many cases we only want to see the 
>> report descriptors and hid-input mappings that are printed when a device 
>> is probed.
> 
> Hi Anssi,
> 
> thanks for your patch, I agree that making this more configurable makes 
> sense.
> 
> But I would propose staying backwards compatible, i.e. debug=1 does the 
> whole dump, debug=2 excludes the individual reports but still dumps the 
> report descriptor and mappings etc. What do you think?

Well, I think having higher debug level should mean more debugging
output and that this logic is more important than backwards
compatibility of a debug option, it is not like it is going to break any
software or so.

But I don't care too much about it, feel free to do it the other way as
well :)

-- 
Anssi Hannula
