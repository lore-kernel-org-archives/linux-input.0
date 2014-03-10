From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [PATCH 01/05] input synaptics-rmi4: Split F01 definitions out
 into header file for use by reflash.
Date: Mon, 10 Mar 2014 15:45:51 -0700
Message-ID: <20140310224550.GF18578@sonymobile.com>
References: <1394245795-17347-1-git-send-email-cheiny@synaptics.com>
 <20140310144658.GB18578@sonymobile.com>
 <531E3DA2.5090705@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:6295 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752935AbaCJWn6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Mar 2014 18:43:58 -0400
Content-Disposition: inline
In-Reply-To: <531E3DA2.5090705@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Mon, Mar 10, 2014 at 11:33:06PM +0100, Christopher Heiny wrote:
> On 03/10/2014 07:46 AM, Courtney Cavin wrote:
> > On Sat, Mar 08, 2014 at 03:29:51AM +0100, Christopher Heiny wrote:
> >> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> >> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >> Cc: Linux Walleij <linus.walleij@linaro.org>
> >> Cc: David Herrmann <dh.herrmann@gmail.com>
> >> Cc: Jiri Kosina <jkosina@suse.cz>
> >>
> >> ---
> >>
> >>   drivers/input/rmi4/rmi_f01.c |  96 ++-----------------------------------
> >>   drivers/input/rmi4/rmi_f01.h | 110 +++++++++++++++++++++++++++++++++++++++++++
> >>   2 files changed, 114 insertions(+), 92 deletions(-)
[...]
> >
> > I might be missing something, but these seem like the only defines used
> > in the flash code.  Why not keep these in the f01 driver, and export
> > a couple more functions, like rmi_f01_reset() and rmi_f01_set_sleep_mode() ?
> 
> It seems better to me to have the information defined in a single place, 
> rather than scattered hither and yon through the source files.

Uh.  Exactly?  This is why I'm suggesting that you keep this information
isolated in the driver to which is directly related.

Perhaps what you mean is that the regs/bits for the entire chip
functionality should be exposed in header files, so one can read/write
it from anywhere?  That seems backwards to the idea of separating these
'functions' out into drivers.

-Courtney
