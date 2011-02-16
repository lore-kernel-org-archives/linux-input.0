From: Rakesh Iyer <riyer@nvidia.com>
Subject: RE: [PATCH v3] input: tegra-kbc: Add Function keymap.
Date: Wed, 16 Feb 2011 15:55:17 -0800
Message-ID: <1FC56210173BB445BD77F608D6FB8D03165A0080E2@HQMAIL03.nvidia.com>
References: <1297280680-7555-1-git-send-email-riyer@nvidia.com>
 <20110216081208.GA12787@core.coreip.homeip.net>
 <1FC56210173BB445BD77F608D6FB8D03165A0080DF@HQMAIL03.nvidia.com>
 <20110216200349.GA31387@core.coreip.homeip.net>
 <1FC56210173BB445BD77F608D6FB8D03165A0080E0@HQMAIL03.nvidia.com>
 <20110216211940.GB31387@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:18371 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377Ab1BPXzV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Feb 2011 18:55:21 -0500
In-Reply-To: <20110216211940.GB31387@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "olofj@chromium.org" <olofj@chromium.org>, Andrew Chew <AChew@nvidia.com>

Alright I will redo my patch with Function keys defined in their separate rows.

Regards
Rakesh

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Wednesday, February 16, 2011 1:20 PM
> To: Rakesh Iyer
> Cc: linux-input@vger.kernel.org; olofj@chromium.org; Andrew Chew
> Subject: Re: [PATCH v3] input: tegra-kbc: Add Function keymap.
> 
> On Wed, Feb 16, 2011 at 12:12:54PM -0800, Rakesh Iyer wrote:
> > I agree with that, and that was my original plan.
> >
> > But I saw matrix_keypad.h has the MATRIX_MAX_ROWS defined at 16, and decided to
> > accommodate for it.
> >
> 
> Conveniently we just increased MATRIX_MAX_ROWS/COLS to 32 (see
> commit cfaea56741360311d0dabcb6603fa78c2e3de155 in mainline).
> 
> Thanks.
> 
> --
> Dmitry
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
