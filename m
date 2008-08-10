From: Aivils Stoss <aivils@latnet.lv>
Subject: Re: PROBLEM: USB keyboards works only 4 per PC host port
Date: Sun, 10 Aug 2008 04:08:37 +0100
Message-ID: <200808100408.37473.aivils@latnet.lv>
References: <200808080702.24969.aivils@latnet.lv> <20080809104226.GF4546@implementation>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from esbens.latnet.lv ([92.240.66.74]:39014 "EHLO esbens.latnet.lv"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753835AbYHKDIv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Aug 2008 23:08:51 -0400
In-Reply-To: <20080809104226.GF4546@implementation>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, linuxconsole-dev@lists.sourceforge.net

On Saturday 09 August 2008 11:42:26 am Samuel Thibault wrote:
> Aivils Stoss, le Fri 08 Aug 2008 07:02:24 +0100, a =E9crit :
> > I suppose this is Linux kernel bug because i test keyboards under
> > Windows, which support any schema of cascading of usb hubs.
>
> On the very same machine and hubs?

Yes, on same machine. Under Windows i don't have evdev interface,
checked only how keypress go to console.
Of course to repeat a try You must have at least 5 keyboards and
1 7-port or 2 4-port hubs and kernel 2.6.22 and above. I allways
got result - 5th, 6th, 7th keyboard does not send events to console
or evdev.

>
> Samuel


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
