From: Ben Gamari <bgamari.foss@gmail.com>
Subject: RE: Why Cypress does not upstream its trackpad driver?
Date: Wed, 07 Nov 2012 22:45:31 -0500
Message-ID: <877gpwlpus.fsf@gmail.com>
References: <CAFub=KTf2dWxM9=saG2JaNJpEioJM8rM3UBG9BkyxRN-+j0psQ@mail.gmail.com> <C825ADB6BE8AC2468577BFFCE7DF5B8A1F080FA111@VMBX133.ihostexchange.net> <EE629F2C-DD83-403C-AD73-E9ED966EEA91@cypress.com> <2208882.BvOrfBvj6F@dtor-d630.eng.vmware.com> <C6B11F3154DB7242B32DD96C876EA7847BAFFAFA95@VMBX113.ihostexchange.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:54510 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890Ab2KHDpe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Nov 2012 22:45:34 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so2238301vcb.19
        for <linux-input@vger.kernel.org>; Wed, 07 Nov 2012 19:45:33 -0800 (PST)
In-Reply-To: <C6B11F3154DB7242B32DD96C876EA7847BAFFAFA95@VMBX113.ihostexchange.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Solda <dso@cypress.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Troy Abercrombia <ta@cypress.com>, Kamal Mostafa <kamal@canonical.com>, Ozan =?utf-8?B?w4dhxJ9sYXlhbg==?= <ozancag@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, customercare <customercare@cypress.com>, "mario_limonciello@dell.com" <mario_limonciello@dell.com>

David Solda <dso@cypress.com> writes:

> Dmitry, all,
>
> To clarify my comment.  Our protocol utilizes 8 bytes which are needed
> in our driver.  In order for the Linux system to accept 8 bytes of
> data, the Linux psmouse system driver is required to be modified.
> Without this modification, the driver that you are referring to will
> not work correctly.  The psmouse system driver change that would be
> required is the item that would be rejected.
>
> I appreciate your comments and of course, if the driver could be
> upstreamed, it would (we already have I2C drivers updstreamed for
> Chrome systems), but there is a difference here.
>
> I will again look into the possibility of what you are requesting,
> however, the changes are extremely low if not zero that it will be
> accepted.
>
You are speaking to the people who ultimately decide whether your change
will be accepted or not. Currently there is no way anyone could know
whether the desired change is acceptable as no patch has been
submitted. 

Send a patch with the (minimal, well-organized) needed changes and the
matter can be discussed from there. If the changes are sane and well
justified, then there's little reason why they can't be accepted.

Cheers,

- Ben

