From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Davinci: DM365: Enable DaVinci Key Scan support
	for DM365 EVM
Date: Thu, 24 Sep 2009 21:01:47 -0700
Message-ID: <20090925040146.GB416@core.coreip.homeip.net>
References: <1253811240-21437-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.221.174]:64749 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbZIYEBq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Sep 2009 00:01:46 -0400
Received: by qyk4 with SMTP id 4so1791845qyk.33
        for <linux-input@vger.kernel.org>; Thu, 24 Sep 2009 21:01:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1253811240-21437-1-git-send-email-miguel.aguilar@ridgerun.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: miguel.aguilar@ridgerun.com
Cc: nsnehaprabha@ti.com, davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com

On Thu, Sep 24, 2009 at 10:54:00AM -0600, miguel.aguilar@ridgerun.com wrote:
>  
> +/* Masks for the various keys on the DM365 EVM */
> +#define KEY_DM365_KEY2		0
> +#define KEY_DM365_LEFT		1
> +#define KEY_DM365_EXIT		2
> +#define KEY_DM365_DOWN		3
> +#define KEY_DM365_ENTER		4
> +#define KEY_DM365_UP		5
> +#define KEY_DM365_KEY1		6
> +#define KEY_DM365_RIGHT		7
> +#define KEY_DM365_MENU		8
> +#define KEY_DM365_REC		9
> +#define KEY_DM365_REW		10
> +#define KEY_DM365_SKIPMINUS	11
> +#define KEY_DM365_STOP		12
> +#define KEY_DM365_FF		13
> +#define KEY_DM365_SKIPPLUL	14
> +#define KEY_DM365_PLAYPAUSE	15
> +
> +#ifdef CONFIG_KEYBOARD_DAVINCI
> +static unsigned short dm365evm_keymap[] = {
> +	KEY_DM365_KEY2,
> +	KEY_DM365_LEFT,
> +	KEY_DM365_EXIT,
> +	KEY_DM365_DOWN,
> +	KEY_DM365_ENTER,
> +	KEY_DM365_UP,
> +	KEY_DM365_KEY1,
> +	KEY_DM365_RIGHT,
> +	KEY_DM365_MENU,
> +	KEY_DM365_REC,
> +	KEY_DM365_REW,
> +	KEY_DM365_SKIPMINUS,
> +	KEY_DM365_STOP,
> +	KEY_DM365_FF,
> +	KEY_DM365_SKIPPLUL,
> +	KEY_DM365_PLAYPAUSE,

These are not standard key codes, why don't you use the ones defined in
linux/input.h?

-- 
Dmitry
