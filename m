From: Jiri Kosina <jkosina@suse.cz>
Subject: RE: [PATCH] HID: Add support to new N-trig firwmare
Date: Mon, 21 Jun 2010 11:48:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1006211143520.13809@pobox.suse.cz>
References: <48A28051AC6D7A48B64F28272458190333674B@Exchange-IL.n-trig.com> <alpine.LNX.2.00.1006041115480.12271@pobox.suse.cz> <48A28051AC6D7A48B64F28272458190326E03E@Exchange-IL.n-trig.com> <alpine.LNX.2.00.1006051741361.12271@pobox.suse.cz>
 <48A28051AC6D7A48B64F28272458190338280A@Exchange-IL.n-trig.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <48A28051AC6D7A48B64F28272458190338280A@Exchange-IL.n-trig.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Micki Balanga <micki@n-trig.com>
Cc: chatty@enac.fr, dhprince-devel@yahoo.co.uk, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rafi Rubin <rafi@seas.upenn.edu>
List-Id: linux-input@vger.kernel.org

On Mon, 21 Jun 2010, Micki Balanga wrote:

> We have some new product so I have to update the patch,
> When I update my git branch I didn't see the changes regarding N-trig
> Product id. If you can insert this patch, if there a problem with the
> patch
> Let me know and hi will update it

Hi Micki,

the patch seems incomplete -- it adds new entries to hid_blacklist[], but 
doesn't update ntrig_devices[].

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
