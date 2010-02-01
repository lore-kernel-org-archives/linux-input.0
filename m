From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: remove BKL from uinput open function
Date: Mon, 1 Feb 2010 13:21:33 -0800
Message-ID: <20100201212132.GA7380@core.coreip.homeip.net>
References: <1264800197-29523-1-git-send-email-cascardo@holoscopio.com>
 <201001302257.09354.arnd@arndb.de>
 <520f0cf11001301507k20e3cf8dqa73026e12f3a1767@mail.gmail.com>
 <201001310520.55813.arnd@arndb.de>
 <20100131052942.GA12320@core.coreip.homeip.net>
 <520f0cf11002011222h134dbf06rf1db612da9a9728@mail.gmail.com>
 <520f0cf11002011227s74e57673j3922941f7ee87989@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:33849 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894Ab0BAVVr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Feb 2010 16:21:47 -0500
Content-Disposition: inline
In-Reply-To: <520f0cf11002011227s74e57673j3922941f7ee87989@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Kacur <jkacur@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Feb 01, 2010 at 09:27:22PM +0100, John Kacur wrote:
> On Mon, Feb 1, 2010 at 9:22 PM, John Kacur <jkacur@redhat.com> wrote:
> > On Sun, Jan 31, 2010 at 6:29 AM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> >> On Sun, Jan 31, 2010 at 05:20:55AM +0100, Arnd Bergmann wrote:
> >>> On Sunday 31 January 2010, John Kacur wrote:
> >>> > > Sorry, I should have been clearer, but not implementing llsee=
k
> >>> > > is the problem I was referring to: When a driver has no expli=
cit
> >>> > > .llseek operation in its file operations and does not call
> >>> > > nonseekable_open from its open operation, the VFS layer will
> >>> > > implicitly use default_llseek, which takes the BKL. We're
> >>> > > in the process of changing drivers not to do this, one by one
> >>> > > so we can kill the BKL in the end.
> >>> > >
> >>> >
> >>> > I know we've discussed this before, but why wouldn't the follow=
ing
> >>> > make more sense?
> >>> > =A0.llseek =A0 =A0 =A0 =A0 =3D no_llseek,
> >>>
> >>> That's one of the possible solutions. Assigning it to generic_fil=
e_llseek
> >>> also gets rid of the BKL but keeps the current behaviour (calling=
 seek
> >>> returns success without having an effect, no_llseek returns -ESPI=
PE),
> >>> while calling nonseekable_open has the other side-effect of makin=
g
> >>> pread/pwrite fail with -ESPIPE, which is more consistent than
> >>> only failing seek.
> >>>
> >>
> >> OK, so how about the patch below (on top of Thadeu's patch)?
> >>
> >> --
> >> Dmitry
> >>
> >> Input: uinput - use nonseekable_open
> >>
> >> Seeking does not make sense for uinput so let's use nonseekable_op=
en
> >> to mark the device non-seekable.
> >>
> >> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> >> ---
> >>
> >> =A0drivers/input/misc/uinput.c | =A0 =A07 +++++++
> >> =A01 files changed, 7 insertions(+), 0 deletions(-)
> >>
> >>
> >> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinp=
ut.c
> >> index 18206e1..7089151 100644
> >> --- a/drivers/input/misc/uinput.c
> >> +++ b/drivers/input/misc/uinput.c
> >> @@ -278,6 +278,7 @@ static int uinput_create_device(struct uinput_=
device *udev)
> >> =A0static int uinput_open(struct inode *inode, struct file *file)
> >> =A0{
> >> =A0 =A0 =A0 =A0struct uinput_device *newdev;
> >> + =A0 =A0 =A0 int error;
> >>
> >> =A0 =A0 =A0 =A0newdev =3D kzalloc(sizeof(struct uinput_device), GF=
P_KERNEL);
> >> =A0 =A0 =A0 =A0if (!newdev)
> >> @@ -291,6 +292,12 @@ static int uinput_open(struct inode *inode, s=
truct file *file)
> >>
> >> =A0 =A0 =A0 =A0file->private_data =3D newdev;
> >>
> >> + =A0 =A0 =A0 error =3D nonseekable_open(inode, file);
> >> + =A0 =A0 =A0 if (error) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(newdev);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return error;
> >> + =A0 =A0 =A0 }
> >> +
> >> =A0 =A0 =A0 =A0return 0;
> >> =A0}
> >>
> >>
> >
> > Hmnn, if you look at nonseekable_open() it will always return 0. I
> > think you can just do the following.

It always returns 0 _now_ but I do not see any guarantees that it will
never ever return anything but 0. If somebody would provide such
garantee then we certainly would not need to handle errors.

> >
> > diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinpu=
t.c
> > index 18206e1..697c0a6 100644
> > --- a/drivers/input/misc/uinput.c
> > +++ b/drivers/input/misc/uinput.c
> > @@ -291,7 +291,7 @@ static int uinput_open(struct inode *inode, str=
uct file *fil
> >
> > =A0 =A0 =A0 =A0file->private_data =3D newdev;
> >
> > - =A0 =A0 =A0 return 0;
> > + =A0 =A0 =A0 return nonseekable_open(inode, file);
> > =A0}
> >
> > Signed-off-by: John Kacur <jkacur@redhat.com>
> >
>=20
> Btw, Thadeu Lima de Souza Cascardo should just combine that all into
> one patch, no point really in making two patches out of that.

I think these are 2 separate changes (the fact that nonseekable_open
also gets rid of BKL invocation is a side-effect), that is not
considering the fact that I already applied Thadeu's change and don't
want to rewind my public branch unless really necessary.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
