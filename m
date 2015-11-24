From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] USB: quirks: Fix another ELAN touchscreen
Date: Tue, 24 Nov 2015 08:29:42 +0100
Message-ID: <1448350182.2213.1.camel@suse.com>
References: <1448165164-11398-1-git-send-email-adrienverge@gmail.com>
	 <alpine.LNX.2.00.1511231551330.20111@pobox.suse.cz>
	 <CANsc=4Xj+3ySvvXxqnz660_iAr9syZwmgL5VLU2OAsUKtL-Lmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANsc=4Xj+3ySvvXxqnz660_iAr9syZwmgL5VLU2OAsUKtL-Lmw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrien =?ISO-8859-1?Q?Verg=E9?= <adrienverge@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Macpaul Lin <macpaul@gmail.com>, Vincent Palatin <vpalatin@chromium.org>, Logan Gunthorpe <logang@deltatee.com>, Hans de Goede <hdegoede@redhat.com>, Yao-Wen Mao <yaowen@google.com>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 2015-11-23 at 18:37 +0100, Adrien Verg=C3=A9 wrote:
> > Makes one wonder however whether we shouldn't be applying
> ALWAYS_POLL to
> > all ELAN devices by default anyway.
>=20
> True! But I don't want to risk breaking anything on other models in
> this patch.

ALWAYS_POLL just extends an existing behavior. The chances
of breaking anything are slim. I'd go for the approach
based on the vendor ID.

	Regards
		Oliver
