From: Alex Riesen <raa.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: OOPS in hiddev_open on connecting "Logitech MX620 Laser Cordless Mouse"
Date: Sat, 18 Sep 2010 22:59:11 +0200
Message-ID: <AANLkTi=T6N6govmQgv5-=KMvHNBE4sX+hKfSyU6ZhUfa@mail.gmail.com>
References: <AANLkTikOowB=8=3cnJ0QgJNfBsVeMUrkNT0E0uH2LDXL@mail.gmail.com>
	<alpine.LNX.2.00.1009181954010.26813@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1009181954010.26813-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guillaume Chazarain <guichaz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mat <jackdachef-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andreas Bombe <aeb-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sat, Sep 18, 2010 at 19:56, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org> wrote:
> On Sat, 18 Sep 2010, Alex Riesen wrote:
>> [ =C2=A0192.656508] BUG: unable to handle kernel NULL pointer derefe=
rence at (null)
>> [ =C2=A0192.658212] IP: [<ffffffff81331108>] hiddev_open+0xd1/0x19f
>> [ =C2=A0192.660745] PGD 79849067 PUD 79a9d067 PMD 0
>> [ =C2=A0192.661291] Oops: 0000 [#1] SMP
>
> Does reverting of commit 8fe294caf8c868edd9046251824a0af91991bf43 fix=
 the
> problem please?

=46or me too, it does help. No oops after reverting the commit.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
