From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [DIGImend-devel] [PATCH 3/4]....
Date: Thu, 26 Feb 2015 16:52:51 -0500
Message-ID: <20150226215251.GB7092@mail.corp.redhat.com>
References: <CADfnJPrGxud1z5rfGfbXvtXTU2eOymf_+5SosTr7c4ThN61Yww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CADfnJPrGxud1z5rfGfbXvtXTU2eOymf_+5SosTr7c4ThN61Yww@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vince Herried <Vince@PlanetVince.com>
Cc: linux-input@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>, Jiri Kosina <jkosina@suse.cz>, Nikolai Kondrashov <spbnick@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Vince,

On Feb 26 2015 or thereabouts, Vince Herried wrote:
> I'm overwhelmed by these updates  My understanding of the code is not=
 that
> good.
>=20
> Currently i have a version of the code that gives two interfaces from=
 my
> Huion h610.  I have gotten the buttons to work using xsetwacom.  I do=
nt
> want to lose button function.
>=20
> Q1.  Will the changes from Benjamin preserve button functionality?

It depend what you call button functionality. My goal is to get rid of
the keyboard shortcuts that are emitted by the device out of the box. I=
t
is a really bad idea from the firmware engineers and you don't get the
release information on each button.

If you are using the branch huion-abstract-keyboard on the
digimend-kernel-drivers tree, then this is what we should end up.

Currently these patch series give little enhancement with respect to
what is currently upstream (these are upstream patches).

The only difference from what you will get from a plain v3.19 kernel is
that there will be some suffixes added to the name of the input nodes
(some more appeared because we can not be sure that we don't need them)=
=2E
On my H610 Pro, I have:

$ xinput
=E2=8E=A1 Virtual core pointer                    	id=3D2	[master point=
er (3)]
=E2=8E=9C   =E2=86=B3 HUION PenTablet Pen                     	id=3D9	[=
slave  pointer (2)]
=E2=8E=9C   =E2=86=B3 HUION PenTablet Mouse                   	id=3D10	=
[slave  pointer (2)]
=E2=8E=A3 Virtual core keyboard                   	id=3D3	[master keybo=
ard (2)]
    =E2=86=B3 HUION PenTablet Keyboard                	id=3D11	[slave  =
keyboard (3)]
    =E2=86=B3 HUION PenTablet System Control          	id=3D12	[slave  =
keyboard (3)]
    =E2=86=B3 HUION PenTablet Consumer Control        	id=3D13	[slave  =
keyboard (3)]

Of course, I receive events only on the Pen and Keyboard interface.

>=20
> Q2.  I want to help where should i grab test versions?

I just pushed the 6 patches of the v2 series on top of a v4.0-rc1 kerne=
l
merged with Jiri's tree (the official hid tree):
https://github.com/bentiss/linux branch huion.v2-4.0-rc1

But that means that you need to recompile the whole kernel for the
tests. You can try to copy/paste drivers/hid/hid-uclogic.c into your
local digimend-kernel-drivers tree and then run make. Depending on your
running kernel, it might work, or not :(

When this will be merged upstream, I'll send the equivalent patches for
the digimend tree, plus the rebase of huion-abstract-keyboard on top of
that.

Cheers,
Benjamin
