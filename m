From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: PATCH: Quirk (hid-saitek.c) for Saitek R.A.T.7 works with R.A.T.9
 too
Date: Mon, 3 Nov 2014 14:34:47 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1411031434070.19451@pobox.suse.cz>
References: <CAEP-KKshiXPfDhHPE7uatU70wfiOM-xMbFS2+6VxBbFM-LMfjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51024 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390AbaKCNet (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Nov 2014 08:34:49 -0500
In-Reply-To: <CAEP-KKshiXPfDhHPE7uatU70wfiOM-xMbFS2+6VxBbFM-LMfjw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville Aakko <ville.aakko@gmail.com>
Cc: linux-input@vger.kernel.org, hbrinkmann@braincalibration.de

On Sun, 2 Nov 2014, Ville Aakko wrote:

> Hi,
> 
> I have tested HID quirk for Saitek R.A.T.7 with my R.A.T. 9.
> 
> (original commit 37c492c8f6a99870551fe2964b2dfce5d9e87375; " HID: quirk for
> Saitek RAT7 and MMO7 mices' mode button ").
> 
> It works fine for me. Attached patch makes the nesessary changes to use the
> quirk on the R.A.T.9 too. No one else has tested this, but it seems quite
> trivial to me.
> 
> Cheers!
> 
> p.s. I have never submitted patches, I apologize if I have done something
> in a wrong way! Should I have added / updated the description in the
> comments?

Hi Ville,

patch looks good, the only thing it is missing is your Signed-off-by: line 
(please see Documentation/SubmittingPatches for explanation of what that 
means).

Please resend the patch with it included so that I could apply it.

Thanks,

-- 
Jiri Kosina
SUSE Labs
