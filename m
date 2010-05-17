From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH V2 3/3] input: Default to only using PNP for i8042
	probing on x86
Date: Mon, 17 May 2010 22:02:24 +0100
Message-ID: <20100517210224.GA1873@srcf.ucam.org>
References: <1274110716-12488-1-git-send-email-mjg@redhat.com> <1274110716-12488-3-git-send-email-mjg@redhat.com> <alpine.LFD.2.00.1005171352010.4195@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:57204 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677Ab0EQVCg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 May 2010 17:02:36 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005171352010.4195@i5.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org

On Mon, May 17, 2010 at 01:52:39PM -0700, Linus Torvalds wrote:

> This can't be right. That #endif is still there. How could this even 
> compile?
> 
> Tssk, tssk.

Crap. Sorry, I suck. I'll resend this one.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
