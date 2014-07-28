From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCHES v2] Add support for more Huion tablets
Date: Mon, 28 Jul 2014 11:33:37 -0400
Message-ID: <CAN+gG=EPK-KENSFBYLEaX_OzaAUHrvU=1mnBgmPoCQgM9rLuXA@mail.gmail.com>
References: <53CFC950.90703@gmail.com>
	<1406133117-29243-1-git-send-email-spbnick@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:50416 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbaG1Pdi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jul 2014 11:33:38 -0400
Received: by mail-la0-f49.google.com with SMTP id hz20so5462929lab.8
        for <linux-input@vger.kernel.org>; Mon, 28 Jul 2014 08:33:37 -0700 (PDT)
In-Reply-To: <1406133117-29243-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On Wed, Jul 23, 2014 at 12:31 PM, Nikolai Kondrashov <spbnick@gmail.com> wrote:
> Hi everyone,
>
> This is the second version of the patch set adding support for more Huion
> tablets [1].
>
> This version has the "hid: huion: Invert in-range on specific product" patch
> removed as requested by Benjamin Tissoires.
>
> Tested with Huion H610N.
>
> Nick
>
> [PATCH 1/4] hid: huion: Use "tablet" instead of specific model
> [PATCH 2/4] hid: huion: Don't ignore other interfaces
> [PATCH 3/4] hid: huion: Switch to generating report descriptor
> [PATCH 4/4] hid: huion: Handle tablets with UC-Logic vendor ID
>
>  drivers/hid/hid-core.c  |   2 +-
>  drivers/hid/hid-huion.c | 265 ++++++++++++++++++++++++++++++++----------------
>  drivers/hid/hid-ids.h   |   2 +-
>  3 files changed, 177 insertions(+), 92 deletions(-)
>
> [1] http://thread.gmane.org/gmane.linux.kernel.input/37187

Just so that the info does not get lost, the v2 of the patch series is still:

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin
