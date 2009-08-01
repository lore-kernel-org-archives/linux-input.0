From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 2/2] rfkill: Add support for KEY_RFKILL_ALL
Date: Sat, 01 Aug 2009 21:25:27 +0100
Message-ID: <1249158328.28327.10654.camel@localhost.localdomain>
References: <1249152859-14769-1-git-send-email-mjg@redhat.com>
	 <1249152859-14769-2-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:35725 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbZHAU3M (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 1 Aug 2009 16:29:12 -0400
In-Reply-To: <1249152859-14769-2-git-send-email-mjg@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-input@vger.kernel.org, johannes@sipsolutions.net, linux-wireless@vger.kernel.org, dmitry.torokhov@gmail.com

On Sat, 2009-08-01 at 19:54 +0100, Matthew Garrett wrote:
> 
> +               case KEY_RFKILL_ALL:
> +                       rfkill_schedule_toggle(RFKILL_TYPE_WLAN);
> +                       rfkill_schedule_toggle(RFKILL_TYPE_BLUETOOTH);
> +                       rfkill_schedule_toggle(RFKILL_TYPE_UWB);
> +                       rfkill_schedule_toggle(RFKILL_TYPE_WIMAX);
> +                       break;

RFKILL_TYPE_ALL?

