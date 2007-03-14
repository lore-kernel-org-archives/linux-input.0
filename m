From: "=?ISO-8859-1?Q?STenyaK_(Bruno_Gonz=E1lez)?=" <stenyak@gmail.com>
Subject: Re: FF layer restrictions [Was: [PATCH 1/1] Input: add sensable phantom driver]
Date: Wed, 14 Mar 2007 19:47:00 +0100
Message-ID: <8e4ff20a0703141147n4b690ab8g4cc8138d1ecc94e1@mail.gmail.com>
References: <2460126662758025813@fi.muni.cz>
	 <d120d5000703070647t223f8858i8c495dcc3e1378a2@mail.gmail.com>
	 <45EEEAA3.50009@gmail.com>
	 <d120d5000703070856of068f19k62c5a7ce1f829336@mail.gmail.com>
	 <4af2d03a0703130919nb4893b1ja9ec795dcf4bf53c@mail.gmail.com>
	 <38b3b7c0703131450v2646e63fj2be4b9dda7f928c0@mail.gmail.com>
	 <45F722CE.9000602@gmail.com>
	 <d120d5000703140802jb48bc74tbbe7ee2b120b1798@mail.gmail.com>
	 <45F82626.8000108@gmail.com> <45F83930.4060401@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_64337_14215107.1173898020513"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <45F83930.4060401@gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, johann deneux <johann.deneux@gmail.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

------=_Part_64337_14215107.1173898020513
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 3/14/07, Anssi Hannula <anssi.hannula@gmail.com> wrote:
>
> >> Do we have any idea if there any users of FF out there?
> >
> > At least me :). I'm using it for wheel and joystick in modules for
> locally
> > developped multiplatform virtual reality system.
>
> Wine and BZflag come to mind, though I think the support is quite
> limited in both.
>

There's also vDrift (racing sim), they added support very recently.
I plan to add it in my car sim too, but there's still nothing coded.

I have a question: if the force is to be 3D, why only 3 possible values?
What would they be, 3 torques or 3 forces? In the case of car sims (ff
steering wheels), only one axis of torque is usually used (except for 6 dof
platforms, as mentioned).

By the way, is this the correct list for asking trivial questions (such as
questions about how the ff api works), or is it only for development of
kernel?

-- 
Saludos,
     STenyaK

_______________________________________________
Site:   http://1ksurvivor.homeip.net  <1kSurvivor>
         http://motorsport-sim.org     <Motorsport>
         http://kwh.iespana.es         <KuantikalWareHouse>
         http://emuletutorial.info     <EmuleTutorial>
ICQ:    153709484
Mail:   stenyak AT gmail DOT com

------=_Part_64337_14215107.1173898020513
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 3/14/07, <b class="gmail_sendername">Anssi Hannula</b> &lt;<a href="mailto:anssi.hannula@gmail.com">anssi.hannula@gmail.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&gt;&gt; Do we have any idea if there any users of FF out there?<br>&gt;<br>&gt; At least me :). I&#39;m using it for wheel and joystick in modules for locally<br>&gt; developped multiplatform virtual reality system.<br><br>
Wine and BZflag come to mind, though I think the support is quite<br>limited in both.<br></blockquote></div><br>There&#39;s also vDrift (racing sim), they added support very recently.<br>I plan to add it in my car sim too, but there&#39;s still nothing coded.
<br><br>I have a question: if the force is to be 3D, why only 3 possible values? What would they be, 3 torques or 3 forces? In the case of car sims (ff steering wheels), only one axis of torque is usually used (except for 6 dof platforms, as mentioned).
<br><br>By the way, is this the correct list for asking trivial questions (such as questions about how the ff api works), or is it only for development of kernel?<br clear="all"><br>-- <br>Saludos,<br>&nbsp;&nbsp;&nbsp;&nbsp; STenyaK<br><br>
_______________________________________________<br>Site:&nbsp;&nbsp; <a href="http://1ksurvivor.homeip.net">http://1ksurvivor.homeip.net</a>&nbsp;&nbsp;&lt;1kSurvivor&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="http://motorsport-sim.org">http://motorsport-sim.org
</a>&nbsp;&nbsp;&nbsp;&nbsp; &lt;Motorsport&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="http://kwh.iespana.es">http://kwh.iespana.es</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;KuantikalWareHouse&gt;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="http://emuletutorial.info">http://emuletutorial.info</a>&nbsp;&nbsp;&nbsp;&nbsp; &lt;EmuleTutorial&gt;
<br>ICQ:&nbsp;&nbsp;&nbsp;&nbsp;153709484<br>Mail:&nbsp;&nbsp; stenyak AT gmail DOT com

------=_Part_64337_14215107.1173898020513--
