From: "Simon Wood" <simon@mungewell.org>
Subject: Re: [PATCH 4/5] HID:hid-logitech: Rewrite of descriptor for all DF
 wheels
Date: Wed, 14 Sep 2016 12:55:42 -0600
Message-ID: <69c4e4c8a24f3e23cd6ae4287836940f.squirrel@mungewell.org>
References: <1473461449-8060-1-git-send-email-simon@mungewell.org>
    <1473461449-8060-4-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host18.canaca.com ([66.49.204.205]:36114 "EHLO
        host18.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbcINSzo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2016 14:55:44 -0400
In-Reply-To: <1473461449-8060-4-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <gitsend@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Edwin Velds <edwin@velds.nl>, Elias Vanderstuyft <elias.vds@gmail.com>, Michal Maly <madcatxster@gmail.com>, Simon Wood <simon@mungewell.org>

On Fri, September 9, 2016 7:34 pm, kbuild test robot wrote:
> All warnings (new ones prefixed by >>):
>
>
> drivers/hid/hid-lg.c: In function 'lg_report_fixup':
>
>>> drivers/hid/hid-lg.c:347:28: warning: unused variable 'rev_min'
>>> [-Wunused-variable]
>>>
> __u16 bcdDevice, rev_maj, rev_min;
> ^
>
>>> drivers/hid/hid-lg.c:347:19: warning: unused variable 'rev_maj'
>>> [-Wunused-variable]
>>>
> __u16 bcdDevice, rev_maj, rev_min;
> ^
>
>>> drivers/hid/hid-lg.c:347:8: warning: unused variable 'bcdDevice'
>>> [-Wunused-variable]
>>>
> __u16 bcdDevice, rev_maj, rev_min;
> ^
>
>>> drivers/hid/hid-lg.c:346:32: warning: unused variable 'udesc'
>>> [-Wunused-variable]
>>>
> struct usb_device_descriptor *udesc; ^

Hi all,
No other comments from the rest of the patch set (so far), so I'll send a
V2 patch set to cover these towards the end of the week.

Also have better support for the "Wingman Forumula Force GT" to include,
as I picked one up cheap on Kijiji.
Simon.

