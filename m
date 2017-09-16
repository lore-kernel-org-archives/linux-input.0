From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: asus: Add support for Fn keys on Asus ROG G752
Date: Fri, 15 Sep 2017 17:58:27 -0700 (PDT)
Message-ID: <nycvar.YFH.7.76.1709151755040.4703@jbgna.fhfr.qr>
References: <20170907191728.19018-1-maxime.bellenge@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57351 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751201AbdIPA63 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 15 Sep 2017 20:58:29 -0400
In-Reply-To: <20170907191728.19018-1-maxime.bellenge@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Maxime_Belleng=E9?= <maxime.bellenge@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 7 Sep 2017, Maxime Bellengé wrote:

> This patch adds support for Fn keys on Asus ROG G752 laptop.
> The report descriptor is broken so I fixed it.
> 
> Tested on an Asus G752VT.
> Resent fix white space fixes

Those whitespace fixes were almost right :) Except for the quirk/blacklist 
additions, which still added with spaces instead of tabs. I've fixed that 
up manually while applying, but please look into it for any further 
submissions.

Applied to for-4.15/asus.

Thanks, 

-- 
Jiri Kosina
SUSE Labs

