From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Add OLPC AP-SP input driver
Date: Fri, 28 Jun 2013 11:20:00 -0700
Message-ID: <20130628182000.GA21589@core.coreip.homeip.net>
References: <20130628171958.CC031FAAD5@dev.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:65040 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab3F1SUE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jun 2013 14:20:04 -0400
Received: by mail-pd0-f180.google.com with SMTP id 10so1173653pdi.11
        for <linux-input@vger.kernel.org>; Fri, 28 Jun 2013 11:20:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130628171958.CC031FAAD5@dev.laptop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-input@vger.kernel.org, pgf@laptop.org, devicetree-discuss@lists.ozlabs.org

Hi Daniel,

On Fri, Jun 28, 2013 at 01:19:58PM -0400, Daniel Drake wrote:
> +static int olpc_apsp_open(struct serio *port)
> +{
> +	struct olpc_apsp *priv = port->port_data;
> +	unsigned int tmp;
> +
> +	if (priv->open_count++ == 0) {
> +		/* Enable interrupt 0 by clearing its bit */
> +		tmp = readl(priv->base + PJ_INTERRUPT_MASK);
> +		writel(tmp & ~INT_0, priv->base + PJ_INTERRUPT_MASK);
> +	}
> +
> +	return 0;
> +}
> +
> +static void olpc_apsp_close(struct serio *port)
> +{
> +	struct olpc_apsp *priv = port->port_data;
> +	unsigned int tmp;
> +
> +	if (--priv->open_count == 0) {

Both need locking. It looks like you need the song and dance similar to
what i8042 has to do with it's multiplexed ports. Or ps2mult.c...

-- 
Dmitry
