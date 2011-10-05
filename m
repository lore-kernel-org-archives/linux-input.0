From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/4] input: wacom - add LED support for Cintiq 21ux2
Date: Tue, 4 Oct 2011 23:53:37 -0700
Message-ID: <20111005065337.GA11260@core.coreip.homeip.net>
References: <1317686605-29648-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44324 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925Ab1JEGxn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Oct 2011 02:53:43 -0400
Received: by iakk32 with SMTP id k32so1468310iak.19
        for <linux-input@vger.kernel.org>; Tue, 04 Oct 2011 23:53:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1317686605-29648-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Mon, Oct 03, 2011 at 05:03:25PM -0700, Ping Cheng wrote:
>  
> -What:		/sys/bus/usb/devices/<busnum>-<devnum>:<cfg>.<intf>/wacom_led/status_led_select
> +What:		/sys/bus/usb/devices/<busnum>-<devnum>:<cfg>.<intf>/wacom_led/status_led0_select

Hmm, normally ABI does not change. I guess since we have not released an
official kernel with this interface it is ok...

Applied (and the other 3 as well).

-- 
Dmitry
