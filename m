From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: [patch] hid: only dump report traffic with debug level 2
Date: Sun, 23 Mar 2008 00:33:16 +0200
Message-ID: <47E5892C.9010708@gmail.com>
References: <47E4200D.9080904@gmail.com> <Pine.LNX.4.64.0803222248360.5541@jikos.suse.cz> <47E58129.7050607@gmail.com> <Pine.LNX.4.64.0803222328590.5541@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:45513 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753282AbYCVWdT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Mar 2008 18:33:19 -0400
In-Reply-To: <Pine.LNX.4.64.0803222328590.5541@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Jiri Kosina wrote:
> On Sat, 22 Mar 2008, Anssi Hannula wrote:
> 
>> Well, I think having higher debug level should mean more debugging 
>> output and that this logic is more important than backwards 
>> compatibility of a debug option, it is not like it is going to break any 
>> software or so.
> 
> I agee. On the other hand, I am currently quite often telling people who 
> (for example) complain about non-functioning keys on some expotic keyboard 
> "just modprobe the hid module with debug=1, press the non-functioning key, 
> and send me dmesg output". This would now be different depending on the 
> kernel version they use, which I don't like too much.

Wouldn't debug=2 work with older kernel versions as well?

-- 
Anssi Hannula
