From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: HID: broken force feedback support for ACRUX gamepad
Date: Wed, 3 Aug 2011 09:11:17 -0700
Message-ID: <201108030911.18304.dmitry.torokhov@gmail.com>
References: <CAFxvmmd3NB5jtEb4TPtLuHxWC_PDUReVe1cB=nS93GfJqJmxqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:46322 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632Ab1HCQLZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Aug 2011 12:11:25 -0400
Received: by pzk37 with SMTP id 37so284246pzk.1
        for <linux-input@vger.kernel.org>; Wed, 03 Aug 2011 09:11:25 -0700 (PDT)
In-Reply-To: <CAFxvmmd3NB5jtEb4TPtLuHxWC_PDUReVe1cB=nS93GfJqJmxqw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bernard GODARD <bernard.godard@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi Bernard,

On Wednesday, August 03, 2011 09:06:15 AM Bernard GODARD wrote:
> The force feedback support for the ACRUX gamepad is broken since
> 2.6.38.8 and more recent kernels due to this
> commit:	0ae43810976bc969ee158510c4acbe70ed136e61
> The problem is simply with drivers/hid/Kconfig:
> HID_ACRUX_FF should be a bool not a tristate. Otherwise the support
> for the force feedback is not compiled into the module hid-axff.

Yep, I have a couple of patches from original author correcting that
and a few other issues, I just need to translate changelogs...

-- 
Dmitry
