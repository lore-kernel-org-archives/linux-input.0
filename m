From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: gpio_keys - Use of_property_read_u32
Date: Fri, 9 Sep 2011 11:10:35 -0700
Message-ID: <20110909181035.GF32383@core.coreip.homeip.net>
References: <1314775945-6822-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35505 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759162Ab1IISKm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Sep 2011 14:10:42 -0400
Received: by gxk21 with SMTP id 21so1544249gxk.5
        for <linux-input@vger.kernel.org>; Fri, 09 Sep 2011 11:10:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1314775945-6822-1-git-send-email-tklauser@distanz.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Grant Likely <grant.likely@secretlab.ca>, David Jander <david@protonic.nl>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On Wed, Aug 31, 2011 at 09:32:25AM +0200, Tobias Klauser wrote:
> Use the of_property_read_u32 helper function to retreive u32 values
> from the device tree. Also do not pass the len parameter to
> of_get_property if it isn't checked afterwards.
> 

Applied, thanks Tobias.

-- 
Dmitry
