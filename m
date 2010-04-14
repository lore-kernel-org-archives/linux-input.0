From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Input: add HP Compaq 2710p to 'noloop' table
Date: Wed, 14 Apr 2010 13:36:43 +0100
Message-ID: <20100414123643.GB9242@srcf.ucam.org>
References: <alpine.LNX.2.00.1004141409450.8345@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42641 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775Ab0DNMgq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Apr 2010 08:36:46 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1004141409450.8345@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Apr 14, 2010 at 02:16:25PM +0200, Jiri Kosina wrote:
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq 2710p (#ABD)"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "F.14"),

Is this really the only BIOS version affected? It seems unlikely. It's 
also a pretty good indication that we're doing something wrong.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
