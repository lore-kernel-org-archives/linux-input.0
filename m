From: Marty Plummer <netz.kernel@gmail.com>
Subject: Re: Assistance in remapping keys with no scancode in kernel module
Date: Fri, 13 Nov 2015 10:17:36 -0600
Message-ID: <56460D20.3000600@gmail.com>
References: <564543F9.9000109@gmail.com> <20151113095456.GA24750@untxi.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:33347 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932455AbbKMQRj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Nov 2015 11:17:39 -0500
Received: by ykdv3 with SMTP id v3so154404916ykd.0
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2015 08:17:38 -0800 (PST)
In-Reply-To: <20151113095456.GA24750@untxi.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, =?UTF-8?Q?Cl=c3=a9ment_Vuchener?= <clement.vuchener@gmail.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 11/13/2015 03:54 AM, Cl=E9ment Vuchener wrote:
> On Thu, Nov 12, 2015 at 07:59:21PM -0600, Marty Plummer wrote:

>
> You will have to parse these reports yourself by implementing the raw=
_event op
> and generate the appropriate input events. I think you also need to d=
eclare the
> keys you will be using in the input_configured op. You should be able=
 to find
> a lot of examples for that in the existing HID drivers.
>
Hrm. I've grepped for the raw_event and have been looking at it, and wi=
ll check
for input_configured as well. See, I've been looking at your hid-corsai=
r driver,
but that seems to be a bit simpler as they all report on separate usage=
s unlike
my situation. Would it be out of the question to ask for a particular d=
river to
look at that is more similar to my situation?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWRg0ZAAoJEHWEtN3AMJGNxhAP/0neYJIkEkgBwn5l5CVV3pWl
0QU5/ND7rZNuTp+HYXQHzU7SFTGOqbSvhFwWYXXvDupNp+tYwngcvN84EnO6PKZG
qgelkzLXExecVGqRH4rqQPrOsP8GeaZcTOrLdTe6ItWzB9QigGf19LLDo4O86ph3
0V1Sqt3ozsipROt7P7zu5DF7MNNNgx8mel1M8J+EHaTF84WJ9gUK4sD2MQKAmbAA
/jVdqoPpbEI6tBbQeiBB4u+qZm17Y4/jVDpJ6WZTn0/y/4M0yEZ97cxOK0YIuVhu
0UevZCAD1EX0/uwe4dTbG4K5Bti3+PYaHFPr/J6OU7Eicr0NKpetiF/iYju0UOpM
a1d4fOrd2Q8MQWvPCU7O0xVfPx03xe+55fqqYQGCos6oiB797BI9KFchIwcR+doo
id9bO/WHF46ZrNXlbXWLbFAAu9+qsq76BaLrqT8q8H6FKwqvHcak5dOMs74B5bb6
rG8bhF3bw1sGuRRQbbIRiMzYucGhO2bx7sr0tKOOOREm9gLPSLkWEntjV5jxg5wV
6OPCfGJGp2RlEc4/6Ff0hZwIcqDvFAZBBiN0l+fJdM9VciwsOxG1ShBfQ0BLUAp+
PTLWDJt6ptm95qnkIycmIbNa/8p8zEzwdZHFXQrCagXc9rrQo8h7MuOXuLbuKJQt
tOORVLzi7lFlDMQCmQTv
=3DNEuA
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
