From: "Jan Kratochvil" <honza@jikos.cz>
Subject: Re: [PATCH] playing ff effect with code greater then FF_EFFECTS can cause buffer overflow
Date: Wed, 2 May 2007 17:31:00 +0200
Message-ID: <35f02cc20705020831s36a1741awd699fc382c1cd309@mail.gmail.com>
References: <Pine.LNX.4.64.0705020101460.9489@twin.jikos.cz>
	 <200705012253.47925.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3969_7597763.1178119860075"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200705012253.47925.dtor@insightbb.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Jan Kratochvil <krata@matfyz.cz>, Jiri Kosina <jkosina@suse.cz>, Anssi Hannula <anssi.hannula@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

------=_Part_3969_7597763.1178119860075
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Dmitry,

On 5/2/07, Dmitry Torokhov <dtor@insightbb.com> wrote:
>
> Hi Jan,
>
> On Tuesday 01 May 2007 19:15, Jan Kratochvil wrote:
> > From: Jan Kratochvil <honza@jikos.cz>
> > To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Jiri Kosina <jkosina@suse.cz>, Anssi Hannula <
> anssi.hannula@gmail.com>,
> >     linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
> > Subject: [PATCH] playing ff effect with code greater then FF_EFFECTS can
> cause buffer overflow
> >
> > Hi,
> >   i found a bug in ff-memless.c so i fixed it. As you can see I am
> > doing check if effect_id is less then 0, but I am aware that it is
> useless
> > because effect_id is actually input_event.code which is __u16, but on
> the
> > other side as long as the effect_id is int I feel it is correct to check
> > whether it is > 0.
> >
>
> Well spotted, thanks. However I think that the check should be moved up
> the stack, into force feedback core. What do you think about the patch
> below?


Ok by me.

Jan Kratochvil

--
> Dmitry
>
>
> Input: force feedback - make sure effect is present before playing
>
> Make sure that requested effect id is not out of range for the
> device and that effect is present before requesting device to
> play it.
>
> Reported-by: Jan Kratochvil <honza@jikos.cz>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> drivers/input/ff-core.c |    3 ++-
> 1 files changed, 2 insertions(+), 1 deletion(-)
>
> Index: work/drivers/input/ff-core.c
> ===================================================================
> --- work.orig/drivers/input/ff-core.c
> +++ work/drivers/input/ff-core.c
> @@ -281,7 +281,8 @@ int input_ff_event(struct input_dev *dev
>                 break;
>
>         default:
> -               ff->playback(dev, code, value);
> +               if (check_effect_access(ff, code, NULL) == 0)
> +                       ff->playback(dev, code, value);
>                 break;
>         }
>
>
>

------=_Part_3969_7597763.1178119860075
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Dmitry, <br><br><div><span class="gmail_quote">On 5/2/07, <b class="gmail_sendername">Dmitry Torokhov</b> &lt;<a href="mailto:dtor@insightbb.com">dtor@insightbb.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Jan,<br><br>On Tuesday 01 May 2007 19:15, Jan Kratochvil wrote:<br>&gt; From: Jan Kratochvil &lt;<a href="mailto:honza@jikos.cz">honza@jikos.cz</a>&gt;<br>&gt; To: Dmitry Torokhov &lt;<a href="mailto:dmitry.torokhov@gmail.com">
dmitry.torokhov@gmail.com</a>&gt;<br>&gt; Cc: Jiri Kosina &lt;<a href="mailto:jkosina@suse.cz">jkosina@suse.cz</a>&gt;, Anssi Hannula &lt;<a href="mailto:anssi.hannula@gmail.com">anssi.hannula@gmail.com</a>&gt;,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; 
<a href="mailto:linux-input@atrey.karlin.mff.cuni.cz">linux-input@atrey.karlin.mff.cuni.cz</a>, <a href="mailto:linux-kernel@vger.kernel.org">linux-kernel@vger.kernel.org</a><br>&gt; Subject: [PATCH] playing ff effect with code greater then FF_EFFECTS can cause buffer overflow
<br>&gt;<br>&gt; Hi,<br>&gt;&nbsp;&nbsp; i found a bug in ff-memless.c so i fixed it. As you can see I am<br>&gt; doing check if effect_id is less then 0, but I am aware that it is useless<br>&gt; because effect_id is actually input_event.code which is __u16, but on the
<br>&gt; other side as long as the effect_id is int I feel it is correct to check<br>&gt; whether it is &gt; 0.<br>&gt;<br><br>Well spotted, thanks. However I think that the check should be moved up<br>the stack, into force feedback core. What do you think about the patch
<br>below?</blockquote><div><br>Ok by me.<br><br>Jan Kratochvil<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">--<br>Dmitry<br>
<br><br>Input: force feedback - make sure effect is present before playing<br><br>Make sure that requested effect id is not out of range for the<br>device and that effect is present before requesting device to<br>play it.
<br><br>Reported-by: Jan Kratochvil &lt;<a href="mailto:honza@jikos.cz">honza@jikos.cz</a>&gt;<br>Signed-off-by: Dmitry Torokhov &lt;<a href="mailto:dtor@mail.ru">dtor@mail.ru</a>&gt;<br>---<br><br> drivers/input/ff-core.c
 |&nbsp;&nbsp;&nbsp;&nbsp;3 ++-<br> 1 files changed, 2 insertions(+), 1 deletion(-)<br><br>Index: work/drivers/input/ff-core.c<br>===================================================================<br>--- work.orig/drivers/input/ff-core.c<br>
+++ work/drivers/input/ff-core.c<br>@@ -281,7 +281,8 @@ int input_ff_event(struct input_dev *dev<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;default:<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ff-&gt;playback(dev, code, value);<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (check_effect_access(ff, code, NULL) == 0)
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ff-&gt;playback(dev, code, value);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br><br><br></blockquote></div><br>

------=_Part_3969_7597763.1178119860075--
