From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] input: Fix USB autosuspend on bcm5974
Date: Fri, 7 Oct 2011 20:20:39 +0100
Message-ID: <20111007192039.GA15786@srcf.ucam.org>
References: <20111006231954.GA32029@srcf.ucam.org>
 <201110070837.46926.oliver@neukum.org>
 <20111007123653.GA7325@srcf.ucam.org>
 <20111007162027.GA25307@core.coreip.homeip.net>
 <20111007162756.GA12136@srcf.ucam.org>
 <20111007170612.GA2215@polaris.bitmath.org>
 <20111007171324.GC12879@srcf.ucam.org>
 <20111007174214.GA2746@polaris.bitmath.org>
 <20111007173937.GB13468@srcf.ucam.org>
 <20111007181310.GA2762@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:48619 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281Ab1JGTUn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2011 15:20:43 -0400
Content-Disposition: inline
In-Reply-To: <20111007181310.GA2762@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Oliver Neukum <oliver@neukum.org>, linux-input@vger.kernel.org

Ah, I see the issue. This is handled by the core hid code in most cases, 
but it looks like the bcm code needs to do it itself. I'll fix up and 
repost next week.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
