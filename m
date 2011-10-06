From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] input: Fix USB autosuspend on bcm5974
Date: Fri, 7 Oct 2011 00:19:54 +0100
Message-ID: <20111006231954.GA32029@srcf.ucam.org>
References: <1317936997-20438-1-git-send-email-mjg@redhat.com>
 <20111006223835.GA30738@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:36341 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759161Ab1JFXT4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2011 19:19:56 -0400
Content-Disposition: inline
In-Reply-To: <20111006223835.GA30738@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, rydberg@euromail.se

You're completely right. I have absolutely no idea how I missed that - I 
checked and didn't find any other puts. I'll fix and resend.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
