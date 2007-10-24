From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: New version of Elantech touchpad driver for kernel 2.6.23.1
Date: Wed, 24 Oct 2007 00:10:07 -0400
Message-ID: <200710240010.08023.dmitry.torokhov@gmail.com>
References: <20071024035002.GA12026@adopmeer.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20071024035002.GA12026@adopmeer.homeip.net>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
Cc: Arjan Opmeer <arjan@opmeer.net>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tuesday 23 October 2007, Arjan Opmeer wrote:
> @@ -88,6 +88,7 @@ enum psmouse_type {
> =A0=A0=A0=A0=A0=A0=A0=A0PSMOUSE_LIFEBOOK,
> =A0=A0=A0=A0=A0=A0=A0=A0PSMOUSE_TRACKPOINT,
> =A0=A0=A0=A0=A0=A0=A0=A0PSMOUSE_TOUCHKIT_PS2,
> +=A0=A0=A0=A0=A0=A0=A0PSMOUSE_ELANTECH,
> =A0=A0=A0=A0=A0=A0=A0=A0PSMOUSE_CORTRON,
> =A0=A0=A0=A0=A0=A0=A0=A0PSMOUSE_AUTO=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/=
* This one should always be last */
> =A0};

Do not move protocol constants around as they are exported to
userspace. New protocols should go to the end of the list
(right in front of PSMOUSE_AUTO).

Thanks.=20

=2D-=20
Dmitry
