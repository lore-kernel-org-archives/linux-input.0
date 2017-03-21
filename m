From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 0/2] HID: hiddev: move hiddev's minor number and
 refactoring
Date: Tue, 21 Mar 2017 15:25:28 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703211525080.31814@cbobk.fhfr.pm>
References: <1488531241-18367-1-git-send-email-climbbb.kim@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43382 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757263AbdCUOnn (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Mar 2017 10:43:43 -0400
In-Reply-To: <1488531241-18367-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaejoong Kim <climbbb.kim@gmail.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, 3 Mar 2017, Jaejoong Kim wrote:

> Jaejoong Kim (2):
>   HID: cp2112: use proper hidraw name with minor number
>   HID: hiddev: reallocate hiddev's minor number

Applied to for-4.12/hiddev. Thanks,

-- 
Jiri Kosina
SUSE Labs

