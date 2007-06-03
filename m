From: "Brian Magnuson" <bdmagnuson@gmail.com>
Subject: Fwd: [PATCH 3/4] xpad.c - support for xbox360 wireless receiver
Date: Sun, 3 Jun 2007 13:03:49 -0400
Message-ID: <bafd4ab0706031003w6fd262dbs57a3c874904fccb7@mail.gmail.com>
References: <alpine.LRH.0.98.0706031601390.22353@twin.jikos.cz>
	 <20070603153723.GA14913@rcn.com> <20070603155330.GB14913@rcn.com>
	 <alpine.LRH.0.98.0706031818450.22353@twin.jikos.cz>
	 <bafd4ab0706031003n23c30e1ah3fdf82bf0e586aa8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_24608_2195546.1180890229693"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <bafd4ab0706031003n23c30e1ah3fdf82bf0e586aa8@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jan Kratochvil <honza@jikos.cz>
List-Id: linux-input@vger.kernel.org

------=_Part_24608_2195546.1180890229693
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Accidentally dropped the cc:

---------- Forwarded message ----------
From: Brian Magnuson <bdmagnuson@gmail.com>
Date: Jun 3, 2007 1:03 PM
Subject: Re: [PATCH 3/4] xpad.c - support for xbox360 wireless receiver
To: Jan Kratochvil <honza@jikos.cz>


On 6/3/07, Jan Kratochvil <honza@jikos.cz> wrote:
>
> Hello,
>
> On Sun, 3 Jun 2007, Brian Magnuson wrote:
> > * Brian Magnuson <bdmagnuson@gmail.com> [2007-06-03 11:37]:
> >> I can tell you without even testing that it's not going to work.  The
> data
> >> length returned by the wireless controller is alway 29 bytes, but as
> far
> >> as I can tell there is no field that indicates that length.
> >
> > Ok, looks like I was a bit hasty.  Looking at the data again there does
> > appear to be a length field in the returned data however.
> >
> > 1) It's 19 bytes rather than 20.  This is a internel data format length
> > though.  The USB data returned is still 29 bytes long.
> > 2) You still need to apply to four byte shift for it to be in the
> "right"
> > place.
>
> Oic. I somehow missed the shift. Sorry for that. So in your process packet
> function you got 19 on position 5?


Yup.

And what is on last five bytes? I
> suppose that the rest is the same as in wired controller.


I'm not someplace where I can check for sure right now, but it didn't seem
to
be useful data.  Might have even been all 0s.  I'll be able to check on that
later tonight.

-Brian

------=_Part_24608_2195546.1180890229693
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Accidentally dropped the cc:<br><br>---------- Forwarded message ----------<br><span class="gmail_quote">From: <b class="gmail_sendername">Brian Magnuson</b> &lt;<a href="mailto:bdmagnuson@gmail.com">bdmagnuson@gmail.com</a>
&gt;<br>Date: Jun 3, 2007 1:03 PM<br>Subject: Re: [PATCH 3/4] xpad.c - support for xbox360 wireless receiver<br>To: Jan Kratochvil &lt;<a href="mailto:honza@jikos.cz">honza@jikos.cz</a>&gt;<br><br></span><br><div><span class="q">
<span class="gmail_quote">On 6/3/07, <b class="gmail_sendername">Jan Kratochvil</b> &lt;<a href="mailto:honza@jikos.cz" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">honza@jikos.cz</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hello,<br><br>On Sun, 3 Jun 2007, Brian Magnuson wrote:<br>&gt; * Brian Magnuson &lt;<a href="mailto:bdmagnuson@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">bdmagnuson@gmail.com</a>&gt; [2007-06-03 11:37]:
<br>&gt;&gt; I can tell you without even testing that it&#39;s not going to work.&nbsp;&nbsp;The data
<br>&gt;&gt; length returned by the wireless controller is alway 29 bytes, but as far<br>&gt;&gt; as I can tell there is no field that indicates that length.<br>&gt;<br>&gt; Ok, looks like I was a bit hasty.&nbsp;&nbsp;Looking at the data again there does
<br>&gt; appear to be a length field in the returned data however.<br>&gt;<br>&gt; 1) It&#39;s 19 bytes rather than 20.&nbsp;&nbsp;This is a internel data format length<br>&gt; though.&nbsp;&nbsp;The USB data returned is still 29 bytes long.
<br>&gt; 2) You still need to apply to four byte shift for it to be in the &quot;right&quot;<br>&gt; place.<br><br>Oic. I somehow missed the shift. Sorry for that. So in your process packet<br>function you got 19 on position 5?
</blockquote></span><div><br>Yup.<br></div><span class="q"><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">And what is on last five bytes? I
<br>suppose that the rest is the same as in wired controller.
</blockquote></span><div><br>I&#39;m not someplace where I can check for sure right now, but it didn&#39;t seem to<br>be useful data.&nbsp; Might have even been all 0s.&nbsp; I&#39;ll be able to check on that<br>later tonight.<br>
<br>-Brian
<br></div><br></div><br>

------=_Part_24608_2195546.1180890229693--
