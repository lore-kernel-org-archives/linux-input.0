From: Yves-Alexis Perez <corsac@debian.org>
Subject: Re: [PATCH v2 0/7] New Lenovos 2015 touchpads: party time!
Date: Thu, 19 Mar 2015 16:25:27 +0100
Message-ID: <20150319152526.GA3651@balvenie>
References: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
 <20150319142450.GA1641@balvenie>
 <20150319144627.GA18134@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150319144627.GA18134@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Thu, Mar 19, 2015 at 10:46:27AM -0400, Benjamin Tissoires wrote:
> On Mar 19 2015 or thereabouts, Yves-Alexis Perez wrote:
> > So I have two questions/remarks about this:
> > 
> > - if I don't use the touchpad, do I need xf86-input-synaptics at all?
> 
> Wether you use it or not, with the current kernel patch set, there will
> be no modifications to do in xf86-input-synaptics. Legacy versions will
> work just fine and the trackstick/touchpads are seen like they were in
> the past (lik ein the thinkpads t410 .. t430).
> 
> So I would advice to just revert to whatever Xorg / xf86-input-synaptics
> / configuration you had from your distribution, apply the patches (or
> wait for 4.0-rc5), and you are done.

So to summarize: both patchsets are enough for complete
touchpad+trackpoint operations, having both is not useful but not
harmful either, and it's better to have the kernel one.

Am I right? Thanks for the information, I'll also try to point our
kernel maintainers to that thread and ask them if it's possible to
backport them to the 3.16 kernel for Jessie.
> 
> > - how can I have the BIOS setting respected by the psmouse/synaptics
> >   kernel module (like when using psmouse)
> 
> I was confused at first so I double checked. If you use the
> psmouse.proto=imps boot parameter, then the bios setting is respected.
> 
> If the trackpad is enabled, it is barely usable, but that's what you get
> :)

Oh ok. I didn't try to boot with touchpad enabled in BIOS and
psmouse.proto=imps, so I missed that.

But that doesn't really answer my question. Can the BIOS setting be
handled correctly, so I don't have to disable the touchpad from xinput
or something?

Regards,
- -- 
Yves-Alexis
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCgAGBQJVCupjAAoJEG3bU/KmdcClcikH/2e5qahRr2+gXRbEzQcimMvp
9EHk7cY+1AQlDfN5EasKY3mEbYUC7ZZP97IlKZSTCgcl8Ai8d+jYAMlkOviytV5x
eh8LixhI/0d4u/SBDycXYXezMaNqdVQYBJ+E8bEHM6SXp4h1qEHlhzeIwDDafWQk
UeVFWbQAxrWSXX+6ZCrmBNqDOvKdCddAa77DjZGhOztBrnk4+Kr2CvcurNiHJ/36
Z1gdSaVk9Or8hfwxcoT5ZMGXld+CihK0MMuwSLBoHjggHjGFkDZuQM6I3l8WAQO5
uMjQhp+s3Gt2raMYwSFDSQQ2Tlc7//nh6LySIkPVUU+uaG3W2xbhOUFHnauLW1I=
=xG6T
-----END PGP SIGNATURE-----
