From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: driver for USB VoIP phones with CM109 chipset #2
Date: Mon, 18 Aug 2008 13:47:27 -0400
Message-ID: <20080818134407.ZZRA012@mailhub.coreip.homeip.net>
References: <200806271424.50425.oliver@neukum.org> <200808041356.57928.oliver@neukum.org> <489767D3.6070408@db.org> <200808050008.48846.oliver@neukum.org> <4898A8C2.2080307@db.org> <20080805201403.GA13557@anvil.corenet.prv> <4898C3D8.4010004@db.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:26245 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbYHRRrc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Aug 2008 13:47:32 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2174026wri.5
        for <linux-input@vger.kernel.org>; Mon, 18 Aug 2008 10:47:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4898C3D8.4010004@db.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Alfred E. Heggestad" <aeh@db.org>
Cc: Oliver Neukum <oliver@neukum.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Alfred,

On Tue, Aug 05, 2008 at 11:19:20PM +0200, Alfred E. Heggestad wrote:
>
> I send a new complete CM109 patch below, hope things are working better
> this time.. your input has been appreciated!
>

I reworked support for sepcial keys so they can also be set via
setkeycode and dropped the keymap for carpophone since is was marked
as incomplete. The driver is in the 'next' branch of my tree and will
be merged when 2.6.28 opens.

Thank you for your patience.

-- 
Dmitry
