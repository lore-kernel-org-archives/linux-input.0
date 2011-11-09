From: JJ Ding <jj_ding@emc.com.tw>
Subject: Re: [PATCH] Input: elantech: adjust hw_version detection logic
Date: Wed, 09 Nov 2011 09:55:01 +0800
Message-ID: <87zkg6vz4a.fsf@emc.com.tw>
References: <1320754099-2669-1-git-send-email-jj_ding@emc.com.tw> <1998016.KAbb3SKMtM@ax5200p>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:64117 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab1KIB5X (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Nov 2011 20:57:23 -0500
In-Reply-To: <1998016.KAbb3SKMtM@ax5200p>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marc Dietrich <marvin24@gmx.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?utf-8?Q?=C3=89ric?= Piel <E.A.B.Piel@tudelft.nl>, linux-input@vger.kernel.org

On Tue, 08 Nov 2011 18:55:37 +0100, Marc Dietrich <marvin24@gmx.de> wrote:
> hi Jj,
> 
> On Tuesday 08 November 2011 20:08:19 JJ Ding wrote:
> > This patch fixes some v3 hardware (fw_version: 0x150500) wrongly detected
> > as v2 hardware.
> > 
> > Reported-by: Marc Dietrich <marvin24@gmx.de>
> > Signed-off-by: JJ Ding <jj_ding@emc.com.tw>
> > ---
> > Hi list,
> > 
> > This is patched against v3.2-rc1.
> > 
> > Marc, could you please test this again? Thanks a lot.
> 
> patch works fine here. You may add:
> 
> 	Tested-By: Marc Dietrich <marvin24@gmx.de>
> 

Thank you for the testing ;-)

> Btw, are there any known issues with suspend/resume? The touchpad doesn't seem 
> to wakeup again after resume, but that's propably a problem of our kbd 
> controller driver. Just in case there's something known...
> 
> Thanks Marc
> 
I am not aware of any issue with suspend/resume, AFAICT. But we really
test mostly on a standard PC hardware, I think I cannot say there's
none, since your board is arm-based.

Thanks,
jj
