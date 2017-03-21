From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/2] HID: wacom: patches for 4.11
Date: Tue, 21 Mar 2017 14:44:48 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703211444390.31814@cbobk.fhfr.pm>
References: <1488826498-8578-1-git-send-email-skomra@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59987 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756343AbdCUNou (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Mar 2017 09:44:50 -0400
In-Reply-To: <1488826498-8578-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Armstrong Skomra <skomra@gmail.com>
Cc: linux-input@vger.kernel.org, pinglinux@gmail.com, Ping.Cheng@wacom.com, killertofu@gmail.com, benjamin.tissoires@redhat.com

On Mon, 6 Mar 2017, Aaron Armstrong Skomra wrote:

> Two fixes for patches included in 4.11
> 
> Aaron Armstrong Skomra (2):
>   HID: wacom: Correct Intuos Pro 2 resolution
>   HID: wacom: don't manually release resources for the EKR
> 
>  drivers/hid/wacom_sys.c | 4 +++-
>  drivers/hid/wacom_wac.c | 4 ++--
>  2 files changed, 5 insertions(+), 3 deletions(-)

Applied to for-4.11/upstream-fxies. Thanks,

-- 
Jiri Kosina
SUSE Labs

