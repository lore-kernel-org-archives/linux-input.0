From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 6/6] Input: gpio_keys - switch to using generic device
 properties
Date: Mon, 31 Oct 2016 12:44:27 +0200
Message-ID: <20161031104427.GL23812@lahna.fi.intel.com>
References: <1477696485-6995-1-git-send-email-dmitry.torokhov@gmail.com>
 <1477696485-6995-6-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:21045 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764952AbcJaKoc (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 31 Oct 2016 06:44:32 -0400
Content-Disposition: inline
In-Reply-To: <1477696485-6995-6-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org

On Fri, Oct 28, 2016 at 04:14:44PM -0700, Dmitry Torokhov wrote:
> Make use of the device property API in this driver so that both OF based
> systems and ACPI based systems can use this driver.
> 
> Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I tested 1-6 on Intel Joule with both gpio_keys and gpio_keys_polled and
it works fine. Thanks for doing this!

For the whole series,

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
