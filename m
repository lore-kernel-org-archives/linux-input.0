From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCHv3] HID: i2c-hid: Add sleep between POWER ON and RESET
Date: Wed, 11 Jan 2017 21:55:51 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701112155370.25515@cbobk.fhfr.pm>
References: <20170106081144.GE15702@mail.corp.redhat.com> <1483736498-7805-1-git-send-email-redmcg@redmandi.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757981AbdAKUzy (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 11 Jan 2017 15:55:54 -0500
In-Reply-To: <1483736498-7805-1-git-send-email-redmcg@redmandi.dyndns.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Brendan McGrath <redmcg@redmandi.dyndns.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Victor Vlasenko <victor.vlasenko@sysgears.com>, Frederik Wenigwieser <frederik.wenigwieser@gmail.com>

On Sat, 7 Jan 2017, Brendan McGrath wrote:

> Support for the Asus Touchpad was recently added. It turns out this
> device can fail initialisation (and become unusable) when the RESET
> command is sent too soon after the POWER ON command.
> 
> Unfortunately the i2c-hid specification does not specify the need for
> a delay between these two commands. But it was discovered the Windows
> driver has a 1ms delay.
> 
> As a result, this patch modifies the i2c-hid module to add a sleep
> inbetween the POWER ON and RESET commands which lasts between 1ms and 5ms.
> 
> See https://github.com/vlasenko/hid-asus-dkms/issues/24 for further
> details.
> 
> Signed-off-by: Brendan McGrath <redmcg@redmandi.dyndns.org>
> ---
> Changes since v2:
>   - added comments to explain the reason for the sleep

Applied to for-4.10/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

