From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: PATCH [1/3] drivers/input/xpad.c: Improve Xbox 360 wireless
 support and add sysfs interface
Date: Mon, 2 Mar 2009 19:12:30 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0903021902460.3111@localhost.localdomain>
References: <5aa163d00902282053h38b0febbyb37fc30855fdc985@mail.gmail.com>  <20090302130425.23cc628d.akpm@linux-foundation.org> <5aa163d00903021847n525e8704jd332610c45e4675a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5aa163d00903021847n525e8704jd332610c45e4675a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Murphy <mamurph-ZCNwHF9ErpZ2icitjWtXSw@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org, fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org



On Mon, 2 Mar 2009, Mike Murphy wrote:
> 
> 3. The outer cast (__s16) converts the unsigned values to signed
> values, while the "~" inverts the y axes to make them function like a
> joystick instead of a flight simulator control.

You should do the ~ before the cast, or use - if you just want to reverse 
things. It probably doesn't much matter (the difference between ~ and - i 
just one), but still..

Also, quite frankly, it looks like your 'coords[]' array should just be of 
type 's16' (rather than 'int') to begin with. You seem to really never use 
it as an int anyway. That would get rid of the cast.

> Is there a cleaner way to accomplish the transition from 16-bit
> unsigned little endian to 16-bit signed host endian?

I think the code is fine, but I think you'd be better off if the "data" 
pointer was perhaps of type "le16 *" to begin with.

That obviously means that your "offset" addition should now be in 16-bit 
words rather than in bytes, so you'd need to divide the offsets by two to 
do that, but those are just numbers anyway. And quite frankly, it looks 
like the actual data is just offset differently - but with the same fixed 
offset between values - for the two cases, so you could just have _one_ 
offset (and even just add that into the 'data' pointer).

That would get rid of the second cast. You'd end up with just

	s16 coords[4];

	/* In words - so this is 12 vs 6 bytes into the data */
	data += (xpad->xtype == XTYPE_XBOX) ? 6 : 3;

	coords[0] = le16_to_cpup(data);
	coords[1] = ~le16_to_cpup(data + 1);
	coords[2] = le16_to_cpup(data + 2);
	coords[3] = ~le16_to_cpup(data + 3);
	..

which looks a bit shorter and avoids those casts. I dunno.

		Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
