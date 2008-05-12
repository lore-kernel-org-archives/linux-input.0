From: Dag Bakke <dag@bakke.com>
Subject: Re: [PATCH] fix apple alu keyboard with numpad
Date: Mon, 12 May 2008 09:45:22 +0200
Message-ID: <4827F592.50500@bakke.com>
References: <4814612F.5030606@bakke.com> <20080506125406.dc047710.akpm@linux-foundation.org> <Pine.LNX.4.64.0805062244130.11363@jikos.suse.cz> <48233747.1030605@bakke.com> <Pine.LNX.4.64.0805120053520.11363@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail43.e.nsc.no ([193.213.115.43]:51653 "EHLO mail43.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755705AbYELHq1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 May 2008 03:46:27 -0400
In-Reply-To: <Pine.LNX.4.64.0805120053520.11363@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Diego 'Flameeyes' Petteno <flameeyes@gmail.com>

Jiri Kosina wrote, On 05/12/2008 12:54 AM:
> On Thu, 8 May 2008, Dag Bakke wrote:
> 
>>> Dag, I think Diego's patch should solve the issue you are seeing, right?
>>>
>>> [1]
>>> http://git.kernel.org/?p=linux/kernel/git/jikos/hid.git;a=commit;h=ffe6f7b799e33f51732520979f9c253a252b9d5e
>> I'll give it a shot and let you know.
> 
> Dag,
> 
> any update here, please?
> 
> Thanks,
> 

The patch works, thank you. Looks like all keys produce what I expect now.

Well. At least in X11 they do.
In the console, I get '~' instead of '=', when hitting the numpad '=' key.

This may have been no different with the patch I used previously.


Dag B
