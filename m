From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH 0/3] wistron_btns: More keymaps, take 2
Date: Mon, 26 Mar 2007 23:39:03 -0400
Message-ID: <200703262339.04480.dtor@insightbb.com>
References: <45ECA23A.5010503@tremplin-utc.net> <45F91F73.8040200@tremplin-utc.net> <45FDAAB2.8010208@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <45FDAAB2.8010208@tremplin-utc.net>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: =?utf-8?q?=C3=89ric_Piel?= <Eric.Piel@tremplin-utc.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, mitr@volny.cz, otauber@web.de, linux-kernel@vger.kernel.org, linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

On Sunday 18 March 2007 17:10, =C3=89ric Piel wrote:
> Hello,
>=20
> This is a new version of my patch to add support for more laptops to the=
=20
> wistron_btns driver. Modifications from the previous version:
> * sends lid close/open event as a switch event (not a key event)
> * Display on/off is KEY_SCREEN and Display selection is=20
> KEY_SWITCHVIDEOMODE, from the discussion they seemed the "less bad"=20
> keycodes.
> * keymaps are now declared initdata in order to save some memory
>

Everyting applied to the input tree. Used new KEY_DISPLAYTOGGLE instead
of KEY_SCREEN.
=20
Thank you Eric.

=2D-=20
Dmitry
