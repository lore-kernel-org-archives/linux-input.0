From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: keyboard: adp5589-keys: Add support for the
 ADP5585 derivatives
Date: Wed, 3 Aug 2011 20:19:07 -0700
Message-ID: <20110804031906.GA30482@core.coreip.homeip.net>
References: <1311944415-20197-1-git-send-email-michael.hennerich@analog.com>
 <4E390710.5060503@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:34757 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756201Ab1HDDTN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Aug 2011 23:19:13 -0400
Received: by pzk37 with SMTP id 37so1211545pzk.1
        for <linux-input@vger.kernel.org>; Wed, 03 Aug 2011 20:19:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E390710.5060503@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>

On Wed, Aug 03, 2011 at 10:30:08AM +0200, Michael Hennerich wrote:
> On 07/29/2011 03:00 PM, michael.hennerich@analog.com wrote:
> >From: Michael Hennerich<michael.hennerich@analog.com>
> >
> >The ADP5585 family keypad decoder and IO expander is similar to the ADP5589,
> >however it features less IO pins, and lacks hardware assisted key-lock
> >functionality. Unfortunately the register addresses are different, as well as
> >the event codes and bit organization within the port related registers.
> >
> >Move ADP5589 Register defines from the header file into the main source file.
> >Add new defines while making sure we don't break existing platform_data.
> >Add register address translation, and turn device specific defines into variables.
> >Introduce some helper functions and disable functions that doesn't
> >exist on the added devices.
> >
> >Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
> >---
> >  drivers/input/keyboard/Kconfig        |    4 +-
> >  drivers/input/keyboard/adp5589-keys.c |  607 ++++++++++++++++++++++++++-------
> >  include/linux/input/adp5589.h         |  157 ++++-----
> >  3 files changed, 549 insertions(+), 219 deletions(-)
> >
> Hi Dmitry,
> 
> If you prefer support for the ADP5585 as separate driver, please let
> me know.

Hi Michael,

No, I actually like this approach very much, but do you think we could
have adp5589-keys.c, adp5585-keys.c and adp558x-keys-core.c? The
register definitions put all in one file are a bit overwhelming...

Thanks!

-- 
Dmitry
