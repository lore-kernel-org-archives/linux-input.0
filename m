From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/7 v3] HID: magicmouse: don't allow hidinput to initialize
 the device
Date: Thu, 02 Sep 2010 11:28:06 +0200
Message-ID: <4C7F6E26.2030301@gmail.com>
References: <1283306184-28833-1-git-send-email-chase.douglas@canonical.com>	<1283306184-28833-2-git-send-email-chase.douglas@canonical.com>	<4C7E94F6.9050806@gmail.com> <AANLkTi=z5s8mbjG54930Lxj-O9Of2fXHE6kDJhijyOb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34683 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab0IBJ2K (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Sep 2010 05:28:10 -0400
In-Reply-To: <AANLkTi=z5s8mbjG54930Lxj-O9Of2fXHE6kDJhijyOb7@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
Cc: Chase Douglas <chase.douglas@canonical.com>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>, Tejun Heo <tj@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/02/2010 01:57 AM, Michael Poole wrote:
> Jiri Slaby wrote:
>> This looks weird. Is there any past discussion about why you cannot use
>> hidinput and you have to do all the input bits yourself while cheating
>> this very weird way?
> 
> The Magic Mouse and Magic Trackpad do not publish HID descriptors for
> the multitouch reports.  Given the variable-length report packets --
> and especially the Magic Trackpad's new, mutant DOUBLE_REPORT_ID
> packets -- it would be non-trivial to write accurate descriptors that
> the HID core can use.  (Someone wrote a patch to try that a few months
> ago.  It ended up adding significantly more lines to hid-magicmouse.c
> than it removed, and it was not obvious to me that it got the Report
> Count fields correct.)

Ok, makes sense. The proper solution is to call a driver hook in
hidinput_connect to do the mapping instead of report parsing done there,
right? (And not setting [gs]etkeycode in that case.)

Then the part of magicmouse_setup_input starting at the first __set_bit
will be exactly the hook.

Otherwise this hack looks like a hard cross-layer breakage.

/me wonders how HID issuers are creative in breaking standards.

regards,
-- 
js
