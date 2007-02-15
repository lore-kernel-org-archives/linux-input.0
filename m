From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Added device to hid-ff
Date: Thu, 15 Feb 2007 15:09:50 -0500
Message-ID: <d120d5000702151209y4b048040m85cf546129ae86b8@mail.gmail.com>
References: <38b3b7c0702151056m7c396952j81199783f654bf7a@mail.gmail.com>
	 <op.tns2alf2a64tfs@localhost>
	 <d120d5000702151142l5dca88f7nc71f58473fa27040@mail.gmail.com>
	 <45D4B9AB.70509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <45D4B9AB.70509@gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: "STenyaK (Bruno Gonzalez)" <stenyak@gmail.com>, johann deneux <johann.deneux@gmail.com>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, Valentin Zagura <puthre@gmail.com>
List-Id: linux-input@vger.kernel.org

On 2/15/07, Anssi Hannula <anssi.hannula@gmail.com> wrote:
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

Yep. It looks like they should be mapped to ff_joystick, right?

> I'm not able to check right now, but I think some earlier kernels may
> have defaulted to ff_joystick if no entry is present in devices[], hence
> these devices working for some without the entry.
> (so the alternative is to restore that behaviour)
>
> BTW, shouldn't the PID/VID check in hid_lgff_init() do endian conversion?
>

No, because input_id keeps this data in host format. See usb_to_input_id().

-- 
Dmitry
