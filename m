From: John S Gruber <johnsgruber@gmail.com>
Subject: Re: [PATCH 1/2] HID: redragon: Fix regression in non-Redragon
 keyboard due to this new driver
Date: Wed, 1 Aug 2018 16:46:24 -0400
Message-ID: <CAPotdmQZoMDQ3iTKCyiQXHWUUpt45WrWz4mXYerFdSpJP9PCAw@mail.gmail.com>
References: <CAPotdmQtXmfHJfcgrXZ02NrPgS3Az=SpZnBsRZ_8dGvPfdi+Mw@mail.gmail.com>
 <1532807605-26023-1-git-send-email-JohnSGruber@gmail.com> <CAPotdmT-zCVL=hoV0y83bbksTQ3AWsCybzisL8B6n-OB-M645g@mail.gmail.com>
 <6330995a9313ade9196cadb2e3696d53d4ef9aa8.camel@apache.org>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="00000000000060a0ae057265ca65"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6330995a9313ade9196cadb2e3696d53d4ef9aa8.camel@apache.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Munteanu <rombert@apache.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--00000000000060a0ae057265ca65
Content-Type: text/plain; charset="UTF-8"

Right, Robert.

I tested it and it works to solve the problem I reported.

On Mon, Jul 30, 2018 at 10:05 AM Robert Munteanu <rombert@apache.org> wrote:

> Hi John,
>
> On Sat, 2018-07-28 at 15:53 -0400, John S Gruber wrote:
> > The Redragon keyboard uses the second device being presented, but
> > other
> > devices with the same vendor_id/device_id pair (0x0c45:760b) use the
> > first.
> > Don't cause its deletion. Problem introduced in commit 85455dd906d5
> > ("HID: redragon: Fix modifier keys for Redragon Asura Keyboard")
> >
> > Fixes: 85455dd906d5
> > Signed-off-by: John S Gruber <JohnSGruber@gmail.com>
> > ---
> >  drivers/hid/hid-redragon.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/drivers/hid/hid-redragon.c b/drivers/hid/hid-redragon.c
> > index daf5957..85a5fbb 100644
> > --- a/drivers/hid/hid-redragon.c
> > +++ b/drivers/hid/hid-redragon.c
> > @@ -55,10 +55,6 @@ static int redragon_probe(struct hid_device *dev,
> >               return ret;
> >       }
> >
> > -     /* do not register unused input device */
> > -     if (dev->maxapplication == 1)
> > -             return 0;
> > -
> >       ret = hid_hw_start(dev, HID_CONNECT_DEFAULT);
> >       if (ret) {
> >               hid_err(dev, "hw start failed\n");
>
> As I mentioned, this is already fixed by
> dc9b8e85ed95cbe7e3ad0eabb5b48d617bbc365e, scheduled for 4.19, and I
> suggest that we instead add that one to 4.18.
>
> The explanation is that the block you deleted was the whole reason for
> adding the redragon_probe function, so the changes are largely
> equivalent.
>
> Thanks,
>
> Robert
>
>

--00000000000060a0ae057265ca65
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Right, Robert.<div><br></div><div>I tested it and it works=
 to solve the problem I reported.</div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr">On Mon, Jul 30, 2018 at 10:05 AM Robert Munteanu &lt;<a h=
ref=3D"mailto:rombert@apache.org">rombert@apache.org</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">Hi John,<br>
<br>
On Sat, 2018-07-28 at 15:53 -0400, John S Gruber wrote:<br>
&gt; The Redragon keyboard uses the second device being presented, but<br>
&gt; other<br>
&gt; devices with the same vendor_id/device_id pair (0x0c45:760b) use the<b=
r>
&gt; first.<br>
&gt; Don&#39;t cause its deletion. Problem introduced in commit 85455dd906d=
5<br>
&gt; (&quot;HID: redragon: Fix modifier keys for Redragon Asura Keyboard&qu=
ot;)<br>
&gt; <br>
&gt; Fixes: 85455dd906d5<br>
&gt; Signed-off-by: John S Gruber &lt;<a href=3D"mailto:JohnSGruber@gmail.c=
om" target=3D"_blank">JohnSGruber@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/hid/hid-redragon.c | 4 ----<br>
&gt;=C2=A0 1 file changed, 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/hid/hid-redragon.c b/drivers/hid/hid-redragon.c<b=
r>
&gt; index daf5957..85a5fbb 100644<br>
&gt; --- a/drivers/hid/hid-redragon.c<br>
&gt; +++ b/drivers/hid/hid-redragon.c<br>
&gt; @@ -55,10 +55,6 @@ static int redragon_probe(struct hid_device *dev,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* do not register unused input device */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (dev-&gt;maxapplication =3D=3D 1)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D hid_hw_start(dev, HID_CONNECT_DEFAUL=
T);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hid_err(dev, &qu=
ot;hw start failed\n&quot;);<br>
<br>
As I mentioned, this is already fixed by<br>
dc9b8e85ed95cbe7e3ad0eabb5b48d617bbc365e, scheduled for 4.19, and I<br>
suggest that we instead add that one to 4.18.<br>
<br>
The explanation is that the block you deleted was the whole reason for<br>
adding the redragon_probe function, so the changes are largely<br>
equivalent.<br>
<br>
Thanks,<br>
<br>
Robert<br>
<br>
</blockquote></div>

--00000000000060a0ae057265ca65--
