From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Tue, 11 Oct 2011 06:10:12 +0200
Message-ID: <201110110610.12999.oliver@neukum.org>
References: <1318261630-24044-1-git-send-email-mjg@redhat.com> <20111010224431.GA2377@polaris.bitmath.org> <20111011001102.GA28157@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:50126 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab1JKEJy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Oct 2011 00:09:54 -0400
In-Reply-To: <20111011001102.GA28157@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, dtor@mail.ru

Am Dienstag, 11. Oktober 2011, 02:11:03 schrieb Matthew Garrett:

> Ah, right, sorry - I wasn't trying to use the device after it had been 
> closed. In an ideal world we'd really want to be able to indicate that 
> we don't want a remote wakeup in that situation. Otherwise, the patch 
> looks good. Thank you!

It looks like we had exactly that capability until
48826626263d4a61d06fd8c5805da31f925aefa0
removed it.

	Regards
		Oliver
