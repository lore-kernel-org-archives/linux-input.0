From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Input - synaptics: re-route tracksticks buttons on the
 Lenovo 2015 series
Date: Thu, 5 Feb 2015 17:49:24 -0800
Message-ID: <20150206014924.GB21288@dtor-ws>
References: <1423168683-12507-1-git-send-email-benjamin.tissoires@redhat.com>
 <54D419D3.5080807@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:44487 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984AbbBFBt3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Feb 2015 20:49:29 -0500
Content-Disposition: inline
In-Reply-To: <54D419D3.5080807@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Feb 05, 2015 at 05:33:07PM -0800, Andrew Duggan wrote:
> On 02/05/2015 12:38 PM, Benjamin Tissoires wrote:
> >Lenovos 2015 series has the physical tracktick buttons wired
> >through the touchpad. The kernel should re-route them through
> >the pass-through interface.
> >
> >Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >---
> >
> >Hi Dmitry,
> >
> >Well, in one of your replies regarding the Synaptics Lenovo 2015
> >series, you mentioned that you wouldn't mind having the trackstick
> >buttons re-routed through the trackstick (pass-through interface).
> >
> >I came out with this patch (checkpatch complains a lot about it but
> >today's setup is not that convenient), and I'd like to hear what you
> >think of it.
> >
> >If you agree to go this path, I'll remove the warnings from checkpatch
> >and do a proper submission.
> >
> >The patch is still not future proof (if Synaptics updates the board like
> >they did for the *40 series, we will need to fix this all over again),
> >so I might have a little bit more of work to do. Anyway, it works.
> 
> I discovered that there is a firmware query to determine if the
> touchpad has stick buttons which are wired to the touchpad and are
> reported as extended buttons. Query $01 bit 17 indicates that Query
> $10 exists. Then Query $10 bit 0 indicates indicates the extended
> buttons should be mapped to the guest stick buttons.
> 
> Additional information and some diagrams are in the pdf here:
> https://www.dropbox.com/s/vv1j4zsytgrw7mm/synaptics-tp-stick-buttons.pdf?dl=0

Awesome, thanks Andrew.

-- 
Dmitry
