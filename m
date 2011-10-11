From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Tue, 11 Oct 2011 13:09:21 +0200
Message-ID: <201110111309.21132.oliver@neukum.org>
References: <1318261630-24044-1-git-send-email-mjg@redhat.com> <201110110610.12999.oliver@neukum.org> <20111011110421.GA21008@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:40196 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab1JKLJD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Oct 2011 07:09:03 -0400
In-Reply-To: <20111011110421.GA21008@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Alan Stern <stern@rowland.harvard.edu>, linux-input@vger.kernel.org, dtor@mail.ru

Am Dienstag, 11. Oktober 2011, 13:04:21 schrieb Henrik Rydberg:
> On Tue, Oct 11, 2011 at 06:10:12AM +0200, Oliver Neukum wrote:
> > Am Dienstag, 11. Oktober 2011, 02:11:03 schrieb Matthew Garrett:
> > 
> > > Ah, right, sorry - I wasn't trying to use the device after it had been 
> > > closed. In an ideal world we'd really want to be able to indicate that 
> > > we don't want a remote wakeup in that situation. Otherwise, the patch 
> > > looks good. Thank you!
> > 
> > It looks like we had exactly that capability until
> > 48826626263d4a61d06fd8c5805da31f925aefa0
> > removed it.
> 
> Hm. Throwing in another related question below.
> 
> Problem: the hid keyboard driver refuses to suspend while a key is
> pressed, which is fine per se, but there is no indication presented to the power layer,
> resulting in a failed suspend and (due to complex reasons it seems) disabled autosuspend.

That is a bug. Autosuspend at a later date should happen.

> Question:  If the hid interrupt handler were to actually prevent
> suspend during keypress, what would be the natural way to do it?

Firstly we must prevent autosuspension when a key is pressed
because most keyboards do not generate a wakeup upon key release
which is then lost.

Secondly a key pres triggers the mark_busy. We could do an async
get on every key press and an async put on every key release. But you
cannot beat the principal race here because the operation happen
in interrupt and must therefore be async. You must be prepared for
the window to be hit and return an error code.

	Regards
		Oliver
