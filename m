From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Re: [PATCH] HID: sony: Add force feedback support for Dualshock3 USB
Date: Sun, 17 Nov 2013 10:36:55 +0100
Message-ID: <1567991.TNa7UhjX8Q@sven-desktop>
References: <1384021557-24106-1-git-send-email-sven@narfation.org> <f26febe04a776d22c913ed3ade3a8d90.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3333706.daXzLSPg9T"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from narfation.org ([79.140.41.39]:42071 "EHLO v3-1039.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753741Ab3KQJg7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Nov 2013 04:36:59 -0500
In-Reply-To: <f26febe04a776d22c913ed3ade3a8d90.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Colin Leitner <colin.leitner@gmail.com>


--nextPart3333706.daXzLSPg9T
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Saturday 16 November 2013 17:30:25 simon@mungewell.org wrote:
> This patch appears to work OK with my DualShock/SixAxis controller (USB
> connection), but causes a machine lockup when used with my Intec wired
> controller.
> 
> The Intec controller works OK up to the point when I start rumble,
> sometimes the motor runs some times it doesn't. I am using SDL2's
> 'testhaptic' application.

Thanks a lot for this bug report. The testhaptic was a good testcase because 
it is a heavy user and can reproduce the problem quite easily. I've only 
tested it using testrumble and own programs which didn't seem to trigger the 
problem here. The problem is easy to explain:

 * usb_control_msg/usb_interrupt_msg/usb_bulk_msg/... may sleep
 * sony_play_effect may gets called in an softirq context (atomic)

So it is a bad choice to use hid_output_raw_report (which calls 
usb_control_msg) in a ff_memless control function. I will just send a revert 
patch in some minutes.

Kind regards,
	Sven
--nextPart3333706.daXzLSPg9T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCgAGBQJSiI44AAoJEF2HCgfBJntG8UEQAK4i7zOOSc6slj2u7LKu+xAZ
jhSmtUKgcXYL4qko5n55ogLQxsSm8Il/YiWqmlEsMK8IdchrjH6m1CNlp60UJQ9Q
d65TBZWfrN3aH+k5Srj2hTIYiAv9Gw0uv8ePmmyzxqcFOFAqrV2tgeIF4Gm8rpZ9
BKoTvgHtURFOwyQZ/MDmLePd+i5czXrBVg/yY1m9EYJf48FGvAjAHBUJiYhbSwE0
ruKhwyzOp2Q2L9Jczl/YQvr029mU3Jv1b5XTh1wx2OapmlJLzVKIagRw/phOrSxr
teHY9LufawRvYvewsOuTdNhOb++PEOamYIxyCYx8iI7ztzuhqht4/ZUcTXdWX2dC
gqwIVNepJ06LMhydN/lzKNWgWh8IvAIaCoXgtpIV5ihqa0d9E6Mw06JRqMI+o0JR
VJYHiZshaQ9L4EfubNmqJlJCqV+o8LZuX3zarmb9E1uATXIpkZyLH+EBQ4pVPiWp
azrfliHZkal+avfNcu0u0PmlfsMkgZ0mowGshOlkhNKSZpDPX7jU4feXaM2G/X5a
2n6MD3wX186wBuk6AXWq0h9c/D242e/anBjmFadTY1TDBn+Qn/d/bHgR50VCKROX
EVMtRrEz2yIdBpsnKht/161OdrQi7WuMdqqVzB1CHU7k8oe9K6UamIm5eVN0uVMg
m4WjicpacoBhULQ9p1Ww
=mIyL
-----END PGP SIGNATURE-----

--nextPart3333706.daXzLSPg9T--

