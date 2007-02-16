From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Added device to hid-ff
Date: Fri, 16 Feb 2007 11:03:14 -0500
Message-ID: <d120d5000702160803g54616f28ya1d13fb4bb78503b@mail.gmail.com>
References: <38b3b7c0702151056m7c396952j81199783f654bf7a@mail.gmail.com>
	 <op.tns2alf2a64tfs@localhost>
	 <d120d5000702151142l5dca88f7nc71f58473fa27040@mail.gmail.com>
	 <45D4B9AB.70509@gmail.com>
	 <38b3b7c0702160743g67ae3e55pbccad84eefc2368b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <38b3b7c0702160743g67ae3e55pbccad84eefc2368b@mail.gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: johann deneux <johann.deneux@gmail.com>
Cc: Anssi Hannula <anssi.hannula@gmail.com>, "STenyaK (Bruno Gonzalez)" <stenyak@gmail.com>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, Valentin Zagura <puthre@gmail.com>
List-Id: linux-input@vger.kernel.org

On 2/16/07, johann deneux <johann.deneux@gmail.com> wrote:
> On 2/15/07, Anssi Hannula <anssi.hannula@gmail.com> wrote:
> > Dmitry Torokhov wrote:
> > > On 2/15/07, STenyaK (Bruno Gonzalez) <stenyak@gmail.com> wrote:
> > >> Sorry for not providing a proper patch, could you please also add
> > >>         {0x46d, 0xc294, hid_lgff_init}, // Logitech G25 wheel
> > >> to the list? I tested it here and that wheel is also working.
> > >>
> > >
> > > OK.
> > >
> >
> > Hmm.. Shouldn't an entry also be added to the devices[] list in
> > hid-lgff.c for these devices? (and it seems one device is already
> > missing from there in the current kernel).
> >
> > I'm not able to check right now, but I think some earlier kernels may
> > have defaulted to ff_joystick if no entry is present in devices[], hence
> > these devices working for some without the entry.
> > (so the alternative is to restore that behaviour)
>
> Yes, defaulting to joystick was the way it was when I wrote hid-lgff.c, and
> I guess Valentin made his original patch on a kernel where defaulting was
> still there.
> I'll send a separate mail with the patch adding the devices there too, but I
> personally think defaulting was nice. Was there a reason behind the removal?
>

Simple oversight. I think we should restore defaulting.

-- 
Dmitry
