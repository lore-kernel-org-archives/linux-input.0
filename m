From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Tue, 11 Oct 2011 13:04:21 +0200
Message-ID: <20111011110421.GA21008@polaris.bitmath.org>
References: <1318261630-24044-1-git-send-email-mjg@redhat.com>
 <20111010224431.GA2377@polaris.bitmath.org>
 <20111011001102.GA28157@srcf.ucam.org>
 <201110110610.12999.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:58237 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265Ab1JKK5d (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Oct 2011 06:57:33 -0400
Received: from iph1.telenor.se (iph1.telenor.se [195.54.127.132])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id 95E94EA8BB
	for <linux-input@vger.kernel.org>; Tue, 11 Oct 2011 12:57:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201110110610.12999.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>, linux-input@vger.kernel.org, dtor@mail.ru

On Tue, Oct 11, 2011 at 06:10:12AM +0200, Oliver Neukum wrote:
> Am Dienstag, 11. Oktober 2011, 02:11:03 schrieb Matthew Garrett:
> 
> > Ah, right, sorry - I wasn't trying to use the device after it had been 
> > closed. In an ideal world we'd really want to be able to indicate that 
> > we don't want a remote wakeup in that situation. Otherwise, the patch 
> > looks good. Thank you!
> 
> It looks like we had exactly that capability until
> 48826626263d4a61d06fd8c5805da31f925aefa0
> removed it.

Hm. Throwing in another related question below.

Problem: the hid keyboard driver refuses to suspend while a key is
pressed, which is fine per se, but there is no indication presented to the power layer,
resulting in a failed suspend and (due to complex reasons it seems) disabled autosuspend.

Question:  If the hid interrupt handler were to actually prevent
suspend during keypress, what would be the natural way to do it?

Henrik
