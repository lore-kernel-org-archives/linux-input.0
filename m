From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND v6] Input: matrix-keypad - Add device tree support
Date: Tue, 20 Nov 2012 22:54:08 -0800
Message-ID: <20121121065408.GB16772@core.coreip.homeip.net>
References: <1352988788-5336-1-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA77A5C@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57754 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab2KUGyM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Nov 2012 01:54:12 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so4864654pbc.19
        for <linux-input@vger.kernel.org>; Tue, 20 Nov 2012 22:54:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA77A5C@DBDE01.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "dgdunix@gmail.com" <dgdunix@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Wed, Nov 21, 2012 at 06:45:45AM +0000, AnilKumar, Chimata wrote:
> On Thu, Nov 15, 2012 at 19:43:08, AnilKumar, Chimata wrote:
> > Add device tree support to matrix keypad driver and usage details
> > are added to device tree documentation. Also modified the driver
> > according to recent update of matrix_keypad_build_keymap(), which
> > automatically allocate memory for keymap. Driver was tested on AM335x
> > EVM.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> > This patch was tested on AM335x-EVM and based on linux-next, cleanly
> > applies on top of "input/next"
> 
> Hi Dmity,
> 
> If there are no further comments on this patch, could you please
> take this in?

Applied to my 3.8 queue, thank you AnilKumar.

-- 
Dmitry
