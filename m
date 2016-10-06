From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: elantech - add Fujitsu Lifebook E556 to force
 crc_enabled
Date: Thu, 6 Oct 2016 09:04:21 +0200
Message-ID: <20161006070421.GD19261@mail.corp.redhat.com>
References: <20161006055500.GA9017@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752994AbcJFHE1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 6 Oct 2016 03:04:27 -0400
Content-Disposition: inline
In-Reply-To: <20161006055500.GA9017@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Ulrik De Bie <ulrik.debie-os@e2big.org>, William Linna <william.linna@gmail.com>, linux-kernel@vger.kernel.org

On Oct 05 2016 or thereabouts, Dmitry Torokhov wrote:
> Another Lifebook machine that needs the same quirk as other similar
> models to make the driver working.
> 
> Also let's reorder elantech_dmi_force_crc_enabled list so LIfebook enries
> are in alphabetical order.
> 
> Reported-by: William Linna <william.linna@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

