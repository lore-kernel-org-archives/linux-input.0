From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hid-input: battery quirk for Apple keyboard
Date: Mon, 26 Nov 2012 14:27:13 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211261426240.12570@pobox.suse.cz>
References: <50B22662.4070503@odi.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <50B22662.4070503@odi.ch>
Sender: stable-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Ortwin_Gl=FCck?= <odi@odi.ch>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 25 Nov 2012, Ortwin Gl=FCck wrote:

> Support battery capacity on another Apple wireless
> keyboard.

Your patch has been whitespace damaged. I have fixed it by hand and=20
applied, but please fix your process for any future patch submissions.=20
Thanks.

> NB: most likely all other APPLE_ALU_WIRELESS_* keyboards should be ad=
ded=20
> as well.

I think it's likely true, but I prefer to have it actually tested befor=
e=20
doing such changes blindly.

Thanks,

--=20
Jiri Kosina
SUSE Labs
