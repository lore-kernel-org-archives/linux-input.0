From: Rakesh Iyer <riyer@nvidia.com>
Subject: RE: [PATCH v3] input: tegra-kbc: Add Function keymap.
Date: Wed, 16 Feb 2011 12:12:54 -0800
Message-ID: <1FC56210173BB445BD77F608D6FB8D03165A0080E0@HQMAIL03.nvidia.com>
References: <1297280680-7555-1-git-send-email-riyer@nvidia.com>
 <20110216081208.GA12787@core.coreip.homeip.net>
 <1FC56210173BB445BD77F608D6FB8D03165A0080DF@HQMAIL03.nvidia.com>
 <20110216200349.GA31387@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:9003 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731Ab1BPUM6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Feb 2011 15:12:58 -0500
In-Reply-To: <20110216200349.GA31387@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "olofj@chromium.org" <olofj@chromium.org>, Andrew Chew <AChew@nvidia.com>

I agree with that, and that was my original plan.

But I saw matrix_keypad.h has the MATRIX_MAX_ROWS defined at 16, and decided to
accommodate for it.

Regards
Rakesh

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Wednesday, February 16, 2011 12:04 PM
> To: Rakesh Iyer
> Cc: linux-input@vger.kernel.org; olofj@chromium.org; Andrew Chew
> Subject: Re: [PATCH v3] input: tegra-kbc: Add Function keymap.
> 
> On Wed, Feb 16, 2011 at 11:51:18AM -0800, Rakesh Iyer wrote:
> > >
> > > On Wed, Feb 09, 2011 at 11:44:40AM -0800, riyer@nvidia.com wrote:
> > > > +
> > > > +	/*
> > > > +	 * If the platform uses Fn keymaps, translate keys on a Fn keypress.
> > > > +	 * Function keycodes are KBC_MAX_COL apart from the plain keycodes.
> > > > +	 */
> > > > +	for (i = 0; (i < num_down) && fn_keypress; i++) {
> > > > +		scancodes[i] += KBC_MAX_COL;
> > >
> > > This should be KBC_MAX_KEY, isn't it?
> >
> > In my implementation (and in your change) each row contains both Plain and Fn translated
> keys.
> > So Cols 0-7 correspond to the plain keys and Cols 8-15 correspond to the Fn keys.
> > That's why we add KBC_MAX_COL to get to the Fn translation.
> >
> > This is using the logic from matrix_keypad.h
> >
> > keymap[MATRIX_SCAN_CODE(row, col, row_shift)] = code;
> >
> > and #define MATRIX_SCAN_CODE(row, col, row_shift)   (((row) << (row_shift)) +
> (col))
> >
> > I will address the latter part after this one is cleared up.
> >
> 
> Ah, yes. However I think we should change this so that Fn adds more
> rows, not columns. This way you can properly limit keymap size and would
> not accept/report to userspace (via EVIOCG/SKEYCODE) scancodes that are
> not valid for given configuration. Do you agree?
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
