From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/2] HID: wacom: patches for 4.11
Date: Tue, 7 Mar 2017 11:34:16 +0100
Message-ID: <20170307103416.GB24124@mail.corp.redhat.com>
References: <1488826498-8578-1-git-send-email-skomra@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753835AbdCGMbj (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 7 Mar 2017 07:31:39 -0500
Content-Disposition: inline
In-Reply-To: <1488826498-8578-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Armstrong Skomra <skomra@gmail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, pinglinux@gmail.com, Ping.Cheng@wacom.com, killertofu@gmail.com

On Mar 06 2017 or thereabouts, Aaron Armstrong Skomra wrote:
> Two fixes for patches included in 4.11
> 
> Aaron Armstrong Skomra (2):
>   HID: wacom: Correct Intuos Pro 2 resolution
>   HID: wacom: don't manually release resources for the EKR

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Aaron told me about the issue in patch 2/2, so it's not news to me.

Cheers,
Benjamin

> 
>  drivers/hid/wacom_sys.c | 4 +++-
>  drivers/hid/wacom_wac.c | 4 ++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> -- 
> 2.7.4
> 
