From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: wacom - add 0xE5 (MT device) support
Date: Sun, 29 Apr 2012 21:10:20 -0700
Message-ID: <20120430041020.GB1055@core.coreip.homeip.net>
References: <1335402856-11256-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:48894 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab2D3EKZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Apr 2012 00:10:25 -0400
Received: by dadz8 with SMTP id z8so3537222dad.10
        for <linux-input@vger.kernel.org>; Sun, 29 Apr 2012 21:10:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1335402856-11256-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Chris Bagwell <chris@cnpbagwell.com>, Ping Cheng <pingc@wacom.com>

On Wed, Apr 25, 2012 at 06:14:16PM -0700, Ping Cheng wrote:
> Main part of patch is adding support for a new Wacom MT touch
> packet and labels these devices using MTSCREEN type.
> 
> Other items of interest:
> 
> Delete some duplicate code in HID parsing for Y info since
> its already done in X path.
> 
> In wacom_query_tablet_data(), only invoke the set report
> that requests tablets to send Wacom Touch packets for
> Finger interfaces.  Mostly, this is to make code intent clear.

Applied, but:

> +
> +	wacom->num_contacts_left -= contacts_to_send;
> +	if (wacom->num_contacts_left < 0)
> +		wacom->num_contacts_left = 0;

num_contacts_left is unsigned so this condition woudl never fire.
Changed num_contacts_left to be signed before applying.

Thanks.

-- 
Dmitry
