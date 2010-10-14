From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH/RFC] input: hil_mlc - Fix hil_mlc_serio_id file2alias
 failure
Date: Thu, 14 Oct 2010 11:43:04 -0400
Message-ID: <20101014154304.GJ24144@bombadil.infradead.org>
References: <alpine.DEB.2.00.1010122111270.6491@ayla.of.borg>
 <20101013065602.GA7014@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-m68k-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20101013065602.GA7014@core.coreip.homeip.net>
Sender: linux-m68k-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Dzianis Kahanovich <mahatma@eu.by>, Helge Deller <deller@gmx.de>, linux-next@vger.kernel.org, linux-input@vger.kernel.org, Linux/m68k <linux-m68k@lists.linux-m68k.org>, linux-parisc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Oct 12, 2010 at 11:56:02PM -0700, Dmitry Torokhov wrote:
> Gah, that original patch was incorrect, I should not have applied it at
> all... The serio_device_id in question is for serio port that is being
> created by the driver and thus of course should not be used in
> MODULE_DEVICE_TABLE().
> 
> I'll drop it from my 'next' queue.
> 

Cool, thansk Dmitry!

--Kyle
