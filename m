From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 2/2] DaVinci: DM365: Add the device_enable for the DaVinci Keyscan
Date: Mon, 07 Dec 2009 16:26:15 -0800
Message-ID: <87aaxu5n14.fsf@deeprootsystems.com>
References: <1258141463-24937-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:46328 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935725AbZLHA0M (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Dec 2009 19:26:12 -0500
Received: by yxe17 with SMTP id 17so4462285yxe.33
        for <linux-input@vger.kernel.org>; Mon, 07 Dec 2009 16:26:18 -0800 (PST)
In-Reply-To: <1258141463-24937-1-git-send-email-miguel.aguilar@ridgerun.com> (miguel aguilar's message of "Fri\, 13 Nov 2009 13\:44\:23 -0600")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: miguel.aguilar@ridgerun.com
Cc: davinci-linux-open-source@linux.davincidsp.com, nsnehaprabha@ti.com, linux-input@vger.kernel.org, santiago.nunez@ridgerun.com, todd.fischer@ridgerun.com, clark.becker@ridgerun.com

<miguel.aguilar@ridgerun.com> writes:

> From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
>
> Adds the device_enable function to the DaVinci Keyscan platform data
> to setup the PINMUX configuration.
>
> It also removes #ifdef from the DM365 EVM board in order to load it
> properly as a module.
>
> Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>

This looks good to me.  Will queue when I hear whether driver change
is queued.

Kevin

