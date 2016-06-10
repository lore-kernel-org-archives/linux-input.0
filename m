From: Ben Gamari <ben@smart-cactus.org>
Subject: Re: [PATCH 3/4] input/alps: Allow touchsticks to report pressure
Date: Fri, 10 Jun 2016 12:21:56 +0200
Message-ID: <871t45xs1n.fsf@smart-cactus.org>
References: <1464436862-2649-1-git-send-email-ben@smart-cactus.org> <1464436862-2649-4-git-send-email-ben@smart-cactus.org> <625ba798-bec9-7dfe-ba9d-55a8c3ba347e@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:56431 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222AbcFJKW5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jun 2016 06:22:57 -0400
In-Reply-To: <625ba798-bec9-7dfe-ba9d-55a8c3ba347e@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org
Cc: Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Morgan <Ben_Morgan@dell.com>

--=-=-=
Content-Type: text/plain

Hans de Goede <hdegoede@redhat.com> writes:

> Hi,
>>
>> @@ -2996,6 +2999,10 @@ int alps_init(struct psmouse *psmouse)
>>
>>  		input_set_capability(dev2, EV_REL, REL_X);
>>  		input_set_capability(dev2, EV_REL, REL_Y);
>> +		if (priv->flags & ALPS_DUALPOINT_WITH_PRESSURE) {
>> +			input_set_capability(dev2, EV_ABS, ABS_PRESSURE);
>> +			input_set_abs_params(dev2, ABS_PRESSURE, 0, 127, 0, 0);
>> +		}
>>  		input_set_capability(dev2, EV_KEY, BTN_LEFT);
>>  		input_set_capability(dev2, EV_KEY, BTN_RIGHT);
>>  		input_set_capability(dev2, EV_KEY, BTN_MIDDLE);
>
> This seems wrong, reporting ABS_PRESSURE on a relative device. And yes, this
> really is a relative device (it sends repeated delta events when you
> keep pushing at the same force, rather then sending a single coordinate
> value).
>
> Maybe we need a REL_PRESSURE for cases like this ?
>
Fair enough. However, if such a thing were added how would one specify
the range of the value (which seems necessary for the pressure to have
any meaning whatsoever)? It seems odd that the distinctions of
absolute/relative and bounded/unbounded values are conflated in the
event interface. It's not clear to me what input_set_abs_params isn't
instead input_set_params.

Cheers

- Ben

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXWpTEAAoJEAiHZbT6yZE31uIIAMAhUZJepbChFs3WJ3BMfhxT
SYNCbSR0R4EmP2nPxNxtOERl4Iu7IwqSCbqLAwtxUHQpI1BV2pSErdO2kXeBSI/K
mObftOiPXz6NhpcV42VLNpQPcfSNKQ5olE2LU/KXnR/SICNwmcTTUayKMLDfZ2VW
uORljs6U+RxcmYFfEWTEtTCR8FVjv+x0JNMggi/zsoWmoK6wIYwY56qSKaQGlnHP
cEL+2ZmENDS9QtcfB9RhZAbNhHUSjXyFFQ1DIPl9gX6hZ6AawRvpKKsVHpuVNKMQ
aAd/vBX1uYskzlRehFWT+jsV2MqSvE55rshcja60fDstS6mnV8Za35gDH9XAOJk=
=Xgy7
-----END PGP SIGNATURE-----
--=-=-=--
