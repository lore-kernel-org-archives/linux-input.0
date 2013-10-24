From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 4/8] input: Remove OOM message after
 input_allocate_device
Date: Thu, 24 Oct 2013 11:45:39 -0700
Message-ID: <1382640339.22433.73.camel@joe-AO722>
References: <cover.1382555436.git.joe@perches.com>
	 <cc5e6a317bc9ef33cfdfae3ed9d3a47b5319a47b.1382555436.git.joe@perches.com>
	 <20131024183707.GA5281@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20131024183707.GA5281@core.coreip.homeip.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Wan ZongShun <mcuos.com@gmail.com>, Andrey Moiseev <o2g.org.ru@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Josh Wu <josh.wu@atmel.com>, Ferruh Yigit <fery@cypress.com>, Pau Oliva Fora <pof@eslack.org>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 2013-10-24 at 11:37 -0700, Dmitry Torokhov wrote:
> Hi Joe,
> 
> On Wed, Oct 23, 2013 at 12:14:50PM -0700, Joe Perches wrote:
> > Emitting an OOM message isn't necessary after input_allocate_device
> > as there's a generic OOM and a dump_stack already done.
> 
> No, please don't. The kzalloc may get changed in the future to not dump
> stack (that was added originally because not everyone was handling OOM
> properly, right?), input core might get changed to use something else
> than kzalloc, etc, etc.
> 
> The majority of errors use dev_err so we also get idea what device
> failed (if there are several), and more.

I think that's not valuable as input_allocate_device already has
dozens of locations that don't emit a specific OOM and centralizing
the location for any generic message would work anyway.
