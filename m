From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] input: remove BKL from uinput open function
Date: Tue, 2 Feb 2010 00:18:35 +0100
Message-ID: <520f0cf11002011518y22c2f097s87872e7b5b1690d7@mail.gmail.com>
References: <1264800197-29523-1-git-send-email-cascardo@holoscopio.com>
	 <201001302257.09354.arnd@arndb.de>
	 <520f0cf11001301507k20e3cf8dqa73026e12f3a1767@mail.gmail.com>
	 <201001310520.55813.arnd@arndb.de>
	 <20100131052942.GA12320@core.coreip.homeip.net>
	 <520f0cf11002011222h134dbf06rf1db612da9a9728@mail.gmail.com>
	 <520f0cf11002011227s74e57673j3922941f7ee87989@mail.gmail.com>
	 <20100201212132.GA7380@core.coreip.homeip.net>
	 <520f0cf11002011350u3b541a0cxfb0ed882dca13afe@mail.gmail.com>
	 <20100201220856.GB7380@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:39583 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556Ab0BAXSh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Feb 2010 18:18:37 -0500
In-Reply-To: <20100201220856.GB7380@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Feb 1, 2010 at 11:08 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Feb 01, 2010 at 10:50:25PM +0100, John Kacur wrote:
>> On Mon, Feb 1, 2010 at 10:21 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Mon, Feb 01, 2010 at 09:27:22PM +0100, John Kacur wrote:
>> >> On Mon, Feb 1, 2010 at 9:22 PM, John Kacur <jkacur@redhat.com> wr=
ote:
>> >> > On Sun, Jan 31, 2010 at 6:29 AM, Dmitry Torokhov
>> >> > <dmitry.torokhov@gmail.com> wrote:
>> >> >> On Sun, Jan 31, 2010 at 05:20:55AM +0100, Arnd Bergmann wrote:
>> >> >>> On Sunday 31 January 2010, John Kacur wrote:
>> >> >>> > > Sorry, I should have been clearer, but not implementing l=
lseek
>> >> >>> > > is the problem I was referring to: When a driver has no e=
xplicit
>> >> >>> > > .llseek operation in its file operations and does not cal=
l
>> >> >>> > > nonseekable_open from its open operation, the VFS layer w=
ill
>> >> >>> > > implicitly use default_llseek, which takes the BKL. We're
>> >> >>> > > in the process of changing drivers not to do this, one by=
 one
>> >> >>> > > so we can kill the BKL in the end.
>> >> >>> > >
>> >> >>> >
>> >> >>> > I know we've discussed this before, but why wouldn't the fo=
llowing
>> >> >>> > make more sense?
>> >> >>> > =E1.llseek =E1 =E1 =E1 =E1 =3D no_llseek,
>> >> >>>
>> >> >>> That's one of the possible solutions. Assigning it to generic=
_file_llseek
>> >> >>> also gets rid of the BKL but keeps the current behaviour (cal=
ling seek
>> >> >>> returns success without having an effect, no_llseek returns -=
ESPIPE),
>> >> >>> while calling nonseekable_open has the other side-effect of m=
aking
>> >> >>> pread/pwrite fail with -ESPIPE, which is more consistent than
>> >> >>> only failing seek.
>> >> >>>
>> >> >>
>> >> >> OK, so how about the patch below (on top of Thadeu's patch)?
>> >> >>
>> >> >> --
>> >> >> Dmitry
>> >> >>
>> >> >> Input: uinput - use nonseekable_open
>> >> >>
>> >> >> Seeking does not make sense for uinput so let's use nonseekabl=
e_open
>> >> >> to mark the device non-seekable.
>> >> >>
>> >> >> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>> >> >> ---
>> >> >>
>> >> >> =E1drivers/input/misc/uinput.c | =E1 =E17 +++++++
>> >> >> =E11 files changed, 7 insertions(+), 0 deletions(-)
>> >> >>
>> >> >>
>> >> >> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/=
uinput.c
>> >> >> index 18206e1..7089151 100644
>> >> >> --- a/drivers/input/misc/uinput.c
>> >> >> +++ b/drivers/input/misc/uinput.c
>> >> >> @@ -278,6 +278,7 @@ static int uinput_create_device(struct uin=
put_device *udev)
>> >> >> =E1static int uinput_open(struct inode *inode, struct file *fi=
le)
>> >> >> =E1{
>> >> >> =E1 =E1 =E1 =E1struct uinput_device *newdev;
>> >> >> + =E1 =E1 =E1 int error;
>> >> >>
>> >> >> =E1 =E1 =E1 =E1newdev =3D kzalloc(sizeof(struct uinput_device)=
, GFP_KERNEL);
>> >> >> =E1 =E1 =E1 =E1if (!newdev)
>> >> >> @@ -291,6 +292,12 @@ static int uinput_open(struct inode *inod=
e, struct file *file)
>> >> >>
>> >> >> =E1 =E1 =E1 =E1file->private_data =3D newdev;
>> >> >>
>> >> >> + =E1 =E1 =E1 error =3D nonseekable_open(inode, file);
>> >> >> + =E1 =E1 =E1 if (error) {
>> >> >> + =E1 =E1 =E1 =E1 =E1 =E1 =E1 kfree(newdev);
>> >> >> + =E1 =E1 =E1 =E1 =E1 =E1 =E1 return error;
>> >> >> + =E1 =E1 =E1 }
>> >> >> +
>> >> >> =E1 =E1 =E1 =E1return 0;
>> >> >> =E1}
>> >> >>
>> >> >>
>> >> >
>> >> > Hmnn, if you look at nonseekable_open() it will always return 0=
=2E I
>> >> > think you can just do the following.
>> >
>> > It always returns 0 _now_ but I do not see any guarantees that it =
will
>> > never ever return anything but 0. If somebody would provide such
>> > garantee then we certainly would not need to handle errors.
>>
>> Well, all it's doing is changing the f_mode. If anyone ever changes
>> that function
>> to return anything other than 0 it will be their responsibility to g=
o
>> fix all the
>> uses of it.
>
> No, not really.
>
>> If you do a git grep of nonseekable_open, you'll see that this
>> is a very common paradigm. (to return 0).
>
> The reason for nonseekable_open return 0 is so that you can plug it
> directly into fsops. The fact that many users abuse that and do:
>
> =A0 =A0 =A0 =A0return nonseekable_open(indoe, file);
>
> when doing:
>
> =A0 =A0 =A0 =A0nonseekable_open(indoe, file);
> =A0 =A0 =A0 =A0return 0;
>
> would not introduce any complexity if they dont want to handle errors=
 at
> this time, and would be much safer (and one could mark
> nonseekable_open() __must_check down the road if it is ever changed
> to actually fail), does not validate such practice in any way.
>
>> It makes your code shorter,
>> and more readable. Plus, you are writing speculative code based on
>> what might exist in the future?
>
> No, I try to write the code that handles errors from functions that
> could return errors even if current implementation does not do that.
>
>> Also, then should uinput_release be called?
>> If it is called will kfree be called twice on the same memory. If it
>> isn't called, is
>> that a problem because you've already done most of the work that req=
uires
>> a call to uinput_destroy_device ?
>
> Why would release be called if open failed?

Sorry, maybe I am doing a poor job of explaining myself. My question
was whether your driver needs to call uinput_release() or not if it
went through your proposed error path, because that is where you have
the call to the uinput_destroy_device() function.
After taking a fresh look at your code I don't believe that it does.
However, you could still hoist your code that calls nonseekable_open()
above all that init stuff in uinput_open(), just under the return
-ENOMEM if you think that it could fail.
However, I still think that nonseekable_open() is designed from the
"get-go" to never fail, so I think your code is unnecessarily
complicated, by just a little bit. It will still work, so you decide
which to go with. I'm fine with either way.

John
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
