From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 1/6] Input: psmouse - use switch statement in
 psmouse_process_byte()
Date: Fri, 11 Dec 2015 12:37:28 +0100
Message-ID: <20151211113728.GH12308@pali>
References: <1448774036-39040-1-git-send-email-dmitry.torokhov@gmail.com>
 <1448774036-39040-2-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448774036-39040-2-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Thomas Hellstrom <thellstrom@vmware.com>, jckeerthan@gmail.com, till2.schaefer@uni-dortmund.de, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Saturday 28 November 2015 21:13:51 Dmitry Torokhov wrote:
> Instead of a series mostly exclusive "if" statements testing protocol=
 type
> of the mouse let's use "switch" statement.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
