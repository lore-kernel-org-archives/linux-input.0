From: Mike Murphy <mamurph-ZCNwHF9ErpZ2icitjWtXSw@public.gmane.org>
Subject: Re: PATCH [1/3] drivers/input/xpad.c: Improve Xbox 360 wireless
	support and add sysfs interface
Date: Mon, 2 Mar 2009 23:16:10 -0500
Message-ID: <5aa163d00903022016s14b7ad32qfbaf82a07b9e0921@mail.gmail.com>
References: <5aa163d00902282053h38b0febbyb37fc30855fdc985@mail.gmail.com>
	 <20090302130425.23cc628d.akpm@linux-foundation.org>
	 <5aa163d00903021847n525e8704jd332610c45e4675a@mail.gmail.com>
	 <alpine.LFD.2.00.0903021902460.3111@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.2.00.0903021902460.3111-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org, fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Mar 2, 2009 at 10:12 PM, Linus Torvalds
<torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> wrote:
>
> You should do the ~ before the cast, or use - if you just want to rev=
erse
> things. It probably doesn't much matter (the difference between ~ and=
 - i
> just one), but still..
>
> Also, quite frankly, it looks like your 'coords[]' array should just =
be of
> type 's16' (rather than 'int') to begin with. You seem to really neve=
r use
> it as an int anyway. That would get rid of the cast.
>
>> Is there a cleaner way to accomplish the transition from 16-bit
>> unsigned little endian to 16-bit signed host endian?
>
> I think the code is fine, but I think you'd be better off if the "dat=
a"
> pointer was perhaps of type "le16 *" to begin with.
>
> That obviously means that your "offset" addition should now be in 16-=
bit
> words rather than in bytes, so you'd need to divide the offsets by tw=
o to
> do that, but those are just numbers anyway. And quite frankly, it loo=
ks
> like the actual data is just offset differently - but with the same f=
ixed
> offset between values - for the two cases, so you could just have _on=
e_
> offset (and even just add that into the 'data' pointer).
>
> That would get rid of the second cast. You'd end up with just
>
> =A0 =A0 =A0 =A0s16 coords[4];
>
> =A0 =A0 =A0 =A0/* In words - so this is 12 vs 6 bytes into the data *=
/
> =A0 =A0 =A0 =A0data +=3D (xpad->xtype =3D=3D XTYPE_XBOX) ? 6 : 3;
>
> =A0 =A0 =A0 =A0coords[0] =3D le16_to_cpup(data);
> =A0 =A0 =A0 =A0coords[1] =3D ~le16_to_cpup(data + 1);
> =A0 =A0 =A0 =A0coords[2] =3D le16_to_cpup(data + 2);
> =A0 =A0 =A0 =A0coords[3] =3D ~le16_to_cpup(data + 3);
> =A0 =A0 =A0 =A0..
>
> which looks a bit shorter and avoids those casts. I dunno.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linus
>

Thanks Linus... that solution worked, and it did make the code
shorter. To get a clean compile, I had to cast the actual argument
data pointer to (__le16 *), but that only adds 2 casts. I will send
the revision shortly.

Thanks,
Mike
--=20
Mike Murphy
Ph.D. Candidate and NSF Graduate Research Fellow
Clemson University School of Computing
120 McAdams Hall
Clemson, SC 29634-0974 USA
Tel: +1 864.656.2838   Fax: +1 864.656.0145
http://cirg.cs.clemson.edu/~mamurph
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
