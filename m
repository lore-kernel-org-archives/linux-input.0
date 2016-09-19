From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: apple: Fix the '`'/'~' key issue for MacBook Air
 6,2.
Date: Mon, 19 Sep 2016 15:04:46 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1609191503230.22028@cbobk.fhfr.pm>
References: <CAADKi7=eQhQaqFDgrhbQA9xObBpWGUrni8ZA1V0rt=aO+ZFuzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755740AbcISNEt (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Sep 2016 09:04:49 -0400
In-Reply-To: <CAADKi7=eQhQaqFDgrhbQA9xObBpWGUrni8ZA1V0rt=aO+ZFuzQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yuan Chao <yuanchao@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, 31 Aug 2016, Yuan Chao wrote:

> The '`'/'~' key delivers '<'/'>' on MacBook Air 6,2. [1] By forcing
> the module parameter iso_layout = 0, this issue can be fixed. [2][3]
> This patch checks the DMI information and sets the parameter.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=60181#c43
> [2] https://bugzilla.redhat.com/show_bug.cgi?id=1025041
> [3] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1245081
> 
> (Sorry Jiri for duplicated message)

Hi,

thanks for the patch.

> +       /*
> +        * This is to solve the 'tilt' key problem on
> +        * macbook air 6,2 problem by setting iso_layout = 0
> +        */
> +       if ((quirks & APPLE_ISO_KEYBOARD) &&
> +           dmi_name_in_vendors("Apple Inc.") &&
> +           dmi_match(DMI_PRODUCT_NAME, "MacBookAir6,2")) {
> +         hid_info(hdev, "Parameter iso_layout is set to 0 for MacBook Air 6,2.\n");
> +         iso_layout = 0;
> +       }
> +

Can't we really rather introduce device-ID based quirk? Odds are that 
there will be more devices (rebranded stuff etc) appearing that'd need the 
same quirk, and scaling up DMI matching is just horrible.

Thanks,

-- 
Jiri Kosina
SUSE Labs

