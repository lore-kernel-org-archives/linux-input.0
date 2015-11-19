From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v11 3/8] Input: goodix - write configuration data to
 device
Date: Thu, 19 Nov 2015 10:20:38 -0800
Message-ID: <20151119182038.GA24773@dtor-ws>
References: <1447936001-21420-1-git-send-email-irina.tirdea@intel.com>
 <1447936001-21420-4-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34153 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbbKSSUl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2015 13:20:41 -0500
Content-Disposition: inline
In-Reply-To: <1447936001-21420-4-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, linux-input@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Thu, Nov 19, 2015 at 02:26:36PM +0200, Irina Tirdea wrote:
> +	if (ts->gpiod_int && ts->gpiod_rst) {
> +		/* update device config */
> +		ts->cfg_name = kasprintf(GFP_KERNEL, "goodix_%d_cfg.bin",
> +					 ts->id);

devm_kasprintf maybe (don't resubmit)?

Thanks.

-- 
Dmitry
