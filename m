From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: HID bus
Date: Wed, 16 Apr 2008 22:54:03 +0200
Message-ID: <4806676B.30809@suse.cz>
References: <1207341357-17792-1-git-send-email-jirislaby@gmail.com> <1207341357-17792-8-git-send-email-jirislaby@gmail.com> <Pine.LNX.4.64.0804161529270.12972@jikos.suse.cz> <480661FE.1040807@gmail.com> <20080416164500.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:56273 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1765557AbYDPUyK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Apr 2008 16:54:10 -0400
In-Reply-To: <20080416164500.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, marcel@holtmann.org

On 04/16/2008 10:45 PM, Dmitry Torokhov wrote:
> When I added serio bus I had to send patches to Rusty for
> module-init-tools... No way around it as far as I understand.

I have no fear of augmenting the tools, but the regressions. If one compile
those as modules, it won't work with older init tools installed, since it won't
get loaded. In that way I have been thinking of the option CONFIG_I_HAVE_OLD_MIT
which would integrate the drivers into hidbus module or something scary like that.

When you added that serio bus, you just added a new code, or converted something
into a bus?
