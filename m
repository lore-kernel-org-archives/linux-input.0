From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 6/6] Input: psmouse - limit protocols that we try on
 passthrough ports
Date: Fri, 11 Dec 2015 12:50:09 +0100
Message-ID: <20151211115009.GL12308@pali>
References: <1448774036-39040-1-git-send-email-dmitry.torokhov@gmail.com>
 <1448774036-39040-7-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448774036-39040-7-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Thomas Hellstrom <thellstrom@vmware.com>, jckeerthan@gmail.com, till2.schaefer@uni-dortmund.de, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Saturday 28 November 2015 21:13:56 Dmitry Torokhov wrote:
> PS/2 protocol is slow, and using it with pass-through port (where we
> encapsulate PS/2 into PS/2) is slower yet so it takes quite a bit of =
time
> to do full protocol discovery for device attached to a pass-through p=
ort.
> However, so far we have not see anything but trackpoints or basic PS/=
2
> mice on pass-through ports, so let's limit protocols that we probe th=
ere
> to Trackpoint, IntelliMouse Explorer, IntelliMouse, and bare PS/2 pro=
tocol,
> and avoid other extended protocols, such as Synaptics, ALPS, etc.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

Thanks for this patch series!

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
