From: "Timo S." <m.silentcreek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] touchscreen: sun4i-ts: Really fix A10
 temperature reporting
Date: Wed, 24 Jun 2015 13:59:17 +0200
Message-ID: <CAKLfuV2rvTy2vSLQfN+db-4J+nTvcRuH6kfGzw4E16wTLjSP4Q@mail.gmail.com>
References: <1425893870-28715-1-git-send-email-hdegoede@redhat.com>
	<41a7a857-96fd-48ab-9778-127cfc091ef0@googlegroups.com>
	<5589B78C.4080600@redhat.com>
	<20150623195424.GE40168@dtor-ws>
	<558A5966.9010908@redhat.com>
Reply-To: m.silentcreek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=047d7b6dcd748e6df00519423c9b
Return-path: <linux-sunxi+bncBDGZFWHP6IMBBFVXVKWAKGQERYWAKLI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <558A5966.9010908-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

--047d7b6dcd748e6df00519423c9b
Content-Type: text/plain; charset=UTF-8

Hi Hans,

On Wed, Jun 24, 2015 at 9:16 AM, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

Ah yes, something went wrong during the 4.1 cycle wrt merging ARM patches
> which have caused almost all ARM patches intended for 4.1 to get delayed to
> 4.2, including that one, that is the problem.
>
> We did our best to update the driver and the dts in lockstep, and you
> should
> have never seen this problem, but the missing of the merge window for all
> ARM patches during the 4.1 cycle has caused our carefully planned lock-step
> update to fail, sorry about that.
>

No need to apologize. Things happen. Glad to see this cleared up so quickly.

Thanks for the help (and all the other work you do ;)).

Kind regards,

Timo

-- 
You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--047d7b6dcd748e6df00519423c9b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Hans,<br><div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Wed, Jun 24, 2015 at 9:16 AM, Hans de Goede <span dir=
=3D"ltr">&lt;<a href=3D"mailto:hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">hdego=
ede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br><br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><span class=3D""></span>
Ah yes, something went wrong during the 4.1 cycle wrt merging ARM patches<b=
r>
which have caused almost all ARM patches intended for 4.1 to get delayed to=
<br>
4.2, including that one, that is the problem.<br>
<br>
We did our best to update the driver and the dts in lockstep, and you shoul=
d<br>
have never seen this problem, but the missing of the merge window for all<b=
r>
ARM patches during the 4.1 cycle has caused our carefully planned lock-step=
<br>
update to fail, sorry about that.<br></blockquote><div><br></div><div>No ne=
ed to apologize. Things happen. Glad to see this cleared up so quickly.<br>=
<br></div><div>Thanks for the help (and all the other work you do ;)).<br><=
br></div><div>Kind regards,<br><br></div><div>Timo<br></div></div><br></div=
></div></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org">linux-s=
unxi+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

--047d7b6dcd748e6df00519423c9b--
