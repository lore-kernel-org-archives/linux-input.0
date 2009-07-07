From: Andi Kleen <andi@firstfloor.org>
Subject: [regression] 2.6.30 leaking keys on console switch
Date: Tue, 07 Jul 2009 10:44:32 +0200
Message-ID: <87eiss7uhb.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:43270 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbZGGIoa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jul 2009 04:44:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: rjw@sisk.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jkosina@suse.cz


One new issue I see in 2.6.30 (I think I saw it in some rc*s) too is
that console switch often leaks the Fkey of the console switch into the 
target console.

The symptome is that e.g. firefox if it was active and you're switching
into X displays its help screen (F1 = help). It happens on non X 
consoles too, but of course the symptoms are different here.

That's a regression against 2.6.29; I don't remember it in .29

Haven't investigated code.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
