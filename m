From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 1/1] Input: Improve the performance of alps
 v5-protocol's touchpad
Date: Sun, 1 Dec 2013 22:41:21 -0800
Message-ID: <20131202064121.GD21404@core.coreip.homeip.net>
References: <1382355711-3211-1-git-send-email-yunkang.tang@cn.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:48395 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab3LBGlY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Dec 2013 01:41:24 -0500
Received: by mail-pb0-f54.google.com with SMTP id un15so18158251pbc.41
        for <linux-input@vger.kernel.org>; Sun, 01 Dec 2013 22:41:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1382355711-3211-1-git-send-email-yunkang.tang@cn.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yunkang Tang <tommywill2011@gmail.com>
Cc: cernekee@gmail.com, dturvene@dahetral.com, linux-input@vger.kernel.org, ndevos@redhat.com, yunkang.tang@cn.alps.com

Hi Yunkang,

On Mon, Oct 21, 2013 at 07:41:50PM +0800, Yunkang Tang wrote:
> +static void alps_process_packet_v5(struct psmouse *psmouse)
> +{
> +	unsigned char *packet = psmouse->packet;
> +
> +	/* Ignore stick point data */
> +	if (packet[0] == 0xD8)
> +		return;

Why are we ignoring trackstick data? If there Dolphin models with
tracksticks that would basically "break" the device for users compared
withe the emulated Explorer PS/2 mode.

Thanks.

-- 
Dmitry
