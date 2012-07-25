From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] fixed a macro coding style issue
Date: Wed, 25 Jul 2012 07:15:12 +0100
Message-ID: <20120725061512.GB6481@ZenIV.linux.org.uk>
References: <no>
 <1343193656-2643-1-git-send-email-chenbdchenbd@gmail.com>
 <20120725053755.GA2100@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:51060 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932744Ab2GYGPN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Jul 2012 02:15:13 -0400
Content-Disposition: inline
In-Reply-To: <20120725053755.GA2100@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Baodong Chen <chenbdchenbd@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jul 24, 2012 at 10:37:55PM -0700, Dmitry Torokhov wrote:
> On Wed, Jul 25, 2012 at 01:20:56PM +0800, Baodong Chen wrote:
> > Fixed a coding style issue in driver/input/input.c
> > 
> > Signed-off-by: Baodong Chen <chenbdchenbd@gmail.com>
> > ---
> >  drivers/input/input.c |    6 ++++--
> >  1 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/input/input.c b/drivers/input/input.c
> > index 8921c61..c96e983 100644
> > --- a/drivers/input/input.c
> > +++ b/drivers/input/input.c
> > @@ -845,11 +845,13 @@ int input_set_keycode(struct input_dev *dev,
> >  EXPORT_SYMBOL(input_set_keycode);
> >  
> >  #define MATCH_BIT(bit, max) \
> > +	do { \
> >  		for (i = 0; i < BITS_TO_LONGS(max); i++) \
> >  			if ((id->bit[i] & dev->bit[i]) != id->bit[i]) \
> >  				break; \
> > -		if (i != BITS_TO_LONGS(max)) \
> > -			continue;
> > +			if (i != BITS_TO_LONGS(max)) \
> > +				continue; \
> > +	} while (0)
> 
> This changes semantics. While current implementation of MATCH_BIT might
> not be great style, it is not supposed to be used outside of
> input_match_device(), and the replacement is completely broken.

Replacement is certainly completely broken, but "might not be great style"
is quite an understatement.  Everything else aside, it's too obfuscated
and ugly for anything outside of IOCCC and too verbose for IOCCC.

Damnit, at least turn that into
static inline int is_subset(unsigned long *bitmap1, unsigned long *bitmap2, size_t bits)
{
	int i;
	for (i = BITS_TO_LONGS(bits); i; bitmap1++, bitmap2++, i--)
		if ((*bitmap1 & *bitmap2) != *bitmap1)
			return 0;
	return 1;
}
and just before your loop
/* ignore ones that don't have bits required by id */
#define MATCH_BIT(array, bits) if (!is_subset(id->array, dev->array, bits)) continue;
with #undef MATCH_BIT right after the loop, to make it damn clean that it's local.
And frankly, I'd consider expanding that variant and killing the macro off.
Macros that affect control flow are vile and actively confusing for reader.
