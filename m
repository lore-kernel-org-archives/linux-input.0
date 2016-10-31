From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] usbhid: Add quirks for Mayflash/Dragonrise GameCube and
 PS3 adapters.
Date: Mon, 31 Oct 2016 11:34:51 +0100
Message-ID: <20161031103451.GA11633@mail.corp.redhat.com>
References: <20161030092913.GA3426@arch-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1765434AbcJaKez (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 31 Oct 2016 06:34:55 -0400
Content-Disposition: inline
In-Reply-To: <20161030092913.GA3426@arch-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcel Hasler <mahasler@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

On Oct 30 2016 or thereabouts, Marcel Hasler wrote:
> All known gamepad adapters by Mayflash (identified as Dragonrise) need HID_QUIRK_MULTI_INPUT to
> split them up into four input devices. Without this quirk those adapters are falsely recognized
> as tablets. Fixes bug 115841 (https://bugzilla.kernel.org/show_bug.cgi?id=115841).
> 
> Signed-off-by: Marcel Hasler <mahasler@gmail.com>

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

