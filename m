From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 01/26] Input: synaptics-rmi4 - embed the function modules
 in rmi_core
Date: Mon, 9 Nov 2015 13:51:28 +0100
Message-ID: <CACRpkdb-SOvGO9xgpu+xW_NoCd1LBF_k=ND6=iVc1E6FDUe4RA@mail.gmail.com>
References: <1446766578-30160-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:35920 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbbKIMv3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 07:51:29 -0500
Received: by oiww189 with SMTP id w189so74568442oiw.3
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2015 04:51:28 -0800 (PST)
In-Reply-To: <1446766578-30160-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Fri, Nov 6, 2015 at 12:36 AM, Andrew Duggan <aduggan@synaptics.com> wrote:

> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> the function modules can not be auto-loaded by udev. So at boot, the
> functions are not there and the device is not properly populated.
> Force the functions to be embedded in rmi_core so that when the touchpad
> is there, the functions are there too.
>
> There is not much use of having the functions separate anyway
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Tested-by: Andrew Duggan <aduggan@synaptics.com>

Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
