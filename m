From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: asus: Add support for Fn keys on Asus ROG G752
Date: Wed, 6 Sep 2017 11:04:50 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1709061104100.4077@jbgna.fhfr.qr>
References: <20170820125814.21641-1-maxime.bellenge@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54239 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752361AbdIFJEw (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 6 Sep 2017 05:04:52 -0400
In-Reply-To: <20170820125814.21641-1-maxime.bellenge@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Maxime_Belleng=E9?= <maxime.bellenge@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 20 Aug 2017, Maxime Bellengé wrote:

> This patch adds support for Fn keys on Asus ROG G752 laptop.
> The report descriptor is broken so I fixed it.
> 
> Tested on an Asus G752VT.
> 
> Signed-off-by: Maxime Bellengé <maxime.bellenge@gmail.com>

Looks good to me, but the patch is whitespace damaged (it adds only 
spaces, no tabs).

Could you please fix that up and resend (with Benjamin's Reviewed-by 
added)?

Thanks,

-- 
Jiri Kosina
SUSE Labs

