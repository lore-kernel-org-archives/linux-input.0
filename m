From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 03/11] aiptek: Fix probable mask then right shift defects
Date: Mon, 27 Oct 2014 11:01:49 -0700
Message-ID: <3320721.qubDk7TkeJ@dtor-glaptop>
References: <cover.1414387334.git.joe@perches.com> <20141027144411.GA7594@dtor-ws> <1414432614.18896.1.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414432614.18896.1.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Monday, October 27, 2014 10:56:54 AM Joe Perches wrote:
> On Mon, 2014-10-27 at 07:44 -0700, Dmitry Torokhov wrote:
> > Hi Joe,
> 
> Hello Dmitry.
> 
> > On Sun, Oct 26, 2014 at 10:24:59PM -0700, Joe Perches wrote:
> > > Precedence of & and >> is not the same and is not left to right.
> > > shift has higher precedence and should be done after the mask.
> > 
> > Looking at the protocol description the current code is exactly right.
> > We want to "move" button bits first as in packet type 1 they are in a
> > different place than in other packets.
> > 
> > I'll take a patch that adds parenthesis around shifts to make clear it
> > is intended.
> 
> I think it's more sensible to do the shift first to a
> temporary then direct comparisons.
> 
> Perhaps something like this cleanup that also uses
> a temporary for aiptek->curSetting and
> !!(foo & mask) instead of ((foo & mask) != 0) ? 1 : 0;

Unless you have the device I'd rather kept the changes (which are mostly
cosmetic in nature and do not fix any bugs) to a minimum.

Thanks.

-- 
Dmitry
