From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 0/2] input/serio: Add a firmware_id sysfs attribute
Date: Sat, 19 Apr 2014 22:31:04 -0700
Message-ID: <20140420053104.GB12454@core.coreip.homeip.net>
References: <1397471419-31224-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:39153 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbaDTFbH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Apr 2014 01:31:07 -0400
Received: by mail-pd0-f179.google.com with SMTP id w10so2646010pde.24
        for <linux-input@vger.kernel.org>; Sat, 19 Apr 2014 22:31:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1397471419-31224-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org

On Mon, Apr 14, 2014 at 12:30:17PM +0200, Hans de Goede wrote:
> Hi All,
> 
> Here is v3 of my serio firmware_id sysfs attribute patch-set
> 
> Changes in v2:
> -Add a helper function to avoid copy/pasting the code for building
>  the firmware_id string from pnp_ids
> 
> Changes in v3:
> -Prefix the firmware_id string for 8042-pnp devices which "PNP: " so that
>  it will be easy to differentiate pnp-ids from ie devicetree ids in the future

Applied, thank you.

-- 
Dmitry
