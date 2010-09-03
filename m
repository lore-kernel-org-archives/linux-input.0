From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] Input: wm97xx-core - add retries to
 wm97xx_read_aux_adc
Date: Fri, 3 Sep 2010 10:52:59 +0100
Message-ID: <20100903095259.GC16587@rakim.wolfsonmicro.main>
References: <1283458597-27348-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:50724 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751900Ab0ICJxA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 3 Sep 2010 05:53:00 -0400
Content-Disposition: inline
In-Reply-To: <1283458597-27348-1-git-send-email-emillbrandt@dekaresearch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, linux-input@vger.kernel.org

On Thu, Sep 02, 2010 at 04:16:37PM -0400, Eric Millbrandt wrote:

> +       if (timeout >= 5)
> +               wm->codec->dig_enable(wm, false);
> +

Looks good but I think it'd be better to log an error here at least at
debug level since I bet people won't do such a good job of checking the
return value and this shouldn't be happening in normal operation.
