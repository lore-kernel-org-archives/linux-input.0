From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/8] constify input usb_device_id.
Date: Mon, 7 Aug 2017 20:05:08 -0700
Message-ID: <20170808030508.GD12328@dtor-ws>
References: <1502005287-17705-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:36172 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751834AbdHHDFM (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 7 Aug 2017 23:05:12 -0400
Content-Disposition: inline
In-Reply-To: <1502005287-17705-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Aug 06, 2017 at 01:11:19PM +0530, Arvind Yadav wrote:
> usb_device_id are not supposed to change at runtime. All functions
> working with usb_device_id provided by <linux/usb.h> work with
> const usb_device_id. So mark the non-const structs as const.
> 
> Fix checkpatch.pl error in patch 1,3 and 7:
> ERROR: space prohibited before open square bracket '['.
> 
> Arvind Yadav (8):
>   [PATCH 1/8] Input: iforce: constify usb_device_id and fix space before '[' error.
>   [PATCH 2/8] Input: xpad: constify usb_device_id.
>   [PATCH 3/8] Input: keyspan_remote: constify usb_device_id.
>   [PATCH 4/8] Input: powermate: constify usb_device_id and fix space before '[' error.
>   [PATCH 5/8] Input: appletouch: constify usb_device_id.
>   [PATCH 6/8] Input: synaptics_usb: constify usb_device_id.
>   [PATCH 7/8] Input: acecad: constify usb_device_id and fix space before '[' error.
>   [PATCH 8/8] Input: kbtab: constify usb_device_id.
> 
>  drivers/input/joystick/iforce/iforce-usb.c | 2 +-
>  drivers/input/joystick/xpad.c              | 2 +-
>  drivers/input/misc/keyspan_remote.c        | 2 +-
>  drivers/input/misc/powermate.c             | 2 +-
>  drivers/input/mouse/appletouch.c           | 2 +-
>  drivers/input/mouse/synaptics_usb.c        | 2 +-
>  drivers/input/tablet/acecad.c              | 2 +-
>  drivers/input/tablet/kbtab.c               | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)

Applied the lot, thank you.

-- 
Dmitry
