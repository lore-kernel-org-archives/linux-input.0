From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: May close() return any error code?
Date: Sun, 2 Aug 2015 14:57:23 +0100
Message-ID: <20150802135723.GC17109@ZenIV.linux.org.uk>
References: <s5hr3nrs0kc.wl-tiwai@suse.de>
 <20150802074220.GF3720@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:51110 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbbHBN53 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Aug 2015 09:57:29 -0400
Content-Disposition: inline
In-Reply-To: <20150802074220.GF3720@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Dr. Werner Fink" <werner@suse.de>

On Sun, Aug 02, 2015 at 09:42:20AM +0200, Pavel Machek wrote:
> > This seems coming from evdev_flush().  As there is no fd leak, it's=
 no
> > big problem per se.  But, now the question is whether returning suc=
h
> > an error code is correct behavior at all.  At least, it doesn't see=
m
> > defined in POSIX:
> >
> http://pubs.opengroup.org/onlinepubs/009695399/functions/close.html
>=20
> Returning an error from close() would imply that file descriptor is
> not closed.... seems like bad idea. Just fix the kernel not to do it.

The only thing implied here is failure to RTF{M,S}.  To quote close(2):

NOTES
       Not checking the return value of close() is a common  but  never=
theless
       serious  programming error.  It is quite possible that errors on=
 a pre=E2=80=90
       vious write(2) operation are first reported at the final close()=
=2E   Not
       checking the return value when closing the file may lead to sile=
nt loss
       of data.  This can especially be observed with NFS and with disk=
 quota.
       Note  that  the  return  value should only be used for diagnosti=
cs.  In
       particular close() should not be retried after an EINTR since th=
is  may
       cause a reused descriptor from another thread to be closed.

That's Linux one.  FreeBSD one says

     In case of any error except EBADF, the supplied file descriptor is=
 deal-
     located and therefore is no longer valid.

and that matches behaviour of historical BSD variants as well.  POSIX i=
s being
its usual charming self and says "if a kernel shipped by $VALUED_MEMBER=
 does
this and that cretinous thing, far be it from us to call it broken".
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
