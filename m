From: JJ Ding <jj_ding@emc.com.tw>
Subject: Re: [PATCH 2/2] Input: elantech - add resolution query support for v4 hardware
Date: Fri, 18 Nov 2011 18:19:02 +0800
Message-ID: <87ipmh91ih.fsf@emc.com.tw>
References: <1321524994-5513-1-git-send-email-jj_ding@emc.com.tw> <1321524994-5513-3-git-send-email-jj_ding@emc.com.tw> <CAGS+omCnQGyw3j=B7JxTwtsu0Vn+_iT1+y8tN72_zxo4Z09=bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:26927 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386Ab1KRKVK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Nov 2011 05:21:10 -0500
In-Reply-To: <CAGS+omCnQGyw3j=B7JxTwtsu0Vn+_iT1+y8tN72_zxo4Z09=bQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, =?utf-8?Q?=C3=89r?= =?utf-8?Q?ic?= Piel <E.A.B.Piel@tudelft.nl>, linux-input@vger.kernel.org

Hi Daniel,

Thanks for your suggestion, I'll send new patches to do this next week.

jj

On Fri, 18 Nov 2011 16:08:53 +0800, Daniel Kurtz <djkurtz@chromium.org> wrote:
> Hi JJ,
> 
> 
> You might consider allowing this command to fail, but just log a
> warning message.
> Then only do the input_abs_set_res() if x_res / y_res != 0.
> 
> Otherwise, for both patches in this set:
> 
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> 
