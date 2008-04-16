From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: HID bus
Date: Wed, 16 Apr 2008 17:05:23 -0400
Message-ID: <20080416170415.ZZRA012@mailhub.coreip.homeip.net>
References: <1207341357-17792-1-git-send-email-jirislaby@gmail.com> <1207341357-17792-8-git-send-email-jirislaby@gmail.com> <Pine.LNX.4.64.0804161529270.12972@jikos.suse.cz> <480661FE.1040807@gmail.com> <20080416164500.ZZRA012@mailhub.coreip.homeip.net> <4806676B.30809@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:59726 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584AbYDPVFm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Apr 2008 17:05:42 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1417533ywb.1
        for <linux-input@vger.kernel.org>; Wed, 16 Apr 2008 14:05:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4806676B.30809@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Jiri Slaby <jirislaby@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, marcel@holtmann.org

On Wed, Apr 16, 2008 at 10:54:03PM +0200, Jiri Slaby wrote:
> On 04/16/2008 10:45 PM, Dmitry Torokhov wrote:
>> When I added serio bus I had to send patches to Rusty for
>> module-init-tools... No way around it as far as I understand.
>
> I have no fear of augmenting the tools, but the regressions. If one compile
> those as modules, it won't work with older init tools installed, since it won't
> get loaded. In that way I have been thinking of the option CONFIG_I_HAVE_OLD_MIT
> which would integrate the drivers into hidbus module or something scary like that.
>
> When you added that serio bus, you just added a new code, or converted something
> into a bus?

The drivers already were there (atkbd, psmouse, etc) but I dont think
they were auto-loading before.

-- 
Dmitry
