From: "Brian Magnuson" <bdmagnuson@gmail.com>
Subject: Re: [PATCH] new driver for wireless xbox receiver for review
Date: Wed, 30 May 2007 09:47:26 -0400
Message-ID: <bafd4ab0705300647w3d54aaa6meee94c98005650d7@mail.gmail.com>
References: <20070529043957.GB6157@rcn.com>
	 <d120d5000705290859k63f9110akba428332a5557a21@mail.gmail.com>
	 <20070530002846.GA8595@rcn.com>
	 <d120d5000705300540v32b2f32eub8e74b88fea6a593@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4231_29969655.1180532846181"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000705300540v32b2f32eub8e74b88fea6a593@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, honza@jikos.cz
List-Id: linux-input@vger.kernel.org

------=_Part_4231_29969655.1180532846181
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Dmitry, (sorry about the misspelling last time)

On 5/30/07, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> Hi Brain,
>
> [Added Jan to CC list]
>
> On 5/29/07, Brian Magnuson <bdmagnuson@gmail.com> wrote:
> > Hi Dimitri,
> >
> > Thanks for taking the time to review.  My reponses are inline.
> >
> > -Brian
> >
> > * Dmitry Torokhov <dmitry.torokhov@gmail.com> [2007-05-29 20:03]:
> > >
> > > Thnk you for the patch. Looking at the code I do not see one device
> > > supporintg multiple controllers... You have one input device per usb
> > > device/interface and the properties of said device are known
> > > beforehand. So I would just create and register input device right
> > > there in xboxrcvr_probe() and get rid of your build and teardown
> > > works. The fact that is it a wireless device and at transmitter may at
> > > times be out of range is not important.
> >
> > Actually, I rather liked the fact that the input devices only show up
> when
> > there is a controller connected to the receiver, since there can be
> anywhere
> > from 0-4 controllers alive.  This way there are no device nodes for
> > non-existant controllers.
>
> Let's keep it simple. This way we don't have to worry about races
> between build and teardown work pieces and the driver is much
> simplier. After all we don't do dynamic device creation for wireless
> mice (non blue-tooth). And if we did it would make some programs
> unhappy if they did not see that device all the time... Even with
> controller - imagine you are playing and somebody calls you - you walk
> away with your controller in hand and when you come back it stops
> working because we tore down one device and created the a one but
> application is still latched to the old device - not nice.


Yeah, I came to the same conclusion shortly after sending my last message.
I'll change it to just create all 4 devices in probe.  I was going to do the
"disconnect + reconnect and see if it still works" test when I got home
today.
I don't expect it to.

> >
> > > Overall I would like support for this wireless receiver to be
> > > incorporated into xpad.c driver.
> >
> > Knew that was coming :).  Should be able to manage it.  Since the
> wireless
> > model returns a expanded data format it needs to be handled specially.
> > Another flag in the xpad_device struct?
>
> We have xtype field, I think it should be used.


I don't see this field in xpad_device in your tree or Linus'.

In any case I'll take these changes and your earlier ones, merge it into
xpad.c and
resubmit.

Thanks,
Brian

------=_Part_4231_29969655.1180532846181
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Dmitry, (sorry about the misspelling last time)<br><br><div><span class="gmail_quote">On 5/30/07, <b class="gmail_sendername">Dmitry Torokhov</b> &lt;<a href="mailto:dmitry.torokhov@gmail.com">dmitry.torokhov@gmail.com</a>
&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi Brain,<br><br>[Added Jan to CC list]<br><br>On 5/29/07, Brian Magnuson &lt;
<a href="mailto:bdmagnuson@gmail.com">bdmagnuson@gmail.com</a>&gt; wrote:<br>&gt; Hi Dimitri,<br>&gt;<br>&gt; Thanks for taking the time to review.&nbsp;&nbsp;My reponses are inline.<br>&gt;<br>&gt; -Brian<br>&gt;<br>&gt; * Dmitry Torokhov &lt;
<a href="mailto:dmitry.torokhov@gmail.com">dmitry.torokhov@gmail.com</a>&gt; [2007-05-29 20:03]:<br>&gt; &gt;<br>&gt; &gt; Thnk you for the patch. Looking at the code I do not see one device<br>&gt; &gt; supporintg multiple controllers... You have one input device per usb
<br>&gt; &gt; device/interface and the properties of said device are known<br>&gt; &gt; beforehand. So I would just create and register input device right<br>&gt; &gt; there in xboxrcvr_probe() and get rid of your build and teardown
<br>&gt; &gt; works. The fact that is it a wireless device and at transmitter may at<br>&gt; &gt; times be out of range is not important.<br>&gt;<br>&gt; Actually, I rather liked the fact that the input devices only show up when
<br>&gt; there is a controller connected to the receiver, since there can be anywhere<br>&gt; from 0-4 controllers alive.&nbsp;&nbsp;This way there are no device nodes for<br>&gt; non-existant controllers.<br><br>Let&#39;s keep it simple. This way we don&#39;t have to worry about races
<br>between build and teardown work pieces and the driver is much<br>simplier. After all we don&#39;t do dynamic device creation for wireless<br>mice (non blue-tooth). And if we did it would make some programs<br>unhappy if they did not see that device all the time... Even with
<br>controller - imagine you are playing and somebody calls you - you walk<br>away with your controller in hand and when you come back it stops<br>working because we tore down one device and created the a one but<br>application is still latched to the old device - not nice.
</blockquote><div><br>Yeah, I came to the same conclusion shortly after sending my last message.<br>I&#39;ll change it to just create all 4 devices in probe.&nbsp; I was going to do the<br>&quot;disconnect + reconnect and see if it still works&quot; test when I got home today.
<br>I don&#39;t expect it to.<br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; &gt;<br>&gt; &gt; Overall I would like support for this wireless receiver to be
<br>&gt; &gt; incorporated into xpad.c driver.<br>&gt;<br>&gt; Knew that was coming :).&nbsp;&nbsp;Should be able to manage it.&nbsp;&nbsp;Since the wireless<br>&gt; model returns a expanded data format it needs to be handled specially.<br>&gt; Another flag in the xpad_device struct?
<br><br>We have xtype field, I think it should be used.</blockquote><div><br>I don&#39;t see this field in xpad_device in your tree or Linus&#39;.<br><br>In any case I&#39;ll take these changes and your earlier ones, merge it into 
xpad.c and<br>resubmit.<br><br>Thanks,<br>Brian<br></div></div><br>

------=_Part_4231_29969655.1180532846181--
