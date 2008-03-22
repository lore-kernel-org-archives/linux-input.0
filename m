From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch] hid: only dump report traffic with debug level 2
Date: Sat, 22 Mar 2008 23:31:26 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803222328590.5541@jikos.suse.cz>
References: <47E4200D.9080904@gmail.com> <Pine.LNX.4.64.0803222248360.5541@jikos.suse.cz>
 <47E58129.7050607@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:47815 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753222AbYCVWb2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Mar 2008 18:31:28 -0400
In-Reply-To: <47E58129.7050607@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-input@vger.kernel.org

On Sat, 22 Mar 2008, Anssi Hannula wrote:

> Well, I think having higher debug level should mean more debugging 
> output and that this logic is more important than backwards 
> compatibility of a debug option, it is not like it is going to break any 
> software or so.

I agee. On the other hand, I am currently quite often telling people who 
(for example) complain about non-functioning keys on some expotic keyboard 
"just modprobe the hid module with debug=1, press the non-functioning key, 
and send me dmesg output". This would now be different depending on the 
kernel version they use, which I don't like too much.

Thanks,

-- 
Jiri Kosina
SUSE Labs
