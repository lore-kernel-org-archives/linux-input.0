From: Samuel Thibault <sthibault@debian.org>
Subject: Re: Bug#594089: keyboard-configuration: caps lock keycode problem
Date: Wed, 27 Oct 2010 14:05:13 +0200
Message-ID: <20101027120513.GT4725@const.famille.thibault.fr>
References: <4C866913.3030201@triadsys.com> <4C8E6861.1070502@triadsys.com> <20101024144150.GV24091@const.famille.thibault.fr> <20101025045003.GA1438@core.coreip.homeip.net> <4CC58816.3090301@triadsys.com> <20101025180320.GA4725@const.famille.thibault.fr> <4CC6E9D8.8010201@triadsys.com> <20101026161820.GE13097@core.coreip.homeip.net> <4CC7426C.8040502@triadsys.com> <20101027091029.GB28895@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from solo.fdn.fr ([80.67.169.19]:55946 "EHLO solo.fdn.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754994Ab0J0MFQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Oct 2010 08:05:16 -0400
Content-Disposition: inline
In-Reply-To: <20101027091029.GB28895@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Tom Vier <tom@triadsys.com>, 594089@bugs.debian.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Dmitry Torokhov, le Wed 27 Oct 2010 02:10:29 -0700, a =E9crit :
> Also, based on evtest data I only see presses/releases for one key (C=
aps
> Lock, Right Shift, etc.) I do not see the presses for the additional
> keys in the evtest stream so I am baffled as to where the additional
> scancode is coming from... Do you have some funky keymap loaded?
> Anything interesting in dumpkeys?

Err, since the duplicates appear in scancodes already, is the content o=
f
dumpkeys really involved?

Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
