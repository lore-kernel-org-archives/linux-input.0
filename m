From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 0/2] uapi/input.h: Add INPUT_PROP_TOPBUTTONPAD device
 property
Date: Sat, 19 Apr 2014 22:30:44 -0700
Message-ID: <20140420053044.GA12454@core.coreip.homeip.net>
References: <1397546663-4447-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:60036 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbaDTFar (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Apr 2014 01:30:47 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so2703019pab.38
        for <linux-input@vger.kernel.org>; Sat, 19 Apr 2014 22:30:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1397546663-4447-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org

On Tue, Apr 15, 2014 at 09:24:21AM +0200, Hans de Goede wrote:
> Hi All,
> 
> I've received an updated list of pnpids from synaptics so here is an updated
> version of the patch-set.
> 
> Changes in v2:
> -Drop adding of pnp_id to struct serio (drop patches 2/4 and 3/4 of v1)
> -Modify the synaptics patch to use firmware_id instead of pnp_id
> 
> Changes in v3:
> -Update topbuttonpad pnpid list in synaptics.c

Applied, thank you.

-- 
Dmitry
