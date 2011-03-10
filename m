From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] hid: Do not create input devices for feature reports
Date: Thu, 10 Mar 2011 17:16:35 +0100
Message-ID: <20110310161635.GA23223@polaris.bitmath.org>
References: <1298572259-18173-1-git-send-email-rydberg@euromail.se>
 <alpine.LNX.2.00.1103011702240.32580@pobox.suse.cz>
 <AANLkTikd67q_j_ySam7RZvau8WoESLEmdXkfCWerVrLp@mail.gmail.com>
 <alpine.LNX.2.00.1103011726300.32580@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:47285 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751938Ab1CJQUY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Mar 2011 11:20:24 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1103011726300.32580@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 01, 2011 at 05:26:41PM +0100, Jiri Kosina wrote:
> On Tue, 1 Mar 2011, Benjamin Tissoires wrote:
> 
> > Tested-by: Benjamin Tissoires <benjmain.tissoires@gmail.com>
> > Acked-by: Benjamin Tissoires <benjmain.tissoires@gmail.com>
> 
> Applied, thanks.

Hi Jiri,

I was wondering if this patch will appear in the final 2.6.38? It
seems the regression it fixes is pretty severe for ntrig devices, and
once out there, the callback argument change will create problems for
add-on modules such as dkms modules.

Thanks,
Henrik
