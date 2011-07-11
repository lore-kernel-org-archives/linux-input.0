From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics - make dmi_check_system return
 immediately when a match is found
Date: Mon, 11 Jul 2011 09:44:26 -0700
Message-ID: <20110711164426.GA1893@core.coreip.homeip.net>
References: <1310395296.2415.7.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1310395296.2415.7.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alessandro Rubini <rubini@ipvvis.unipv.it>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jul 11, 2011 at 10:41:36PM +0800, Axel Lin wrote:
> We only care about if there is any successful match from the table
> or no match at all, make the dmi_matched callback return 1 then
> dmi_check_system will return immediately if we have a successful match.
> 

This adds too much noise for little gain... With other patches we
already have callbacks defined, so it makes sense it apply them, this one
I think I'll drop.

Thanks.

-- 
Dmitry
