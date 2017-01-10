From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/2] Support more Mayflash game contoller adapters.
Date: Tue, 10 Jan 2017 09:52:23 +0100
Message-ID: <20170110085223.GD2299@mail.corp.redhat.com>
References: <20170107110926.GA14173@arch-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38558 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751266AbdAJIw3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 10 Jan 2017 03:52:29 -0500
Content-Disposition: inline
In-Reply-To: <20170107110926.GA14173@arch-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcel Hasler <mahasler@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Robert de Rooy <robert.de.rooy@gmail.com>

On Jan 07 2017 or thereabouts, Marcel Hasler wrote:
> This patchset improves support for the Mayflash DolphinBar and GameCube adapters. These have been tested by Robert de Rooy and confirmed to work correctly using the following patches. See Bugzilla entry 115841 (https://bugzilla.kernel.org/show_bug.cgi?id=115841) for more information.
> 
> Marcel Hasler (2):
>   hid: Add a new device ID for updated Mayflash/Dragonrise GameCube adapter.
>   hid-mf: Add force feedback support for Mayflash DolphinBar and GameCube adapters.

The series looks good to me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

> 
>  drivers/hid/hid-core.c          |  3 +++
>  drivers/hid/hid-ids.h           |  3 ++-
>  drivers/hid/hid-mf.c            | 19 ++++++++++++++-----
>  drivers/hid/usbhid/hid-quirks.c |  2 +-
>  4 files changed, 20 insertions(+), 7 deletions(-)
> 
> -- 
> 2.11.0
> 
