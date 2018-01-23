From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: stmfts,s6sy671 - add SPDX identifier
Date: Mon, 22 Jan 2018 17:41:11 -0800
Message-ID: <20180123014111.qt76xd7dnjikpmm7@dtor-ws>
References: <CGME20171212074156epcas2p4fefff65c3316ec1aa9b3d7797aaca550@epcas2p4.samsung.com>
 <20171212074149.7844-1-andi.shyti@samsung.com>
 <20180105095715.GA6679@gangnam.samsung>
 <20180105164958.csojn6vhy72bwoac@dtor-ws>
 <20180109052331.GC11443@gangnam.samsung>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180109052331.GC11443@gangnam.samsung>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Philippe Ombredanne <pombredanne@nexb.com>
List-Id: linux-input@vger.kernel.org

On Tue, Jan 09, 2018 at 02:23:31PM +0900, Andi Shyti wrote:
> Hi Dmitry,
> 
> On Fri, Jan 05, 2018 at 08:49:58AM -0800, Dmitry Torokhov wrote:
> > Hi Andi,
> > 
> > On Fri, Jan 05, 2018 at 06:57:15PM +0900, Andi Shyti wrote:
> > > Hi Dmitry,
> > > 
> > > this is a kind ping, would you also mind giving me a feedback to
> > 
> > Yes, sorry. Could you please split the patch for each driver
> > individually? Also, until we have an update to the CodingStyle doc
> > mandating the C++ style comments, I'd prefer keeping the original style
> > of comments. So // for the SPDX line and /* */ for the rest.
> 
> I was actually following Linus guideline [1] [2]. I also had the
> same discussion previously in another context [3].
> 
> Please let me know if you still want a mixed style of comments in
> the next patch.

Eh, I guess it does not matter in the grand scheme of things; applied as
is.

Thank you.

> 
> Thanks,
> Andi
> 
> [1] https://marc.info/?l=linux-kernel&m=151163713125320&w=2
>     ...
>     └-> https://marc.info/?l=linux-kernel&m=151163867325641&w=2
>         ...
>         └-> https://marc.info/?l=linux-kernel&m=151163867325641&w=2
> 
> [2] https://marc.info/?l=linux-kernel&m=150964359922353
> [3] https://marc.info/?l=linux-kernel&m=151312974503109&w=2

-- 
Dmitry
