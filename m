From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 2/2] HID: logitech-hidpp: 2 fixes in
 hidpp_root_get_protocol_version()
Date: Tue, 4 Nov 2014 11:12:05 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1411041111580.19451@pobox.suse.cz>
References: <1415048999-4490-1-git-send-email-benjamin.tissoires@redhat.com> <1415048999-4490-2-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415048999-4490-2-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 3 Nov 2014, Benjamin Tissoires wrote:

> - remove the constant '1'
> - when the device is not connected, the protocol error
>   HIDPP_ERROR_RESOURCE_ERROR is raised. We should not warn the user about
>   it because it is somewhat expected as an answer when we check if the
>   device is connected.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> 
> Changes in v2:
>  none

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
