From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 001/002] linux-input:  bcm5974-0.31: fixed resource leak, removed work struct, device data struct introduced
Date: Tue, 1 Jul 2008 20:53:31 -0700
Message-ID: <200807012053.31524.david-b@pacbell.net>
References: <1214653629.10495.11.camel@alnilam> <200807012004.17292.david-b@pacbell.net> <20080701203847.2dae15ba.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080701203847.2dae15ba.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Henrik Rydberg <rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robfitz-lqAI2a470fI@public.gmane.org, jikos-wDf7oJUeT2I@public.gmane.org, vojtech-AlSwsSmVLrQ@public.gmane.org, dmonakhov-GEFAQzZX7r8dnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tuesday 01 July 2008, Andrew Morton wrote:
> > > I dunno what USB driver normally use for their dma memory. __Perh=
aps
> > > dma_alloc_coherent()?
> >=20
> > kmalloc() as a rule ...
>=20
> kmalloc(GFP_DMA)? =A0Hopefully not...

Right.  Does anything except parport need that any more?
Precious little ISA stuff does DMA.

USB should never use GFP_DMA.




--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
