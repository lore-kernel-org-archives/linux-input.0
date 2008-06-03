From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] ati_remote2 loadable keymap support
Date: Tue, 3 Jun 2008 21:45:26 +0300
Message-ID: <20080603184525.GC5067@sci.fi>
References: <200804051930.10574.linux@dadeos.co.uk> <20080408201826.GG16619@sci.fi> <200804182042.29337.linux@dadeos.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:33610 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753385AbYFCSp2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Jun 2008 14:45:28 -0400
Content-Disposition: inline
In-Reply-To: <200804182042.29337.linux@dadeos.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Stokes <linux@dadeos.co.uk>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, dmitry.torokhov@gmail.com

On Fri, Apr 18, 2008 at 08:42:29PM +0100, Peter Stokes wrote:
>=20
> Ville,
>=20
> My apologies for not responding to your feedback sooner. I had not no=
ticed the=20
> comments that you had inserted within the patch. Please find my respo=
nses=20
> below:

Sorry it took so long to respond. I'll just throw some comments here bu=
t
I'll also post a modifed patch that I cooked up.

> On Tuesday 08 April 2008 21:18:26 Ville Syrj=E4l=E4 wrote:
> > On Sat, Apr 05, 2008 at 07:30:10PM +0100, Peter Stokes wrote:
> > > +static int ati_remote2_getkeycode(struct input_dev *idev,
> > > +				  int scancode, int *keycode)
> > > +{
> > > +	struct ati_remote2 *ar2 =3D input_get_drvdata(idev);
> > > +	int index, mode;
> > > +
> > > +	if (((scancode >> 8) & mode_mask) !=3D (scancode >> 8))
> > > +		return -EINVAL;
> > > +
> > > +	index =3D ati_remote2_lookup(scancode & 0xFF);
> > > +	if (index =3D=3D -1)
> > > +		return -EINVAL;
> > > +
> > > +	for (mode =3D 0; mode < ARRAY_SIZE(ati_remote2_modes); mode++) =
{
> > > +		if ((1 << mode) & (scancode >> 8)) {
> > > +			*keycode =3D ar2->keycode[index][mode];
> > > +			return 0;
> > > +		}
> > > +	}
> >
> > Is there a reason you using the high bits like a mask? IIRC the har=
dware
> > mode byte isn't a mask. So something like this should do:
> >
> > mode =3D scancode >> 8;
> > if (mode < 0 || mode > MAX_MODE)
> > 	return -EINVAL;
> > index =3D ati_remote2_lookup(scancode & 0xff);
> > if (index < 0)
> > 	return -EINVAL;
> >
> >
> > I'm not sure if mode_mask should affect the keymap handling at all =
since
> > both can be changed runtime.
> >
>=20
> The reason I am using the high bits as a mode mask is in order to add=
ress the=20
> issues I felt some people might have regarding the interpretation of =
the=20
> device that allows mapping separate keycodes to each physical button=20
> dependant upon which mode the remote control is currently in. This ap=
proach=20
> address two issues.
>=20
> Firstly, whilst the input system provides a mechanism to configure th=
e=20
> scancode to keycode mapping on a per-device basis (each device can ha=
ve it's=20
> own mapping table) unfortunately the mechanism by which the mapping t=
ables=20
> can be manipulated (via the 'setkeycodes' utility) does not allow for=
 the=20
> device that should be modified to be specified. What actually appears=
 to=20
> happen is that the first device that accepts the specified scancode a=
s being=20
> one it can produce changes it's mapping for that scancode to use the =
new=20
> keycode provided. The practical upshot of this is that I wish to be a=
ble to=20
> remap the keycodes associated with the remote control but if the scan=
codes=20
> the remote control reports are within the normal range associated wit=
h a=20
> regular keyboard (i.e. <=3D255) then the keyboard driver accepts the =
change=20
> first. This not only results in the ati_remote2 not even seeing the r=
equest=20
> for the new mapping it also has the undesirable side effect of corrup=
ting the=20
> mappings for the regular keyboard. To overcome this problem, I decide=
d that=20
> instead of using the mode byte as is (i.e. a number between 0 and 4) =
I would=20
> convert it into a bit mask, thus moving all the remote's reported sca=
ncodes=20
> (0x0100 -> 0x1FF9) outside to the regular keyboard range.

That just tells me that setkeycodes is the wrong tool for this job.
Trying to work around bugs/misfeatures in a simple tool like that insid=
e
the kernel is no good. Writing a small tool that directly uses the even=
t
device (or patching setkeycodes) is trivial enough.

> Secondly. whilst I decided to provide the flexibility of a mechanism =
by which=20
> a single key may be mapped to different keycodes dependant upon which=
 mode=20
> the remote is currently in, I expected that not everyone would need t=
hat=20
> functionality. A potential downside to providing the flexible impleme=
ntation=20
> could be that if a user simply wanted to change the mapping for a giv=
en=20
> physical button regardless of what mode the remote is currently in th=
en it=20
> might be necessary to submit five requests to update the mappings for=
 each=20
> mode. By converting the mode byte into a mode bit mask it allows a ma=
pping=20
> request to simultaneously update the mapping for a single physical bu=
tton for=20
> all modes. So, for example:
>=20
> setkeycodes 0x015C 28    - Would map the OK button for AUX1 mode to b=
e 'enter'
> setkeycodes 0x1F5C 28    - Would map the OK button for all modes to b=
e 'enter'
>=20
> The usage of the mode_mask module parameter in the 'ati_remote2_getke=
ycode'=20
> and 'ati_remote2_setkeycode' is only used determine whether the drive=
r, as=20
> currently configured, will respond to the specified scancode. If the =
driver=20
> will not currently respond, because a given mode is masked out, then =
it is=20
> not possible to request or modify the keymapping for a physical butto=
n in=20
> that mode.=20

I understand but I still think it's the wrong thing to do. The API is
documented to do 1:1 mapping and you're making it do something else.
Also getkeycode can't really handle a mask since you'd need to return
multiple keycodes for one scancode which would make API strangely
assymmetric (and not to mention confusing for unwary users).

> > > +
> > > +	return -EINVAL;
> > > +}
> > > +
> > > +static int ati_remote2_setkeycode(struct input_dev *idev,
> > > +				  int scancode, int keycode)
> > > +{
> > > +	struct ati_remote2 *ar2 =3D input_get_drvdata(idev);
> > > +	int old_keycode =3D -1;
> > > +	int index, mode;
> > > +
> > > +	if (((scancode >> 8) & mode_mask) !=3D (scancode >> 8))
> > > +		return -EINVAL;
> > > +
> >
> > Same comments as above.
> >
> > > +	index =3D ati_remote2_lookup(scancode & 0xFF);
> > > +	if (index =3D=3D -1)
> > > +		return -EINVAL;
> > > +
> > > +	if (keycode < 0 || keycode > KEY_MAX)
> >
> > Are KEY_RESERVED/KEY_MAX valid here?
> >
>=20
> Yes, this is merely checking that the keycode provided is within the =
range=20
> expected by the linux input system.

I meant that it now accepts KEY_RESERVED and KEY_MAX. Are those suppose=
d
to be valid keycodes? Hmm, I suppose KEY_MAX at least is supposed to va=
lid
judging from REP_MAX and FF_STATUS_MAX.

> > > +		return -EINVAL;
> > > +
> > > +	for (mode =3D 0; mode < ARRAY_SIZE(ati_remote2_modes); mode++) =
{
> > > +		if ((1 << mode) & (scancode >> 8)) {
> > > +			old_keycode =3D ar2->keycode[index][mode];
> > > +			ar2->keycode[index][mode] =3D keycode;
> > > +		}
> > > +	}
> > > +
> > > +	set_bit(keycode, idev->keybit);
> > > +
> > > +	for (index =3D 0; index < ARRAY_SIZE(ati_remote2_keycodes); ind=
ex++) {
> > > +		for (mode =3D 0; mode < ARRAY_SIZE(ati_remote2_modes); mode++)=
 {
> > > +			if (ar2->keycode[index][mode] =3D=3D old_keycode)
> > > +				return 0;
> > > +		}
> > > +	}
> >
> > Because of using the scancode high bits as a mask this could leave =
some
> > bits set even though they are no longer in the map.
> >
>=20
> No, in this function the 'mode' variable is an index into the ar2->ke=
ycode=20
> table (i.e. a number between 0 and 4). The implementation is attempti=
ng to=20
> ascertain whether or not the 'old_keycode' is still in use within the=
 key=20
> table. The implementation does not filter the contents of idev->keybi=
t based=20
> upon whether a given keycode is only used by the remote in modes that=
 are=20
> currently masked off. Is that what you meant?

No. I meant that scancode is a mask so you could end up updating severa=
l
keys in the keycode table but you clear the keybit only for the last ke=
ycode
to be overwritten. One or more of the other overwritten keycodes could
have also disappeared from the keycode table but still be present in ke=
ybit.

Example:
Let's say you have KEY_FOO and KEY_BAR mapped to the same button in
modes AUX1 and AUX2. No other key is mapped to KEY_FOO or KEY_BAR.
You then call setkeycode with the mask set to AUX1|AUX2 and KEY_NEW.
The code would basically do this:

old_keycode =3D KEY_FOO;
keycode[button][AUX1] =3D KEY_NEW;
old_keycode =3D KEY_BAR;
keycode[button][AUX2] =3D KEY_NEW;
set_bit(KEY_NEW, keybit);
clear_bit(KEY_BAR, keybit);

In the end KEY_FOO would still be present in keybit even though it was
overwritten in the keycode table.

But anyways I got rid of this mask feature in my modifed patch.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
