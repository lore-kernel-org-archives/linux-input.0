From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc: Xilinx: PS2: Added new XPS PS2 driver
Date: Mon, 30 Jun 2008 16:45:27 -0600
Message-ID: <20080630224526.GA23679@secretlab.ca>
References: <20080630142451.516A41D1006C@mail57-sin.bigfish.com> <20080630171628.GF17916@secretlab.ca> <20080630200015.06E6E1F8054@mail93-va3.bigfish.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:31985 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762522AbYF3Wpc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Jun 2008 18:45:32 -0400
Received: by py-out-1112.google.com with SMTP id p76so439072pyb.10
        for <linux-input@vger.kernel.org>; Mon, 30 Jun 2008 15:45:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080630200015.06E6E1F8054@mail93-va3.bigfish.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Linn <John.Linn@xilinx.com>
Cc: linuxppc-dev@ozlabs.org, Sadanand Mutyala <sadanan@xilinx.com>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On Mon, Jun 30, 2008 at 02:00:12PM -0600, John Linn wrote:
> >
> >Since xps2_recv() and xps2_send() are used by the sxps2_* routines and
> >by the irq handler, they should be moved to about them in this file.
> >
> 
> OK, keeping them close makes maintenance easier I guess.
> 

Oops, there is a typo in my comment:

"... they should be moved to *above* them in this file."  'about' doesn't
make much sense.

g.

