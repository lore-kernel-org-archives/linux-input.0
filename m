From: =?ISO-8859-1?Q?=C9ric_Piel?= <eric.piel@tremplin-utc.net>
Subject: Re: [REGRESSION] "bind" a device to a driver doesn't not work	anymore
Date: Tue, 13 Oct 2009 11:52:19 +0200
Message-ID: <4AD44DD3.4070508@tremplin-utc.net>
References: <4AD120F2.3020606@tremplin-utc.net> <20091011030029.GA6526@suse.de> <200910112135.29384.dmitry.torokhov@gmail.com> <4AD31709.4000103@tremplin-utc.net> <20091012154846.GB7996@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759248AbZJMJxK@vger.kernel.org>
In-Reply-To: <20091012154846.GB7996@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Op 12-10-09 17:48, Dmitry Torokhov schreef:
> On Mon, Oct 12, 2009 at 01:46:17PM +0200, =C9ric Piel wrote:
>>> Eric, do you still need to fiddle with i8042 to get your keyboard w=
orking with=20
>>> 2.6.32-rc3? We need to make sure that resube works without users ne=
eding to=20
>>> mess with bind/unbind.
>> Yes, the keyboard doesn't work after the first resume from ram (the
>> later resumes do work). I haven't tried any special option to the i8=
042
>> driver. This is on a HP 2510, in 64 bits.
>=20
> Could you please try and let me know if unloading at suspend and
> reloading after resume atkbd and/or psmouse drivers and leaving i8042
> alone "fixes" the issue?
>=20
Unloading the modules before suspend and reloading them after works
around the issue, indeed.

Eric
