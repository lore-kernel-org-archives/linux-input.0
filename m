From: "johann deneux" <johann.deneux@gmail.com>
Subject: Re: [PATCH] Added device to hid-ff
Date: Fri, 16 Feb 2007 16:43:54 +0100
Message-ID: <38b3b7c0702160743g67ae3e55pbccad84eefc2368b@mail.gmail.com>
References: <38b3b7c0702151056m7c396952j81199783f654bf7a@mail.gmail.com>
	 <op.tns2alf2a64tfs@localhost>
	 <d120d5000702151142l5dca88f7nc71f58473fa27040@mail.gmail.com>
	 <45D4B9AB.70509@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6263_4452801.1171640634515"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <45D4B9AB.70509@gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "STenyaK (Bruno Gonzalez)" <stenyak@gmail.com>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, Valentin Zagura <puthre@gmail.com>
List-Id: linux-input@vger.kernel.org

------=_Part_6263_4452801.1171640634515
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 2/15/07, Anssi Hannula <anssi.hannula@gmail.com> wrote:
>
> Dmitry Torokhov wrote:
> > On 2/15/07, STenyaK (Bruno Gonzalez) <stenyak@gmail.com> wrote:
> >> Sorry for not providing a proper patch, could you please also add
> >>         {0x46d, 0xc294, hid_lgff_init}, // Logitech G25 wheel
> >> to the list? I tested it here and that wheel is also working.
> >>
> >
> > OK.
> >
>
> Hmm.. Shouldn't an entry also be added to the devices[] list in
> hid-lgff.c for these devices? (and it seems one device is already
> missing from there in the current kernel).
>
> I'm not able to check right now, but I think some earlier kernels may
> have defaulted to ff_joystick if no entry is present in devices[], hence
> these devices working for some without the entry.
> (so the alternative is to restore that behaviour)


Yes, defaulting to joystick was the way it was when I wrote hid-lgff.c, and
I guess Valentin made his original patch on a kernel where defaulting was
still there.
I'll send a separate mail with the patch adding the devices there too, but I
personally think defaulting was nice. Was there a reason behind the removal?

-- 
Johann

------=_Part_6263_4452801.1171640634515
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 2/15/07, <b class="gmail_sendername">Anssi Hannula</b> &lt;<a href="mailto:anssi.hannula@gmail.com">anssi.hannula@gmail.com</a>&gt; wrote:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Dmitry Torokhov wrote:<br>&gt; On 2/15/07, STenyaK (Bruno Gonzalez) &lt;<a href="mailto:stenyak@gmail.com">stenyak@gmail.com</a>&gt; wrote:<br>&gt;&gt; Sorry for not providing a proper patch, could you please also add<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {0x46d, 0xc294, hid_lgff_init}, // Logitech G25 wheel<br>&gt;&gt; to the list? I tested it here and that wheel is also working.<br>&gt;&gt;<br>&gt;<br>&gt; OK.<br>&gt;<br><br>Hmm.. Shouldn&#39;t an entry also be added to the devices[] list in
<br>hid-lgff.c for these devices? (and it seems one device is already<br>missing from there in the current kernel).<br><br>I&#39;m not able to check right now, but I think some earlier kernels may<br>have defaulted to ff_joystick if no entry is present in devices[], hence
<br>these devices working for some without the entry.<br>(so the alternative is to restore that behaviour)</blockquote><div><br>Yes, defaulting to joystick was the way it was when I wrote hid-lgff.c, and I guess Valentin made his original patch on a kernel where defaulting was still there.
<br>I&#39;ll send a separate mail with the patch adding the devices there too, but I personally think defaulting was nice. Was there a reason behind the removal?<br><br>-- <br>Johann<br><br></div></div>

------=_Part_6263_4452801.1171640634515--
