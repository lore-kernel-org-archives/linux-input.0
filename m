From: "Li, Yan I" <yan.i.li@intel.com>
Subject: Re: [PATCH v2] Input: Bug 18122 - Support Lenovo S10-3t's 2-button
 ClickPad
Date: Wed, 1 Dec 2010 12:11:04 +0800
Message-ID: <20101201041102.GC3411@thyme.bj.intel.com>
References: <aefc1833eeede37ae6ea4a9ddeaa602eb7d31101.1290823698.git.yan.i.li@intel.com>
 <ddb890ce98e91c7422da64168b1624c1e62a02ee.1291101955.git.yan.i.li@intel.com>
 <20101130075026.GA15731@core.coreip.homeip.net>
 <20101130080759.GA17830@thyme.bj.intel.com>
 <BAY130-DS5A81442DAC5CC69983A4ADE250@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13152 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753789Ab0LAELI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Nov 2010 23:11:08 -0500
Content-Disposition: inline
In-Reply-To: <BAY130-DS5A81442DAC5CC69983A4ADE250@phx.gbl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tobyn Bertram <tobynbertram@hotmail.com>
Cc: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, 'Takashi Iwai' <tiwai@suse.de>, "Ding, Jian-feng" <jian-feng.ding@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "meego-kernel@lists.meego.com" <meego-kernel@lists.meego.com>

On Tue, Nov 30, 2010 at 11:48:12PM +0800, Tobyn Bertram wrote:
> I do not have a S10-3t.  I have a HP DV7t with a standard 1 button Clickpad.
> I am sorry for any confusion.

Thank you. This clarify the S10-3t touchpad mystery. So I think my v2
patch is valid.

> I think that 2 different Clickpads will need to be defined: 1 button
> Clickpads and 2 button Clickpads.  Maybe like this?
> 
> #define SYN_CAP_CLICKPAD1BTN(ex0c)		((ex0c) & 0x100000)
> #define SYN_CAP_CLICKPAD2BTN(ex0c)		((ex0c) & 0x000100)

Maybe, although we don't have any code that needs
SYN_CAP_CLICKPAD2BTN() so far, only 1-button clickpad needs special
handling, but it's good to have a more precise name.

-- 
Best regards,
Li, Yan

MeeGo Team, Opensource Technology Center, SSG, Intel
Office tel.: +86-10-82171695 (inet: 8-758-1695)
OpenPGP key: 5C6C31EF
IRC: yanli on network irc.freenode.net
