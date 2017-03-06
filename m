From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 1/2] HID: reject input outside logical range only if
 null state is set
Date: Mon, 6 Mar 2017 14:04:36 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703061404230.31814@cbobk.fhfr.pm>
References: <20170214231433.27060-1-tk@the-tk.com> <20170214231433.27060-2-tk@the-tk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753458AbdCFNY1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 6 Mar 2017 08:24:27 -0500
In-Reply-To: <20170214231433.27060-2-tk@the-tk.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tomasz Kramkowski <tk@the-tk.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?ISO-8859-15?Q?Valtteri_Heikkil=E4?= <rnd@nic.fi>

On Tue, 14 Feb 2017, Tomasz Kramkowski wrote:

> From: Valtteri Heikkilä <rnd@nic.fi>
> 
> This patch fixes an issue in drivers/hid/hid-input.c where USB HID
> control null state flag is not checked upon rejecting inputs outside
> logical minimum-maximum range. The check should be made according to USB
> HID specification 1.11, section 6.2.2.5, p.31. The fix will resolve
> issues with some game controllers, such as:
> https://bugzilla.kernel.org/show_bug.cgi?id=68621
> 
> [tk@the-tk.com: shortened and fixed spelling in commit message]
> Signed-off-by: Valtteri Heikkilä <rnd@nic.fi>
> Signed-off-by: Tomasz Kramkowski <tk@the-tk.com>

Applied to for-4.12/hid-core-null-state-handling. Thanks,

-- 
Jiri Kosina
SUSE Labs

